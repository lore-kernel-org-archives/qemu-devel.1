Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6DDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DC12075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="POwnswFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DC12075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiKu-0006Lu-H6
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiKB-0005nq-HR
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:57:39 -0400
Received: from mail-dm6nam10on2122.outbound.protection.outlook.com
 ([40.107.93.122]:57726 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiK9-0003Ul-IV
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6wCVNY4AuhRCfCQiO3nwEM0C7RaMWm4Cu4SKHlI/yuMCu8E//9Umv0dnVqrfzJgQSZZFU7KFhkWGKoiz7w/r19O8htwUmFPffKtfHYOePdr8W2v7r8JqOmjRGHBx3y9mTnCkNMEdiLg8uDpMrlGVy4Kk9WDmV0Mck6INimCzM4UFvQsiDn93TVSAlvOnigkCGWAm0SlwwVFjFCahjboVSPdNGGzhhSlAGwOUNYNkJgjKS5YndWqQZnOKljiTDQpZHlpElsikYEULYC4/l8ZCwpnmHq0AsT7REbh16EFRqHxWQgYJIX96DHPJIppEdmfeFYGXzor7fGuKZ+hhEHDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R693xrsfPjKMVeJfA9kIDi9VkchLPMpwuhXyduMZDI=;
 b=ersJAdNOGS9065IGaG+/sdNyZw9EB4bsB6H5vsoH9EUK1yLTBh9ayxs0Ps+dfMYHQ3QPqhf8rdcHLUypCB3eU/FOi4PDQJGLZAuuV4dUGkpVKkvUtOxqDgPqsSNcQUrLt01OO60yVaicPreX9rXrOisQ7tR+mfX9kI2727s3+XZ5eFEzXVnbB9EC4bNAfCw91f+/r2gSWp9d2lWPxWc70UDSZO3R+ziR0yKtUeo3pbBXqaz6c8oomuSaZY6tBW5xopFeue/F4doALCtuhCfYMj9AoQif+blA/KZCSovzdzK2ZMQy4KIZ46GqVgp0Pgp3UHL+BKqdc0TW+z0oZdPg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R693xrsfPjKMVeJfA9kIDi9VkchLPMpwuhXyduMZDI=;
 b=POwnswFMTILgSD0JqMfBcEy37O+b4E7qEASzV3tbQzv2DT3FBFvGblYUsVTG0VGpL9tlnj/WCBMBBJKkK5zvwKvCXcSVPJkGNLPC3EOST5aFqkr/aNddW3kXb8g49TL7UzXiPno2emF80etRdPxwAoE5WwlWbF8h1QuDOY8O5pM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3917.namprd03.prod.outlook.com (2603:10b6:805:72::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 29 May
 2020 16:57:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 16:57:34 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] fuzz: skip QTest serialization
Date: Fri, 29 May 2020 12:57:18 -0400
Message-Id: <20200529165719.19262-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529165719.19262-1-alxndr@bu.edu>
References: <20200529165719.19262-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:208:51::18) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0077.namprd02.prod.outlook.com (2603:10b6:208:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 16:57:33 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c05445b2-83ce-45e4-0a6e-08d803f16229
X-MS-TrafficTypeDiagnostic: SN6PR03MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3917BD1FECBFBD8EFCBAC532BA8F0@SN6PR03MB3917.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0pP917SNYnGSMMQTvnlGHyCKlSrf3Z9aMHByDYMP7V7RbfZq5HEldiTsqYmOgItf4I1YVLdUxt4J97Fku+MJO+fGB67EkveJys7VGC1y3l24SmEtCtvdhFH1i8rNKLo2KJakzcJkmEStYtbjEJ6/4DJR+WlpGpXGzad6EnLjuo/x6JQlLxWvBRymC40s+UDXWQgVCTRPkx+Ltj4+vOKfyWcZaI7ZPZKzbIqgwHp4bHUJm9ia7b2lMYiKO6XUxCv44YIxcOIX0BACZUxJQdx8aV/9yOc9BW8AwaQwmEa8ZJqKFqkQsmXEodfId8H2D1I7IdmQI95n4TP6UEipUujPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(8936002)(186003)(83380400001)(2616005)(956004)(6666004)(6486002)(1076003)(36756003)(30864003)(26005)(16526019)(786003)(316002)(54906003)(478600001)(4326008)(66476007)(5660300002)(66946007)(7696005)(52116002)(86362001)(66556008)(8676002)(6916009)(2906002)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vHo7xlBNBK5TpTgd1lqfAtXKvaoY+OdRrQJhGflOc1U+oibcko+BTzErfgBhLELngdeDF7Ek4jiVrE9d+T18bFTMzqc72svyU1MTnC0+qW36sjINbpKNIyt2QIQDxTirHmpw1fsX3RuMPR6CkX9fntQR7q8U3AWl5PhlieVCdoK867OdR9wcPa+HkmhaTyTpeZiPNqcpdaoJy6UwIk47k+KI6ctl4hPwimSFBKsWChK3NhWPpR/PXFFKxtZy6RMrTcmdLyWPRlEY6DaHlhCz4fvQlN4ZUUEiCAhUMEV1zzCCOfk+3LKz3qnObmVZ84dg+YCOJaeUot7Wz9qkNEJiwhfhyFsvSQ67d+MoU7BaFeITrORR8YeFdwLnS9Qx4vhyL6Sw7cXqTrdD+BV1J/MLeTDdM2ILuGeHxGGP7a1VKYJt8rhCXYVnyyId/G40KgxwWFaz8QSCBHkOZwBG3oG3a9u847VEaO78pbyAxApQ0KmFMriOjrHBWzR3NR6JFPo6
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c05445b2-83ce-45e4-0a6e-08d803f16229
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 16:57:34.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig3NCfgAIPED0m8KomC0g8D5RHi2Z7BHEzy5yQ7RjmDpDWKD4Wb9lRlVvsp1SwX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3917
Received-SPF: pass client-ip=40.107.93.122; envelope-from=alxndr@bu.edu;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 12:57:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QTest server usually parses ASCII commands from clients. Since we
fuzz within the QEMU process, skip the QTest serialization and server
for most QTest commands. Leave the option to use the ASCII protocol, to
generate readable traces for crash reproducers.

Inspired-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/Makefile.include |  21 +++
 tests/qtest/fuzz/fuzz.c           |  13 +-
 tests/qtest/fuzz/fuzz.h           |   3 +
 tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/fuzz/qtest_wrappers.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index e455bebc9d..0184f59406 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -5,6 +5,7 @@ fuzz-obj-y += $(libqos-obj-y)
 fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
 fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
 fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
+fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
 
 # Targets
 fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
@@ -17,3 +18,23 @@ FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 # Linker Script to force coverage-counters into known regions which we can mark
 # shared
 FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
+
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readq
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writew
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writel
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeq
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memread
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufread
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memwrite
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufwrite
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memset
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 33365c3782..ea630ddb9b 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -91,7 +91,10 @@ static void usage(char *path)
         printf(" * %s  : %s\n", tmp->target->name,
                 tmp->target->description);
     }
-    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n");
+    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n\n"
+           "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
+           "QTest commands into an ASCII protocol. Useful for building crash\n"
+           "reproducers, but slows down execution.\n");
     exit(0);
 }
 
@@ -138,6 +141,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     char *target_name;
     char *dir;
+    bool serialize = false;
 
     /* Initialize qgraph and modules */
     qos_graph_init();
@@ -172,6 +176,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
         usage(**argv);
     }
 
+    /* Should we always serialize qtest commands? */
+    if (getenv("FUZZ_SERIALIZE_QTEST")) {
+        serialize = true;
+    }
+
+    fuzz_qtest_set_serialize(serialize);
+
     /* Identify the fuzz target */
     fuzz_target = fuzz_get_target(target_name);
     if (!fuzz_target) {
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 03901d414e..72d5710f6c 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -82,6 +82,9 @@ typedef struct FuzzTarget {
 void flush_events(QTestState *);
 void reboot(QTestState *);
 
+/* Use the QTest ASCII protocol or call address_space API directly?*/
+void fuzz_qtest_set_serialize(bool option);
+
 /*
  * makes a copy of *target and adds it to the target-list.
  * i.e. fine to set up target on the caller's stack
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
new file mode 100644
index 0000000000..713c830cdb
--- /dev/null
+++ b/tests/qtest/fuzz/qtest_wrappers.c
@@ -0,0 +1,252 @@
+/*
+ * qtest function wrappers
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/ioport.h"
+
+#include "fuzz.h"
+
+static bool serialize = true;
+
+#define WRAP(RET_TYPE, NAME_AND_ARGS)\
+    RET_TYPE __wrap_##NAME_AND_ARGS;\
+    RET_TYPE __real_##NAME_AND_ARGS;
+
+WRAP(uint8_t  , qtest_inb(QTestState *s, uint16_t addr))
+WRAP(uint16_t , qtest_inw(QTestState *s, uint16_t addr))
+WRAP(uint32_t , qtest_inl(QTestState *s, uint16_t addr))
+WRAP(void     , qtest_outb(QTestState *s, uint16_t addr, uint8_t value))
+WRAP(void     , qtest_outw(QTestState *s, uint16_t addr, uint16_t value))
+WRAP(void     , qtest_outl(QTestState *s, uint16_t addr, uint32_t value))
+WRAP(uint8_t  , qtest_readb(QTestState *s, uint64_t addr))
+WRAP(uint16_t , qtest_readw(QTestState *s, uint64_t addr))
+WRAP(uint32_t , qtest_readl(QTestState *s, uint64_t addr))
+WRAP(uint64_t , qtest_readq(QTestState *s, uint64_t addr))
+WRAP(void     , qtest_writeb(QTestState *s, uint64_t addr, uint8_t value))
+WRAP(void     , qtest_writew(QTestState *s, uint64_t addr, uint16_t value))
+WRAP(void     , qtest_writel(QTestState *s, uint64_t addr, uint32_t value))
+WRAP(void     , qtest_writeq(QTestState *s, uint64_t addr, uint64_t value))
+WRAP(void     , qtest_memread(QTestState *s, uint64_t addr,
+                              void *data, size_t size))
+WRAP(void     , qtest_bufread(QTestState *s, uint64_t addr, void *data,
+                              size_t size))
+WRAP(void     , qtest_memwrite(QTestState *s, uint64_t addr, const void *data,
+                               size_t size))
+WRAP(void,      qtest_bufwrite(QTestState *s, uint64_t addr,
+                               const void *data, size_t size))
+WRAP(void,      qtest_memset(QTestState *s, uint64_t addr,
+                             uint8_t patt, size_t size))
+
+
+uint8_t __wrap_qtest_inb(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inb(addr);
+    } else {
+        return __real_qtest_inb(s, addr);
+    }
+}
+
+uint16_t __wrap_qtest_inw(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inw(addr);
+    } else {
+        return __real_qtest_inw(s, addr);
+    }
+}
+
+uint32_t __wrap_qtest_inl(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inl(addr);
+    } else {
+        return __real_qtest_inl(s, addr);
+    }
+}
+
+void __wrap_qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
+{
+    if (!serialize) {
+        cpu_outb(addr, value);
+    } else {
+        __real_qtest_outb(s, addr, value);
+    }
+}
+
+void __wrap_qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
+{
+    if (!serialize) {
+        cpu_outw(addr, value);
+    } else {
+        __real_qtest_outw(s, addr, value);
+    }
+}
+
+void __wrap_qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
+{
+    if (!serialize) {
+        cpu_outl(addr, value);
+    } else {
+        __real_qtest_outl(s, addr, value);
+    }
+}
+
+uint8_t __wrap_qtest_readb(QTestState *s, uint64_t addr)
+{
+    uint8_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 1);
+        return value;
+    } else {
+        return __real_qtest_readb(s, addr);
+    }
+}
+
+uint16_t __wrap_qtest_readw(QTestState *s, uint64_t addr)
+{
+    uint16_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 2);
+        return value;
+    } else {
+        return __real_qtest_readw(s, addr);
+    }
+}
+
+uint32_t __wrap_qtest_readl(QTestState *s, uint64_t addr)
+{
+    uint32_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 4);
+        return value;
+    } else {
+        return __real_qtest_readl(s, addr);
+    }
+}
+
+uint64_t __wrap_qtest_readq(QTestState *s, uint64_t addr)
+{
+    uint64_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 8);
+        return value;
+    } else {
+        return __real_qtest_readq(s, addr);
+    }
+}
+
+void __wrap_qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 1);
+    } else {
+        __real_qtest_writeb(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 2);
+    } else {
+        __real_qtest_writew(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 4);
+    } else {
+        __real_qtest_writel(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 8);
+    } else {
+        __real_qtest_writeq(s, addr, value);
+    }
+}
+
+void __wrap_qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           size);
+    } else {
+        __real_qtest_memread(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           size);
+    } else {
+        __real_qtest_bufread(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_memwrite(QTestState *s, uint64_t addr, const void *data,
+                           size_t size)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_memwrite(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_bufwrite(QTestState *s, uint64_t addr,
+                    const void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_bufwrite(s, addr, data, size);
+    }
+}
+void __wrap_qtest_memset(QTestState *s, uint64_t addr,
+                         uint8_t patt, size_t size)
+{
+    void *data;
+    if (!serialize) {
+        data = malloc(size);
+        memset(data, patt, size);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_memset(s, addr, patt, size);
+    }
+}
+
+void fuzz_qtest_set_serialize(bool option)
+{
+    serialize = option;
+}
-- 
2.26.2


