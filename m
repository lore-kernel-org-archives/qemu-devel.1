Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C703C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DD120855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tOPYNnMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DD120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FIC-0005KG-S6
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHS-00046j-Fl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:02 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com
 ([40.107.77.78]:21363 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHQ-00027k-V6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CywvoWnv64u+7sblI70mETPGHlOSm9n3xaJb/4MD5sjJEHvbfX2nHZvXh+0Y+vCxD2pbh91+7i7FxvMC1TZnsujvrLojboelRAIfjzccG8khclMqY8Sl0iujXLGKDS9tTfMN4JG/Uh7pew+A+ShAbzbeJLJpMRTm3IT2G7EwyaAG3OB4FsJBV6drrkAecqMTaoQzyoUQXzsiEWMpy45lnbwq+Uq+LwcKuKGgEUhvRrJrR/vm6MvXO2r+p9kEJaPjW5lnvAe+AGxBrB38Dh1x1VFu6spG/wEtWyRnDoeP05W1rjDDxj+o03b9LisYaBMq58gLdt44DGkFZc4WYT950w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqeDoUw2ATwU+l1GtZvpMYQ2cs1HefxOr3fZQp6qa0U=;
 b=bIFMfn+jBTG9J4/o3TadoqQvb3QjNTWABTZP9pnDiPooSt+KvbrKRXwARFGbMV9ZMmSZ5qXL+dhu94+szQiClWXhgUJ/xYhWWBoDC6FXmMexWLjIhCtAT6GgWLPfmqPy3wzAFsA14gCxFhhMR5gqTpUPQ5uEXV5spnzDjvZE4Tqh5GNuEkRH82+ZhyRelbh1HvQO2AyUnxFUBAsKFv/j3gnM7o0pin/MvGoW+IxnqQlaYJBXk2i4WDBSSV9VDT3oOrPTiCAftSgfY08Ha6Xs6cWDWNdybYPbW6+L2RwW9oQZ7h/L0bhO677uaFjA5TeIWF0mGuYgmKQvyUffhVaPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqeDoUw2ATwU+l1GtZvpMYQ2cs1HefxOr3fZQp6qa0U=;
 b=tOPYNnMX0SQXuym7YP2fZYcDDkbgS2JIPkxryMaGywmXbfBeStcGLervfunsTxOEOXIfsWkOpdqYozsh2uU88BKNZ82j4LUZC7A3Tl2kZ5JGHM3Cv5Oahk3icMfEPnSrIhU+rEIfnQ6McLN4x5Sk3Kas9uMlYgnQbYiw7ygyvhw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:58 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:58 +0000
Subject: [PATCH v5 6/8] Revert "hw/i386: Introduce apicid functions inside
 X86MachineState"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:56 -0500
Message-ID: <159804797689.39954.15208502866023220930.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0029.namprd05.prod.outlook.com (2603:10b6:803:40::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:12:57 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7623b940-6965-488b-68b4-08d8461f5c19
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB267070B2003875887C3362B1955B0@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RI0TQ5img1zPMtrDmo68dMIWGVR9gKrbDy7pOGql2n0UElY4wj9ygqfFhskOF6ZLmzrSZ8NSrG1jVlrZe2N4NUq2qBVNDExZdHLObEfNg2E9fd7AkLKgNilp0z4frRh3cxa09eefJjDl1CQBtw1rVCGhyTsRwltscrmF82WCXIH9+Z4cweVtpFDzVdeMfLZUdGm5MNFPZXjRivN7D0w2boV6fi9SKoK4dAIABhEW9eGWyUA4J+NZvRSDS8rayYKH8dVi2Yi4pBRnjq3WV4mTtNr+4fkLe3zDRbyKw92DxHnVMDkQST9FYjj0aMU8ShBVnvi3Tj6UQNvQdwgIPGBbPkM+WvhhnM5OSzDZVLfB0m6G7Av4OtsiqgaorYqw6KZt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(5660300002)(83380400001)(86362001)(52116002)(110011004)(8676002)(316002)(26005)(186003)(956004)(478600001)(6486002)(66946007)(66476007)(66556008)(8936002)(44832011)(16576012)(2906002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 24w69tlpkJvAGHFuxVbkL/DfBbOkeC8hEa2OUSWCkBkXFrpXFDPka7zjWejeus1SlJQB9nrDZtwRoFc81cu3DN4WOALI/0Kc+7SCgtcH8OJjfwCmVWyoDtbHS1qFkoVNnISBXobuZH1tG41mFreT8bjECUlddh8wALNjRfNb8XdeD35K5EjWGZ4Ep+dy9yiO9AVUOUDPkLNE9de7vo7LfOYdLf75wxLTNiWLCTxUAGqNOgKdbAwmQiVkNGEN1zhji2m2USe49BXisPyqZxUMrs5viJYGQeHDpvYhoO5skw97BSj7b0R0Y6FOYRu9PJNlZGEnq2NO/+M4GT3ZptHSWOK2dNki1XALfOnJX12pODsPn6GHjkM6k2mJ6ONnT5Y5yUsOD0aoxLLxvKZJnhUgSwzguXGR+LxBZB9Pw3duEhnteC42mIbDn6RwfhX5yzripWd8HEdAqTJsKNN0xBzgwwh1iDpp7fqCh2+ApdjgXpqQ37wWLxHcwJZpf32XxbbELO209nn9CcBxt0aFNqxHLn0ip6W3ALTxqFvvkgCcrRCviqDLoDu2o2abXWBvdbrOvnzDp0oLoVrP3Tlzq8C0pjUfQE1y5I0kJPIQkk3gnZ9D/YW55tADS5wZzhMwzuKArWL+9dpwx58mVlARvFoNAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7623b940-6965-488b-68b4-08d8461f5c19
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:57.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7EBLLQY/qA0Yub71BOvD0/F25A8kb425wzXzLz65wX9IC7yXYTNYbGNa4e0r+zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Received-SPF: none client-ip=40.107.77.78; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:12:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the EPYC specific apicid decoding and use the generic
default decoding.

This reverts commit 6121c7fbfd98dbc3af1b00b56ff2eef66df87828.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c         |    5 -----
 include/hw/i386/x86.h |    9 ---------
 2 files changed, 14 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 0a7cf8336c..c9dba0811a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -895,11 +895,6 @@ static void x86_machine_initfn(Object *obj)
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->acpi = ON_OFF_AUTO_AUTO;
     x86ms->smp_dies = 1;
-
-    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
-    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
-    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
-    x86ms->apicid_pkg_offset = apicid_pkg_offset;
 }
 
 static void x86_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b79f24e285..4d9a26326d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -63,15 +63,6 @@ typedef struct {
     OnOffAuto smm;
     OnOffAuto acpi;
 
-    /* Apic id specific handlers */
-    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
-                                    unsigned cpu_index);
-    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
-                                 X86CPUTopoIDs *topo_ids);
-    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
-                                      const X86CPUTopoIDs *topo_ids);
-    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
-
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.


