Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0949CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010492078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="J1MBKlOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010492078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3YF-0000lK-RL
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WC-0007Pq-Uw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:08 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WA-0000kr-Li
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiukT7eEzJShPo+E2naSnW/ArE/LqJfJUGHR0oHIofwJJDEoB91Q2w/Lh+nFqF/nuIY94pecDf/2pkrSHO/DsiFb4Lgl/aeqhFNrEb2UnylKXFmvp0BPytAJQocZk2aPzsW8Lvul29WBMZ4WH1dlLaOzzQ/k8mZKqU7DLx5Ucrdno2pU9vlX1uvdlKqooCl5dzOcwFHmxTz5mHP9MoMqOokQVFxWMcVUPylT2mff4mFlNzswc8YWhLBgj1/6ZXdbx7Fnl8eoZ8xpbvTgXuS2q2bPDUsuVxPa0sW2wob5Ujr3S0ffSJXSR29/lo6NnJ5B3b3aGjOkvMseIZkZMgk24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX056Rf6DSUltnR4J91NJYCtam/Fo4tFlIXd4RkYse8=;
 b=d0kqRn3VWl9oetMCZFG2bzEHxiHxuU9XV3AFcTFkAqD9d4zsASwzyTAbxHrb0wJxW9XmqjlFr+vt1B7Q7HqneJBojsJkkHDN53H4ZKq5HXCGJGvQFEWsosXIJRUn9I0c9NaT5N2qlupi3BEYoGiO7NeQPi2H10QAsXiweywHvFVNF7Mlt2V4ni2XQ+AofXAu/gwh3t03bztFb8R5l4Dsubi4nLgvgP4lgo11TUkoA9g+UE7h/LKotwZxh5g8ekYto0RG4vyPWYXPDK1cYGnKljDEs8CmFisPl8R8RQ8XnTkjc/CT05Cm7iHCOrLYKviUL69jnm8ZNFbwO+syarx3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX056Rf6DSUltnR4J91NJYCtam/Fo4tFlIXd4RkYse8=;
 b=J1MBKlOhfJvURLAKex3Eoo/1B0sxoB7CQxbG0PyzwyrdHXnHt0WGZnXDY6B7x+Kr8GPYKP+5mcLq6GDIRfDngPofOlXqBkpatUsDJl1//74eu/29BDN86L2hQcYmB0mI/oe/1bRT/uiFDgQ+JdhQsqVTVfqvUxTj3RT+S96A1TY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:41:51 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:41:51 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/16] memory: Add FlatView foreach function
Date: Thu, 15 Oct 2020 09:41:21 -0400
Message-Id: <20201015134137.205958-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:41:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e37d5c-8523-4d87-0424-08d871101248
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB546513FDC36D6A0EE19D6AC0BA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdcR3w17suhEAQrqf2a5ZKg1O4TzwQmn2A6Ud6D4Nr2u4fdlJ8uEajrb2vNGrGjaqRiRt6fuERxsXO+cKiiX4rXd0NWaSdBNO775PahZlwTERiNEiG6MvO3eCb7Kkmdb06ncF4+IDdNt7+pjtwJrCkr3zY5CDvxVAhRrohVlsPWpHLTzYvK7L1eU1waQMIJIMNRQG44UHfhJh+qlM3FfxZIylhuMgkLUrfLcJhRHOypY91vgE1QRYen6P+LEQwfhACDnR/oCV4W+fQJInIN+eMvG3QPWRU/rbTjGhdL/yQSfYVLm0rqvykXLpnzTh0mb+582fNK5KJYIA4L6hMzyfZe/eqnSpufiZ98ElEXcCB7VJlT0OZZMZ24QZ2M4TZQo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5f842UzZcywj7M9YxC9pmmYTt43HlNMg3ew+rjU90qBFmPQnA6KZS3eIx2nkgqlEdvjfsclJNoqB1H2J6tQ5WdiYRG0NGUyEI1JAbu39B5XzvEXwNsoC5vXp7roachfa04vySqTsg8h5E9v9OPHCiyQmJrxdlKtON3/vtxjwEPNgD61FFweFzxvmRNyJUr63U40VNT6D69c/xF0yIURMjDSRv1gmJ0+UcOxKct/YIin70p5r7ilMF3lD8H+flyJjlZwBNk5ugC16oqGxArew2tGyDiCzmrfCK76wDijN8jmcoDGpoyGgIBfJp65fWU3lIu21GU/9JPhxrG3fwgtz6q1oi4vyQ1ROSFxDTUUvcfsqbUFNSvoaJ8jBI8FvDn4oNywXJhQC9Gw2b1V/2TakzZy7veNSQUMOww14+yWnSr2WmzhRMXv9Zihu3gun/jcJcWRYb5Vl2qn4zzj/kbNsRtDUZI4HBdYfTmCvM6vMUjYLCLcFkElc50kScAu2mD7MUdIBNXvxncvxVAesL/J62bmaM1RFVXfwdz1zb0tr2QnEw3E6di95yzZs3Hosn9hzK65UZR4hojHJ7wY6lLiipOZNSNmGn8u/RNE2JJ2Y/hA7GD1uW/qvIm+ZqKWKZWzbXAqGKfYPD3g1PAWdxh5ZeA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e37d5c-8523-4d87-0424-08d871101248
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:41:51.5019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0NUB1TiCfeSIXguLzafEUm+h3WiAocTs33QL/IHslwUSERu8fn2FJs01seHp0/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.112; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
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


