Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53FFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A7E206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wN9SI7CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A7E206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCoqW-0005jh-85
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColM-0006Wa-P5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:40 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com
 ([40.107.75.73]:50756 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColL-0007VR-6j
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyn6A9bS/HzTKizioFNWrPKqLJ2sW21+kmhySMeKeNs11DnQlrUn3a9Y5sogtoVXYx15n9LhbVPPtkgiu1dSWMMRaZj6fKRfMOGonUNwZ4ss+pqVHCq7+bPGrs2V7st5gNpjC3eEO4UWA7QDYh5yd99Fgqh39wkxwp1ENVIlgLz1Qims72WPxN8UEQ4G1SxZWWwnCCdCc3RHebBiS3/8hskcUINyiqd0G8iFSwFXIyqAXXP1cBfYiZYy150AA2Aa97IUaNwiIrHQLUiZlJCcHDzOCwmfFLndXpT0tpIUH3DeefnPOWjy6Dl6Dy0246tNyczhAH1O4uJbJT9UFCeApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9/vr0RtSjw+QTEjZPNKRKielVluz3EjNwJfVjl268=;
 b=cbfey7Un2JpxvH4hqTV/l+GZqKiY3SgXx94/WZB5EhozErBuirJtrCKV0GqMUmDMTth+2C8b0aoyK4PijKvqUMgK0qu+Z8EREc4x5Ep6GcR+i8xnDo0bZK8ZxdtrJ0qORiiq1mKb9/2n/K7bkkIt9lDanpiocd5Y2ywfcdGWrZoByrScpEvPxq4CIDMXALhJW5vZecs+0GHZUu7bBo+c/gSTuMRPXKvI+vh4IFUb+FWXWQQr5mIYKrJb5vCjWFlB17i+NBIT9FED4NjC6179KjPA0WcezW1iJbTuEk15CLN6H7rGt14JObtYkqnCcw1Bwb9fl3FnW1mHHzNLTil/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz9/vr0RtSjw+QTEjZPNKRKielVluz3EjNwJfVjl268=;
 b=wN9SI7CZ6HiDbzJYHwiaNjjDsK4s40dSe1BMspyedJtJ0uID5xXKWsVqsKKEiUZ5Sb6uZX2Ud5opGTm4KTDp0mP/zaMxCI7ELs8utLNHAutNKLPYewabxccbfUCd0kpb29CxC0sfxTzraMkLdh1ipGX58FAaNbdRsY6rmnUnr74=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 18:42:37 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:37 +0000
Subject: [PATCH v6 05/10] Revert "hw/i386: Introduce apicid functions inside
 X86MachineState"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:36 -0500
Message-ID: <159889935648.21294.8095493980805969544.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0073.namprd05.prod.outlook.com
 (2603:10b6:803:22::11) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0073.namprd05.prod.outlook.com (2603:10b6:803:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Mon, 31 Aug 2020 18:42:37 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcda55d4-8b29-4607-1fea-08d84ddda1f7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB255912FEB6E7E86256B3162C95510@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POQRKpm8OzwI/pc8beLIJWB0crhqCFFaXWwZ3hGSrT6Ckrb6lONF96GVqcdMOPadTJUtp6ma+eQ/jLYwGSULljesUUBoMAOek6VqwpMoots3efoHzyhphcNdmYsuV8vrfJwajCxFZ9fT4SBS+7R1b7j3ODwjswIKlpEnuPktjXo/6ed34o6dLCgB81/hoUoaakD3sRZXJ6//nvBLhpy2+qOTdjA3CbKWir9BQTCmK2HASTIG8l1w1/SSarEqZp6J8yHOn+P80+7+vWsUil4M1lrxNhAnD4fMaSNoKyVQmfnk++47pmWqqRzA1HW5ogLUW434ECzjtaMXtfBVtXBtdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66946007)(83380400001)(66556008)(4326008)(26005)(956004)(316002)(16576012)(5660300002)(186003)(66476007)(6486002)(8676002)(478600001)(44832011)(8936002)(86362001)(52116002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fNYtjFHMBNO4GitOcRCBcIfOxSUWcvFcuf1+c8oATmyu2fj4uWy1kAym4FCw6oaLKYApeTzs2AbgZt97ZPgeztSW9tDvn6J1nqHGtKSDIPMslMXUGd9FuYnaVVKxcz7xeGXsn4SmN27YP3dfzosMBAqT5CeEt36LCrwY4r6366RkqdXsJf5gEgWH3Zjm65RhK5PxafzDTvOOj/zM4z5NLydDhK1X/p89FSdvz4Jr9svjdL91K9U0XIrNQA4SCWS8L26QQO1uvzNOo3rTlauuXrILnAjo0UVMF5lBgU4KEXVqp37Omd3kxvciHVUjw3vJhl3e8pbg+fdFO3YspS0RWPpVJMMoSxkefuBIdB0vVraPks3DXxoBaOVttJCndislMPIswJjhqUnbTyul8DdSwuIK8fUlsofcSCZOWTn9ZIcm//CUqevhKgz7K/YRbp1acOZVaBLEqS4Q+sVyC5gwzlOHVsGIdr9lbflBUSOhV4VPJVO0tPyBaQk+jl8OZ+761oCsnk4A/vFyVdUDAzSVg1/2TBAN8DjDjEgsrd4yBNdmtqz0/d0WYesoMuH731ch/pVAla5FG987b9wKB9hnqadzBtJK9m1/x9puaae9v9E7MRaRv2CvSqqOW0P9o+VWqmS4Vuue2K+TWDsASliGYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda55d4-8b29-4607-1fea-08d84ddda1f7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:37.4323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIyAN25ZY6WnyTfLTcMlpWsn8XstkuGa14wQ7xOLutHYcFCgGxqlogiUUdU21voq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
Received-SPF: none client-ip=40.107.75.73; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:38
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

This reverts commit 6121c7fbfd98dbc3af1b00b56ff2eef66df87828.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c         |    5 -----
 include/hw/i386/x86.h |    9 ---------
 2 files changed, 14 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3cc2318212..727c4a0f1d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -896,11 +896,6 @@ static void x86_machine_initfn(Object *obj)
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


