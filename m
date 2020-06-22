Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892DA2541D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0o12OZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892DA2541D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnG6W-0005Oh-Qw
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1k-0006c3-Hi; Mon, 22 Jun 2020 02:33:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1h-0007vc-MT; Mon, 22 Jun 2020 02:33:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id x16so4555894wmj.1;
 Sun, 21 Jun 2020 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Bf9mVslhR8Md1AJAa172xTX30v7Z4QWEBUyTeFfWAU4=;
 b=p0o12OZ3EJiu6TbgQNLrR89eYluwfA5iYe5EVxpVWp5PoX+ENaVbloaFOH/ESk+ul5
 3s1GZDgFlPG+T9BSqFjkB1rSpEkPizbxKXOgm7xrepZcZ6MyMQCTh3ainRrVCu0Z3LrH
 uR3l1CqNXfrma7+Mu62sQ0rgLddzOEQkQeOFbBOQiXBBCxsQRzSTFzhmmTw5GXk58OFh
 9+YpBgxhkRHzM+r1FXSBdEHP2rm2A1hYp2Fcs2z8giI5/n61Pa2xF/oPXu0W+41aVNts
 AcCkVNy9tWixPgLos05n43UZDBEQaIGSk9W1PfP+NTXmow8pbrnALXULBJzaDB//B+RW
 D67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Bf9mVslhR8Md1AJAa172xTX30v7Z4QWEBUyTeFfWAU4=;
 b=XN0kNOxEGYxkZ8PRBjXJpZOAvybuWY/UCOYYkJMgRx+2xaJcb5OhgAan+CW27ev00i
 ING4ZUeOe+yM6RVIni3x2lNSpo+arRXm3Pb+w/KvpvBJPSoeBCbcXYpgRFcebrq94ou2
 TgzPcSQCi+usO/4Hr5UWgUUhJ6M1IlRfgtiKN8/ls0akyD61tiRjYv/flDbJsSPXRW9a
 LRAp6WKF2EOljldqOLH5Ust9O9W40RLuU+xIb6tBbteYvC6Tj/WZSYkacNUkVlLg2T/m
 OLNeU9ur3eOakYHZZOaZY+vcejZsM2+AiMcouH7Z3xHWLXgbmq+Vwyw8gdW4ZMqvHcpt
 SfvQ==
X-Gm-Message-State: AOAM533joqQ8KSEWDKK+lIhtxKD40JlaeQ1PvWM1bPbVW2lSo2cfXUSS
 gN/W9C1GsVnrcJzkTPhxscs=
X-Google-Smtp-Source: ABdhPJxrsHGxPd8Eu7eA08bYb8E62OX07e+JeAE7oc1K80El8Keyw9+g/JLO423rBAqcv3z+/bpFjw==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr5242721wmi.19.1592807627832; 
 Sun, 21 Jun 2020 23:33:47 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id a10sm16684240wrm.21.2020.06.21.23.33.45
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 21 Jun 2020 23:33:47 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 6/7] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
Date: Sun, 21 Jun 2020 23:33:23 -0700
Message-Id: <1592807604-20805-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This updates the GitLab CI opensbi job to build opensbi bios images
for the generic platform.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>

---

Changes in v2:
- Include ELF images in the artifacts

 .gitlab-ci.d/opensbi.yml | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c0..23e2fe4 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -34,18 +34,14 @@ build-opensbi:
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
+   - pc-bios/opensbi-riscv32-generic-fw_jump.bin
+   - pc-bios/opensbi-riscv32-generic-fw_jump.elf
+   - pc-bios/opensbi-riscv64-generic-fw_jump.bin
+   - pc-bios/opensbi-riscv64-generic-fw_jump.elf
+   - opensbi32-generic-stdout.log
+   - opensbi32-generic-stderr.log
+   - opensbi64-generic-stdout.log
+   - opensbi64-generic-stderr.log
  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
  variables:
    GIT_DEPTH: 3
@@ -54,10 +50,6 @@ build-opensbi:
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


