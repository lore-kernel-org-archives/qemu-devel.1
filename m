Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F4C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3818F21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="muQfAS9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3818F21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JDF-00071G-Bw
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3R-0002hh-Qn
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3Q-00005s-QJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:37 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com
 ([40.107.220.64]:6061 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3Q-0008Va-Jk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpkebKYJHFvvR9YeUE0IqLYwA7idFkozc6zpd5sUv2T0un1Q5xazxrAHNvY5+gADr+++5ysz/zsH5O4KeJUH6KVBpfji3FH17rI9gjWZ0b7kP5RWyba1IaR1RVjsPAfQ01gSg4EQSrFK7cndl+WE0M4P0Z1zMBqbNAdorPKKUcN2VIV+McrDJvsrBkxeUx4yYHcrotB6rorHruuvTdlXOQdYPFNtRSeCenW66gcIuknX48njv9c7PHRAHl5JP+fXvcbdDQk6EfgL9EoKAtQx/NHLOHaNspO/0KT/+PEIE3N8a+8RoCaztXEwk5nAcBel472wSSXUdeSM03raDvsLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIgdlWrg/XYsW0ykVAU3vEyOu1DEy+QY2vvZvhEUZZQ=;
 b=GNASXAZXYiwwOG79I4a8Z7kQUkl2M3vBd7qJ5N+lGrwns4yrJj8VEdJbdBi5DBtsNo3bSrm+5zvxAS5xZezsKWb9sbbUHMhzbfnVY4yOF0MlPwEIZg7EmWTEhkkWkIysTOh/D2FKeGe/+zDiUynTbdqlFqfxLywGYvT7qXWrYg0rEMkK/etA/uI9Uj0h1iSPS1KFGTgu599lMKIciDSvKMKrGYsggr6CbcXCrYlJS0U2u4LL/BSH9u0iVy6ib5zKgiOfJMcgXiuGCrihgIvt2VZ80DN5K7HabLoUBR/17EedAhefrjWd+FOIA8MBjme+qwYEUzLRiUEWblRist9TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIgdlWrg/XYsW0ykVAU3vEyOu1DEy+QY2vvZvhEUZZQ=;
 b=muQfAS9a3O4DOdgMLOzijZibJtE7R/k170xfDl0D2zmYbTEV9WOD2s/y8n+MHHv7x9emSD4+wluMsDD+5BVZNb9gHY77h30/DVhSg728OuX8Ioi9QrOXhMHx0kjAGvzVC4Dxp1TqOWaKubgJhjhV/1p6Cro4stL+FYCKMBfHl7g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:34 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:34 +0000
Subject: [PATCH v4 10/16] hw/i386: Introduce apicid functions inside
 X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:32 -0600
Message-ID: <158161785243.48948.11368379114010493667.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:5:54::30) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 18:17:33 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b144d26-e2ae-43d8-94a4-08d7b0b0ff5d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318D3F4A98759E966F7533F951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(4744005)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV1stVYQjh3LOj4IP3MJe9L8/giCbNGLJUtgcYZlRIBFbd0tKwYvGW45jbKLi9auRZpS+e6T45a/BCabWPp1VE9Ow/rq+by7NUPOcgARtAI7IC68w+vuRTyL2ypyBO7TWrnULNSIl9KCsN2idBX7f/d4afhJJGc2PgCx9uuSTW+kHJpVlr6X6emsAUGSJf+IrdwyBMya5oDwUJNsF9W5dIcxvFhOVpSMsTp9XHq/pIOIw4jSp/fpi7as4xPWRvyrSCWUpgssuMxHAkj6Cs31xVS5sA/L4rah0xSRHzHivqnAPLbkpEAPXCzPMfDrC3aQUzeRGSJNREv6v3Nvw+aW1vWj01Kxzb8u37Nl3LjmY5Ay4OUN/KYvn3F+irEb/Ip2wxUDTez/8XigDF6f5Vx98dqkM06dKC0E+1c++lShgqa7fxDvXQeS4Eaim1eV6Hsr
X-MS-Exchange-AntiSpam-MessageData: EQGorrbhaSBUqgAIA3wDDBHZy8iDZ6SMkM2Yg0JrRC0UL435KvugoqmnvZdz/eNqdrjDzPxJ1U2u+GDg75jVtJ+UxZhv7jI7pPVvqNN/G7ZX3YtThy0UVFEZ9n1eCK29D0eC1eXAbxG8dRRJ402YIQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b144d26-e2ae-43d8-94a4-08d7b0b0ff5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:34.3299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0Nqq5OacOjVzK9hdY0XJkmtzkVudes/LOqaHVwGjkABNlif33ZPZ96kEkZkqQzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.64
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

Introduce model specific apicid functions inside X86MachineState.
These functions will be loaded from X86CPUDefinition.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/x86.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 38c2d27910..75c2462770 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -79,6 +79,15 @@ typedef struct {
     uint16_t boot_cpus;
     unsigned smp_dies;
 
+    /* Apic id specific handlers */
+    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
+                                    unsigned cpu_index);
+    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
+                                 X86CPUTopoIDs *topo_ids);
+    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
+                                      const X86CPUTopoIDs *topo_ids);
+    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
+
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.


