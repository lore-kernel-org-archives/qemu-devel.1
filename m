Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD0EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2C520663
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsW8fobP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2C520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTRt-0003SP-Fy
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtTRA-0002za-Jt; Thu, 09 Jul 2020 06:05:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtTR8-0005Jk-UO; Thu, 09 Jul 2020 06:05:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id m22so766267pgv.9;
 Thu, 09 Jul 2020 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AMyr7dWDU73aKt2+6divzOJRdddWTJsk4BMrMGpRhgw=;
 b=PsW8fobPnVQH0or/eZWzSMjyz42ZHEsBkYcsE3icVUBrgglScIGwSAJ5gkSngnKHCQ
 /Lzybe/A0+HIlpk4xyLf1rSxQnSr5G9wqunxx+25Fi6YUGeIcRZg4UPP1FhOjGKoJfJh
 undjdmEmG6mI6GnLRIJtYXwieQfTq0dRKD85tbXPs7NzkqazOVzMZVjY1i4AmiOoxzWu
 D2iqcdfFw5daTE5fvMfcfLl1yDLaPwNIL7pY6joFyLxOhpfIdUaKdhEkZq3qc5X3LrHM
 YM/oGX6o0Gh/fIGmr27UKW2q4whkpPfBa+VPf94IHy55zyFs5NHxCE5Guz7ZJZ+KvAur
 8ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AMyr7dWDU73aKt2+6divzOJRdddWTJsk4BMrMGpRhgw=;
 b=QXfEtn8VxOSQH9pOWegnuj6Y6062RLlC7eMNK0YxQ2vBNVXLSXPQPrWj8GrbETXIs5
 +1/FTtYOIK3TiU5Xamd2SAJgIMZTrMbF2JgWuUHNgplbp5zZIrtWdy/oByK171KRtlsA
 gAltHk0KeFLzd5s7uYBPAgndCIDvCJSYwZgPwCMr46NhCl6gH46FGZe9FfEqGncTjdp2
 0OGO7krTBYxANPQ2ps2GrWVsOnh9n8F68piv2O6nXXIN3EuDLhThx4otrzgWgY6/NFDG
 H18+MXKiS8qCHr/TRCj24o+iKepq20byb4+vZTDjEgZd3amiv70tbpjxqf5K+438vXde
 TiKw==
X-Gm-Message-State: AOAM530r9A9juN4Ikb2eCmaVIOvri8REDSYUayY0L4+jn5MoORp5xu6b
 Rqg+B3+xP0BSiXoDZWaWvCc=
X-Google-Smtp-Source: ABdhPJyCra5Czz21hjT4yVZQ6G7k1HetCZAaL3tU/+9FIDWY5QcvNkH0PjU1Xz0pdQf+V5kOjw7MXQ==
X-Received: by 2002:a62:ce83:: with SMTP id
 y125mr55219087pfg.181.1594289149059; 
 Thu, 09 Jul 2020 03:05:49 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id cv7sm2093972pjb.9.2020.07.09.03.05.48
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 09 Jul 2020 03:05:48 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/2] hw/riscv: Modify MROM size to end at 0x10000
Date: Thu,  9 Jul 2020 03:05:43 -0700
Message-Id: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x543.google.com
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

At present the size of Mask ROM for sifive_u / spike / virt machines
is set to 0x11000, which ends at an unusual address. This changes the
size to 0xf000 so that it ends at 0x10000.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

(no changes since v1)

 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index dc46f64..3413369 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -70,7 +70,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
+    [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index a187aa3..ea4be98 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -57,7 +57,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,    0x11000 },
+    [SPIKE_MROM] =     {     0x1000,     0xf000 },
     [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5ca49c5..37b8c55 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } virt_memmap[] = {
     [VIRT_DEBUG] =       {        0x0,         0x100 },
-    [VIRT_MROM] =        {     0x1000,       0x11000 },
+    [VIRT_MROM] =        {     0x1000,        0xf000 },
     [VIRT_TEST] =        {   0x100000,        0x1000 },
     [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
-- 
2.7.4


