Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE9920825
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 05:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="CikMtqiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE9920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGEt-0003Pw-B1
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 01:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDh-000273-I8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:45 -0400
Received: from mail-dm6nam11on2121.outbound.protection.outlook.com
 ([40.107.223.121]:54785 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDg-0002UZ-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUEyvKi9sn5KkQU/MVFXgksGWYOXgksVKkBcBRP0lvw7PUf5KK2PAMCbeW0dqRALjnxvlr9IFMzSO70EPrWUH8THYmSjUQ2VP9BGVupI/IiZtAN8gmBrYaUJ2YTn1JTeJZyDH8J+FnESzHdMGh6wPRR5FENvlTKjBGIgOYGlmsbonxp4IOhoiv2x+01WSN7WXaXaBlTIH7AaD3zUK6N4fDdUgc+Lpq67iQ81V4seDgQ7NqvJmQUYOAip+l5My1jNKXReWvyUtK39F1oqwAE4RreeLfrq/q3N+3ta7AsZbqmuuvl5TmR9zYwQ4CJRGzSaE4c6anjUZVA1DPlCxXHzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRwny3wMrw1+RpEj3ey2OgRIlFcf/Msbp1r2nKG7vAM=;
 b=nvlg+OH5DvZ+6HgWATo/Oj5JwY9fHcdpotmPB/kd8vJdFc69elebGq3RoN6n8gcCSb5VTgaCtXOa8aiE5CIf9OwxWJGO5+m8XqdmzCWd2BFWhZ+KL2/Sx+rgRQsWa2UimHmS6XGQo2G8o6r2BTJ2bCqeU0jyPLdHahD6ouZvBzcmHps3jOcuPD4RrQDv4+oBwHv6DS+MfOf2phlAIwANHsAp+e3DNLD7yafYctWujQQWOZGHsy4+MIXeNIfZCLSij6dTvgtSmhdZA2918SZlE77zNH8IsfzSA2BDP9lvE0WF6rhRKfuwLkADDlXlkTLWnA/Fb0ltL12YwtX6M3xfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRwny3wMrw1+RpEj3ey2OgRIlFcf/Msbp1r2nKG7vAM=;
 b=CikMtqiT+pp1q7h6o0deRjmBmQzVpL+yuk/EpuoERYQDS7Sti2ZNXaXp3QRl9W5e90kGahfbABYaF6y/7z3MT+p/n6Yvhtq7+7B95aGSYD9BmibhjnAjI24vtfGxKgo8GMgNvnLvyp904diRT9eyNkRYkCCSJddEW5oLh8Gt5mc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4173.namprd03.prod.outlook.com (2603:10b6:805:c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 05:57:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 05:57:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] fuzz: add support for fuzzing DMA regions
Date: Thu, 11 Jun 2020 01:56:50 -0400
Message-Id: <20200611055651.13784-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611055651.13784-1-alxndr@bu.edu>
References: <20200611055651.13784-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 05:57:07 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b6f446-cd7b-475f-5ba2-08d80dcc4694
X-MS-TrafficTypeDiagnostic: SN6PR03MB4173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB41735E40F96D204A687BF180BA800@SN6PR03MB4173.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Aj6aYX07F7ktgPJ/xyZohQqeX6e/b2scIktKe1jvEySEl6hYgxSvI0zdUV7qWDHr39eW4usP3LTSt9znca+D3YwVz7ggLoXT9Xu3jRuq0Ct3QZA4Y8rfFRugOZJhaR3+5ZGmm/UBdvwiYbmd4McONLTklKukDJW+djSb2nN2pyphie0/IFRSIjVBDJ0P6XqFhR9CmZJl1T3+8cdgxFPTSZik84EsM4H+/40dKL5/+fWNnMTvWt9Lm7OJRk9/PQTivWxjasFR90c0YMJnkr9l9R5cK3Dxj8VYkZPEmsqoTfRHDDgaghQXB7s5cx1GaTTdSePHTrU/IhhXpl6ZYUe4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(786003)(478600001)(26005)(316002)(6916009)(186003)(66476007)(7696005)(4326008)(16526019)(8936002)(66946007)(66556008)(8676002)(5660300002)(52116002)(36756003)(54906003)(2906002)(86362001)(83380400001)(6666004)(2616005)(956004)(6486002)(75432002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Pv3JDoG927cMVyqPNzK04xPuxuEHk0VH7rwBe5cLzt8Mcz7bsGC1rWIZZIJrFcM64UzPpJsMA+TNuzncdSIPtKhFhIL+oYCa5LV+Eo0qi9LrhpqHNW20KUrw2lGlaglCmpJdYMyj/XOcWu4w55JM1ESQpSkY8dhwBayVr245kgjpxJ8CaYTnZUfphr9UdzEY+tUeGDnwtUCxUqmb4usei1M8N+CAbx5iHmNIa2d0M/VC4UO8AdryGaCdAoRh/yGm7NNFcADW8BhJuvXABs4+1iZif3mhzgCRAW2w/dKgpTiTHDPB/WvQELm/R0n0MHJNb9tbCJcAI3d/l6xyFhddDrI6ZBGq5gJfV1OdH1dOWTmvhPcpK4Edpvveei7GmI4cKT5b4k5ht3+82tWTHnn55dfpMPuc3OgRY7L9q0YoJGsCMVzaZZpggSEe9uMke6uboGorOStc253Bb+z2geYIoqYlYpx/oVy1g+q9cBSlaOg=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b6f446-cd7b-475f-5ba2-08d80dcc4694
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 05:57:08.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmJA3YGhdqsZq4Vm5ZecnHPNK4fn+9OWOeK7nIR//i4PLqeDpTx6ugqkH4YkAMyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4173
Received-SPF: pass client-ip=40.107.223.121; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 01:57:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/general_fuzz.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
index 5c29306bb6..9e981e870f 100644
--- a/tests/qtest/fuzz/general_fuzz.c
+++ b/tests/qtest/fuzz/general_fuzz.c
@@ -32,6 +32,7 @@
  * input
  */
 #define CMD_SEP "\x84\x05\x5C\x5E"
+#define MAX_DMA_FILL_SIZE 0x10000
 
 typedef struct {
     size_t addr;
@@ -57,6 +58,18 @@ typedef struct {
  */
 char **region_whitelist;
 
+/*
+ * List of dma regions populated since the last fuzzing command. Used to ensure
+ * that we only write to each DMA address once, to avoid race conditions when
+ * building reproducers.
+ */
+static GArray *dma_regions;
+
+static GArray *dma_patterns;
+int dma_pattern_index;
+
+void dma_read_cb(size_t addr, size_t len);
+
 /*
  * Allocate a block of memory and populate it with a pattern.
  */
@@ -76,6 +89,62 @@ static void *pattern_alloc(pattern p, size_t len)
     return buf;
 }
 
+/*
+ * Call-back for functions that perform DMA reads from guest memory. Confirm
+ * that the region has not already been populated since the last loop in
+ * general_fuzz(), avoiding potential race-conditions, which we don't have
+ * a good way for reproducing right now.
+ */
+void dma_read_cb(size_t addr, size_t len)
+{
+    int i;
+
+    /* Return immediately if we have no data to fill the dma region */
+    if (dma_patterns->len == 0) {
+        return;
+    }
+
+    /* Return immediately if the address is greater than the RAM size */
+    if (addr > current_machine->ram_size) {
+        return;
+    }
+
+    /* Cap the length of the DMA access to something reasonable */
+    len = MIN(len, MAX_DMA_FILL_SIZE);
+
+    /*
+     * If we overlap with any existing dma_regions, split the range and only
+     * populate the non-overlapping parts.
+     */
+    for (i = 0; i < dma_regions->len; ++i) {
+        address_range *region = &g_array_index(dma_regions, address_range, i);
+        if (addr < region->addr + region->len && addr + len > region->addr) {
+            if (addr < region->addr) {
+                dma_read_cb(addr, region->addr - addr);
+            }
+            if (addr + len > region->addr + region->len) {
+                dma_read_cb(region->addr + region->len,
+                        addr + len - (region->addr + region->len));
+            }
+            return;
+        }
+    }
+
+    /*
+     * Otherwise, populate the region using address_space_write_rom to avoid
+     * writing to any IO MemoryRegions
+     */
+    address_range ar = {addr, len};
+    g_array_append_val(dma_regions, ar);
+    void *buf = pattern_alloc(g_array_index(dma_patterns, pattern,
+                              dma_pattern_index), ar.len);
+    address_space_write_rom(first_cpu->as, ar.addr, MEMTXATTRS_UNSPECIFIED,
+                            buf, ar.len);
+    free(buf);
+
+    /* Increment the index of the pattern for the next DMA access */
+    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
+}
 
 /*
  * Here we want to convert a fuzzer-provided [io-region-index, offset] to
@@ -269,6 +338,32 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
     }
 }
 
+static void op_add_dma_pattern(QTestState *s,
+                               const unsigned char *data, size_t len)
+{
+    struct {
+        /*
+         * index and stride can be used to increment the index-th byte of the
+         * pattern by the value stride, for each loop of the pattern.
+         */
+        uint8_t index;
+        uint8_t stride;
+    } a;
+
+    if (len < sizeof(a) + 1) {
+        return;
+    }
+    memcpy(&a, data, sizeof(a));
+    pattern p = {a.index, a.stride, len - sizeof(a), data + sizeof(a)};
+    g_array_append_val(dma_patterns, p);
+    return;
+}
+
+static void op_clear_dma_patterns(QTestState *s,
+                                  const unsigned char *data, size_t len)
+{
+    g_array_set_size(dma_patterns, 0);
+}
 
 static void op_write_pattern(QTestState *s, const unsigned char * data,
                              size_t len)
@@ -341,6 +436,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
         op_out,
         op_read,
         op_write,
+        op_add_dma_pattern,
+        op_clear_dma_patterns,
         op_write_pattern,
         op_clock_step
     };
@@ -348,9 +445,12 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
     const unsigned char *nextcmd;
     size_t cmd_len;
     uint8_t op;
+    g_array_set_size(dma_patterns, 0);
+    dma_pattern_index = 0;
 
     if (fork() == 0) {
         while (cmd && Size) {
+            g_array_set_size(dma_regions, 0);
             /* Get the length until the next command or end of input */
             nextcmd = memmem(cmd, Size, CMD_SEP, strlen(CMD_SEP));
             cmd_len = nextcmd ? nextcmd - cmd : Size;
@@ -418,6 +518,8 @@ static void general_pre_qos_fuzz(QTestState *s)
     }
     counter_shm_init();
 
+    dma_regions = g_array_new(false, false, sizeof(address_range));
+    dma_patterns = g_array_new(false, false, sizeof(pattern));
 
     qos_init_path(s);
 
-- 
2.26.2


