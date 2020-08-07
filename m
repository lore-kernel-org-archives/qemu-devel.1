Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8BFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1576920748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jnkgs+ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1576920748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45K3-0000TO-Cc
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45JB-0007Y9-Fc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:29 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com
 ([40.107.223.82]:39489 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45J9-0002Ws-Le
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSnM9Sc4T7Okl/9GzsXhUsheKAEZJXQX8nV1ejEhmZVuW8InpZMkHoMdciV6c9oXuZ/S2gxEx4htad9Y6i3SMvCD9fs8euQNLy8yf+36nycKFLw8S4wQofD+Ynl1QqxyczFUCG1pK+53eYOTcVjBcOjYoBP68IaNXuzsfSUJJFrFelIcqLwhn+Nv4yokvbF7vYE4/1bJO7d/tl5E0cTwh4srvX5IWUO4BEDcv0zZeR/D5bJ2piFQOw8SS8FuAsv3tnQcZI7FioYvzraXim4MnJq0aTXW2e5bRBqP7bEvhQ6DB2VWfhwKaH7HFpRecnG3pNU45gglkBn36MyPiBSRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkLmVVs3L0O/fLjJqOAg8Ywgwxf5Pcz1jgHg94mTQJw=;
 b=gZAYztpgho6zZ7JJyKYcKrwLVDfj9WE18IAME38L5RCUSWKE2ORVzb2X133X+q+zTEJPQbNlLKKIVyhM327Ymz6KTC2kBo1I0Jn2HOwCVtD/M8NuBDnE0B3bgUzCksBcLsRmoQOso5r/0q4Etur6KIx5tP4gHAzgeygihajoRLReemiBJ8CJ/ix5RVv48K9gfi/+PZ6tEtN6tBjc/xCXTnnP6abfzxltb8sd/j0X5jQOMajpAmxWMkwcLmp5Y7P+5u8cP224tbwgltto/7AH9dCwrn1Q/02M0qPPa1VLukxpWPUlppvgqBAIRYY8y14MuIvB2qPasTJ/8iFFILixOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkLmVVs3L0O/fLjJqOAg8Ywgwxf5Pcz1jgHg94mTQJw=;
 b=Jnkgs+ryHHE3o0CThpasjUrJZPMThLNlz08cJr6DuiSC4WNgFtjDhtlX6NVaA/gz9/nM5vWonNeCQtYhSHHZeON6cyd5qd1ikwo24mEq0Nhg3s1Drqv15fsnB9kv6WYyYckJ0djS10WVy4QI4c/N40SrKOtirQ05uR3ktrCsx+0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 16:32:52 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 16:32:52 +0000
Subject: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for EPYC
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 07 Aug 2020 11:32:51 -0500
Message-ID: <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
In-Reply-To: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0601CA0019.namprd06.prod.outlook.com
 (2603:10b6:803:2f::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0601CA0019.namprd06.prod.outlook.com (2603:10b6:803:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 16:32:52 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cc0b257-3114-41bf-c351-08d83aef87f1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-Microsoft-Antispam-PRVS: <SA0PR12MB441445B0D9DF9BB01B45302695490@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qHvooYr8Ma48FaZN0D5GvxIu2KKb3ux0XZ49k16dIT2NuGcGhzwszhpSJaQc40WYp5tqxY70TAGRnaG3sE/f4pvAE5fWr9H3GEFGXCcMzCWe8dML/B3Nitik8DfCS0URJh1dEynk3ZcYlTwsIY4JJjALJQ+ojdgFDTZSPCQk2MYkw5xy7UfSiGQ97LVvd5ECGRYxNAfIx3TB4j7XXe9B3Jdv4MWk+wTvG+SuRvKf7S0X4DBQ05k16miEeM30Tz/hTVe8ogxHdVk2PgrR44kGefTOlqrdtJSqG7pHmerqlnUNtKLpaactdMr9uPP9WfVgyU2FhiHrwfuiFWY6FJCuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(66476007)(66556008)(103116003)(66946007)(8936002)(4744005)(316002)(8676002)(186003)(478600001)(16526019)(86362001)(956004)(7696005)(52116002)(2906002)(5660300002)(44832011)(26005)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rTAGx/hYhEbA4YJpL/4dBTd+JxSl4zb4cVYxy0PeDADrzHwSvcQzDm7bdfd8R41TZo9vTvW3na7Anj4Eepr9KNjs8dECd6CX03zRda5Vm7WqFY/SfHI6JBpN7oxneEbCM8dQy/bFln5YqE24LIf1Uz1BC/RTYbgsgqlTevMXC+s3YQvu++k8SG9B3SC2xLw2NMwmJJP9BCPgePToW7tADZDHigpON8EOVPMlaOj4V5isyApesGOlHfJN1wvB3J/r+VgzVMsH7ZWWA8vpO7Epfg4Dh6gAp78mAAFM0b4NgnPb1P+pOuaOth1Y3zeRfmCf4XDj0OM16iMSiImzhb7+XZnToJxCD9t9R8N3pXe9NoamB9T/WK2v8lre4eZhmHN/Ti6BpB3VM3fWYMc2uh8vprs4HYJqy1a/3ShZXGB7WiCyEfErmkYE6FTWeiScSodcP/k1MvcR+42WOB6ISTgFacIrfOBebXC52axc3r79U1mv2h9giIW3fTPrHVcyAxWDai8Zj4d+ZJE4v1XUL4n6CpHnmfb/3wocKCpVyXkuF4SzCQvaRjC8GUeJ63pbNoi6u7sv0GHs8Q1Bspqx+n2YycPE4posxWnYUHy2Xa0r+JIHuZJuDh0V5oxKUHgrmVEmwZ2VyjKjmt9T02QeBDeqIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc0b257-3114-41bf-c351-08d83aef87f1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:32:52.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzKxIStCOML1JkIiLwT9tTFrraIhHWlzGM/dTLRwkMaBJBpqsN1Q0iTvJKOXHmoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Received-SPF: none client-ip=40.107.223.82; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 12:33:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Adding a new check to warn the users to configure 'dies' when
topology is numa configured. It makes it easy to build the
topology for EPYC models.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 67bee1bcb8..2a6ce56ef1 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 
     /* Check for apicid encoding */
     if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
+        if ((ms->numa_state->num_nodes > 0) &&
+            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
+            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
+                       "parameter. Configure the cpu topology properly with "
+                       "max_cpus = sockets * dies * cores * threads");
+            return;
+        }
         x86_set_epyc_topo_handlers(ms);
     }
 


