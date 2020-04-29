Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B1C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F4F2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UY4GTyPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrhq-00045u-Oy
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraE-0008RT-PN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraB-0003VH-R8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra5-0003PL-F1; Wed, 29 Apr 2020 14:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185434; x=1619721434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uth3SOy7J70UXYgMlMkEumsDQFWDBmDIt0wImRmilQQ=;
 b=UY4GTyPgobkdf/2b5gmBg+q9tLK/Nz5thcHTOmObrWNCZoNAGx/5W7uI
 srVeR/BxkxoLFfiqalF7XHLBlacF1w2YfNeTklVLSCSN0MUVOCw4ANmhY
 NPBB3HNTh6hOg16XYjQQ+7xOvgjsU6Nr7gOX/ryC9pde27/JR+ESU7V6g
 LI4lHqfPtA/lMo6WQJH8gvMjk2WrdvVtW5LnGWT/Got4TUna2MBjN+FaL
 FTxwP0J06ua6OG94ufzX0K5XBzQvppM6EJNniHljpWS5UGyAN/06o9BZ/
 5P25jzY1luPcbFrgxs68b+nOhFYwu9aiQZJiR3YqK7yAIwZSwmI0kB9Jg w==;
IronPort-SDR: 7wVa8qGSN35GJJM8a2kecfPF8uTylSr/EQX3+hGY4r19IUnabMXPS4rwFMQg+FWXkk6T4EmXG5
 AJz30k31fN81ExhxcV7bvL6tuqDKHn/6DckS+PtMYO3QCPzwscQTK6GwO6sCr6y5/IPt16pwlx
 G7RnVgwKuVtGl6uISmQxwHtP9l43KShLaepbf0ECatpo9FvOvT56TXlvuxQsqoN8mU/wHpHlfd
 FzRlGutB32RiYx9aDH1GJMrFbHv/G2MJchyWOKD6kXW0EwjI7NIwnuFJIeNad/0cYPPHsV/1ZE
 YrY=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935146"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:06 +0800
IronPort-SDR: /zRL849gXteY/znLM78iVERjyJ5BR84DK/W9wRnq3LELcMgxIxfO8LtIPQv4JIlE0V/ZePf4kn
 adjDSV2vD9bqJ9NwkrWOCcTLEYXMk68ac=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:10 -0700
IronPort-SDR: 1dgaDGiAqqODlBTSFMFfNB6jSrEMkMF4WYn3AsXp+NkSV89OQFg9rGumJ1YBXM/8YaELiHUgFv
 ewwHpgjFyMuQ==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 08/14] riscv: sifive_e: Support changing CPU type
Date: Wed, 29 Apr 2020 11:28:50 -0700
Message-Id: <20200429182856.2588202-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: qemu-riscv@nongnu.org, Corey Wharton <coreyw7@fb.com>,
 palmerdabbelt@google.com, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Wharton <coreyw7@fb.com>

Allows the CPU to be changed from the default via the -cpu command
line option.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200313193429.8035-2-coreyw7@fb.com
Message-Id: <20200313193429.8035-2-coreyw7@fb.com>
[ Changes by AF:
 - Set "cpu-type" from the machine and not SoC
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 646553a7c3..b53109521e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -123,8 +123,6 @@ static void riscv_sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
-                            &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
     sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
@@ -141,6 +139,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
 
+    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
+                            &error_abort);
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
                             &error_abort);
 
@@ -219,6 +219,7 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = riscv_sifive_e_init;
     mc->max_cpus = 1;
+    mc->default_cpu_type = SIFIVE_E_CPU;
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-- 
2.26.2


