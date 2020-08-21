Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAEAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471B5207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FzaVjeti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471B5207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FLN-0001qF-Hu
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHY-0004IC-M7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:08 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76]:40513 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHX-00027r-5N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/bH96aH5drgTX1q1jEpI2ZAiFA7EPPggnwVGbvCVH1Zg6KLLQZ5uT7G5Unx5wHyN2UnTIYAlSG0rvG7CdXbUbC/l5pATsAtcbbxhM1zl3VBM5BYQ1F44Nb/I8JZknmqp/M9l/VnRWQSQuul/VnkhRhyoC7zojCAuSrTWjiAknZBU82C8/g++SYijr9U6U4/X+jZxTAlZacJ1lxhK9Luq2cXD0tRRVU1Ijah8b2eyOXqmd993OTBNMHKzaBQ+OGnYYf7aDgIUqHTRQLQCPmtp9D3qEadWQjLj/vsoCfrEjvQ/CAWQSsO8D1693CbHM35ZYFhDucyBn8G1hjLQSaCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+KgcY3+39eWLChOdc11dtZyVc/j1j90PkNlEF+TcjE=;
 b=ltjCHQv4S9S5yAU70Oy+UC4oMO0RZIQeAtKz4V3K/r5uDOA8sL6Vp7TaIico/CHCX35Z7WVEO+VdWU5f4n/f09A9gWQoUXi0wjhae3Pu18RmaGJDOyeEFIn8+dFCtJqTL4/+Lw4vkkHA5RbbkxhMc1CaZ2kVfyMwJhNuYpU2maW71dDjxOW3gEN+BtrXAnUUYpmzIPDnXiX5Qwa4/oXioed5fdVI9skqT7Edzt1Aq5KJ315s6gFFazKMvZov4bL17YnsFXVJ+CoqVtivOORImY0WpFqgfTE6Qpf7EKPvTsflNKaoL96QIeqX7HwO2iSo2CxyNj8/t42DEQOQwIAj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+KgcY3+39eWLChOdc11dtZyVc/j1j90PkNlEF+TcjE=;
 b=FzaVjetiXxvGb2oVLB9gByOHQo3A12p/1lCIeOrp42LspCfYnCncbmwz5ZBs1vmRXHMhWMrH/5pW8Xf9LoLHj9OS+O7U/aS/qCvtqU8AYFDC/U9LDaWFEPTx07nL62a8xz6/T1yoSqKvbGMt7plUpUtyTsmnpJRWSyz8GMR+5wU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:40 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:38 +0000
Subject: [PATCH v5 3/8] Revert "target/i386: Enable new apic id encoding for
 EPYC based cpus models"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:37 -0500
Message-ID: <159804795781.39954.6498589500212777914.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0112.namprd05.prod.outlook.com (2603:10b6:803:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:12:38 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2bd546d-cf71-4cfc-4487-08d8461f50cb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23831BD4FA5AF2CB281C1A16955B0@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moOn2tbsfANiqbbgn28eud7PFuJHELZ++oWInXwp0WfKz4vg0Gwo/e6O8GLhZAc3SWZRKqIpv/YDJH90/k3XK1fGODr0VDcK7jhNVyOuLPPepzoAQToohkxy5UA9O1D025UGndjsoyOLedYBYb+IaYTHmlcnn8aA/ruzLbvt3q0YHekV0NZ+GgxLGD0HP8ib3Ru1HX/3pXVUXT6JE8Eb+x+t82eykrLDhrXdwZobr838/n1KpExPaW2axGR16Os6RdFImIU7YXLfjrbpLgbqu51OezJPMxSz78gwITo3z8ntz+uTlepIJMjQr4zcjKrI3xpSZx9zd2/jn3h99nGCJtq0ovEAQpQ5P/HOMcvP+fx831Yu9T5gR+3LD2Yv+6kL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6486002)(2906002)(8676002)(103116003)(956004)(8936002)(44832011)(110011004)(26005)(478600001)(86362001)(16576012)(316002)(52116002)(66946007)(186003)(66556008)(4744005)(66476007)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l1oW36W95D5KMzRiWmpkxWYsNoMyvJ5QWe0Dcd4C7pYNViT7c2RZKa+ZXWj0PW0kyz4KhLTpYsrRYfbj56qxaBNlU5D+4BrgFHmS2XBuVTYLF+QdmS9Moh5a99xirpcMd+eark4hgf0igs66qZXa+EUshP7HkM1wVqoy5PB4iYPP5xi2EmCLzp0kdZ9RVPC9WFnKGj9OvkAA+m1gEh2nA1XBqYMNwKYJHTDo4+c1/NUY00Sy2G4aOBiF3BZHc1xm5I9ciUL9987nIPpDEoIcK1dVhvcBmvV1XPY1Uv5aZnbsPF9h3cIcN2ZjiT2+xEqd397oxk1W3cQ1ZvODaVLrwEwe8lwQR6AjsEVilUKSXZkBQRpor0DhBx7AuYBLp9a1RNOkjDnDqc6LWl383LVYMLovtIEuBT9OJ9WOcF5i6W0pZr2zPtoY2QphhmXaSzSEEngZzSY/VRU6LmDts3CGYhHfP+cE7Ipn4Nf0SsdLq42G735XfaAKoW/wMh/h4TY8Gtb4DoLInY9K3W5RWxte05Hab59rFi0HFoQVv5g6zszRGL1MfF24rmMErhtRW1ab86UIl1X2AS6koVnM22XJdBEaHzXRkGM0IQT25PSwjJ2u+qKJQEE/WjZWnZK+pK7Xu3T83qUIdwiZoImi2m/rwA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bd546d-cf71-4cfc-4487-08d8461f50cb
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:38.8243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUJGOJDZ2V5glj3htkawrPPlV0yQJBSYQCU3gxQfYnZoKsLHIpXH6uiwKTffuu/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.220.76; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:13:01
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

This reverts commit 247b18c593ec298446645af8d5d28911daf653b1.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 83acbce3e9..567d864051 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3993,7 +3993,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
         .cache_info = &epyc_cache_info,
-        .use_epyc_apic_id_encoding = 1,
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
             {
@@ -4121,7 +4120,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC-Rome Processor",
         .cache_info = &epyc_rome_cache_info,
-        .use_epyc_apic_id_encoding = 1,
     },
 };
 


