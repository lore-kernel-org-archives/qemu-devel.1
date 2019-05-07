Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F37C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6423020449
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiA8VY7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6423020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6vK-0005SL-Ki
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:42:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO6rw-0000zd-Nt
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hO6ru-0006io-SM
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:39:20 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hO6rt-0006gw-HE
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:39:18 -0400
Received: by mail-oi1-x229.google.com with SMTP id l203so13451894oia.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=89lAoNPfsCNBTvP3A3+OrhM+2bOZ/IbaORQMiyFRBcc=;
	b=xiA8VY7yCAWezgZdIUu7QmTc8n7j3GWVAuIcvklIDRBZ8UZ6HWncilHn2OsKPSkYJ5
	HaPqeBE2pclwjvvaNyc6QnizMemc8tv74sb3+VLDkDBfjKdNt2r2p30R8jA4xvKSc5EQ
	/XYx9o+jAGRzevTJeFy9KF1oFEl+IUy62EZKU2gVrhGZKo+Ol2PYpLlzgWw25U0vlFoR
	Fon17yMNNWWpJgQjcfpwfCcT5h57oClywD8ychbWFNGI2HtlenS4qOzmInLHjVaGyo38
	FdogbL0v5MPlz4FPrUELgEV5QjIAlutzUPo5kfnuuzTmRev1XzT2s88KIfSWCBArBtVX
	Eyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=89lAoNPfsCNBTvP3A3+OrhM+2bOZ/IbaORQMiyFRBcc=;
	b=Wxag6XX4XNnhhvbC8bhRWrgF23Hv/v0sA9HVwjQ3Ui0C4L/rREqWJpu2Sn3lNJuMJd
	uVb5C4rZIC5rjNYhtSwxRSbrYMzHHxsDUlwqq8MVaMi4qq3PiliwCqvP9ASyYVtuhwVq
	VG/xMvmorO/FkrhZcMHHK/dVtBJ78vWSl3MbNu8ldEdmiL61pWE6DHGjn4QYKIO0+z/a
	1oD/BadIu3afCRkM+329Uh7WdbKNgQpv8tAg1gS5iOzHBTWNTofTc87IaELeY2h4ePPM
	lUHlWtAJ1MKNrO8sOxiV8hEFsXUFbn9dhKPYv7Aex8//OYv3roao/bG9NlNtSVzZG3cF
	9nFQ==
X-Gm-Message-State: APjAAAU6I56DoMNPL6Wp1DaXIHTd25yknlCcacNWovaJtdX/wouhykxc
	dy7/mKrxScr7yj9suiwrowuZ0tHjtpm0qYkDGSR4KA==
X-Google-Smtp-Source: APXvYqzzb4YR3OiNRsBMYGCykxOVic1HXK9e6I90AXLEV9QuTAqDCkAsO+9uUuDU0OJr212FfMAXcc/MkMyX40d7saM=
X-Received: by 2002:aca:b783:: with SMTP id h125mr243726oif.146.1557261554982; 
	Tue, 07 May 2019 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190506182940.2200-1-richard.henderson@linaro.org>
In-Reply-To: <20190506182940.2200-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2019 21:39:03 +0100
Message-ID: <CAFEAcA_1Rr29cSK+fYD2n+k9JPeVLP94y3fqmzby9WPBk9pj=w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 0/3] decodetree: Support variable-length ISAs
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

On Mon, 6 May 2019 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is a pre-requisite for the RX port.
>
>
> r~
>
>
> The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-dt-20190506
>
> for you to fetch changes up to 451e4ffdb0003ab5ed0d98bd37b385c076aba183:
>
>   decodetree: Add DisasContext argument to !function expanders (2019-05-06 11:18:34 -0700)
>
> ----------------------------------------------------------------
> Add support for variable-length ISAs
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

