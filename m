Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB0DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE3A2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bx0A+Smb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE3A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMXiY-0001mg-Tu
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:55:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXhk-0000yT-2P
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXhi-0002ds-TW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXhi-0002d1-N9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id t189so4237001oih.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=g9mlfHF7Sb62amx3l7Viw5gV2k0wjucsZ3XlnnzGDW8=;
	b=Bx0A+Smb9jv5LXCQucK1r8N/L2WoHuzqxOOH8y6ezRVMpjGq3oV9RR0e0L7rhXUFzx
	RuD/DhEvPj8Zk1yvAONQ/bP4VnS4xbwlttz2dJPplmkwrfAGFhRIBvMQArpEwnXz3DMw
	f6CTszPbCyYY+ulYmsKmuE51584ip4A8kOnH+0aTcOebFXjxq2AdelSWvr5vnGOQ6mmD
	T2HgveFAVMzr98ayu/O5yuhJ2hd3LnYL/MRDmWz5DXQ4CB2hyr3+minQczwnc/0Bf7fa
	8eIuxvMtKQI1N4yOuxOJp+Jtz6fJ3xCkk0n0OqjTJ1TcNMiyjvMqmDe+SnQ9ewK4vPPw
	AEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=g9mlfHF7Sb62amx3l7Viw5gV2k0wjucsZ3XlnnzGDW8=;
	b=jVQgWoG0FOaqWrB2dJhgszUWTMwTQpHGcqZXMqy0a6hYwTfc33pqukuCvkDGk7FUzm
	L2rsvWteLNOqKPfR1xIpFEqBOax5yGjY5YsuHD6A2LqSY1QrWVynK+SHJB4jy7+0CNHf
	tJ40+oIBhmqsP09nX/MWhwIxuMRagrY9IpDr+wE0fibc+iB+XPuNkD5KjIKTSfT70Ttb
	aBa4veUagMgKUsdT4bfoZ6/zetP/Xe0de8iaxA+Jgo0ivwxyx9Bo5I16Enh2wzBzS/Fb
	UeWTUCYOulHHCN8U9BePbuAAvLXX+ZNng0F1SkQO+1b44XoNsDN5CWIuWp2fVJSpNfSi
	idIw==
X-Gm-Message-State: APjAAAVZ4B24rE6n3iBSm4vRaBk+Jj9Xyi3NOz1bqvevvUX1e6pV3RTh
	FE9LAtqCGRBQcv0aq81dkGNgHPF1cTWs52r8qMfLYw==
X-Google-Smtp-Source: APXvYqxMcsjtoy3rNEnP27bT3NAh99dCapCHyxHCx/cqlriW0iHEY83xu9J8RGeQF0Xjy4TWiAmua3Sb9ab7NL5aarE=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr5850491oia.170.1556888057549; 
	Fri, 03 May 2019 05:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
In-Reply-To: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:54:06 +0100
Message-ID:
 <CAFEAcA_BvMq08k5s+aFFXdsf_Hy88zH_C=riC_4R3nDJyMYKjA@mail.gmail.com>
To: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH RESEND 0/2] ui/cocoa: Fix absolute and
 relative input issues on Mojave
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503125406.oP6DR92Rq5z1yS1kWJV_mk2aFc2ko75XmzdR4HuSl_I@z>

On Sun, 28 Apr 2019 at 04:30, Chen Zhang <tgfbeta@me.com> wrote:
>
> The following patches fixed absolute and relative input device issues on macOS Mojave.
>
> Chen Zhang (2):
>   ui/cocoa: Fix absolute input device grabbing issue on Mojave
>   ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>     device
>
>  ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)

Hi -- unfortunately your email client seems to have sent
these patches in a way that has confused our patch
handling systems (eg
https://patchwork.kernel.org/patch/10920623/ has
only half of the patch as actual patch, so it doesn't
apply properly, and the 'patches' program has been confused too.

Looking at the headers, your mail client is trying to send the
patches as multipart/alternative with a combined text and HTML
version. You could try configuring it to just send plain text,
which is definitely the preferred format for public mailing lists.
Or alternatively you could try using git-send-email instead.

thanks
-- PMM

