Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68837C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897E6207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="1NMkVXcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E6207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVykG-0000UE-Ey
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfr-0003W6-Kk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:11 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:44513 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfp-00076m-Ut
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSoPSvQSfyQ9wNjibhw5HCTZgVawK6+XG4jGjQe5lKZA5HlnVD+MMsD5SdeoBlXQVWgybqdIElk9f6A+9AsSntSpGA63LffewuSXldOqgqTCwiL52DsDuZNs9TkG2gT9A/K1AuNnRjyELhaMGYp6Bh8l4Z7xux1WHdUc+gL5FdOWqSbqbrvgKT2sxYo8u1VCzMtw4nW2Wqp/+rN0ZfA1ZyIgzISbFedoO5Im1sz0/hA0fOYjz6fcXxWjOPelpotDFUi+tfflXWgLeDHDwX+pevR9iAjb4+EIiVj04VXVwua2bqJX3ByBud8peuCN/W4TYWVdgCteU6Gle6V9HhEj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+x2NyRq3SEc2lMRVqPaA/yOwChrjZZjY9J7JLnJvg=;
 b=hU+8wfdDvr1ncTg23bsQa3kw+mL5tBwAc0GHXxrtTgZV8s+iAqFIk5SQ8G0ifBVr4AF21qAUhcK7pGWakmdlK2YWyCSFk7vs8OOYwI+tyXugUuELyE4POeTacBqdNKk4aw1Dm4b27CFO2zoTeaILXqd709bRKXwa8twVKgPbBUwYL3iX9mxUlOEjR/7koQlZuPx4ksQnNXCS+/sqwfWvlZfWTkYc+qvrlFaFC0LCzwBn4tzR34txS86CSI5CEfP3IU5yiTz5P4ZCeOJyJDZsXsNhoZwHUzfPTd53Tf901c/Synf5Sx4cgHqQkfwFRY02iwbTxb056ue/aSeeYnz70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+x2NyRq3SEc2lMRVqPaA/yOwChrjZZjY9J7JLnJvg=;
 b=1NMkVXcFEDvIwdthLiHa6cC8ndX4+5MJBmn+jAnpXwSPhsGa+XYA/lpaWfGU5jA/LEQWUODkvSDIGnBFD6zHKGKhbJ64YxQlb5WiYP8FpF1fR1FpVlzdMJAYMPlHREov9+FLnHigPov2n+1L5yV/XFR62H9azQ3J3UmAC5mqQOw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:07:59 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:07:59 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/17] memory: Add FlatView foreach function
Date: Fri, 23 Oct 2020 11:07:30 -0400
Message-Id: <20201023150746.107063-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:07:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e1f9b7-81f4-42f2-d627-08d877656dc1
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4368EEDA995D4035282948B7BA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/HUf5BlVBggLXvLPH/afUjPGRVsjyb4O7PAw+q4LVrjjZUDzY6biSSI+/VC3WEUqsO93cyg1Y3qkOJAonaHrkTu19UX+1VwLMUZiduHPTXNCyaH1eNSKZ+EM1IeIFnkHaka6NEDge0KUVOlMMNJzZ4MaUxkQc/Ux2wKEcpPpf7cRoGzTJgiUooFyQymWRi6vRUpTY3bWewdnhwzvTeY8etJIn140FN+y8mQ/CJ5RtjYQeY1+kuqtPxixWMNaoI8IL0Qei0erIQQ6FzJ3bDt1o9Rf3FmaVGuXfM42UvGY7QChAv0fK/rXGGdO8flYMYaN7kSORwOEk7rloCLUK5gQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(2616005)(36756003)(52116002)(5660300002)(6512007)(4326008)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +7EqVMLmcUBSYVFAtGW6HO+uhYspjcpVm3t52MCxqhJExWAGrng9XV2l1LAFpw5IE5/m/g7P1YBSoVwnKpUQmlRRjo9DBj82jY1FCY1vpfUjk1CoLMFHq2rHyvZrOgaAY+RJv7DThwgDU/SLoh2EU3NSrBtdj7wsDx4uVXZOtM3DQSteCOL7DNHwPHcqdsHNGPLVJV7B5OjRmv4yjLiNvEZqmri5Bv+oerBffO5EC1z7AGpjrJLlPlspQkQayCnC6U6CxiPdIDSFt2y6XqABgJ11fbmmW/HSqg3qJghQ2g8das6IfowwTX+eg4tQvGy2U+99oMoGdB2lWQKvZN+2lIDwVY9tNEn+nCPg1iXnKypZrCgHKYMvOe/vxgL3elWRkxFbCEeIzFDUp7OXy/1ziY+E1xzMXTXR5dN3PMhhx+UUv1RqBnIHic8fkdWfWvNuxIeLi8/CJYFPD+ff9E7Q/6LPPA+OsftNsqGLwLeLP5zZLCNRgkhFffAnjJsQhsZ5Hg/Z02GXW/8lr2VGp0gTHAqguFOylFJHBUMpDaVoUAnvc17X6dxyGvvb/QAE6CvaT3o4KsgDjoLAS6vPx8z06zV7+IDrGQcZahMGvMHVdbB+FSJEtGnF3JgivVaVtsTXDmBcbXSWlsHXVb1f0Sp72w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e1f9b7-81f4-42f2-d627-08d877656dc1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:07:59.2105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3Q7njSRBRj0qTvlxYARhK6EpGg6KxqDc3USQz+Kaw0ioqOgXiXF7Mi+ubuYvbd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.243.109; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/exec/memory.h |  5 +++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 622207bde1..042918dd16 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -719,6 +719,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
     return qatomic_rcu_read(&as->current_map);
 }
 
+typedef int (*flatview_cb)(Int128 start,
+                           Int128 len,
+                           const MemoryRegion*, void*);
+
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
 
 /**
  * struct MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 403ff3abc9..a5d1641820 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -656,6 +656,19 @@ static void render_memory_region(FlatView *view,
     }
 }
 
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
+{
+    FlatRange *fr;
+
+    assert(fv);
+    assert(cb);
+
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


