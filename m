Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E62C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D8520873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 12:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgAdRnuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D8520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRue-00031E-5J
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 08:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRuT-0002ae-9G
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRuS-0003EA-Ap
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:22:49 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoRuS-0003Dj-4h
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 08:22:48 -0400
Received: by mail-oi1-x235.google.com with SMTP id s184so24105509oie.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p7M5q5F7MxIa/r2jjKkheseBpte21hWoZc4a2t8a9EA=;
 b=KgAdRnuFIUicQCHi7on4sFCrKLGCHsMEHu9a3Uwp5uvL3XV/QRnacSPo6R96wnNyCt
 EeEc0Osl0PKuzJGc8+/NOYUmUJHTbQAjrBBIGPMeDAUnMhGDmutMXafyfKSeMzYs5yJr
 dDbaANxUT31/9OiTLpBkB4QzS3DfPkRjyyILp6kCKG+yeX2r1yQaogcq3tt51nVLs8vz
 dTCgPUC1ILzrDerljX2CiiO9EpYNRNeptZrnJcqwekMK9sFL0T6ed8jXYVYlyCy1onsM
 woto+lMEnEk62Jg/bW/9usCjcen7ctqa1TKOZQ9J+Wjy91r9Ii4GVTey0wrQy5gyG9Es
 qKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p7M5q5F7MxIa/r2jjKkheseBpte21hWoZc4a2t8a9EA=;
 b=WivPOv5rDSGE/X5ry/Pbzre9cAzOsc0efGaJXMJg+htKGNt+F2WeIhR/jOzVRHSDPt
 UogWeHuzJkJTXc/+MYQ4m/LwDtvIBRIBbmNhuroFiMuxfNQLOXbgsgNdykW9tKNLkRYo
 7L949d/XyR1OM+qeHDluZKDog1/ZYzq5k2oK6sXjn7SZPEHMUHYaR718uN2km2TpS+CX
 9r+NPrHk3ycpcb3I9A68thLNmOdEo7iT5Ac6xgUP+4WliTPjS9gSPto4r7UN+5rGsinN
 pR2NOliuz6HphHQRFBJn3gsoIq7q6aCBkAGyn9Nl6yeI54TC+DhQnvUmrj4Suwx1pFSg
 DX5w==
X-Gm-Message-State: APjAAAWld1KJjtIUT7lIZzeR1t4Yg3urxeCXjzDwV9wAzJNa5rKKnQAM
 sEBShhlN9xt84dHvDav7nq0wrXWr+Geqg7zR/k1xnQ==
X-Google-Smtp-Source: APXvYqzTUlla9FDfQ1xfQkR9sIDQOtPHeWqZ+oO7417ERtMjiuwNeKQH4bijCLJVTIpnHArtwh/fJqSJQA2GDpGfc6Q=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr23919833oib.146.1563538967085; 
 Fri, 19 Jul 2019 05:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190719115031.16331-1-cohuck@redhat.com>
In-Reply-To: <20190719115031.16331-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 13:22:36 +0100
Message-ID: <CAFEAcA_kUhVRF0WS2y_05DVstFA4xha2xyf+WRzkmJSOy7eNnA@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL for-4.1 0/1] one s390x fix/annotation
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 12:50, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 0b18cfb8f1828c905139b54c8644b0d8f4aad879:
>
>   Update version for v4.1.0-rc1 release (2019-07-16 18:01:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190719
>
> for you to fetch changes up to efac5ae420ca0644db9360861a1bf02d040afd18:
>
>   s390x/pci: add some fallthrough annotations (2019-07-18 11:29:50 +0200)
>
> ----------------------------------------------------------------
> Add missing fallthrough annotations.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

