Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A90C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7192082E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew02Ddjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7192082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFkeu-0007Lu-Fl
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 15:19:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFkd5-0006U4-2V
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFkd3-0007m2-TN
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFkd3-0007lD-FX
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:17:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id i21so11996931oib.11
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kLQPFnZGSmAsTBl9G6pKn8pNyEkWCNn2t1wFDPSChF8=;
	b=ew02Ddjg1wahRsyNy1BkDzGjPKKfFAqT1EfdTG2G1NcEIm6qaq050s9HQ+dLvXmq6Z
	olUUy2nC/XvHQina53WsUaCZjE2Dzr+zTiHuP98zCFn5UGHQ1IlOxadbNk+sv9ovsH0m
	B5TcqDnmcQICWkEfu5YsPC12inEQfWUJlFSRFBhSTNwT89fTdBqPV38Dz7DWH9zb4Xv0
	Uirt60YPW539eB3vbjEQZX9hjCECLp3uZEgrFUqQyxjS8aDCNNqSFTfoUMuL4J0LeADU
	WxKd9B/8Cap39zIvaekCoZSPnH1e13IwRaMnOvigf8gghawnCK8qop4Mge4JNYYQKZ85
	jrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kLQPFnZGSmAsTBl9G6pKn8pNyEkWCNn2t1wFDPSChF8=;
	b=L2PsLKO/6Ef8QvP46y/1bVjvLRD/+vjuQeJA3SXc4HfAmMV0iRSYTa9FUCrJFfOl8M
	g4mpdo9ML5+qx+RgOJ0oGuIKbZd/xu/Sto7Rafui3OAaURhzUvgBT5yTFFEnAchEF4fa
	lFM0iKTvuBNxE5CzB04VHJZIeeZxsp1JeMQ/ZMWjLaif+/c1GUmol3tva1PZ/rpX5IMP
	MSQ+TgXS367Ayty1I+K5qPadXugddZj+MkMd3beNxQbd54h7OcXUsbn/Yn7plehcfXsI
	mzLSwn7ZUHv7h7C35fNAxV4wds/y/w9jXvLyy2oadhhENMNSs5Y74Pu4oRirPjKa0BAL
	YHkQ==
X-Gm-Message-State: APjAAAUB9l0ZlY0kHozNikjsey9b/uMbEtcBiLa1CQ3pdx3Q6Pe4Ryls
	qMRsEsP6nbF38MtaG7MArp3GYxmy8PemkOXDL9kzKg==
X-Google-Smtp-Source: APXvYqw/HlOUsbiWtmPZ/vRdBLmXOdU/t39QIKEN/ZWl2KYECAGB8KSJmytV9QCcQpLkQiRmhcV236+r78AwnRzUqHk=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr15729493oif.48.1555269444292;
	Sun, 14 Apr 2019 12:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190412160458.23920-1-kwolf@redhat.com>
In-Reply-To: <20190412160458.23920-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 20:17:13 +0100
Message-ID:
 <CAFEAcA-xcQW1mkyFL=e922oOEoukHRqCWkRukVmfpbR00avemw@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 0/2] Block layer patches for 4.0-rc4
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414191713.YmpNxLdOD32W7uVLit8AdtVIsHk9tkzzRnqHx8_Km-g@z>

On Fri, 12 Apr 2019 at 17:05, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 13c24edaa742181af8d9c6b027ee366b04de1ea1:
>
>   qemu-img: fix .hx and .texi disparity (2019-04-12 14:17:10 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 9749636b005d118259810afb92482df2fe0ae2ad:
>
>   iotest: Fix 241 to run in generic directory (2019-04-12 18:03:01 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - iotests fixes

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

