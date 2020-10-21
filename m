Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEFC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408D120797
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3OFgpacv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408D120797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2dn-0002Ut-31
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2bx-0000rj-En
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:17 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2bv-0004s9-J7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZVjnlfLBW0xhrgw3/jAQoj7ePx2Ad8ME4CnHrOyd5fugeoJ75ZI6HQ4Fdlig8vpP5S2/DidsYg+rT9lBKnGn45pV+N5Y/U4+x7/Mv42dLAbS4K0pJgAi8LEMCujhplMyZTq1KsUI97yUYylQ/xRQUDyx0evTpS3u1cDtizpMDLHzFgZz1dBE8fXsuWUDCDWq7cQgxIBtmwIrAhfp6BaCcTib15710NdIrMeOhs6+zZSGGZX5mdWT3N7FCcsau98M/5ebYOf5jae9uFXq3Khg8+zXksgBeILo8SziuZ1qNqv2sCSMnYPdzAhCYv5wegooVPXRuofm+OvaUvPW1hiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX056Rf6DSUltnR4J91NJYCtam/Fo4tFlIXd4RkYse8=;
 b=MV1/mFcJrEAozNY4unx/AW7GM51qmhb+nbR01dnpXHZcRe6yL+600UflGAF3wrBJqwRAkz4HoY77mQrmvr6VcTlVhsj/qG/bjNQku3shY+LMttAZFM1UTCDSOaidB0MHZWN0u3SCjnYDAJYPx4IZTAjVqJXAANa9VTbLria1MxddQF/JmvDTMq6nmv1l7BfGaVUPadJ1b+LQ6r+9R97zuxFDRvJygproDLPWNEImXDKPlhLu2ndFXEvg2hcQZ+soNQCR4MB3aKUDMWrei8mIpzsxBeenF+797+EWRBHKZNX1BPtX9M/3SQWqp4/dEU6gcjvsv+pQAKFrMYYOnlzQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX056Rf6DSUltnR4J91NJYCtam/Fo4tFlIXd4RkYse8=;
 b=3OFgpacvxwSY8y80Fk73pXilrItDrgKzdvOwV9w78Ci983yy5+CyOs+c/ZXVfuqFz/1pDFp2L5Foqfvto5EsvpGaFX90vPHFRHNOUlNl6NddMlbb4bXDjqMOZf62cLY+kHJDb8ATm8a5fwcNg9Tu5zk/PxEFDC/nhvD4d5i8wEc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:05 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:05 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/16] memory: Add FlatView foreach function
Date: Tue, 20 Oct 2020 21:07:37 -0400
Message-Id: <20201021010752.973230-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 141ea922-58b6-4f5c-8f9d-08d8755dc3ae
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23331548A64F990BB5711961BA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eV3WSTWgSS80brsJ6KMD/BH56I1+sbioNbjz4W9MhReCAy2Xac7JKRs4WA/32lfu4ZHntlbWDh5mLKysAtd2OqigYX1ijBW8i+kS7B7pT0FpEsdPf/gRXM7IhRVxREo2leJOU6Jbcm+GB3uCoWHC41kp1s9G39rvGwC17BGZ0eNPR/q7SIfAQ3S08XoUCt8+P3CXLb3intGj6iRgVJ+jdzU9mwuDigMJv6Cc6AeZgHp2SNC2PlukyHNg+RJA1gvVX7HlGQ7p66HqwOt80FkKtKVg7Tb4YoGqjAhqSeUAMNlsbZ96vC0J6JzX+WeddbjQGqoeQdaQai1r+Ria49bLzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uH13vaCY/NH3IqL8Ni8AYGUGVhodrovVfX+qRaPVLnNfHLnxE8r+xJvz7yDx55jpXfdgQwfejtZpYFL7MlUyUfDSuGY50DGShy1oE6wPP16cV7tjIKB4H2ZVDRlN6Rx0wJI3TuYPs5U4arBWlMVJzQvlTxKLa0wPA9FC9/8OcL3cUQJ9tCC3lspTJyw+y3Ui/udvghnJBb6dDNxr85zYHfHFI+xx2KTwXqcKq7X2v3D0a1dCfU7x0Ql/EBEm7nJ3QkrfASFpmuXmhwIkYE38W6x1cXVUFbg6zAjFbGln4NIJzeuBEaelFjZqV8Q/vUw++lYxFWqzf4yIRX3XgxdJDv2p1bHayMb6wklS5zKqxnYOF8j2v+QZkZzJYe4NtBJnefnKqEFPvk6aWeQW/4zn8F/y+punnMr9E1GWpgdqLwTEHQTOZ3ipNr3i6yxNZ0yQAquTSIYyGqSjJaRlHHy53zu2zIW45FnbnstnuQCba8yhe84XS4nt7LFiGDiaJlibEygeJQNXg4F2XEjMPlqvgDeISMFSbbcgvImdfdCMewo04bn8FF7DPfC5aC/GWdHDJ5qSxOmNjJVwvteIEGKs4uVtMtjvCAy71/x6ggoL2ySuXrfpO/5+VOhgycsnB+Esf+i+jDbQt3CDnK9S9RA97A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 141ea922-58b6-4f5c-8f9d-08d8755dc3ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:04.9989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KVxQJnE5rWQNmVNYtS8MomCOsLrTgI4A2Ie6BlsCo7wTwgtsAsRzsz5Ke3uUopg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/exec/memory.h | 5 +++++
 softmmu/memory.c      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 622207bde1..233655b29a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -719,6 +719,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
     return qatomic_rcu_read(&as->current_map);
 }
 
+typedef int (*flatview_cb)(ram_addr_t start,
+                           ram_addr_t len,
+                           const MemoryRegion*, void*);
+
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
 
 /**
  * struct MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 403ff3abc9..c46b0c6d65 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -656,6 +656,15 @@ static void render_memory_region(FlatView *view,
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


