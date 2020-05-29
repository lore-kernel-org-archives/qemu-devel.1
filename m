Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABBF2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ckDd96dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABBF2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejMA-00054k-W2
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKx-000467-P9
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:31 -0400
Received: from mail-bn7nam10on2138.outbound.protection.outlook.com
 ([40.107.92.138]:39969 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jejKw-00068r-Mi
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOk19/RP7MoL05xnFlcuKfEALpJxsbUwrrec3UTZj9ZJRunCekf2jOkHtrs693GOmVTMxVvI6qzvXevJER3cxwZQhHCuCRSZ/rO+9Btw6dHrWWPJqoJ7m/0+vnm1N/vd6Lo0jNwHj5KQxxMi/5OF4foJs0ma65jdEMVv+JRCM9CFMRtkGTqxJY2zkJ0kwlSSP+awUA9DivjvvSYYABYo2e/pFTJE8XVURcdnlVpCbRL7uK/EUOIX9/+srPgHBr116rp7bpCOTBKAiNkloLySKy61FhPGYdexg9wpJdA0ejchCIoeYYANL91TNY2TtyrKUjAm3CUhCCIQY4hcJRsKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a50Bva5hWYNdNWV4SjgfgoQAl2STW1yYA2HCrS5fzG8=;
 b=OQZGQguh4FhBL4+QhseeDUclM2dffoOOPSPnia8yC7WK/44FmJl/RYjgaZw3uUqDTQxqA6egomocWX21WjhMK3PRkJHvOlg7UsEeDiwHUcqG/zkY9xpHU0oJKZlAwtu0TAgm/2n4KClde57egukARBcuNT+cN5JPf4vF0JF9W091IYrMakrJEACt/CnBd7yB0dUV5d1Q/suGN6ycOzvkYiVTyqSiRvQZg9OvkJZ0g7qXatExV0NGWVRvmtMCD8HUlvB0nrBr4Qh6MfucUKHXZMW2sby2Fe/6tgOgdCvlUKFKBkKRyuazm9MLtMGRfVFygy5K1IZNAZ/igLaj6Yrj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a50Bva5hWYNdNWV4SjgfgoQAl2STW1yYA2HCrS5fzG8=;
 b=ckDd96dnKDBHcpX2YXpA/3iaHwS0uwlyAejfEhyN8MWBtPVBrlJiyMI9UhFDn7lHOLFbRmKDkKy2ZK2nl1GUCiy7T2sRUiMT7qlunHLxkGqd1697sPIdtN2EBp6OPoxGpLXDC9GBdZdT9gw2imoGaYWNy3BME5lmM1zUI9tmVxU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4096.namprd03.prod.outlook.com (2603:10b6:805:ba::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 29 May
 2020 18:02:27 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:02:27 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] fuzz: skip QTest serialization
Date: Fri, 29 May 2020 14:02:09 -0400
Message-Id: <20200529180210.28120-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529180210.28120-1-alxndr@bu.edu>
References: <20200529180210.28120-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend
 Transport; Fri, 29 May 2020 18:02:26 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83326b1-35f9-483b-9fc1-08d803fa7268
X-MS-TrafficTypeDiagnostic: SN6PR03MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4096D672FB9BE009E191A263BA8F0@SN6PR03MB4096.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4khsa24pz3RZy9YHdzSyCOGCYXnA38BEPEK4+DFStE27JDMTn/HhLZ/BYK43v7lOXj5JtmxMf7QjqSFUESU0NubGy+VmmElac+zUE3WJnA3NQZ8WP0eViZHQ3xZYb7NAaSB990Gt3mJ2U3pg2cryN0iseMQ7wlcIYWWpxC7nutYkFAmrK/IanHmXHiqsNDRoaaAX7QthivcteEfRefJ7mGMj+TekLOfwdnRWhjtsuCmBk8XCUBYdtYYkLqlOEY50EUrsXPI5i6mIZL9iGEfGlPR7W4g5WYww71kVJModsx8pXf89PYbPIz4+wuBywgTaXM4VA50GJJFuieVTUvLGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(8676002)(4326008)(6486002)(786003)(956004)(8936002)(6916009)(7696005)(186003)(54906003)(26005)(52116002)(478600001)(83380400001)(16526019)(316002)(2616005)(66946007)(36756003)(66556008)(1076003)(66476007)(6666004)(86362001)(5660300002)(2906002)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +UE78iL+BWaZIi+ELMFs7HjqbFlG8UoElO3blsC+b6N8jioP8nqlBBuSzkas87/4jENchFkiMaJvclT9XIsf7PObANXildCklzagcoEZ/TJBlCkwwZyUydcaBY/+k/PvwLyGu8x/+s2Vi6kl6brtD5xjtAwJ3BvEybg8e+MrCDuxiDTyy6kl+mNMNJSQj79iQFBHSyGTg8nJVOQbW45z0DyEdde2RdMdj1Sb1iySchv8RXwBoHuaXK/N2cbGIBYtIe9wCyrjkpXaa7yBvoGR5afK+5IxywjIhlvAwdGNVZ6d7SazYxdb9/0JGH1+whtjMB//1jQlFOYFrfFxfiVGG4GquxGsBISG1PNdTCNrT5cK9NHUfCFZQfVxMy9wvf0rCt1Is2fgLijiZUQSMw3DvAETRqzcY0rQCgprjwB+aeOqyPiNm//FpY567KAqFemG6VbLFNsxEZigJvNczbOqkcyX36cpDrMoo/BkQdvWBtk=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f83326b1-35f9-483b-9fc1-08d803fa7268
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 18:02:27.0970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nvxVid2dvSrHKjs20euhipOleyLOPlznMY/ZUKN71FFC9l50ibvAMN5XYETn2qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4096
Received-SPF: pass client-ip=40.107.92.138; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 14:02:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 tests/qtest/fuzz/Makefile.include | 21 +++++++++++++++++++++
 tests/qtest/fuzz/fuzz.c           | 14 +++++++++++++-
 tests/qtest/fuzz/fuzz.h           |  3 +++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index f259d866c9..5bde793bf2 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -5,6 +5,7 @@ fuzz-obj-y += $(libqos-obj-y)
 fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
 fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
 fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
+fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
 
 # Targets
 fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
@@ -16,3 +17,23 @@ FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
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
index f5c923852e..cf76a6636f 100644
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
 
@@ -137,6 +140,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 {
 
     char *target_name;
+    char *dir;
+    bool serialize = false;
 
     /* Initialize qgraph and modules */
     qos_graph_init();
@@ -157,6 +162,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
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
-- 
2.26.2


