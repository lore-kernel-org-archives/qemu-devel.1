Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B786C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C502074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vsTR/hTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C502074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAJg-0002aS-EH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEi-00008g-70
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEh-00068U-1K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:00 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com
 ([40.107.92.77]:6259 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEg-00066g-S7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRRgIcUiXUKGuJ9WcpZnrz6lr755ajMXYk2Za0gaUr2EsmzCftUr78I4N4L9pCDzMdpKwSl6arCXYm02KmpZnLZKw6f0b2mFF1+mR0AF3/b1Gb0yF1BRyTmL0aPpCL0PCh795my5sGUkoB9EwKJWtn1M5LENAtYX1iX5l882OwbyIIjYtHZQ92yU6c81ij8BBwTF+AdyzOamtAjsmvf99MlsnZO56pjnZNtR73mchrRvv2X11RmPfVbqWyi1q86I6s8yuRPAO3qHLNTOgXvWTJ2V12EZ1FzrBp7UDldUlycgEL+N7ExEYAQ3SZHvwXsUH6h3JkondS2lI2vNjwqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI0OIQxLx9TGOpr3BTtPBV+cOhHkeeuuol7ElE0Lazw=;
 b=G6FZi6ZQu7HgikZC1ld+2zBUJ1URvInCoxo3Z4ICySo31FWKVaNz8YivqWBMKyYaD/rlfJk2luKKEWz58P4DnAhRkczT78hzMp7qizgTnUZocb4eR3gQO5QzvPCckD+AttOSxlcnbkOFQvq5HNLFi8y5DbyZSK7Yo8ffpva7XgLzUS00wKs6VJwoDA/BS9MNeVcuEBgXb1qNBoPNoG0QD8hOItY4RVuxnLk3O7uCCfrhOCdhADyGFOw1rsgvxuBHEBR9cYJr74nc2qPGpv03Hqedej/4j4qnG2wGcmmwrdG4kCwaCkeX84wXJ2cZaEklHm+0yFQ91nuF1Tn8KZfOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI0OIQxLx9TGOpr3BTtPBV+cOhHkeeuuol7ElE0Lazw=;
 b=vsTR/hTWmmc84I+/kAQNj2tjGrySSy6X+UBgz+7S5YoyAwMJujuaIziZucpueqrB+pBgKjm3Wf7l+IlVBQz/GkAvSHSsjXx0Fk/sN8AAhJxj7kXmPNrOEMuXkVvE+dbBVCuxKCvRUyGmpiS3Kr8gRTHhE1NPr35IwT7ICTB7n+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 22:53:57 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:57 +0000
Subject: [PATCH v7 10/13] i386: Introduce use_epyc_apic_id_encoding in
 X86CPUDefinition
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:55 -0500
Message-ID: <158396723514.58170.14825482171652019765.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:0:54::33) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM3PR11CA0023.namprd11.prod.outlook.com (2603:10b6:0:54::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 22:53:56 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 938e12cb-4b55-4595-3b0d-08d7c60f148c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:|SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24802DF9B2A6992E92AC9F5895FC0@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(186003)(4326008)(478600001)(2906002)(16526019)(81156014)(26005)(55016002)(316002)(956004)(66946007)(8936002)(44832011)(66556008)(103116003)(7696005)(52116002)(5660300002)(8676002)(81166006)(86362001)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2480;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gn8tObp8TIKDoqs0l49BulOYTc/bjERJ0BW4UcOUsR31J7RNPZui70xavEg00s6xyOoFSG2gxzVlcvkUDxGKtRGmVpspI9WfcINa9BLhaLNW7oY0fOkhoSELnfB2PSUKfKj5RATLuHWhbXxm9RRR0y7FvH6uupz9A8861dep1BJyONahOsU4ygcKNK7MrJIzi+jLeCn1vmzPyFJbESo2+1ShA+xg0A4EAt4iPjsgPNc1UlytTxBkNMbrz7qpL2ompRPl+ViGX+ncc9SlM6vPqoKQrmFxVg5ZUOAbt3H0yUYqW05GyfBmfn9pLSA3Y+mWMFVV71Bgj6xZtxiUQUcrVP5t/GUqVdYqI9d+TWEf1Gq3YqSSDInDweSZVUQAUodnaN5HElDdWNsqx2c8HMi7Kv4Cz/E3G8t9wMU42NQtjA03Nw4kWc/VzhoHrDzgJpKW
X-MS-Exchange-AntiSpam-MessageData: IuaXhiTQ5ilCuSakAqs48Ltx+zBJoIrmP3yvfl+TZaJl58zBUlCoxCM895OClOzMyfnUjpbw+AJxavokSU/wWso48FDxzlzaV6/2gvqM/0Etg4WU4XoE/ZkwwIGbcY4kGIhgkYSHL4SINoTmDRqWEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938e12cb-4b55-4595-3b0d-08d7c60f148c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:56.9457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3QrEcbbpb7p1nhKhVr5xi2yqXmLNRonNifrVnEnhKEeTx964sLrx1pR0t/q3dGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.77
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

Add a boolean variable use_epyc_apic_id_encoding in X86CPUDefinition.
This will be set if this cpu model needs to use new EPYC based
apic id encoding.

Override the handlers with EPYC based handlers if use_epyc_apic_id_encoding
is set. This will be done in x86_cpus_init.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   16 ++++++++++++++++
 target/i386/cpu.h |    1 +
 2 files changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7361a53166..1e4400df7a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1614,6 +1614,10 @@ typedef struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
+
+    /* Use AMD EPYC encoding for apic id */
+    bool use_epyc_apic_id_encoding;
+
     /*
      * Definitions for alternative versions of CPU model.
      * List is terminated by item with version == 0.
@@ -1655,6 +1659,18 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
     return def->versions ?: default_version_list;
 }
 
+bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
+
+    assert(xcc);
+    if (xcc->model && xcc->model->cpudef) {
+        return xcc->model->cpudef->use_epyc_apic_id_encoding;
+    } else {
+        return false;
+    }
+}
+
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e9e963d78..6e522fcd34 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1897,6 +1897,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


