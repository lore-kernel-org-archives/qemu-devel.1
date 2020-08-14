Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E436C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175B623101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yUJKJh8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175B623101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xtc-0006jk-IF
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xqJ-0002G3-Mj
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:35 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com
 ([40.107.237.84]:40417 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xqI-0000QD-2h
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ7fqALZWNeX7d8wnB2NOEhB4ofjHjIfCFdMMq8UVm7c7Ah5Lkr1fCMpngFSD0j1zOJKWpXCg+PHauaR1gW0y5TKmF3LLkfQkwgun0B9rtZeWhMbZfhPRQQvvdjSO+wwuFlve4UU/L4o9PUMYSJYdBWwcugPu1+9kU0eD8Ib/ltI0Cun9vXSSYYJzMI6o+IlAOh2IouKZHZOGHekGky1rad9nbfQbRRsPP9iSM7YFAgpo2eCPfoKD8GfvKhBI5lx5VaLiKUXJdelSlZH0M89L2mgWDvW9fJPbz2UNqqJCRiJ0H2VyfKxnPcm87bLf41vsKmvA2cAQdKCGWHT4eRyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG8S6WbiTtaWyIIhUJfxL0W3tKURnf/TVK9UBMWJZnQ=;
 b=T7znqW6mLnXBdhc/QE6byHdC/137nNssCS2VogVoo6EeOB3aXRTzt0+JRSydMhdImv9Gx490lrM5YEF7VE2HkYbwtItgCsR88vQmjBdVR+XdmrPS+KpBJro83+OpL/DBgpMAxeSDH0FdNzWwopAB8lRvIcKxvRBao7vdmsW5Rz4yYsUQOCE7FrJ9qo9G3+zTtD4vRNobTFS9zAoUyKCi0u/n0bkuHeBpZ5n9RFX2PYnhzSexCKolBl4gC332/NqFWUiA6CbzeRkxSwBaTnhBtVCuIHOQr4SiNIedoFUXoU64U0vesT++P2ZfqbOCvFRMMBJT0nr3U/Vjj19ao+LYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG8S6WbiTtaWyIIhUJfxL0W3tKURnf/TVK9UBMWJZnQ=;
 b=yUJKJh8i8s/e/daZgyc+JP46bUeTjfkC0s2XkoeZbnHV8P5Zk7aqRuubqbvYyjQhlEzk89Q1MbYY3DHWL7m3yysHFuN8EPhCvFETDYc1uDulG+kQLsFynG+KBa7e4wAFSfjBJwpkl5rgVp4dVO+HDT+t8CAzUWIHecWSoXiP1c0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 21:39:35 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.026; Fri, 14 Aug 2020
 21:39:35 +0000
Subject: [PATCH v4 2/3] hw/i386: Update the EPYC topology to use
 socket/dies/core/thread model
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 14 Aug 2020 16:39:33 -0500
Message-ID: <159744117377.39197.9319853595178174798.stgit@naples-babu.amd.com>
In-Reply-To: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:d3::7) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 21:39:34 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3b8cbff-0be3-4be1-409f-08d8409a8975
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45280F4B03F339B1F4C8B3EC95400@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mU+GdfNbTzeEh7XI62POXAfqKz9P3eO1yYH5JHH/uVtyenWFvwyBJ6iFZPyN2C3XduG6O1mwqS1O1VoTKUv6VbDFyy5+SLrvqvZAZHf8xKzlF9B+nDrEwFoTOTpBAEbmoB713SeBToGfrUQxq/qyz6sFIvOO2M27WSJtf2t2IeL2ckgFvFthVlQ+T1Q8UIWkyHB83g7IJHf8fKompWuAcIRrlGDO83CQLnObBlwzGN263Bim3WyHFHYIeoCL5zXEJJWYm2PJ57dl8IpgdI53/zTKpU1lE+OLEh73hPue7TLcnhImFEsh6PPcHgfXloVfqlXAsHOzJF86M/ahOpqlHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(956004)(186003)(16526019)(26005)(316002)(478600001)(8936002)(8676002)(2906002)(86362001)(44832011)(4326008)(15650500001)(52116002)(7696005)(55016002)(83380400001)(5660300002)(66556008)(66476007)(103116003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YF/A7cXa4KE/jHUU5f+stEPRIpHIkaQvCNgvPjz/Km8iCOZWVNbQcXcWUds6/p2ZP8jQ7dxekYknMQxrRAdtG9ZGl6V4W/5/0XqYj6pwJ00ZdMwG2G8T+2CNUIQ7f0bfU4ej8IBXuc51+B3ggoD1E/4/vYGMOEDTNKYye8HeZ1brDu/hgYrmboAfc5aOkwUYBnsNuLBmMNVFk0UsjIqE1fD1YQ0TK12Y/H12HQWi7If/IHxGyqb+6RNlitbNbANZmdMEknJVJ3Q6Hl/zeC+za4vYCRyJ168Da/pEf0CsnHKbchKGH7Urro6onEbaTn7IY6mt4g6jAdb36oI3dsB9DM6lqQS1XxceZon97mKGVIIFis2PGWq22+TQMLGXV2BGxM5M8QmlWy0p47yOwEkPlcA/tIGfnkglr8zmrrW9Q0lhoF+jJfgHgn3cJy0DdLz/J8PdCX43gvl1KQxOpyD9INm3WdGJ1baJ9isDxGsSSSYKlz6mT1/qXzhwm6GUCy+gulUH20URvcKdPFnLZNLpxc7HyQV5R+Djk7X4wnJjVmy2wxy48N0/rbp1+KJaJMic4+PQFfR1H1+9SRnYInmVpeWkEFPL0HeRqcC7unb66gzhDg+VuSJrBZ1x7KPu0JwRCXT6HsfPNMkwxXy1vNC0uA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b8cbff-0be3-4be1-409f-08d8409a8975
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 21:39:34.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SSG1P7OPrmQOCqNa4256s3VuLTRbj+en+4uKuhOSsHnsH2J7TOCxPlBUsEXI5mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: amd.com
Received-SPF: none client-ip=40.107.237.84; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:11:33
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

Update the EPYC topology to use socket/dies/core/thread model. The EPYC
model does not use the smp dies to build the topology. Instead, it uses
numa nodes to build the topology. Internally both are similar concept
which divides the cores on L3 boundary. Combining both into one terminology
makes it simple to program.

Add a new check to error out when smp dies are not provided when EPYC
model is numa configured. Next task is to remove node_id, nr_nodes and
nodes_per_pkg from EPYC topology which will be done in next patch.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 67bee1bcb8..e90c42d2fc 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -138,6 +138,14 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 
     /* Check for apicid encoding */
     if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
+        if ((ms->numa_state->num_nodes > 0) &&
+            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
+            error_setg(&error_fatal, "Numa configuration here requires smp "
+                       "'dies' parameter. Configure the cpu topology properly "
+                       "with max_cpus = sockets * dies * cores * threads. Dies"
+                       " is equivalent to number of numa nodes in a socket.");
+            return;
+        }
         x86_set_epyc_topo_handlers(ms);
     }
 


