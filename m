Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD4C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371B3206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6ZNofpXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371B3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLC0-0008R9-Cl
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLB8-0007LW-Ot
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:01:58 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com
 ([40.107.244.98]:45797 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLB7-0007mk-HR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2j+I4/Au2Jj8J4WBVZdxB79369/PCJdAbCinHNTiKI8EOZH9PYwI32Nj+qg0meB90x8uXrW9LtWR8BY5NUfSqonG125DlYtMlrY578YqvW7Botxv+MIGF1KAwHCqljBuAV5QYf+Zaur54cp4icLaa9VAMBf3SZL+iW2fuKcFoIYpEqOemg/4LLx3yiAs62IoDzoG0IRzhZ2o4asWe1JaZFWkEnAeCA+9BRP+WOxNH3ywQ/e6SqGsxF1OxAk5ZVvnOKtwcFsCSYB5CZf20O+/FpNNG3Tkf3yQ0H8LNkusm0/Z61PdDCZecmHFuT+7Rh5HBYTFZFQvTr5hs45MBQ21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb2RvfCo2OZW8d0lv0tSyhRcLeFS5Mba0y8MB52KgeA=;
 b=cSeDToyFmJlJFvV2xlWMAAQVUeDaFVxIy5b4braPNP13n0IrXkUGMBPaLrYyERtfCEaTpTISUrm2Zb46aJ/lngIMoeyt20T2PdsnBwne3aA9evo6Vs+OxQXM1kQl7NecWTU6p3exHSAsYyXDLrWP5XyWXTz3AVkm27qNmHIOVSW9eQYnppg50UX7fHcpdms/ZSQvMg5NQVsupxNaowbyCFbSiSXaTc/HFAmq1YDr1Vdftx2DBU/L2iKvgbp2kDkRSzt6LpZruDPIMO9P0nQcekdnKCOW+pTtCAB/pg4rMz1oh9RgR1qRmUf9cgbtcCm60oPE57JpyQzrybwJXuOhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb2RvfCo2OZW8d0lv0tSyhRcLeFS5Mba0y8MB52KgeA=;
 b=6ZNofpXjmbcEFJobY5aa+4yNthwY9Dvvtf3U4pTT8mAN2vA2xo8EST/+UsIK9xMWNMro38uncG3epRTUYWV/zafLuvDZ/Flq9OFWi+isfz6n+SWvwvLFcDCwVlQvt0PI7SErtQzaHyP1nSWcT0i4Vw+ojw0tjh9Y0cjz0BWGXks=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3887.namprd03.prod.outlook.com (2603:10b6:805:70::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Tue, 12 May
 2020 03:01:49 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:01:48 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] fuzz: add mangled object name to linker script
Date: Mon, 11 May 2020 23:01:32 -0400
Message-Id: <20200512030133.29896-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512030133.29896-1-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Tue, 12 May 2020 03:01:48 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bdd21cf-560b-4a5c-eb6d-08d7f620cff7
X-MS-TrafficTypeDiagnostic: SN6PR03MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3887D66484EC2DF0A4381DE4BABE0@SN6PR03MB3887.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMJABtwz9/iTlgSUY8dlRYU1lhviRCzzgX4BpiOkM2LC1wrDervDRY1P/GzwcQ6OLVvbbzixB0bSxJbv6rz8463sutsajTv5gVm0Jcfok/OWQknjnPtxidnnMdnAziKn7eAojBhAJixRGEMsoCMQQdRQS53F5LjcWqFmDIzDBuxXP7BLsgKQ0+e+1ZL5HayKA04S4eOhD/Ybt8ZfubpYCsM9l6GLhUtgrkVn0zWbxHpWF4eJgtBmxZx0ePgsWquxF+RtKJQkeAWH/OF6gZsYX9sFWx1bYYlYWhx+y74SzRBR6PNiFI7Wdhn6RMSkJFCkwOzUEOeNSBec9ciMBgQ/WPL0nIpeZb5TleMDhCQWUHcLNGH+fWBW8dGejkOucSlUYXwcnKvntao9qT9yir0S8z+49rWD/hlue12rtgoEuTqcneXCJMVXgPWzq6sN0Ut29fVJVTtsHexZLv1pYzarJUxJbPl2V9RLZpqeFpe/VBH2nOcE36v2zhR5BE1Urptk5qbqcxvmUQKsyAFLt3tZbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(33430700001)(52116002)(66556008)(66476007)(66946007)(5660300002)(7696005)(8936002)(33440700001)(2616005)(8676002)(36756003)(956004)(6486002)(75432002)(2906002)(86362001)(54906003)(4326008)(186003)(316002)(16526019)(786003)(6666004)(6916009)(478600001)(1076003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ibQlwv/AQzs/PuaEHpuDYw0+8ZT+G2FMkKcW3MwmRmSKyJbNR/IfCthP0wtzf9RF8XZTr4U4YuSP6fvsi1xGMx6uMIhMXnSJ1wertVBd7RXqHR8Vfp0nNTWIZW9qb0AyW5udzeBCyNzAVFe7rrBxAtjFgqfpjD/lhbzt9ZN4b+TqaE4y4AqYRMBudxH2+f0ckMnGxMxPUAA1hoqMZRjLr0tEbnWwIDdbN+XtiWcVtDtifaSHzXRLWERd/X5r73ByCIBGST7vgcYndZgYn2qWuC+f8bR1GM3qkCWFmZK7wfSOKeUnwhb72Ksl5z+n8l+IiFxAiYyhv3OJsZhCPodN48O2RjCSVXzbJIl3tx/vmrBLORkGpdeMvEKIrXs/Zhj10gh3rLTMiFGT4ueSguz2aSMST19P7Ay1ABqhVWEIjFkTvwLAJzKrSObycfFqiurUiKey9T45uHHTFJJp4hNhNoPj0YOlfHvBlIho882gpws=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdd21cf-560b-4a5c-eb6d-08d7f620cff7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:01:48.6841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T++hVpG9h4TIYEANadSf8FBY16EP/4zXtbWdqPOSwFvjKYC7csd2k9YhevxQX6fi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3887
Received-SPF: pass client-ip=40.107.244.98; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:01:56
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
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously, we relied on "FuzzerTracePC*(.bss*)" to place libfuzzer's
fuzzer::TPC object into our contiguous shared-memory region. This does
not work for some libfuzzer builds, so this addition identifies the
region by its mangled name: *(.bss._ZN6fuzzer3TPCE);

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fork_fuzz.ld | 5 +++++
 1 file changed, 5 insertions(+)

This isn't ideal, but I looked at the libfuzzer builds packaged for
debian, for versions 6, 7, 8, 9, 10 and 11 and this (mangled) object
name appears consistently in the symbol tables.

diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
index e086bba873..bfb667ed06 100644
--- a/tests/qtest/fuzz/fork_fuzz.ld
+++ b/tests/qtest/fuzz/fork_fuzz.ld
@@ -28,6 +28,11 @@ SECTIONS
 
       /* Internal Libfuzzer TracePC object which contains the ValueProfileMap */
       FuzzerTracePC*(.bss*);
+      /*
+       * In case the above line fails, explicitly specify the (mangled) name of
+       * the object we care about
+       */
+       *(.bss._ZN6fuzzer3TPCE);
   }
   .data.fuzz_end : ALIGN(4K)
   {
-- 
2.26.2


