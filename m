Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8715C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1BC21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1kOm0IjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1BC21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JBX-0004QI-W1
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J37-000206-4i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J36-0007dh-5z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:17 -0500
Received: from mail-bn7nam10on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62b]:4288
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J35-0007aJ-Ty
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gily5Hn7C9dm6X58g/N3Le1CQ/e6hOu5kkNB+0bhURNcrYV1cCqO/EEAPtl3aqQ4HRU2bLStyM1TYqnGsSl4s2XLMeNEAaT7HIFrh3JZOsEoAEu95k6I1rFmdEKwH5GIP9cjvPap3CpCb1dBOv6b71Yqp61Vw0QSqDV/1D9BCNA9OJoAmLEVl78VYgl0Ml7OrintHHYXcWOfmgxgxqDEYReJ+ddV+O6gKMyqmFF1uAArwG2+mIs9swdzLF7Mvth61RB0Emp2zA5ICfDrYu5Pyn8RXUbICoWkGvH3IlKfez7enQsoM7p1xkN7q2av3VMkjV5EWCdDLSdyYTbHL882lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF9GO/4yHRqo0s96wTWjK7Jp2KhmVyoDWXsSMuoi0tw=;
 b=fw2Ku1Y97oZ50wmIFnnyX8DR99Rh3Vasl/kns0JrCceUte4BXdmdNsRWautSq2Cyq4jtUWdnWaWoUqXE+vnpst2+p+AgHgXxgy22Y6PqJk8IlEXvdO+PkNc3c9eUdXkLctX2fd0djR/JD3W8cVsdtaRcE5vW6q9wYHfMY/0AYQxc8YlcM3S8zSZ2HebW3KxPGxA43zz/1Ek9Qq7JVkY8H3gMFqmpCDMXUHsNmXkA2AnCe4C9ST9qmlRK0FHnU54xNtlfVeUUpFufti33WGcW/L7dKMeKo/4A7w7PJOOF00gC+NK6q/kLKNnm3L7hUG2fy1EQUuOvssjJeqhzI8/V5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF9GO/4yHRqo0s96wTWjK7Jp2KhmVyoDWXsSMuoi0tw=;
 b=1kOm0IjAjzjhi4UguT5K/wRYRrm6Gm4ervXxOcb81wAsNwOPsuKFtlJP0rjrZABdOTAK4IpeVvjCZ1KOBriTShAOF2pe8iefxcCXlpvPM6YgDwI5nUbExWkvPYTDGausY/X0iOna/C/YsvMoLy+SyBi0Bv3Ivk/xPV2Hj1Z3a1w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:13 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:13 +0000
Subject: [PATCH v4 07/16] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:12 -0600
Message-ID: <158161783201.48948.10267676745424104315.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0110.namprd12.prod.outlook.com
 (2603:10b6:802:21::45) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0110.namprd12.prod.outlook.com (2603:10b6:802:21::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 18:17:12 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8116797b-6051-45f2-94d4-08d7b0b0f2ed
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318F583BC6E162E6F58238B951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4QfQqYHs0pn65veNKnFogUO+KdkpioOC/wme8fjg15DAYMXIYYTTAISC4OzOrTFTK3IMWebAuv647+Msud5AhOb2wO3IwuafZXXgMaR0NuIlJP8S/jOr8TC+MPAEVc3DcbN0p6fVbVlh5c/c0aWtFbWApunri3CJqviwwBpv1fu1G1vDSlJv2vjiMkQ+bVZ32XUTRwa+8YabA7IEP2qmFFuVBTx6yJlwvsJbiX7YkwyRAt7RgtMR6dPCofsL60AT7akcg9rTvjTcRw6nQD+23iEgjq/cBODqbmrLDrctwVyqNaUsJOr+81Lhwrflj9hQP/Z+wGo6YoSW7HcZhcpbj8zkJFWYcShaM4e/lFOeXT7+GjUHOPWyYVXiGDf9WnJo9NxvcdVTFotIwtzPmjIqLlhfVhAcCFlEfCLlU7IhUX9+Bbwu+DYJTuz9dZ8SrYO
X-MS-Exchange-AntiSpam-MessageData: whk8lnMwrE/NelSTpcAWykYEhWmtUI8khp7oWVIvi2kdQXzJK0KIdWyOrKE/EDBNZLIGR9PPR6GDYkYS1TWopXFkE6kjk0nmXJ2SyEDt2Mej5TJ2lblrxpBNVtUJHHqZgTUwgo1HZi0BEWzXm0y79Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116797b-6051-45f2-94d4-08d7b0b0f2ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:13.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HzJX8KD6sl9jAmkldXQ+we06JSHZW8o19OBpkwGCzGxBLLzBSyWke+l6Ze0jM4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e8a::62b
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
---
 hw/i386/pc.c               |    2 +-
 include/hw/i386/topology.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 02fdb3d506..be72a49716 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1808,7 +1808,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 522c77e6a9..3158157430 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -107,8 +107,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
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
@@ -160,7 +160,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


