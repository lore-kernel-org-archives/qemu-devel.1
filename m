Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84647C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF1320644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ehou+1k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF1320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPFd-0003wh-LQ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:17:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOPEV-0002DF-Ha
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOPET-0004oW-Q5
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:15:51 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOPET-0004o6-Ka
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:15:49 -0400
Received: by mail-ot1-x333.google.com with SMTP id g24so18868554otq.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5IIrDIgfjfI0oL7wCG8vvoaWAXrFLZCHghz3bc6veuA=;
	b=Ehou+1k29yY5VwjCmKhp3RKJEJ+cLCgwGrE55yqmxEcnuFRoBY9cy7ysuqktaxHLQk
	5M5h/pc1n0/arYyWBZEB5e1yC0vpyHiR/8wsBUWhwzZU0GI8dBt3imyVFhMMHJAQpPsI
	k1GQYpKFAOqLMOW2RyQ6I+Puoi0W8aSQ3gxbg7fzAzZInrFVbKt7rRve47UVZShEm7oN
	zd5+A9I8lTj8dQzYgq4WCfjaUqdGNUHhPJRd43zFw//Ec4lRNYpVPcagksJrHi2fZmXJ
	BndiqDmaO17+dxMHRdVN33TSJrksn3R7dg+HEkCHr/Lrr/8AfGOSvpePJ5fOkx/5mLpO
	rtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5IIrDIgfjfI0oL7wCG8vvoaWAXrFLZCHghz3bc6veuA=;
	b=LV939GmZfragqSzIXj0JXA7aC3IavvmUNJ+XqiQhh0CJdXh1Xai/LuC/2eRsDG/Nh/
	EmVWF+t8SXwmwVlbR48+UPj5iYLDObIX51bPwn5OcGsTSSOevLMlhlDiMImi7wYoS0MH
	w7gQ56+X8XgP5etiRSQUwUUrHh93DOe+bJwzitqHEZNHA2TMMtvEDswSUMJNDxYGSJss
	3Skm8Yquw1BKix7xZPr8b+Mp+nnY00VChjDV+mXXraE043fb0wHDjoWdOr04mmAbOYh6
	zXfonckj1xPeCsGmRoeCWcnFgFSrI2fBADKpfTF5G3q62o33r6H5qOAGTnxpICMR6r2r
	P57g==
X-Gm-Message-State: APjAAAUHEAd3sgpCEjIy8XeA87g6fveLPdH8zTfyguaoOZSwWwu8L7hU
	2PnGbTH6zC9UX3gCcVXW1mCwkSVAIiywfnPkRa5Ihg==
X-Google-Smtp-Source: APXvYqxKO46gAwFOk8P4N+tvrVAccOeBaDOtsLGWEDgg+Hbv4hlzkbt6CojVy0X9OHSrreGYGoWcqmOP9D2ICntT9dA=
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr9167944otp.151.1557332148235; 
	Wed, 08 May 2019 09:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190507150153.26859-1-eblake@redhat.com>
In-Reply-To: <20190507150153.26859-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2019 17:15:36 +0100
Message-ID: <CAFEAcA9z2fng0QpSa4EuQcgA7oACm8CaorY7ve6=5mUOezS7Fg@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL 0/5] NBD patches for 2019-05-07
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 16:03, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08e0:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-05-07 10:43:32 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-05-07
>
> for you to fetch changes up to 8fabb8be37775ebb32b0d78bc7be815a29b8a107:
>
>   iotests: Make 182 do without device_add (2019-05-07 09:43:42 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-05-07
>
> - iotest improvements
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

