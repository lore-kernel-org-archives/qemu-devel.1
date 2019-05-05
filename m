Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2592C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF05206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlArEtj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF05206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJDo-0005XS-TM
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:38:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJCt-0005Au-8X
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJCs-0001ZO-9L
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNJCs-0001Yw-3p
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:38 -0400
Received: by mail-ot1-x344.google.com with SMTP id b1so9412457otp.5
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=D4L+cAmaPe/6KB+vMUO/7+WroFId3kzDeasKJiTWh0c=;
	b=RlArEtj++6SAkrLwziHzyUbLr6/dwXvLaRpQ+IufwiWHtghF0qjC+tM8GeoylXQFqV
	MCDReuclMxKenWXQSJ7/tfR66H5vbJ2Q2sXkiTzQLBobldiIY+9Q3ktiyfV5xknnMJvx
	ksEDWCtIrhdYBhBKBIwgaCq6I8yl8x5Olg8CutYcfCmZo0qM2/OyZFsNjcd4v4v6ynb2
	TkF8hJ1NCc3KHfgxq4I41NbI3zmIXOrtCIxyyf6tyi7gU328XiPt6OMnlBLwEtUVqUqJ
	ZWzom4R9EGns8KxQnGTbRLiSKYqoZn9epwpjV3Hmhc7iO/MO2Uf2sEw2OaFU0fXkHm8j
	R11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=D4L+cAmaPe/6KB+vMUO/7+WroFId3kzDeasKJiTWh0c=;
	b=rrkDT0xhZjwGAK3vBR9Q9rC8ZFnEfHH3OxP7R1QJ8m6twXCY7+ok3tLT6I+VmU5JNF
	55878Om+AiLKcJC/JyGnD01iuXzBRKpxkxnCvh3p8BM61NEyxwrC5xwH5WXeqPiO8p1f
	/plwZef3gW3LL9OAWs9DUsZ4OMhKzpJXJdc37UtoqOw0QinRNtFRl8WOa68ZYUdb7HpD
	rbuDK07aa8IJSNSy4RKeBKKc+IHGeXZU3rZY5lbkxTdMtTU0fETI+NAmQWDyVGgyorbi
	0rUKejdK/Yeq97Fu3CI/z4xUpvxnSMP40UdXCW5oPZtqcoP7m56jp9FEhAehOxFXVQyd
	F7+w==
X-Gm-Message-State: APjAAAXTaudUVV+iqJQqpAhBpnGomne/rjeFdIpTZrM5cxahAB67u6vI
	Irwker7+dUYcTTj5mvBXp2rhdStIpAtNfEm6QKnCpw==
X-Google-Smtp-Source: APXvYqw5Xmyv9FN5K4IzHQYkNOFooWQuVD48MuDtW/5iFsoxF9iG8hYKeVvTr0PVOk6qTAk5qVNUkwxkRxBtL8uvqt0=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr14514962otb.238.1557070657297;
	Sun, 05 May 2019 08:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190505070059.4664-1-zhengxiang9@huawei.com>
In-Reply-To: <20190505070059.4664-1-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 May 2019 16:37:26 +0100
Message-ID:
 <CAFEAcA-_bk0hr3g4VhxWHktMOyQ-vDvYSCBXcjMjusMFbwScgQ@mail.gmail.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of
 backend image
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505153726.lwl44BdQ5yx1nLo5bifKmdbxQFRK2D3flB9lCi5AufQ@z>

On Sun, 5 May 2019 at 08:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> Currently we fill the memory space with two 64MB NOR images when
> using persistent UEFI variables on virt board. Actually we only use
> a very small(non-zero) part of the memory while the rest significant
> large(zero) part of memory is wasted.
>
> So this patch checks the block status and only writes the non-zero part
> into memory. This requires pflash devices to use sparse files for
> backends.

Do you mean "pflash devices will no longer work if the file
that is backing them is not sparse", or just "if the file that
is backing them is not sparse then you won't get the benefit
of using less memory" ?

thanks
-- PMM

