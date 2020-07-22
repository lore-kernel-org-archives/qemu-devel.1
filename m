Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9604CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3BE2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NN0Z0MPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3BE2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAGr-0002Kc-NH
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyAGE-0001ta-Ia
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:37:58 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:40547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyAFZ-0008Q9-Fv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:37:58 -0400
Received: by mail-oo1-xc41.google.com with SMTP id p26so258090oos.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v/cjIzbDBZgN1h/K4uwgkqsaC6CRNlxsyyzLkJMFcag=;
 b=NN0Z0MPxM4FgpbJLaAYzt/7m2yOYhEvjlZlEq1nt98qxTV9E1/HctHgRboCddyhXHD
 6P/gOw4L5/QfWzDGga55Acm9lfC0IWEtCm5X4A9Jzisv9ym3Y4eonH3mcufX9Zcag+XE
 WPhsDlk00DsyfwF/DxBnFlmlGdcvJQOfZAFS0N6eXWVL/d8ldNIO50FD6yhnwk7ZP6EG
 qzE5K5dzE6HL6JcCB5Q9IAItbzz1UowMSloi7G+2mEgj/JQPqxbkniibFw8Pi0Bxh116
 PkpRD32Y2fINRo9QvjCvWIZ/liGHIPHxML+PBMyh30ZHu8RFZUkCWeNqb2eVRNhoS/lX
 DXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v/cjIzbDBZgN1h/K4uwgkqsaC6CRNlxsyyzLkJMFcag=;
 b=Zt064Fe0AMH3XxBbHD88bwkdg/Q1ck5qFontXxS+N2OPIfQqwBHOef5cFUslBaEgBb
 fgVN6OqafxNvAw8pN1O7DUWosbfT7NmvMlMUW/ApAzPTyxkmwGWzK6S9Jmzzo62/h/hg
 oKq/gVcVctTrhQkguP3a0joc+2IJCeyDBtEiFHwnyHk0x9sNag3KRnOLjkJE/c7c/ZIq
 DyzLIswBsMNQ6es4Uht+J0Hhr5ROIrw5frT3HrQ65oHWr+6cFXwnB2hJztU2bKZG7gmN
 hr98goT+3yPaOLwqPSBJf+nfseSjo0BCF/X/oPqYcUM4/8jsomSDHOA7tejASM9bx5xM
 wbjA==
X-Gm-Message-State: AOAM531xRL7/q+qDydzMGdT1fE8h8sZH7a/PmFBSrcsXFsv37MNosPE/
 gW40LsX3wcxLF30soI4jrHwdu7oXX9sLZrzA3XqHrA==
X-Google-Smtp-Source: ABdhPJzqJuTJAYsOunwDJqyCJRY3q1BfoJvF9IJNGndMA1y17zIvB+6eDSufPm/uVRIgFhZ6o12eAaK7kibKvHB8Vkk=
X-Received: by 2002:a4a:8784:: with SMTP id b4mr27476612ooi.69.1595407036200; 
 Wed, 22 Jul 2020 01:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200722081323.9893-1-guang.zeng@intel.com>
In-Reply-To: <20200722081323.9893-1-guang.zeng@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2020 09:37:05 +0100
Message-ID: <CAFEAcA-M6OghOCX76q2kZDh_Nf1YLEDSLZcwa2ZVJgzwjdDaWw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: support pci device state migration
To: Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, wei.w.wang@intel.com,
 Jiri Slaby <jslaby@suse.cz>, chao.gao@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 at 09:31, Zeng Guang <guang.zeng@intel.com> wrote:
>
> Currently edu device doesn't support live migration. Part of PCI
> configuration information would be lost after migration.
>
> PCI device state in source VM:
>      Bus  0, device   3, function 0:
>      Class 0255: PCI device 1234:11e8
>      PCI subsystem 1af4:1100
>      IRQ 11, pin A
>      BAR0: 32 bit memory at 0xfea00000 [0xfeafffff].
>      id ""
>
> PCI device state in destination VM:
>      Bus  0, device   3, function 0:
>      Class 0255: PCI device 1234:11e8
>      PCI subsystem 1af4:1100
>      IRQ 0, pin A
>      BAR0: 32 bit memory at 0xffffffffffffffff [0x000ffffe].
>      id ""
>
> Add VMState for edu device to support migration.
>
> Signed-off-by: Gao Chao <chao.gao@intel.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Hi; thanks for adding migration support for this device.


> +static const VMStateDescription vmstate_edu = {
> +    .name = "edu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pdev, EduState),

This isn't the only state that the device has. You
also need to migrate:
stopping, addr4, fact, status, irq_status, the struct dma_state members,
the dma_timer, dma_buf and dma_mask.


thanks
-- PMM

