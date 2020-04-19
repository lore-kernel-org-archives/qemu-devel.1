Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17340C54F70
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D205D206D9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwY83jKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D205D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCoR-00005Y-Vu
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42264 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn8-0006t4-2w
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:34 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn6-0006h6-82
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40812)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQCn5-0006dt-Rq; Sun, 19 Apr 2020 12:27:31 -0400
Received: by mail-lj1-x241.google.com with SMTP id y4so7233516ljn.7;
 Sun, 19 Apr 2020 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zea47P0jsAgl833i1uDDqFXtv2d7bbCrHYTlMItLIlg=;
 b=WwY83jKISA77naTEOAD0l2kyfpjxMpF4wWxWAyxlz0reRCT45GFXA5hLKpUI6hcZsX
 Ja7hW8YaR6UmNFkRZpur9zPnXfp3WdMyNkET2kvjjsGmHDKuITmlN+4hHDY4QGLxTtLs
 bnDhKUB+OoU4hW5hy2vD2NS2kcXm+4BJBA2uzLXmNyIMzyqbi6Y/1GPfTuhLzFJB2mWb
 qY87wlPwkgvYemkR4GGUdpRLczTljb+T/ayZUmxYnwACJ9L6+ZdIM9qumqE12xnYoSKW
 f4RvZHKyYwMz9u+3PWOGWniQ4NQ/15CFkgDB38Nh/T4e7V6xsYkIaRAgVXHnSmmfs14d
 2f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zea47P0jsAgl833i1uDDqFXtv2d7bbCrHYTlMItLIlg=;
 b=AJeS5BO3bwQ9yDCb8aiAwmXZYjTvW0yG+wyGuRXfp3SGFLDltaa4bO2gEszn2+95Hx
 62fDfX51t0147uYt34/lLGT0w10X+N72+3cxwCBXdy0cOZcTO+37TWgRC6HV8fa+TKjH
 E8eVWrcYiKkyTWIw2/uMuw589myK6nhP1NrW6bmeYjXlMt33y9PPGzHJCdfr+VbJRyPv
 0uBZpUGtsaC1ig6EpnbEYHPSjUqKgi8cEhCGvIebKvtyHrtHrtMk1KUg8LiD7Sb0EJuu
 /Ij1ciTnKUL+xIkT5Uv+Z9PkwE+ZKdmuKlsqk6HNWW4PknyOg8njxTazW9C24KWOCwMz
 eIsw==
X-Gm-Message-State: AGi0PubtEqjkjqzaPDi+FGhofRjsPrRF/Gu/fEnJT5YNYCftWnriQroC
 hrGMFe5RESkHYj4NKGuMxGYk4/xoJYw=
X-Google-Smtp-Source: APiQypINS+7dPeitakOd4rH5KrZa2lPDXfvPHhIjsZK056G+z568hM68mJl5puPpptU31Cq7V6wX6A==
X-Received: by 2002:a2e:7e0b:: with SMTP id z11mr1436323ljc.284.1587313648503; 
 Sun, 19 Apr 2020 09:27:28 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j19sm24471954lfe.17.2020.04.19.09.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 09:27:27 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/3] hw/arm: xlnx-zcu102: Disable unsupported FDT firmware
 nodes
Date: Sun, 19 Apr 2020 18:27:24 +0200
Message-Id: <20200419162727.19148-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When users try direct Linux runs on the ZynqMP models without enabling
EL3 (and using appropriate FW) they run into trouble because the
upstream kernel device-tree has EL3 based non-PSCI firmware nodes by default.
PSCI firmware nodes work because we emulate the firmware in QEMU.

This series avoids that problem by disabling zynqmp-firmware nodes that the
machine cannot support due to lack of EL3 or EL2 support.

This means we can now (without manually editing DTBs) run the following
in a current Linux tree:

qemu-system-aarch64 -M xlnx-zcu102 -m 2G -dtb arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb -serial mon:stdio -kernel arch/arm64/boot/Image -initrd zu-rootfs.cpio.gz -append rdinit=/bin/sh

Cheers,
Edgar

Edgar E. Iglesias (3):
  device_tree: Allow name wildcards in qemu_fdt_node_path()
  hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
  hw/arm: xlnx-zcu102: Disable unsupported FDT firmware nodes

 device_tree.c                |  2 +-
 hw/arm/xlnx-zcu102.c         | 40 ++++++++++++++++++++++++++++++++----
 include/sysemu/device_tree.h |  3 +++
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.20.1


