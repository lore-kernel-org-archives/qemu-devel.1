Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74976C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAFA2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JbR8Fg6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAFA2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dhi-0004JU-U8
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfi-0000lg-1A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfg-00039B-UV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:41 -0500
Received: from mail-bn3nam04on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe4e::605]:30851
 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dfg-00038Z-Os
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp+cvrN/Py+zU2QJRmHKhLxyL2efBaZoc0i6N+vyfDwg2G6ndKP/0Sas2NyxyaWRXzpiv2g6qgUJbTxrX3bTHOHsLyGjhpP/blcrpR7nz3/k/rb4qLk4QpVXKmsNdNc1Qnm1QMyh40y+48Dv5U7sbISXgh7G9oi/d+qTP0MZQrRynJCo+nc6GDmoZqSkktEBnSYazbBTfhfesi2ogyKlu7oJKQI3rXbe1P4qsWDhaiCI4aN1imL+luC+xfjLkNEUV7Q4+xGP/FTr1aFYcxPMsEpqyfceKSQfNbdwto5KtQbsjUMRSUxxJd3VuG0WOJ+ljjokM6LV7QVAAgrn4exreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+u2ICj/Q5djVtdlPcK6+p/2u0NKk3HTJ0sJ3qCpY08=;
 b=YYE8vljjUKBcEri337GkZDXuUtguv/y3a7XX6mhyXilGAekCPUC5SktIuSQNNDp1i44OPWLKo4/DLo0H1iv8ofyS/NYTj2kXDUhUV1VmunDiknHUrhJX+YeMdrnYniQybPLD9Btd0oMVYzbyXeudHQtwi+hCWdn6G89pouLvKbjJdkcgizf9ZmjHRewngFC07jiwOu7doZs7jW8CH+RpEZBDRNAfRu4o982LapXoFx+3TBAog48Jmzsm6t5stnrj4INTdXpJ+dd/ye6bMauYPdWs4BK1s1ie9COxq4WcHxIPnqv+4edacPM68tairROvDJg0ybhi4m1pf5A9yk5eJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+u2ICj/Q5djVtdlPcK6+p/2u0NKk3HTJ0sJ3qCpY08=;
 b=JbR8Fg6xwdcGM7v24LyazisLwaWjaW1drTuNdXO7MWB9ZXaQx9aa0Qs0rEVckptvmalTKYJc2vrb/Rs7zwiDSawi436PUP1MPAxKlTCXVmH8R+L19wohTdt/EyiWRSniG7CaBloIUOGSKmB+d9KsLWtoosYj9UbJAQepTFAYKHc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:37 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:37 +0000
Subject: [PATCH v5 07/16] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:36 -0600
Message-ID: <158326545682.40452.3744786681609930727.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:805:66::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19 via Frontend Transport; Tue, 3 Mar 2020 19:57:37 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65aec257-0827-445b-88f3-08d7bfad1f7e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573B06D7D888DE51A382AC695E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwxS/7x+QVrzyThrF8MjIasYdG6xYF38Xjaggr22kAodEoB+irnA31OIzPE2heHbtnfN/i8aIXqzsSjvt85qYEiMjO2q6kWegxvHvftx54ZCP8w4PilyUzxg7rsfuU3tRvDIhAnjtDA29vRd32pd5/vi3neL4gmVYtNFxtutUg7hm8FkMTnmvpzEm+3HqVveM+zo86R8KKx5OqRaMMDvKQzLWHDGZihZVxK6xDGTx6hOzqz3tJL/MJ66ZQxX6RP1thpLYkNgD0IM6sOqfoYTOzljWQo26bMHugZE+m2rcJFr/Z8oM4Mk+0cmCJEEHCcydP9RrHYXnJSAZXI3w/aNvXQlAbZGt9njXA/f50m5PN5rFrjDF1UzUGBqhJOpCeyWzD2pES7743eKWaW2lqQSyVNtYKoJUsVZrZJbWE+v1LCNB+FlIwhIig7FYLwbC9Si
X-MS-Exchange-AntiSpam-MessageData: wXaxu543TcQFyDeZ+gYuYHuMtld83neUW1X5V262z4S6/cgQ92+BLmf5Lqk3C2edy+lr2HlNV3ghh5g5ENsaWHXy/NGYb6wQ/CABhjbrBubODFt2ldXo2PuyoT2yEnCVzGkNgpRP0G0SmImtC57+tg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aec257-0827-445b-88f3-08d7bfad1f7e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:37.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Skz/M6O0Y+Q4j4xOfo5L5OBqScz8zfNiZ8ciEXbo3rlzMz94s/1+4unYXTLt0StU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe4e::605
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For consistancy rename apicid_from_topo_ids to x86_apicid_from_topo_ids.
No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c               |    2 +-
 include/hw/i386/topology.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d13cd46d6..17cce3f074 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1581,7 +1581,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 04f01e2a09..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -112,8 +112,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
-                                             const X86CPUTopoIDs *topo_ids)
+static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
+                                                 const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
@@ -165,7 +165,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


