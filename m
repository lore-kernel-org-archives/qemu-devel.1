Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C8C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:39:06 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CED20856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtP0XNKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CED20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LZA-0007O0-Sc
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8LIA-0005pe-W8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8LI9-0000QM-Nv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:21:30 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:35211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8LI9-0000PZ-IP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:21:29 -0400
Received: by mail-oi1-x236.google.com with SMTP id a127so16572347oii.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TNqIZi3uSOI6g9Iu95SIZpcJ4IuWX+ADUadP+K8TlIs=;
 b=VtP0XNKBTtVbDZDzYTTYrV2jMJHF5Ou7QDJwka0w+GHqIFUDmRl8S7pSMDmYv5d+kH
 X6C+jrrH/nE/3QYp2FVeRblz2O46LM8H4mdci1XeNUQGBAoZmxiuaFIFQsr2SO3VEbBL
 N0fzRY0jExlMiGOLSAvvrcZRkn/6N6xHTS4EzOAkl1HGz+/ibj7dakWnZV4/wv5VbJ3i
 ZOy58t+/vidqQkYp3SDru8ataO6A7dPqNxKAW3a7VYnaBiaTR6hfPERs8u1Q4zHnFWFF
 SFtJI8Ey6cZv1YnGKpkCFqPCWMq0AtLMzumgtEfun313U0Vx4Q+hc+mtp+BkvCWOhi4Z
 cTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TNqIZi3uSOI6g9Iu95SIZpcJ4IuWX+ADUadP+K8TlIs=;
 b=ZCo9XCpZQMaeafgqJvUQcbKTbE9PE5tgkZBT/6vFj9R0SJ4ps/d1Re/3UWDRHEMGbB
 Rhkojq3uVjsXJjGgYloQk8C9PirGpAYZtFH3CBeyFO7Spo/lncBgo69WU1gsDLRuPYwU
 imBXWD+JNosWUW1FDcnWO8MBM4eAC5NT/AnILI0GzLRVUrFaF6pVi6xj8y3IpTI5s1c9
 vyz4vOgM8/WIqO31onC7aweMOTf4gobHU6+IANpSnbiLLKXHK/utTz7cnywmSPK3Jy2q
 zrv1rrQnOKflqQrxEF2hCdmTDxTsIoH+IQXIDKbf17N0fnFDdzSmYajTWbO8jhD3NH3A
 3ohg==
X-Gm-Message-State: APjAAAUnF7l7bGwQ4uTmA07fu1t5hoo4EtemKqyUttxe2aM2xzzLfQy2
 hz/nahKt3aFzrUHtdUl+jIL3trFshfVYDwmmqtTikQ==
X-Google-Smtp-Source: APXvYqwFm/vWR1fS38Pg5IYED5LNVlWZ+xcL/DiLExHQV4boqoLsUrxYwI+uGIg5pnwZAVy+xgqO7w8qRQn8wH1znGc=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr7912448oih.170.1568280088058; 
 Thu, 12 Sep 2019 02:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
In-Reply-To: <87y2ytzy17.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 10:21:17 +0100
Message-ID: <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 10:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Well the first thing will be we are not intending to offer a guaranteed
> ABI. While we don't want to be changing it at a whim there shouldn't be
> an expectation that the plugin interface will maintain backwards
> compatibility (unlike the command line interface ;-). There should be an
> expectation that plugins will likely need to be rebuilt against the
> current source tree from time to time.

Wait, what? From my perspective the whole point of the plugin
interface is that it should be stable, in that at least there's
a good chance that a plugin you built will work against multiple
versions of QEMU, and if it doesn't then it should fail with
a reasonable error message telling you to update. I'm not
sure we should be landing the plugins infrastructure if we
don't have that much stability.

thanks
-- PMM

