Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6FC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90BB2146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VI9qGPdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90BB2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54277 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7Wu-0006zj-0z
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:45:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7W5-0006dP-Q7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7W4-0006MG-NC
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:45:05 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:37740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQ7W4-0006Lm-HG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:45:04 -0400
Received: by mail-oi1-x22f.google.com with SMTP id f4so1482004oib.4
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5AJ7U1gMXZFkBfL1SvPPmFRJqFTUNL7LAmdmsQyRab8=;
	b=VI9qGPdwTLVlLqUU8vOHgt13GrhBwiKyEhdosSlLa9JaCG4RiIBL35xP1uLDFTct/6
	LtR0S2voY0+a++TR50scps3rWbZbmG4WKd9an7JCGzi79SjnUWk70YBhxg2Nzma8UqUw
	YGcq1B3DnCGeLYFLaW0Mz6urZqQh0kFnjoSfSoHVVbaO5ryKR9RZsZ/B46h4jPzssuVZ
	WBmy7YYHypIMIr2ECgZDyj47eGcZ2GZnfsV86temNSoxBlRb9MxJa/6ggsptZT07fdQm
	bw0739JRTnSuzoN0lQLgnidQJunthMGCGbUroOfIH0N1txxAEglTrchcpZ2cqrDXdHBY
	OT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5AJ7U1gMXZFkBfL1SvPPmFRJqFTUNL7LAmdmsQyRab8=;
	b=Otiq/CUsVKP8a56yzTEz+cBBt2r1VFG8p5WXGix6kIXNnauzgAJSpUYBJ5T2S5g91p
	AFPlVC2vA4GJ38x+p0SIULrrUd7gHLZVIeTxnyOpCEMO+49bXEl22ARDVVFS44KQ61cS
	sRxxGowRKjMIh88dxW3Z+sxL2MLzcusxlbMPG+bLAhEw9B/tr4EeV4GRBSf5gMpsvXhg
	ittwXKfubxYrfNL2mXbSuHFcoZM9DevHfE0H3cDW6ZTBIh7pP2iK8x7bdulFphJBLqXO
	WgB0lgp72j8TY7WA/9OT7Mb0zkOwXm+2clRuK6NnO0zrRrNzgtB66Iz9oYlSZ4+OM9As
	bq4w==
X-Gm-Message-State: APjAAAXYhzFCUJoeWNxXjn7+m4iLt0UVlIWLg3n2lvqBw/oKaxrGOJyF
	tSdxxXbtxwmO0FAJ1Quab3KEYLN/9UE5f4JM6bhFeuOTzno=
X-Google-Smtp-Source: APXvYqw0S9G9ziphbgeb1ITdDFbu/RVKbeI5T8JC4fA28OVRjTewq8fnARjZracBk7w6o/7O0yLRzjJVrS2ZmN3i0NI=
X-Received: by 2002:aca:845:: with SMTP id 66mr3158412oii.163.1557740702874;
	Mon, 13 May 2019 02:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190510161614.23236-1-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 10:44:52 +0100
Message-ID: <CAFEAcA-1bJ7fqSkvr2YJsRc1S90fe8y=J0oeRTTCtx+K1BESwg@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 00/15] Block layer patches
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

On Fri, 10 May 2019 at 17:18, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 11f6fc50e7501b5f5d04100ea1c21fa8f1cf7b53:
>
>   iotests: Add test for rebase without input base (2019-05-10 16:45:40 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Remove bdrv_read() and bdrv_write()
> - qemu-img: Allow rebase with no input base
> - blockjob: Fix coroutine thread after AioContext change
> - MAINTAINERS updates for pflash, curl and gluster
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

