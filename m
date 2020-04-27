Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E92F20575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbcGVkxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E92F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3Zo-0005Hr-N1
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Z5-0004E3-EF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Z4-0003XV-TT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:12:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3Z4-0003X4-GS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:12:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id j26so25998078ots.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JkmF1I4n/URZA4JyIM+pngRW/xLN9zhqzG0w+jHOOfQ=;
 b=RbcGVkxaecf8F+7SKPne3Y4DqIWpLL7iGncmh39y7S+nzEQfbf8QBSMNjjWwpegZ48
 6WAnf3MJ+PgATGxwsVzO5a30YRdjo7XYXiGanJRayKG6gztyMXk5xEEp63BX/Lrs1S2U
 FOWjxR2N/DiKn9Qd5++e65qcOvz1CyeB344dvAohyoe82WIj72TIJ/p3Gy8661Bm+Kmb
 Q6qzj/hLuT0yeKWsj0W/TfJfFRhIxqbJjNItvAj72p3KaK7lyG8kBtRzLScCq7jTXMzI
 03Da6KCICi6gr5EhBxSJ8dNRxcdJbdWUivNuV4QCW/9AGq5nCLUHjm/M6La7a2s+CB5d
 h6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JkmF1I4n/URZA4JyIM+pngRW/xLN9zhqzG0w+jHOOfQ=;
 b=rwC6oOWjvCwCkBT+qzzYfhbux2pxg+7gSqPexM2T5owecpo3QfCmeVK2pTzGzbiNnc
 HjS8d1xfTe5gwmaypWPf3sbZDnR3CcPyRgm4pyheAky/3zMKRnSMGHsV4j7ishcMKwWQ
 fEKXSf+pb6cVSqj1uvfI5JwoPv1MPQXyyz/3ybQCiBZm7FppoOWZqEHJs3DPv0e2TXXr
 mnrgEaD+u/pTlTIP7WZzzriIiIkqtHrwSJlpXW+2zGdh0QLs/XMK/py+KRFPYGmWDgn1
 qfmX3JEOnnFL4WAhXDG+Fb6kvqtFJgZU1puVoWNMwQ1wP7FvHts6tmRqpYBXlc3ibO9X
 JZUQ==
X-Gm-Message-State: AGi0PubSJqQ/apb1ylhPeSHcLSNF2Gt2QzAOrJUumlbEy0Jh2PQevust
 d5cIKS3X+IuoHkL8YT9VrCj5dFTVIKiEK/C79ArjKg==
X-Google-Smtp-Source: APiQypIiNiPrqkJcRN6J6sSRnXqLT7yA065n4zbveI5YjCrUh3pBJb+nNMYc1m82xRgQeqk0xTZ+jE0P1yLHx+qmb5E=
X-Received: by 2002:aca:c751:: with SMTP id x78mr15798887oif.163.1587993169097; 
 Mon, 27 Apr 2020 06:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200423121114.4274-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200423121114.4274-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 14:12:37 +0100
Message-ID: <CAFEAcA-cMnC6gbhG5OTUhZX8WKSu_WKn3hkeSM=_9USmn45+rA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hw/arm: xlnx-zcu102: Disable unsupported FDT
 firmware nodes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 13:11, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> When users try direct Linux runs on the ZynqMP models without enabling
> EL3 (and using appropriate FW) they run into trouble because the
> upstream kernel device-tree has EL3 based firmware nodes by default.
> PSCI firmware nodes work because we emulate the firmware in QEMU.
>
> This series avoids that problem by disabling firmware nodes that the
> machine cannot support due to lack of EL3 or EL2 support.
>
> This means we can now (without manually editing DTBs) run the following
> in a current Linux tree:
>
> qemu-system-aarch64 -M xlnx-zcu102 -m 2G -dtb arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb -serial mon:stdio -kernel arch/arm64/boot/Image -initrd zu-rootfs.cpio.gz -append rdinit=/bin/sh
>
> Cheers,
> Edgar



Applied to target-arm.next, thanks.

-- PMM

