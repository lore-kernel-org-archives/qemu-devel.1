Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D1EC10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FEE213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6Sjmmez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FEE213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD7cG-0001rE-3X
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 09:13:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7bT-0001aB-Nm
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7bR-0007nS-Qk
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD7bP-0007lD-KZ
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:12:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id u15so9591807otq.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kjFyh197Nwf/GYNur4iIGXDsbx2yQMKyomT2iCC5T1o=;
	b=X6SjmmezNmaAtLdux0f6g2AxXU3vKKoz6bh08Y2O36EDcugOI4d7Wemjgmk8m5iwg1
	kngQ+oIYDMTMXv9G8uHOIoT+S1QkwDLL9HJ7rFnT6xyOq6R+pb6XR9zVlook/O1tCF9Y
	LRwEMbS18RYjW9si6MlMauE1dsvh82S6tgJfOqG11CLZCVOQy6oCHE4EtxTZSn9i7unp
	1j3zVWqzauD7le75RPFiGs1dp39UI2b6qdJN14KC1AOIaLPrgZoOuNzBjg4vCArP9/V3
	qjYftlrDKQuvPMFr6muM2o/yhiCXlyLWDMNyf3vYszzrkVCCiyySsoDiu3pSjYedaX7R
	BBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kjFyh197Nwf/GYNur4iIGXDsbx2yQMKyomT2iCC5T1o=;
	b=Z6bmYmq2gGnxY+5D2BBCuaq2eaSfYmTFp49lkf6NADyrveuDf04kPeqCdIS3ne7kGu
	4Gs64pR62K4/DPeRw5rC4TQ3dXb2x+2gkkFziE/ICDpF+ilEjllqbiP+7YgJgOX7niSG
	PUr3Jc1uCBGGnLyuZG4NbKGY0MgZSRgjVwdU/9f426hk/q3lYtQ09WUOWS70w856WItr
	crSDz3pNpJU62g3g9ar3wId36MSc/ooFGoadortx4Ai98R9QKIOPUfhKHnCF3LoLpivv
	TUw4otUAW/3CpnDMnWDWIACPyctI9aIK4snft9osqRG1Y0cbLmKGnG9Zi/g2tIWoCVSN
	yCiA==
X-Gm-Message-State: APjAAAUjhAnsP42Y/Cq7G9hNiqqaUTlAH6imXFb2QPozLhgMYGcgMD3M
	1L0mXD1dw61tFQaQ1RkhYvwXeBAPscfNf7vjowCqEg==
X-Google-Smtp-Source: APXvYqwbqok8mvAE27XviT8Otf2wtNpT2lNnCDdSn4FKDTPmZYErRM+SyqG6aqwdbdUG4jCfLuv/vuMDXyoGRp/IlyY=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr11923948otq.236.1554642769348; 
	Sun, 07 Apr 2019 06:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <2D646E18-7F28-4F06-9F3D-D5F8A1408FAC@me.com>
	<CAFEAcA_cwH+LH7kzfysQ6Ka98JRX5xf3NgeJo6+0vtuyxP=2ew@mail.gmail.com>
	<7CD2D067-C9F5-435C-97A0-2ED23CA2A20B@me.com>
	<CAFEAcA-VgDpR+jdRFXxw00vtqdd5OZ5N_-xQBC5eFe7LX9M=dQ@mail.gmail.com>
	<C847199D-0619-494F-9376-E8D9C382A4F0@me.com>
	<CE17AB4A-6AF8-4130-937B-301BB974C06A@me.com>
In-Reply-To: <CE17AB4A-6AF8-4130-937B-301BB974C06A@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:12:38 +0100
Message-ID:
 <CAFEAcA8M-UdLrD6D=2SAvY2YQAJ8JF8+yxh5uD-Lo0aJCb_BKw@mail.gmail.com>
To: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Fix absolute input device
 grabbing issues on Mojave
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407131238.jNg8F4ZceYuGDok6e-sfz_EmqboqNTxPiEvCAh_XLLA@z>

On Sat, 6 Apr 2019 at 04:04, Chen Zhang <tgfbeta@me.com> wrote:
>
> ping
>
> http://patchwork.ozlabs.org/patch/1058186/

This needs changes to be able to compile with OSX 10.10.

thanks
-- PMM

