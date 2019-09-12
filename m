Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C2C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0797208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw6x4gKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0797208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MH6-0001lM-LR
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8MEj-0008TB-Qe
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8MEi-0008Nk-TT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:22:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8MEi-0008Lu-OC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:22:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id g25so24297892otl.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iVF7iV89ba3d5AcFA6+ynci1aE3KJdayYyu+9tAkU9k=;
 b=gw6x4gKfJc/uZ6F8bDkPAfa1vOV/QR6MmMPnHri8Dapjin66OwoTnLm2VYjTh4EczP
 F/uqnKQV8OaTaYkryoaFNGIBE8Wr65+znZC4biC6B6/7McMnp6UIei9AAhV0Yu0ejK4j
 GPoG9c0h+rOAypN1oQK7A2gqkcYA7Q1rJ/1Tiss7BhLoIxFLhjcZL7eXTRH2+jpQxOfL
 Em+nvfkiK0cnA1HuaJzCWpqedIRM62K+aW0L/x2vnt6XMfgrhos3uvPZgczJuayBgJT7
 A6FqEfz2qLIS8vIuhBjX8t9+4fJdKSPHjJiGe+sT5eXdZom1KOol++2YYU10PA2rjxoK
 ICGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iVF7iV89ba3d5AcFA6+ynci1aE3KJdayYyu+9tAkU9k=;
 b=GFRdAFNl1wFXQ8yyrKyadAVxlf+Il3AUOLCalkPSerZX7IQ7oJDIvTPWHkeEs+yVGz
 +lU4r6qWvx7RWsuNm52S1Ej2unDH5f1WCHlumHUTqpmBLKA2N2zF7IF1W6XnFhMrhX2L
 tDHbsnYtzwa73Cge2Onnylv0reMQDGjgjeyNuYYZH0Wn7bA02GjtLAEzRJmuG2V+XZQ0
 +/U1TTLHOMSghGA4TEhiNHSxVSaRcMbk/rL3f4szqzPNKNuGq0uM5P7IhXtgs5OytSZu
 pqntDsTfp/Ev9K/R7abAzCHPpW7uFl29z7WOI6d15Foc7kJjUjN+Jty0PkN4iWEfha/o
 6lew==
X-Gm-Message-State: APjAAAXgRld9dPnDQvJNuhS1IN0L5x7l8apMlwfPEuNL/7Zpv76/5+0E
 dKT0zxRqsrlzMWFumRL84EihHP5k7yiwJzHJxcVmRA==
X-Google-Smtp-Source: APXvYqw07Tp939WdnD1mpUm6VsQV5tMJJG31JASEXK+x+EjDBmRQm6mAPPxSgvT5+7JU5LnSWvr+3xGy64Y5dpLYmbk=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr33359268otk.221.1568283719588; 
 Thu, 12 Sep 2019 03:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
 <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
 <87v9txzv3o.fsf@linaro.org> <20190912101651.GK24576@redhat.com>
In-Reply-To: <20190912101651.GK24576@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 11:21:48 +0100
Message-ID: <CAFEAcA9p3gk057MEi3bA_cTJz7+AEC_ODAT+4i1g0fz0dMRAmg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 Pranith Kumar <bobby.prani@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 11:17, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I think forcing recompile for each release is reasonable protection
> to make it less atttractive to create license violating closed source
> plugins.

I'm just not sure that a plugin that, for instance, does
"whenever the guest makes a memory access print the address
and data", is in any reasonable sense a derived work of QEMU
that it makes sense to extend the GPL to. We're providing
a convenient introspection interface here, similar to but
different from the way gdbstub lets you introspect guest
binary behaviour, not an arbitrary mechanism for extending
QEMU itself.

thanks
-- PMM

