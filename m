Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F8C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ED12089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyyeWcuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ED12089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7MY-0007rU-N7
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7LS-0006Pl-As
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7LR-0005YP-Ar
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:02:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw7LQ-0005Vz-Se
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:02:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id q12so8460826wrj.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0ZIP+2gRW5WAHGQ31UFgSHwEatq06pcVw0OD1vUtZxc=;
 b=EyyeWcuuNqItCtKFcOEi8Lzp5ltJFQQW3nnkQUY7V7YRvvIsFl1AnCEDnVPPWgC0lr
 ypQDCTaMkMUjBz6Kb/rqRL7caTUOriUyjaVOfojBT96Lr3IwolXssdErKG1HNIeRG0PJ
 TBsrDU1RRmeGbWCK+MT+2BO9k8y6fS0w6KF6BrvtbjOc9IftG5l6TZOmblcfeqs9pgbj
 bWNk8WdMVHYg96HM2zmoGg2NSusFPE1LtokTSdCAqbCz2iLur/f91p4Me3JdN1ckNUMf
 s7Ma9ENbe+PvDrO+pYCUOgFWg6wXAEmOY3I5I1rtMN/2wehdfnXFjcDc1eKy9dTyvZQx
 uAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0ZIP+2gRW5WAHGQ31UFgSHwEatq06pcVw0OD1vUtZxc=;
 b=gK22GS9Xe9QKmgNbhSS5S0007tYfxQUXWSpxNnPM0KAowPJaatcUcyZP2//PrQrXcG
 qY6s95HyOYQub5eXA72O6MMGJ89clQgf9ayxwAwafx0oLTm7P3xEiwluMJoKR3Y706/6
 AXT253TJP5W8yLNyKjNHo8Z4h1a/z3HQWczck5PHCvjuuk3FIDtnS5p1v39azMpn2ILf
 VuX5VvOlnoyAtHgaMDBpAgt1qYKBGcViXjDtympQQre3HRPQVUio/dyknSz014s9QvX5
 XxQBn37OkKiBk31qPejc7CVUqzI5cd+qIBzLJtR7q6lNic15YXseIGI2dH0TbcdlvGw9
 Pzqg==
X-Gm-Message-State: APjAAAXlkDAEefZH77zt/5eQqwEpRHoGaLixZjvAPIl61vh8AJoh4oAx
 i5FR8PA/pSMy1dEK2/fD+mV0oA==
X-Google-Smtp-Source: APXvYqyQGGKtGMgerqVXZQNHivEsxQKtzXSLqvuUw9LO1ziWgi0eZqEGwrsL+bCN40yYrVGR7Q13dg==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr23215584wri.224.1565366539223; 
 Fri, 09 Aug 2019 09:02:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p13sm28442828wrw.90.2019.08.09.09.02.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 09:02:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 043761FF87;
 Fri,  9 Aug 2019 17:02:18 +0100 (BST)
References: <20190305165051.26860-1-peter.maydell@linaro.org>
 <20190305165051.26860-10-peter.maydell@linaro.org>
 <CAFEAcA8vfxjW6hVnKiBu7jeiFSGXzqdaQ_ytUXgEwJ91JLDf=g@mail.gmail.com>
 <a4857913-8551-14a0-aa5c-f0cc089d79ec@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <a4857913-8551-14a0-aa5c-f0cc089d79ec@linaro.org>
Date: Fri, 09 Aug 2019 17:02:17 +0100
Message-ID: <87y302gwdy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PULL 09/22] target/arm: Implement ARMv8.5-CondM
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/9/19 2:53 AM, Peter Maydell wrote:
>> Hi -- it's just been pointed out to me that if our 'max' CPU
>> supports v8.5-CondM then we ought to be setting the HWCAP2_FLAGM2
>> bit in the hwcaps for linux-user mode. (Maybe we implemented this
>> before the kernel defined the hwcap bit?)
>
> Yep.  We added CondM in March and this hwcap bit was added in June.
>
> I keep thinking that they'll stop adding hwcap bits that can now just as =
easily
> be "read" (trap and emulated) from id registers.  They've filled up HWCAP=
, and
> only have 23 left in HWCAP2.

It's impressive on our modern hardware that bits are getting so scarce
;-)

We haven't yet started on filling up cs_base for our own flags but where
does it all end?

--
Alex Benn=C3=A9e

