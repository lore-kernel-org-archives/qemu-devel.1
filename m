Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53427C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20528206F6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay8rFZkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20528206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Uzu-0007mr-1f
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uw2-0001dn-5W; Mon, 03 Aug 2020 03:31:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvw-00067I-Mb; Mon, 03 Aug 2020 03:31:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id 9so13350141wmj.5;
 Mon, 03 Aug 2020 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gPk8wbtFKUEMIlCNhLaq8+ecNgu5uEuNf0fX/hiwAcE=;
 b=ay8rFZknwf7n8UgDde4ul3vTyVbseIkCXml5U2WPdLodlF2VheD8xyKBszTM1iHQQ9
 V7vnSGsfa6dsbKXHgYZSLDM4HsK2TYjK/BfApfIjATUMnDyFies6nOmu1diWOjWMgmw2
 wGsYYTSXBofUG/6bVa4Eaxdyr0fxR0OnI1LBoPS3wUXSVIr2BA1V1r9Ol+20ESO7qWhA
 C/NY4xXDCyQOya6wfs58i4YSSj/9BTBGcG1h5aF6OXbe3cUe4DRg+DWADbuV9fqzdaqf
 RJ5kccNsH7coUfu90xIPEBx152akY+l/X0br6Gu4DlXT9DSdg3N/HVSeNsyoNP1JhAT8
 Vvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gPk8wbtFKUEMIlCNhLaq8+ecNgu5uEuNf0fX/hiwAcE=;
 b=eZgGSWVDufYSxmMb19VJBbCyl4OxKmsjY601iTrSaC+cCdjB5TshLKWWkmoVnyPMGe
 EcoYAojmr0mTdZep9527u6VJLoChvOT+wGDMLMtOgN3o5C3mvQmg7EK6JdJny5FrJsqM
 nXdISihwjX+yLEcNSCNgbGVFJtlFevCeFU157e0WsN1lPl01Wrro6WPRLF09eiXX7mdV
 gaAvk5E1GQ1kr10mWd/w0njhnJ6mKxjz/rr5ryKiWO86+yYseNyht+LhgKeK1GDY9LSl
 abw7XSlBewpYmFIz1zdT4zIWGHMBSKjPHZwhDjrEInLiOLFzog1P0di8fA6RLsdZ5lD6
 XzGg==
X-Gm-Message-State: AOAM531zSGekdZ77UPjvxuPYJg02j8Nb8W8N4HCpr/Du0QkOFx0gKSMa
 h9mFy5HCbFQmkQNzNrsiD8I=
X-Google-Smtp-Source: ABdhPJyZ0Iuv8uf1qVl4xz5y8jugUH/Mop5YZDARo6YpC/Dao92rIdVjdoOboL8+by3b2xrIoKzFJw==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr16019395wme.16.1596439854092; 
 Mon, 03 Aug 2020 00:30:54 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 130sm23969438wme.26.2020.08.03.00.30.52
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 03 Aug 2020 00:30:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 6/6] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
Date: Mon,  3 Aug 2020 00:30:32 -0700
Message-Id: <1596439832-29238-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
References: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This updates the GitLab CI opensbi job to build opensbi bios images
for the generic platform.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v3)

Changes in v3:
- Generate fw_dynamic images in the artifacts

Changes in v2:
- Include ELF images in the artifacts

 .gitlab-ci.d/opensbi.yml | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 62088ec..5b13047 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -35,18 +35,14 @@ build-opensbi:
    when: always
  artifacts:
    paths: # 'artifacts.zip' will contains the following files:
-   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
-   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
-   - opensbi32-virt-stdout.log
-   - opensbi32-virt-stderr.log
-   - opensbi64-virt-stdout.log
-   - opensbi64-virt-stderr.log
-   - opensbi32-sifive_u-stdout.log
-   - opensbi32-sifive_u-stderr.log
-   - opensbi64-sifive_u-stdout.log
-   - opensbi64-sifive_u-stderr.log
+   - pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
+   - pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
+   - pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
+   - pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
+   - opensbi32-generic-stdout.log
+   - opensbi32-generic-stderr.log
+   - opensbi64-generic-stdout.log
+   - opensbi64-generic-stderr.log
  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
  variables:
    GIT_DEPTH: 3
@@ -55,10 +51,6 @@ build-opensbi:
  - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
  - echo "=== Using ${JOBS} simultaneous jobs ==="
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
-- 
2.7.4


