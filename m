Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 22:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D9C20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Q8eDmhr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D9C20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG8Eg-0004t6-4J
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 18:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kG8Dr-0004Rd-2i
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 18:05:47 -0400
Received: from mail-dm6nam11on2110.outbound.protection.outlook.com
 ([40.107.223.110]:4576 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kG8Do-0000IB-WD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 18:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhun+FNMjmQFzHvMuGcH2PXWI56uYCWTA7E4XUsjbjgeE4PZIk3rvVz82iITmvUvQ7R3ymGkOIevA8qF55LshjSAKUCFRdt285mscsiazsdCd7fUwA17J8JWxGi7mMOzZ5ItZBsp3Eqa/MYmSx2Qi/lX7HPL+yWfSKbPUHL0E3esKDb5HmaAmZabIAvg7T4AWXL5UMhxW0f1fJntJtlN6Qq5MWdcc83ObubpUgPJ1XzQq9lY2gBddqDzyXl/SRE+IasTSTaTc557TPTmWFJFsh+G0nzYCM6X19qMF/NvtpvSfrSld5y8HUzPJ/nvvEeqqfIXjAf/Jm4vfSQ3qL73Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsXZCjz9gPP5hgPrdlxZgBYggxhd99873fX+ncIEyzA=;
 b=G+gDirwn7idskva2bGosBBGRFZC+e21e5gKfxIRqXD0Gvl9t+G8Bu9GJez3iEfbS3GbmTm6Sd1lLipQP47cYp4ikOy4qI2n2x50m09OSNqt5KaBtZNSORqu06q5b1nlG4gf8QrSCTLN0pll6goAHVkvobjjspLu+kW+klebhtirgTNM27x26pFJLP/7hH7d5ebYaYmsw6N7ZTS7N0GXbHxz5QWy5Y8IfYwt3CQ41eC4cPjvrps6zln3SKMCOEW1z7DytEGQDLp7j490wxCEzF29xvwoZeMN4WUhlvoDtwY78K3s0dPwr9ylxpvI4bw0KJwlKJJkp/HbK88jfpXLQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsXZCjz9gPP5hgPrdlxZgBYggxhd99873fX+ncIEyzA=;
 b=Q8eDmhr6zAAAhoPsUQRynPRCoqb39JOsVmOzVQRRDnpmr2yqDV1frf0VM8dAn7hgbyONHTwKl5hFUqiBVCvudoFcSHe03OyO+5n5AG/G4FvH9AF7t1je6FU5Z7eVu+JtQ9cPc+Xf6f7Ap1XHe7mka569isdHSIQtddza3R8R6c0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2286.namprd03.prod.outlook.com (2603:10b6:804:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 22:05:36 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 22:05:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] oss-fuzz: move linker arg to fix coverage-build
Date: Wed,  9 Sep 2020 18:05:16 -0400
Message-Id: <20200909220516.614222-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 22:05:34 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99855e1f-e79a-4a72-e858-08d8550c7a24
X-MS-TrafficTypeDiagnostic: SN2PR03MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2286244286F85C32E9CFB41EBA260@SN2PR03MB2286.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xDRrdvYGOZd5PgVBAYkr/ZGQyiq6Nr6bkngWKJTicBSnEzWiIX1klpEdci27TLsGewEsp1h5UzawJL9idx9YcTQfIsSr6M4M4apmkAGze0cY8v+8teNws4fKkaZX2V60AuVuuSQkx2Kkd2RVYQVsq67xi7H4lRsP9AChdX2cWU2aCGHXMpsqqMAwd8b9TyN3+tjP56mY0yruyWtJThtZrN5LdBat7pXAs6hmGqxJkUgtPLcyIyWGlgodXqqTB4EGLp6qjd3UEYC7p2oGCOqf1824Bol92CMv1Aqi0UUAz9nawMaMuvBCeUd/rlJO7ZQmetl7Xl7zQLVDV7jshbtIymuk8en1lF/kYUfyPO9GCGVZEqzFFcypNLMgO9QmIRHwdYW3fym+pwq3vU3fK7nZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(86362001)(8676002)(1076003)(75432002)(36756003)(186003)(16526019)(5660300002)(52116002)(26005)(83380400001)(2906002)(4326008)(478600001)(66476007)(66946007)(6916009)(786003)(66556008)(6666004)(316002)(6506007)(956004)(8936002)(6512007)(83080400001)(966005)(6486002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Pr1AEedizCug9oayyG+mcOnE6AeV/0SRypFpdzDRB60StJgBZyRrm9sou2nmLbAAC0qMafCstKJAtrqWUMZk91FRdpPNEGXmh3wbwKnkt0utPlp/ixgpvFtZLBIcQBVR/EuVdQl4kgjl0u+O5u1s2IYa0EBLp5TJtQt7gBCBYMHyYJ1o3uqHKuvnMFijzAZCOZiUc/solYdoH3WcQN0G3DpHC9UcNTNzlUzzruS3bVaAvH4GHX62rDlDwmuCQgbKtLMK4e29svFs3+hwEKhpMNtVUxlSB41yYfqlcAaD+1FW566OIxIMsAdnMWWeVOeYdZkJNqD298S631kv9IK8Hma8l+H3cbpt/nPH+26LOda4+CjuI3Xyd6xPVj78RhCvIw3eG1zJARAff6fmHcWxppm9FBLsmViCWB8JiTSQDVnSMW8MJwbAV60O3jl/7vqcRRzEr81YMJKqWOsjCpY2eTEHLatJ0Kgw88vSiBEYAoAScvauePOej8rzYq94CxbW7JV7kiaibd1EYIQO2yBiAnIsb2trQSPRg8xAk5m0hQu98V7f+Rc3/Dfa1hRDySuCJoQx5nKcH1BgnkIIh5DnOd5uBbjbRMIIsftH+M7LCxMCJUNjDm7TdkaFbiU8e3NO6mw2mwEueXihwu3ZJDUtlw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 99855e1f-e79a-4a72-e858-08d8550c7a24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 22:05:35.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6NfsEFUf1jHSTnO8bWfpnYutoVSUU97YsSlHLZzr0fdwMOj8ia0g9t3Xb3aKVZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2286
Received-SPF: pass client-ip=40.107.223.110; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 18:05:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.768,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The order of the add_project_link_arguments calls impacts which
arguments are placed between --start-group and --end-group.
OSS-Fuzz coverage builds seem to just add these to CFLAGS:
-fprofile-instr-generate -fcoverage-mapping pthread -Wl,--no-as-needed
--Wl,-ldl -Wl,-lm Wno-unused-command-line-argument

for some reason that is enough to shift the fork_fuzz.ld linker-script
back into the linker group. Move the linker-script meson call before the
other calls to mitigate this.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 meson.build | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Good news! Standard oss-fuzz builds are working again:
https://oss-fuzz-build-logs.storage.googleapis.com/log-2fa5122f-c98c-4e46-b3ff-e6835d9ecda6.txt

Bad news: Coverage builds are still-broken:
https://oss-fuzz-build-logs.storage.googleapis.com/log-dafece55-81f2-4d1d-a686-c5197cdd15c1.txt

For some reason, just switching around the order of the
add_project_arguments fixes this (i.e. the order of the calls impacts
which arguments are placed between --start-group --end-group). I don't
really like this because it makes this linker-script block even more
visible in meson.build, by placing it directly beneath the "Compiler
flags" heading. Paolo, do you have a better suggestion?

diff --git a/meson.build b/meson.build
index 5421eca66a..2ba1823ca3 100644
--- a/meson.build
+++ b/meson.build
@@ -49,6 +49,14 @@ configure_file(input: files('scripts/ninjatool.py'),
 # Compiler flags #
 ##################
 
+# Specify linker-script with add_project_link_arguments so that it is not placed
+# within a linker --start-group/--end-group pair
+if 'CONFIG_FUZZ' in config_host
+   add_project_link_arguments(['-Wl,-T,',
+                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
+                              native: false, language: ['c', 'cpp', 'objc'])
+endif
+
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
@@ -58,13 +66,6 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
-# Specify linker-script with add_project_link_arguments so that it is not placed
-# within a linker --start-group/--end-group pair
-if 'CONFIG_FUZZ' in config_host
-   add_project_link_arguments(['-Wl,-T,',
-                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
-                              native: false, language: ['c', 'cpp', 'objc'])
-endif
 
 link_language = meson.get_external_property('link_language', 'cpp')
 if link_language == 'cpp'
-- 
2.28.0


