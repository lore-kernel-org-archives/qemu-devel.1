Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E5C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1E525CEB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adU5aCUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1E525CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWN49-00053Y-S6
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 11:34:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWN34-0004ey-MQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWN33-000512-GV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:32:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWN33-000509-AA
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:32:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id v2so5262760oie.6
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zesq/s6uRY4Djx2jDRF4yPDdFFOoVtWGn1EYACeamfc=;
	b=adU5aCUxStQY1iDEH9UrtM7cC48M4fBb1ft/t1ifBTDwzlkn50mTObLmgnqjscaKBQ
	wW6YOkpmBTNVULcps+lRWPykmY8HVL1pzyZmMoQovdRkPrpB1k2Libkz0D52y10P+RrF
	NSFML3RQU0ZGT2j19Hcss1VkRlMm+rAccz4WqkV8J7geEsaun4/LnnXy8BforpRUSM7L
	zp09NR7k4/jQgzpGZWNQMYyLNdiGThbgHgPwG3NtDrwCf0zKEbGHld+qqKgYUv/JHFV2
	w/LcK+8N3dgbuP1Qfe1zRkrKpv9yrS6nXJCMRT0BtHYqO4/BNLC2vVrarh5vz22YMUuf
	JFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zesq/s6uRY4Djx2jDRF4yPDdFFOoVtWGn1EYACeamfc=;
	b=cpxqbIPc2QRHbbWHBBS9oGIh2Eeq8p/Tc8kr6pe2OhFsNIp1+WQLxdLdlp95IzHyX6
	hCKh/6qZvFckMFRR3DDRY5gSKQnQAKCx3Ya2TWIJ1steXltxF0XxdoZKlfmVCUgaZOjQ
	BdkSeWJEABtiwqDmrJbsj/ZvDaaTWe+3Ik9RIvakdK53jt0P4ANrXHiunynhvJH0TA/9
	MSK2am7L0pC/TzUi71HuXPjeEqQInzWv8kXHRD3V/XC79WVev4wZPXhCQ94A4XLboEs0
	dxs+fazDrbI0Q6anXvi808FdX4H0RzDWccP4hWKosHCCWh7BDzKMM+p+R80Gxoc9RvCQ
	bd8g==
X-Gm-Message-State: APjAAAXBaHldZS/kknLShkUgMUFACqKaKwVe2WMjQ+AWSoMuVn/CKlv9
	q9S8PENDoez60sDK+liPgTWPRLg3Q5HGeIM4Ru6jrg==
X-Google-Smtp-Source: APXvYqxMMZSclFbKOT91H7+e+cefb/1+Z3y9SvxuSiRMV1S3bwq2hApDFsPK+uyrbJI7KA6rx3S2/hibyv4KNV7NGKY=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr2929493oif.98.1559230376046; 
	Thu, 30 May 2019 08:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 16:32:44 +0100
Message-ID: <CAFEAcA_1e5GY=+Ck+oSbH+QoQ28m=b-XMeFToA+8QqYWrfRVrQ@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/44] ppc-for-4.1 queue 20190529
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 at 07:50, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190529
>
> for you to fetch changes up to ce4b1b56852ea741170ae85d3b8c0771c1ca7c9e:
>
>   ppc/pnv: add dummy XSCOM registers for PRD initialization (2019-05-29 11:39:47 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-05-29
>
> Next pull request against qemu-4.1.  Highlights:
>   * KVM accelerated support for the XIVE interrupt controller in PAPR
>     guests
>   * A number of TCG vector fixes
>   * Fixes for the PReP / 40p machine
>   * Improvements to make check-tcg test coverage
>
> Other than that it's just a bunch of assorted fixes, cleanups and
> minor improvements.
>
> This supersedes both the pull request dated 2019-05-21 and the one
> dated 2019-05-22.  I've dropped one hunk which I think may have caused
> the check-tcg failure that Peter saw (by enabling the ppc64abi32
> build, which I think has been broken for ages).  I'm not entirely
> certain, since I haven't reproduced exactly the same failure.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

