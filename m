Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A15C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DD220663
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEcTL7mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DD220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlF0-0006I7-5p
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlDw-0004Z3-Kn; Fri, 10 Jul 2020 01:05:24 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlDv-0006I6-3t; Fri, 10 Jul 2020 01:05:24 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ch3so2095061pjb.5;
 Thu, 09 Jul 2020 22:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YUmFSMzRZAi3mzFNX7N3yQtui2gfoXBfZk6bh5/WxTY=;
 b=TEcTL7mntWGet8gfBsPhvLwVFU+W6lYVo4CidgiImrEHFXPGCh2UvC5lL1rTs96L8i
 NVRmCTJwYIl9NaGSMPvCWZkOsg0wLYcE/OhIETx456VglUXI6frEIXpTEio9aTfwc/3V
 Md+0UmSSknZ2p3dwUdqdLBoe7EaII48Ndl7ti+Or/T5G20SBrq/Xux6D3reUduHYbjVs
 HCDiPc/I1b+QCUu7fR8IPqa+QLppnsNrGw2kHdzizKKNndzypkPQgBTPQx+6fVE2lYQe
 InnRDLVRCQO6gepqs8M6fkm6/aKsLP1hhNtKQtyNjmkJ3yLcNHu3RRTTTa05oPi/0pif
 xLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YUmFSMzRZAi3mzFNX7N3yQtui2gfoXBfZk6bh5/WxTY=;
 b=sjy0KQbO8Ey/37W90mcthNoNS0uYPI9ZkvC1XBLdxaT219I3ZgL0qg4tZKSmu6AAsP
 wzJRVkmAvVvqtIFC9cRG4nyrZR/qgd507O1egfT51KyduxhrDu8GQeOf47kqUGe2Cg1p
 iyyaRrIOglUZFG7PK3+5ngi49S7XEP6+E3nNrKXPKEaiWlYhOInAExrFqUtaTAXdTmi6
 r6sM99Z7RUclKMRe95F5Xmp8x2LEJ2CjN8oRnTAmfD9VPj6Tnx+Dx7vcI6z4nejnSBYF
 ACzVopXEIrScEM9bb5fS85ILD2AWdXOfb8Om104N/IBXpWAaYkKVdws+9tvD+VlkHUHP
 KjJg==
X-Gm-Message-State: AOAM530yO2MwlvUFy78nMp0AlvwCgFUGeoaoZAZcMgRApyufC4+G04Sy
 0YbEUOn6EEtv8E5Ae8VtJO4=
X-Google-Smtp-Source: ABdhPJysy3b0ebEJRdSEnUsD4vMbLJwgaDXtJmzOVg2V1VTghjdr2d4wks+1LQO+l4ZGPdwqhfKRfg==
X-Received: by 2002:a17:90a:25ef:: with SMTP id
 k102mr3788498pje.145.1594357521206; 
 Thu, 09 Jul 2020 22:05:21 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id g30sm4659175pfq.189.2020.07.09.22.05.20
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 09 Jul 2020 22:05:20 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 1/7] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Thu,  9 Jul 2020 22:04:53 -0700
Message-Id: <1594357499-29068-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now we need to ship the OpenSBI fw_dynamic.elf image for the
RISC-V Spike machine, it requires us to create symbolic links
for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v2)

Changes in v2:
- new patch: configure: Create symbolic links for pc-bios/*.elf files

 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index ee6c3c6..36ffe82 100755
--- a/configure
+++ b/configure
@@ -8539,6 +8539,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.7.4


