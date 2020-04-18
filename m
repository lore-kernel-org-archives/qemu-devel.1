Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D008C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 04:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD56821D91
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 04:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3imz1owd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56821D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPf9X-0005CN-Tt
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 00:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Wei.Huang2@amd.com>) id 1jPf6M-00040m-Bq
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 00:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Wei.Huang2@amd.com>) id 1jPf6G-0000UD-89
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 00:29:05 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com
 ([40.107.92.59]:42593 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Wei.Huang2@amd.com>) id 1jPf6E-00009Q-77
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 00:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9Ut/hoxoH+5qjrZgjVw195NS9N1XF7FuO/dA0ih+hnIEMjZme5mDhPKLuL6abO9Hh6Mab6CWFqFvR4nJGIK/y7iGzhkuJ0yU2waGN2KpuCRhDw7YC0S1vne+px02ND3VHYI7kNR5Z9Kl2Pr1h7eSYT8KV4W/lpmgDTzYFFwWvOPjpdb6DfFMNKwO/S2Fb1G+8HkiUEQfv41ngjB1zKwyKXLRMD+sA9TQIPvEsyxSM9EktJUptSbcsopo0IztPVLiOkCGPPrz9je67+AxzS7OVmn6VGreQL6Hx5MdbGzdbWof4t5sEnL8ymgYepOZV3n9BpGyvc4BAOVnmqG2DpdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swmB899Ns/MkOErvY7A2/mnvA2TL56CmKzKyNWK6Qk8=;
 b=iF9h6BoJlHm/M1RYoucWzbADoFE1xdIBD+076OOg4l4l1CZtEUExf5OVJbY2JDoN6m3Xlj40ARaa43JVO6185QhpbtrLGZ0bPKK1L0owW2Uei8TvY9j12c3jnLqjzwuORXJkCu06Sb1Td8yVSArBNRzOmpynXE9LTM1QrZ4eycwYEhuXEXUvLXhKs74ZEQ22n2ZjkdK5ZVdDGtgaqWuusQddv296AhkKgX98u3eg6VgDTW/HP/f4a/bD3IEMKHn56xb0Q2jjYsCqlRae67e0H6W95Hf61d0d8ULUEfYwK6zrZujOYELxxbyDFz2mfA9+4nkmQlWMF3NYnVRJvWWsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swmB899Ns/MkOErvY7A2/mnvA2TL56CmKzKyNWK6Qk8=;
 b=3imz1owdjbmmRJAbSXfoAksy+FPv+0QV+KWTrn8Pb1KmmRlMiBzeXIakGFWEgylSlr8tbLBZYVfU5H/uzYoKJHSwYxPKtivtdlEfR6VZYpB0jjZAkuDHToEdgw9gMo2yc/lbCnV5+wGJuAw9gKOC82Dgd4p7I4QkXdLSADv45ts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Sat, 18 Apr 2020 04:28:52 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::5d16:1d8f:9e02:9938]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::5d16:1d8f:9e02:9938%9]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 04:28:52 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/amd_iommu: Fix the reserved bits definition of IOMMU
 commands
Date: Fri, 17 Apr 2020 23:28:45 -0500
Message-Id: <20200418042845.596457-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:4:ad::31) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by
 DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Sat, 18 Apr 2020 04:28:51 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4a6eba1-80b7-4cf4-44ca-08d7e350ff67
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486676DEF58D817ADECDF81CFD60@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-Forefront-PRVS: 0377802854
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(956004)(66556008)(4326008)(86362001)(7696005)(478600001)(52116002)(2906002)(66476007)(1076003)(8936002)(54906003)(26005)(36756003)(16526019)(81156014)(2616005)(316002)(6666004)(8676002)(6486002)(5660300002)(6916009)(66946007)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urS+p5Kyqw84rhzRJ0cCLFYXrGEUwFpqqlRCNATa0hqVlH4SiECom+OmG0dFWdyyYRaiU5+EULwuM8ZmZPBTobOm5AfOLd9xNBprXwDmzG9e2VbjH5ocXRIzTQlSlSwNk14YJb9Dyt1N6w/ruTz8trp7uKVI3yvegulJx1O666DN8Ndqc05Lz9nUgB+qpdBNRZvvEZ4XJ2COu908/vDgyNjzTXgz+shM3zHEFpUPm0h0QLhaA0jOj938dsBYMgWoP9Bs+e2B+QeOGPcn0WDdIDLqYTT4k3EhPHBFdue/tC2e2qAvL/yTMvhFXeJnDom20ChvaPLI2Cj8lLrkFfSLra+KoebKiuOhL1OZLIU1/vOJi0Bq+57i8NWQ503PX0TnJ3K46u3gn5yQIYlF8batCeo6a+duHj/U2/lwyoIqD6wublEzw3uUNkmXUTnmsB9S
X-MS-Exchange-AntiSpam-MessageData: JBuV7zugx8i2saw6zfAgelYUB28rIL8lG9TvYX1QpsCzlvTQP0jvIjxz714EqEmQRw7EYsBpvg20D7JoP0lcM6khCa4r/NSdASY3sCfOI1jKNq0iv3oq13SNkHe+lIO3jMkPdHdO9u18qAaohcZ+Lw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a6eba1-80b7-4cf4-44ca-08d7e350ff67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2020 04:28:52.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr/OnOsC+GIeBa54PfUlLuKsHMRS4ndRiOTcvYLR60dLJhyx1iYZGCMwRiRdSogj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.92.59
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Many reserved bits of amd_iommu commands are defined incorrectly in QEMU.
Because of it, QEMU incorrectly injects lots of illegal commands into guest
VM's IOMMU event log.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 hw/i386/amd_iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index fd75cae02437..4346060e6223 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -370,7 +370,7 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
     hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
     uint64_t data = cpu_to_le64(cmd[1]);
 
-    if (extract64(cmd[0], 51, 8)) {
+    if (extract64(cmd[0], 52, 8)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -395,7 +395,7 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
     uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
 
     /* This command should invalidate internal caches of which there isn't */
-    if (extract64(cmd[0], 15, 16) || cmd[1]) {
+    if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -405,9 +405,9 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 15, 16) ||  extract64(cmd[0], 19, 8) ||
+    if (extract64(cmd[0], 16, 16) ||  extract64(cmd[0], 52, 8) ||
         extract64(cmd[1], 0, 2) || extract64(cmd[1], 3, 29)
-        || extract64(cmd[1], 47, 16)) {
+        || extract64(cmd[1], 48, 16)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -438,8 +438,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
 
-    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 16, 12) ||
-        extract64(cmd[0], 3, 10)) {
+    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
+        extract64(cmd[1], 3, 9)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
@@ -451,7 +451,7 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 20, 8) ||
+    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 52, 8) ||
         extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 5, 7)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -463,7 +463,7 @@ static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
 
 static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 {
-    if (extract64(cmd[0], 16, 16) || cmd[1]) {
+    if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
         return;
@@ -479,7 +479,8 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
     uint16_t devid = extract64(cmd[0], 0, 16);
-    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 9)) {
+    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
+        extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
         return;
-- 
2.24.1


