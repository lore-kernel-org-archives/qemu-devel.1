Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DFC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7BA2071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KiOMW+Vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7BA2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCons-00028O-BL
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColG-0006JB-TT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:34 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com
 ([40.107.75.74]:39303 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColF-0007VD-BM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/YLprAIE/Zkgb8t8ZNAj7YG3o3ygZHILnfDIgdB2vRBNoJuNfJlnb3BvKJY+X4dJ4sktIF0bWG+em+Rsn2uyQOORD13tEwg75perwM+nF9AWMhBBctX4kIrvbPyK7UFEINtec7U89rocrnM4vVULGeCpDNGrPPs+p7BC56kKyr61NMNdvQHvlwTTB/n09D8c4XZC0mAv8RE3rdQP122z6KFgSESwcVd0TqHl6/Wy12fnhnOVSe6T6DQeNQrj9Y9qUNbpKe657c30+XAaj6htZQDhsxdP2EI9DvKExLrtY2eE93du/ejDFYnYXpbsKrlEgeE6DP1wGloM3Wfd9+Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9IGypxYas902igNImmGd5TTMPeGRqNBq9ZlYS/7SwI=;
 b=jvjEho6E2MPxcRNQkD/Dz2C7q/bBvyW7ucoU0I5qvUL/J+iIiEly665QV5YKWTKl/Y5WdYMnBWILetRtoSiWjQKrN5gNLMZ4dQKoREsDO53lOHFc53C9kUTEvPGIko3wVQUZeugW/SE16Ly4G7In1JBmTa3hT+rY/OO3404ipZYhy1x5gEuw5+0Hn+nFvLwpI0cFXyUGdKK4cITWyYAxU2fm8AzkujgzS3qxVsjVEi20g9nAdoBuiilSNbDYZ5QMfnkJPA5wjmCE4iHtKotIRwotp2Lf8fkhzpvyssxxXyXCvq/cJu5TFAW+9fDhcOtAffJBLD2Nu/5miPq2+spmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9IGypxYas902igNImmGd5TTMPeGRqNBq9ZlYS/7SwI=;
 b=KiOMW+Vr4/H5kHe9oHuL7TjBr+Md4jjgvvmPOwlbSY1uPbjMf5TIsyaD2YvF3mJ35ScPKl+lSWzTqYrO+iKXflUQkHcxxxjTvQ90wGefNqOvrJHd7y14/YXmqjQcywreB+ZG1YpbyXjUKJ90b9bcFTfqAa1fhvTwy0yGh396rBo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 18:42:31 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:31 +0000
Subject: [PATCH v6 04/10] Revert "i386: Introduce use_epyc_apic_id_encoding
 in X86CPUDefinition"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:30 -0500
Message-ID: <159889935015.21294.1425332462852607813.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:6e::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SA9PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 18:42:30 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 565d1c80-be9b-44b9-5d90-08d84ddd9e51
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2559A52AB063CBF5E226D87895510@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laYlAA4XYuaL10JNVMPiA6BP6XrpYYvhBLRBQb5yZjUz5l53ZZ6OWpai09wJiOIUgvurnjhMmv6VSOo1F5zSKlSODnJmRGAq2nUev2PwaZ74siiY8IKLudyJwYUMrAn/kk4e8069+PrNvNaOLQ/iei2aqau9k1uSsH2mxWKF2ndYYvXpUgh6oZfXAVFRvNfMOIO10UdqiWDMnckYqTA+zyTnsGEIlic7HyhwQYq87m5BdeZz4SUWKS6CqZ9kdpFAqSzmXi95kwrV2075SWFgWNo3qyIUaMrooXN7cGCDGWyNq0p0Fv2GJPBuIlnq7IDJAZ/WxPI2DGraN0Pw+Uhvhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66946007)(83380400001)(66556008)(4326008)(26005)(956004)(316002)(16576012)(5660300002)(186003)(66476007)(6486002)(8676002)(478600001)(44832011)(8936002)(86362001)(52116002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ePT2hk46raKDew5nkvsomOJkJ+0/IDbffQUOEo2dA9VRAcX6hMtofZ+c4XxzRb5Vgb10ufLNjviUi+OqdBuBJa/6NBN0WtDCIK7mJ+kZ1NvFosqFEu9DcqvbNiz+ck1SfCRBvaGc9/l24Rc4pM/RewmGh7eylZSBeaX4Ym4w9o0YqwLW09khvZWQUjNjyfQK2C+Zl/oTklrwbC5tMpzWLME1v0hB9bFx8MqPKJVe1QIwy0tBiXIggSVLMYiQj7K6wRH4dIGEKh3E/wZcDy4zggV1+8e8TxnylwMKjQMaZSYXX21gjXCuzFYP6CFmkCYqdjewYex2kXujWWIxvsS4ZGqY0dvV9LUQaQMhrVR/JuHAw6NQwijiYx3ATNUkipCs5wLKa1zFSRqpLhWqE4TsZwFeJ+GkhqfLNbgsGDJyEj8IsBU3tuYZvzURcn+5gAzEiIXyuEUxASxH+pL6Vpov5zkJahI34BO/9pQ6J9eYGS5nKasDZtg4CoLrbUt0EPiDeA7e9l0KZLZMZ9ihMEUFZbtneEBlaSDA7K5VI1wvge995CDsSA3tHn5aICdt4Gq+L65lOiBweMNukDkThAtxRR+tX2er8N1JKyxFuaU0VeoHiZQvHQtcQ/StiBcT1dimVJuN3XIf8b8TBNDYKrT/ow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d1c80-be9b-44b9-5d90-08d84ddd9e51
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:31.3228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUtWdm0WOQL2zk+J7xX36FH2RmuJHOk1kx10MgpldyPmIqgrGGox6S7kuNsByH6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
Received-SPF: none client-ip=40.107.75.74; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 0c1538cb1a26287c072645f4759b9872b1596d79.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   16 ----------------
 target/i386/cpu.h |    1 -
 2 files changed, 17 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c9c1e681c2..b72b4b08ac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1638,10 +1638,6 @@ typedef struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
-
-    /* Use AMD EPYC encoding for apic id */
-    bool use_epyc_apic_id_encoding;
-
     /*
      * Definitions for alternative versions of CPU model.
      * List is terminated by item with version == 0.
@@ -1683,18 +1679,6 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
     return def->versions ?: default_version_list;
 }
 
-bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
-{
-    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
-
-    assert(xcc);
-    if (xcc->model && xcc->model->cpudef) {
-        return xcc->model->cpudef->use_epyc_apic_id_encoding;
-    } else {
-        return false;
-    }
-}
-
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d5ad42d694..5ff8ad8427 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1918,7 +1918,6 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
-bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


