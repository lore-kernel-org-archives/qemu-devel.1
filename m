Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A731206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4PxkqUaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A731206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBm1-0007gW-G6
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkI-0006KJ-0r
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:54 -0400
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com
 ([40.107.244.122]:48737 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkF-00053E-MT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLxI0j8V7bNXwNpD/kyB9kwGNFJgcNlsYyzLDXh8OsjYDcic90WyHREVz1N8k8Fg0aqManMBVwOiV1aWlImrb+kjjrJz7oCZu34BaMd7TdkvWYIQ0aH+ZUql5g40c7KXIV5JO2w2JV5E2ICe7JaYP8H/cpn7mNqnI3UgfGX2RKN2x/yERq1QqfJCQTW9sSm2+TCgWIm/Zbf58FFIkhrMYEytlW5dvRo1YKcaiFZdo9mHXVVHLOCRDaDpDiR349FP8+i9uDFBjYOoKJsBYxmydH1D+pRvxQtZb6CHmrPSMeilY/KRi6e/Fr5dU8lCOQwP/stJEdOkuChD3ef1ApdwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnlxJ4vbkkiqTi6tl5sAB1U9Xv+D3enwmWjAjlDaTfA=;
 b=kyvj8V9oFjHd9h5zX7gKjG0I1OCfnijsXDak1FYVhjhCBuW0ea9Q8/Qc2N3uDmrNgh0/kM+NoZQm2M6q5a9Eee+X9eC3u+QmRhBMEXkIj3wrZ+st+bgK1ZciLy2Sy76RhP8Dk/wubW6C6Yy/ovncdjA9UFw5qqBvtvbbfx+PoFkABn9Ont8uLRz9zOtctgeT+hshtpsUJnYzlLcB9KIyvRIWArSPbanPFfTdZyGTaqgvotoZe/s4LYtFw6InXPh1SFmYb4IZRGrOnmzAQ3Ev8Bm64RYWdxMUhR/0PnGDzfgKhUDGNzAuPJcG+ZUBeCFh5cXmAqq8FbMXdHudZaPWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnlxJ4vbkkiqTi6tl5sAB1U9Xv+D3enwmWjAjlDaTfA=;
 b=4PxkqUaYOPC69gwOSanrk+sIGB4Lkd+3znMbNssgEdV29HZR0Kb0zWGU5aiidfGQQ62r3DOz9c2OchpXusSq55yBl6Zs78r1IKezgCDsoheDnTY4FWXHPpKNOWdHSEYQio4rBZX7bOcfVWb1W1cDJkS73n3PAsUCBYCZ93pDk/A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 17:29:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:29:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/3] fuzz: fix writing DMA patterns
Date: Thu, 29 Oct 2020 13:28:58 -0400
Message-Id: <20201029172901.534442-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029172901.534442-1-alxndr@bu.edu>
References: <20201029172901.534442-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:29:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c5616e4-7f0f-487a-a14d-08d87c302864
X-MS-TrafficTypeDiagnostic: SA0PR03MB5531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5531C4F8DB023FF5099A581ABA140@SA0PR03MB5531.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFVbhHy4sgEqpI5wzrOxG60jCVtQPmaKrrjL9sQ0QEsDEJV/UAYV+ZgYo7+H5mTSMdycPMuwVSyBMUCerInUbg0LyAtJEGdcECLFNaltzAphgYWsN/4iFb1cbO6zCEDNFgn3vnTDUJkn4V8pKWJZ2lMVfwsnCcEqFxYXMAe5iHFerhg9CLOBI/SyGo4U/YmEicLbKh/IPHJl5TkMN2abvDQ2kMlWCgCRWF5M6bk9iOLOqJMgt8ETdVKhTvsqAOv8CY4Q4rpU0MLfSV94zfgXxrKDK4u9P5+VW7Z9LnucPHZjCiIO5/EU2EAciNLZV3FIQDsfKtZyLmzhUKIwDeMmcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(1076003)(2616005)(6916009)(956004)(86362001)(786003)(316002)(54906003)(83380400001)(6512007)(36756003)(8676002)(26005)(8936002)(2906002)(4326008)(6506007)(186003)(478600001)(16526019)(52116002)(6486002)(66946007)(66476007)(66556008)(75432002)(6666004)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1hEjpwVtDthLfzYnyngA8T96a3t14RYZ35Lfkw7TJUFERk2sGAIFtaYkZCCHeZrwqSIpY3bPCGP9h1iYrAEE8Iv2dPzk9Z4z+C6b5x/cHvQQAt5q0+43IZMSD0q6o6ZSZQ+hnVqpFxEwuVVmynF78D/Rb6EAZlHVONcdHYMwqzjuvpHnpQzFfJX42EjeH/kL5k3H32IiIwpHLBFkb4D2HtLT9+Kk9E9BTyE4hf8g5grHu+hCK6AgiuwXD2/NqR8THZQ7v3UsHS24DokEtT4dNmzp57NCZjd9mm0e3v/U4R60DjTBek2hviUC8TqQOtjKxf/cAakiE3Qgms6kIneqHkQTy+E8v/L2I3aBfccMD62VqcYdAy5gRpBMIOmy5PY/+wI66P8l4Gerdm7EsYHqriela0AJzHnk29IeRFkItuLCkVquap4sBNTTiiidlYCCUEBA33CibEV88rik5AnvFB7DSgFPkA2E6TEf9g5BSlOFDn00H9ehbHF8fo742y/XWrajUMnawTqplDaCyTlLH4F769YTrKmGvh9pUYU+DRL7eFjDCKKrSKzCSN3BZ2auzo+vmyYm2mVJhDIr+3DIDn97PhNOO+Y+cqmO08lxiNxoOyO1ELscqxvXIAaJniRNmvkjQP3uElxmgwvS6Zsrmg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5616e4-7f0f-487a-a14d-08d87c302864
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:29:15.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9pSik6vA0CCPG51C9bMZxLrPKLdVbim3T7EKnykU+rEBt7jNXcz0y2dx9glOjEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5531
Received-SPF: pass client-ip=40.107.244.122; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:29:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.021,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code had all sorts of issues. We used a loop similar to
address_space_write_rom, but I did not remove a "break" that only made
sense in the context of the switch statement in the original code. Then,
after the loop, we did a separate qtest_memwrite over the entire DMA
access range, defeating the purpose of the loop. Additionally, we
increment the buf pointer, and then try to g_free() it. Fix these
problems.

Reported-by: OSS-Fuzz (Issue 26725)
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 37 +++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index a8f5864883..3e2d50feaa 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -229,10 +229,10 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
     address_range ar = {addr, len};
     g_array_append_val(dma_regions, ar);
     pattern p = g_array_index(dma_patterns, pattern, dma_pattern_index);
-    void *buf = pattern_alloc(p, ar.size);
+    void *buf_base = pattern_alloc(p, ar.size);
+    void *buf = buf_base;
     hwaddr l, addr1;
     MemoryRegion *mr1;
-    uint8_t *ram_ptr;
     while (len > 0) {
         l = len;
         mr1 = address_space_translate(first_cpu->as,
@@ -244,30 +244,27 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
             l = memory_access_size(mr1, l, addr1);
         } else {
             /* ROM/RAM case */
-            ram_ptr = qemu_map_ram_ptr(mr1->ram_block, addr1);
-            memcpy(ram_ptr, buf, l);
-            break;
+            if (qtest_log_enabled) {
+                /*
+                * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
+                * that will be written by qtest.c with a DMA tag, so we can reorder
+                * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
+                * command.
+                */
+                fprintf(stderr, "[DMA] ");
+                if (double_fetch) {
+                    fprintf(stderr, "[DOUBLE-FETCH] ");
+                }
+                fflush(stderr);
+            }
+            qtest_memwrite(qts_global, addr, buf, l);
         }
         len -= l;
         buf += l;
         addr += l;
 
     }
-    if (qtest_log_enabled) {
-        /*
-         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
-         * that will be written by qtest.c with a DMA tag, so we can reorder
-         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
-         * command.
-         */
-        fprintf(stderr, "[DMA] ");
-        if (double_fetch) {
-            fprintf(stderr, "[DOUBLE-FETCH] ");
-        }
-        fflush(stderr);
-    }
-    qtest_memwrite(qts_global, ar.addr, buf, ar.size);
-    g_free(buf);
+    g_free(buf_base);
 
     /* Increment the index of the pattern for the next DMA access */
     dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
-- 
2.28.0


