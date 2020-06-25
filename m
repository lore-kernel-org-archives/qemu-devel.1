Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE612C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A8A20775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKcHQjuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A8A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUJK-0004ql-20
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joU26-0001x1-4c
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:43:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joU23-0000BU-HB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:43:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id 72so5684038otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OPobJVv/bg8YqK/ZN142RvDlQ5+alsiGLy9Ctc2eeRc=;
 b=hKcHQjujCHHX8tQZTQiwOO1gd2zW+2NWgpsZbDU/5JUEP3JiYjmqqzRHn9FS4IfyYL
 VxRCV3DalUKOku5zQ8a3ys3xUTYE8MmTwwzGxhXZV5biI7azN9IO/bZOqzPHp4D6+iH5
 FLMiPjks85EgFchdoiK3kwVVBtiDw4/R8P8QT+gSSnJhJsfGS/dS6rqmoQ2o7FEaak4z
 btA3bP0mI88LTe5Xhw0DyFRc4e0DjY+QnSxH4ihGikfk2OEL4WRm+dQG8LE8hVVRcUAs
 oKEIRMI5gubDg6efZ4U1JycQ+nU9ha/lSBJkiJYwqfp1iEdTbB0ayYtPHOsGOpNJbnZ0
 cc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OPobJVv/bg8YqK/ZN142RvDlQ5+alsiGLy9Ctc2eeRc=;
 b=IkbAehh/ffoDi1PQ0txOKLRhPOZ5ua7Q+8M9GPw4rNL3u9SdytDKYzWqXRMrIpmtQY
 chzwMzmOLPOCEAkzIpOv7mUaoVyJMn5ZuVSySzAJfB7ab65VM/91r0G6wMQSpNTKYUWF
 HKipk41nikB/PBktYeZXHMHEr+PXEpGcMG0PAs6yUC5iYj8M0jNBggn4II99bFdJAsbI
 VnGrh8vbg9u3Ipl7LIsWmrc5ypibsY0PSP5cSi6kJVXPtQT8U3vuw8P5EsVmKQjzABCi
 RfOLrdGKRXafWosPXcRoPpK6uf3zUJEGaRWn+IlVRc7IwTMkSXnd7o9jCBC6rP+WhA7N
 7M7A==
X-Gm-Message-State: AOAM5309mNrNXOvpbQUZlazcVyfCaClkecfS4RVIkRtNDtJ3QFEHmIWo
 zeHOWLwUrsRDzTM2ZvH4erPblgTD4grkGB32i9NCKQ==
X-Google-Smtp-Source: ABdhPJy8w7MQLQiVBP9VtrV7LYjRkcZLtJb9wxIHc2sFvxWoy8ji84ak6c55/GDjH5Gwcv3K0leK36ybWDfY1J0pRIc=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr26096902otn.221.1593099798111; 
 Thu, 25 Jun 2020 08:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-9-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-9-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:43:07 +0100
Message-ID: <CAFEAcA8_ESO6ofRTgh2z2fvmaASSrOKg7_bRqsuR=DEv346p=w@mail.gmail.com>
Subject: Re: [PATCH RESEND 8/9] hw/arm/smmuv3: Get prepared for range
 invalidation
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 17:18, Eric Auger <eric.auger@redhat.com> wrote:
>
> Enhance the smmu_iotlb_inv_iova() helper with range invalidation.
> This uses the new fields passed in the NH_VA and NH_VAA commands:
> the size of the range, the level and the granule.
>
> As NH_VA and NH_VAA both use those fields, their decoding and
> handling is factorized in a new smmuv3_s1_range_inval() helper.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Haven't looked too closely at this patch, but see my remarks
on patch 6 about keys and lookups.

thanks
-- PMM

