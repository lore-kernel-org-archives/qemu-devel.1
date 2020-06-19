Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8544C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B203921532
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DYqbTqsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B203921532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHUA-00015j-Vs
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jmHTO-0008U1-6D
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:54:26 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com
 ([40.107.244.73]:6150 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jmHTL-000182-5c
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkLJBp+STDpPpc5nWjimdnQ1UeytQCmoXbXZs5xxgLaMlwv/ubHSVNFQOozASOoFmurDjxNFq7g8Rjvi0L7Jv90Z7YZCI/93k4qBrxRqTzVkODpdn6xLWJIS1XNwh+2UQp4H8dI/uvvbtVnXqP1nDzwpfc8RA7b5sQe/njIaTJxruWpDn/rJgGFY9xelUEsg2P5wXzXCgdHuExVxaKZ+3gQ1Ea96LEEL/3ZMmgjMF57XL3a167LT5+/vqM8vF1c/+Jj4HYuu1NIBr0KsZ9K8cdZQYd+2auuaCNTLroMuPPh8r70qUEpGMPWBB4iFl2GPwxDsm+jr4qzGE0uZwXLzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyivuoIzfbwIETFz1YjB8bxMlYuG4cJbb/S50kFElPc=;
 b=NfKp2sWs2SHF8LpJ+IxBx26pu9T4c+7MVD7ZFmzpOqQ0QHN8gnDS1JmyZuAfojgie3RugejUth9Lg2JqsXBQXmfmGqhQhRRbQfvq84MVvsMTpXBKQ01MEmEQct5wx/Pkq3oeQeIUlSMq4ZV5LulEjXfOaXMDzjby6LB394Yp+b57j6P0ob0jvqoi1dyBOB4ydWl6K3bSYMj3U1HPiocZK2R8RlqXYl7JNAWh7GlZoB0ab4Yz3GEq+Z1RoZOqonipDQLMfOsI1azpCow2NQph4/Ya6CrnKRRH5TgeFUHJs0keHoJFx6ZoFKEO8GXllXaGNmaqWIxo1XbwZMJGoRmutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyivuoIzfbwIETFz1YjB8bxMlYuG4cJbb/S50kFElPc=;
 b=DYqbTqsP3FyIppxYJx1uYaYnd7+26n0hucQgTKlukzR7yRh3ffgU4PeI1YcwkbD8EWtBHpjYe+IpDFxhk/jnNl9jRLlh6CWT7quksa7E6I8rtun6kWvB89CTdx0wirWbLagJ6mN7emg7qBFIZvZQ+iwJZiv8wkt1YVpLHL4eWDE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 13:39:18 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 13:39:18 +0000
Subject: [PATCH] target/i386: Remove core_id assert check in CPUID 0x8000001E
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Date: Fri, 19 Jun 2020 08:39:16 -0500
Message-ID: <159257395689.52908.4409314503988289481.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 13:39:17 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 278811cc-77b8-47f0-66cc-08d814562a20
X-MS-TrafficTypeDiagnostic: SA0PR12MB4445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4445B3BA8876877323ED1B2C95980@SA0PR12MB4445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlupqSH3Ix/4ArnAJAVDNsqe0tVlTvV8z9KW3fvrdjR1u7lmOJmXxETUmxTD5aMa26NZzJVCILZkYyWVWAq+ltUi7hTWlB5IcYFZE0VgBNBHynJjZS5EoaLksH8P1jIYRuJ/8ftT1E3COUBy6A9Yn2n9NmuLiFtM1N0p3kq5bLg867PBFSEfk6oRWdsrBptXm02CtcwCRGhFDcFfR5kxubmpLBGNWekfbha2+40+2gzaXE8H7K4N0ioYjM7iNapX5UEyuXtdAhEt+4rynqVhwUqqwaHL+4+8LLkRNXBcMkLYgdMqqhoJXEnJrlVkCtDjKXJeBo8ypFQS6A0zGJ+zRlqKjA678EbiRGzdY0iJme/PPKHH/Ll4I7ZkjoVUGSKh3XKrvu73EuU0NgqJr+rDvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(4326008)(7696005)(478600001)(956004)(52116002)(966005)(55016002)(186003)(26005)(316002)(16526019)(86362001)(66476007)(8936002)(8676002)(103116003)(83380400001)(44832011)(5660300002)(2906002)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 31OBjw1uItYy9DKE8zoD9ySO1jCJPD39WKm7/jYiZWGLCyCy2Os5WZQ8nUsZ8k+fJn4DJiaReZFho2ACUFjcZbwrYCCICMpCYtnXQ3RQ+JqqGv4mR7Px9+roxO/cY+D57VDI4FWK09TfwCftpXCBO0EMpsz7a5rUeXZK8b+iQXAufEsg6tRPW7FTGPRcWK3zCNNVkJXiIGFOydQ7JWL5Zh2qLRdDbUz0n/zXK7CPjo4d4fiICGAo1RiNwr3Ou3Lj/sM81koI7gP67w2nM1FJxxHvTKvby3rkbBkkGPT117/6FyD4vfR3Oj9FIrWcOnOzGan1ouEFO9CJ/3EVQQ6ghp+fvdyU18Mzau4P7PTW8jKEbuIZHbMB5GXuVXvYmrzDsqX5JSzxKSOBKFING/nei+MmBz6nT9Qh00yE7kqmVYGKOYkGxOyiD7RyE8iJNhTxhJ2CoMYaw7DrMMS7a+FMGTURruos9fOMWwZQGEAnTdo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278811cc-77b8-47f0-66cc-08d814562a20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 13:39:18.2323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux2kt4dJKzgaj+mMXV7L/DQU5VlXFu4vBaym5htap84yNTxOoMumRIsAL1XZ1srQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
Received-SPF: none client-ip=40.107.244.73; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 09:54:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With x2apic enabled, configurations can have more that 255 cores.
Noticed the device add test is hitting an assert when during cpu
hotplug with core_id > 255. This is due to assert check in the
CPUID 0x8000001E.

We cannot really decode the CPUID 0x8000001E with cores greater
than 255. To support more than 255 cores we need x2apic support.
In that case topology is coming from CPUID 0xB which appears to
work fine.

Remove the assert check and fix the problem.

Fixes the bug:
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1834200

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b1b311baa2..43df2a17f4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5917,8 +5917,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 0x8000001E:
-        assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
+        if (cpu->core_id <= 255) {
+            encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;


