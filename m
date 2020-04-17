Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F100120B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r8oYjzMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F100120B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYzJ-0002JO-5R
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jPYxD-0000m6-Gn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jPYxB-0005o1-2w
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:55:19 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com
 ([40.107.243.46]:10113 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jPYxA-0005kK-Mi
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrM/C06WDa7ZIlBkHzNfRf3prIBo/7uF1GiflNvWn95QaOL+aojunlIj1Ufzqa2UZWSFHthtWiZ/39dtbigMs3EoC+R4VYaP17YxwA9+ocQCmc2jxxBEfXI1Rcoo47T5G2Qp1Pbc6VRjlNfu4fZN66DJhQZ2bF30xe/If60OBle14VaKVW6vrW+SgNC+6wDtLaWk1wQz9aFdOI7IbiFLNnyjL3oFgsKTap70BFcNjafjdsVE9zCusQy8pCbItWMT5QLfRAZGr8nd3mZ5hrNhCplN8rYan361T6fqb8zXXV0B2hxvROtL2tDgckP5a+9Z22p0ucEGPjCNGKcTVqFIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/iialRbx/+naLyBe5T/+oAZMmnhe2N/TSs8voT36go=;
 b=mqHF5iTRB7tGIHHRMxMvh0EJffzfsyJ7dq97jYBDKKcUd1Lltv0VjWvWFST7nkQW8pDAgwCTdt1naqWtpxNteMkD+PNyf8ykfjcv3VlJqKwoNYVOeI+NDcGICKVj+6ka5w7d9Ni9X3Cs2CAFdOywACMVEZEIkoYrUwV0TUgr/GjZsPl8FS1rtIu+emakdulCgDUYlS/NdrdMfiL0n3N/Ey7BR78VrKJfnjMl+9QdA2fOOPcZfj7djw8qNmYO1rvQnGtvCfiIel1OSiVkGBECvp/TaNIWxYwp3G2IWWiKPAWr8vTrTx/AKHMYvqyb2gEGl1fqRSOlCyrM7U7LHKUbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/iialRbx/+naLyBe5T/+oAZMmnhe2N/TSs8voT36go=;
 b=r8oYjzMlQh/VmPCk+b0vqg3E3vnm0dItHt8OKNG+6iI5OCqgUP+bnI6hPRxUGzIlP9OxG0F8M6Y9hrENrG1RdyFIiAQMj2MpQ3/dEtHuQVbd9ZvDaUEYnnGlFCucKKfnnLdMDBlByUe4PqnAQGuci04uuV3fLbg0SNHsx4LxnnM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 21:55:14 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 21:55:14 +0000
Subject: [v2 PATCH] target/i386: Fix the CPUID leaf CPUID_Fn80000008
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Date: Fri, 17 Apr 2020 16:55:13 -0500
Message-ID: <20200417215345.64800.73351.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.78.2) by
 SN4PR0701CA0027.namprd07.prod.outlook.com (2603:10b6:803:2d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29 via Frontend
 Transport; Fri, 17 Apr 2020 21:55:13 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 360843cf-9aab-459e-98b2-08d7e31a0218
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:|SN1PR12MB2560:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25604A0EADA98E1FCB8466A395D90@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(66946007)(103116003)(8676002)(26005)(478600001)(2906002)(5660300002)(81156014)(66556008)(8936002)(186003)(86362001)(16526019)(6506007)(316002)(66476007)(7696005)(55016002)(956004)(9686003)(1076003)(52116002)(4326008)(44832011)(966005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGvimh+0Qx5DyRtQxSrzUe6iWCxgD22vyrruNY12m4+5Pu1/2idIvkOs8r0695WuoaxURC6l/0JLAcV4kc6kKzsS/Yet5b5Miq81D5ExbDD4bkkg6ENNsL8bNf9qRWgFBZoNwtTJiwt8gbseE3oHHqqfa6uaoC6H49iIm4e8kVyxxFT4jXAN9HlaCRrXF+5zvqqk0rWErntVZnsBFTo5XoScwsKaWO/3GzSIxGvCTxZ32KSqWuAde2TJ2PeJBy08qmL5ifpG/jajxo1RkFdcrxylcdSMj5bnc3Ecq7VVMtVysBXDlqnRwyMsw7EWGut8SVNvy42zEoyxV5a+Be8IqxlzDcPvn1Ei5W/Qt8Zgv5BcAgjl58ZoeodtZ+G/8+Lg6h7jtaMkdxWwzxfchHirDkzUp/EIjuV5NiowUNIv5xujq38WNkTRpJyggyMf92I9067MAX/P1MMRrGDct19AbXLhEdXtXdednAiQ6KnPbclzNHIik5/+UV8BaZbA3Rc+ajiZXsxf+XZfWDd0E4AB4w==
X-MS-Exchange-AntiSpam-MessageData: dMz6VDk+IwLweCaSPuAORYsyTOdmroBWioB1z91XjUH5U0GpwltcIkiyvxj4NQJLVHfqhHI7HLnlaMj8kFOllEaZ5gMAFjZwCoCz1a+0LWIM5JY9PMW+A1zi+IXpZ0KwjQ9+mHbVO3wnG1ZolGMggw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360843cf-9aab-459e-98b2-08d7e31a0218
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 21:55:14.2744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpB109bZNCkOWFuXE+v2ovHGPCYcbhvDGDq7LOgOpXXCOSaz4vrxYJRAaeN4BlNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.46
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, 1871842@bugs.launchpad.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPUID leaf CPUID_Fn80000008_ECX provides information about the
number of threads supported by the processor. It was found that
the field ApicIdSize(bits 15-12) was not set correctly.

ApicIdSize is defined as the number of bits required to represent
all the ApicId values within a package.

Valid Values: Value Description
3h-0h		Reserved.
4h		up to 16 threads.
5h		up to 32 threads.
6h		up to 64 threads.
7h		up to 128 threads.
Fh-8h		Reserved.

Fix the bit appropriately.

This came up during following thread.
https://lore.kernel.org/qemu-devel/158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com/#t

Refer the Processor Programming Reference (PPR) for AMD Family 17h
Model 01h, Revision B1 Processors. The documentation is available
from the bugzilla Link below.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: 
  Used env->pkg_offset for bits 15:12 which is already available.

 target/i386/cpu.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f..5e5a605 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5830,11 +5830,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = cpu->phys_bits;
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        *ecx = 0;
-        *edx = 0;
         if (cs->nr_cores * cs->nr_threads > 1) {
-            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
+            /*
+             * Bits 15:12 is "The number of bits in the initial
+             * Core::X86::Apic::ApicId[ApicId] value that indicate
+             * thread ID within a package". This is already stored at
+             * CPUX86State::pkg_offset.
+             * Bits 7:0 is "The number of threads in the package is NC+1"
+             */
+            *ecx = (env->pkg_offset << 12) |
+                   ((cs->nr_cores * cs->nr_threads) - 1);
+        } else {
+            *ecx = 0;
         }
+        *edx = 0;
         break;
     case 0x8000000A:
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {


