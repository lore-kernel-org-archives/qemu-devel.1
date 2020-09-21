Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F42C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8E42078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="nJTF+/aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8E42078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBYE-0004rn-DA
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWL-00036l-A1
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:37 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWI-0000aa-Uz
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1FsDraple05J2T5o0B1b6nyoWCu96jra3t4vx9xnGWoMt9zc/bdbtTY9hIr6F1oE9SXYBVhBHBw6rQGjyHODkimIKdEadh6QOiw+bYt8T3kGErFxBiqhk255Z1ruWqhYoF4OXkP8DezKd24j/lCnOv/zeU2Mp4Cu3bgxJKl74fWbHudASr32/g8LryP0Jz8bqc5RRHSZ9wnK53mNv5/oLk3cLJGgfCzkD0CeDIe31/FOGS4tVdP6tDeHqh1EHklMaQXDJj2nNdXuXp8Md3RFBOqL4s715FjevZVOO7OB1aF+/FnGSB3ke3Ule2EP5bJTkjmoDYoHbJeNZZgV1Kq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXkCKaQY/ufWCpE8/SM6P3+jQtV8gI8PiTB1OsVzgVU=;
 b=TUioZ1hz3qpevoTZPf9TuTyOQ57UU8JU+zEJFedB1hyJB+9FOqKFc6ieBTHG2AHENNP4aQQPLEXXT/bD0C3KvsYWf5Aj3j2nrtAfVkzvc5HtNHahQRBGA656BR9KFW3Ccx/MTfSj9vMqBLTZ3XZIpBBp5ONfJKAFgZc8dbwSK8dXaNo6aUHlFcb33xTrFnEAlmiZPuD+fjdENtkXN9NbXok6AV2NfPL39J6NyhdX+0KdGYggrYO48EIMMZxrUvq1pLKcNlRT8qL6lTfvZ4oTquyxzDDasAaJkF2RkpWzt5LpMvo8m1fdK+nJd/0xEMCTyyNLHnMAHeibt/vYBqdTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXkCKaQY/ufWCpE8/SM6P3+jQtV8gI8PiTB1OsVzgVU=;
 b=nJTF+/aCDQ8PI5Tz+/nvAhk42d0A9xNV9ZZMO+n4n1UxR72/lO0lj9mArR1kfxEiwvwNkZLQbqs+NBBSJO9XJSy94Hmw9c1edipIOqCbeNNOdmBBUKrBb/46ocaSW7eb2oMgojVQfJVstqMrPFnD604D6gMt014Nw98nTEFw1bo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:20 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:20 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/16] memory: Add FlatView foreach function
Date: Sun, 20 Sep 2020 22:24:51 -0400
Message-Id: <20200921022506.873303-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:19 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a9b9828-a1ca-4484-22f1-08d85dd595fa
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237A6D6C68DAA22C188CBFBBA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSyF2pAPDz3E7c3t9Wbb11kMGdGBtjzfot+j9MHHgpgLErnDyse7yuRc1pq5FmynMGCUwb5w5M4NaZpAW+qvMPZKkgXfaq/pMP/qCmwiZY92ovWc6+9wDy+kbDRZdNcoAXxJSke4Q6QLCVq7yqy1qYAYrdeDvvd41cvMrdZ0nfj8UcgixvzEMldDgJ6nSI40Fq6PGA/gAOD6lG2pt0kLFelJ/zckFG1zVlZCbjtCQv15CrRS7PGLfOPQKdbLyRmbqNJDadf/qjegk1ZSs8Qa1x4PkLdLzn0MjVR3g/QX/qoJTNLcYdKKAgS8iu5b6MlesRs8EAKDGZNAQW3COUHjb/Sxl0yJz1KNOe54PxG564ZDdZoXz5QrbdS96WGt1X1G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UihiY8Q3taAKZsg6r8DzUf22MwelYJ7xGvCRr6I17/dDqhmU1BHmkBWWQrpPjabmfKCPiFxfng8hYsAqW5Zwn5XJ1jn3mujTquu7E8xs5lhYWjf6ulbo1RPF3QBOMzMXwCOFL8mSczYEyjpJGpq4Net6NHdnO8fAQjM0whucvcuuArfQMeMjxYYplbwdUO4W34svBhqL2UqSY6N8FHt2OCotGh823A9JV0a7+EVuzTYjntoIcRUmUGJVKNBi+A/QevsQpR3lSWUoflIaii3GYkPVYB2kvEu3LH42aKP6AQaYKl1C2AUkPOaXNSF62FbsLV+c5LVeQMSf5uToQae5rstCs4uAcf64OAhuF8XYnoNLwCc6hTW+aO8jtgKfffkqizOMChbxmcgOd6ffQuzVtaUjVeD4IyiH8WeIXoddzgIW+k+JXuqX3BOr4Tp6G6Supfqes+mx2f3ZQVu05laRE/jb5xR+xCSt2L30nswoBJQFK9Lnp/aQijDj82RVEsPysOLzoRMBrbuyLA9Vsd+L4J0cR8/27QMD4EvvkFVdTkQfgIXUxaappNfZwNr2I1lhZbUUAxBBu7dHzIRT7rP6oMS1ym/1EPHDOHhGsTjm++3m5ksQ6MlE8M7/7R942PdhFnUjaaVDsf3tzqSMgbaFDw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9b9828-a1ca-4484-22f1-08d85dd595fa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:20.1259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5ID/VB6FRRiwfpHt1eKOCugNMSk4UrPu5Bz1eM7N5WU268+bqBNYjXNQLB8FR9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.93.102; envelope-from=alxndr@bu.edu;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/exec/memory.h | 5 +++++
 softmmu/memory.c      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f1bb2a7df5..975a90c871 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -688,6 +688,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
     return atomic_rcu_read(&as->current_map);
 }
 
+typedef int (*flatview_cb)(ram_addr_t start,
+                           ram_addr_t len,
+                           const MemoryRegion*, void*);
+
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
 
 /**
  * MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/softmmu/memory.c b/softmmu/memory.c
index d030eb6f7c..9db5fbe43a 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -655,6 +655,15 @@ static void render_memory_region(FlatView *view,
     }
 }
 
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
+{
+    FlatRange *fr;
+    FOR_EACH_FLAT_RANGE(fr, fv) {
+        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
+            break;
+    }
+}
+
 static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 {
     while (mr->enabled) {
-- 
2.28.0


