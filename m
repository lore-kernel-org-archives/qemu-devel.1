Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ACC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF93205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="djDV4a9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF93205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBxv-0006cE-Ob
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieby1@outlook.com>)
 id 1kEBCC-0008Nu-GX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:52:00 -0400
Received: from mail-oln040092254042.outbound.protection.outlook.com
 ([40.92.254.42]:6116 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieby1@outlook.com>)
 id 1kEBC9-00080H-QZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKNTJmXO9ofCZOkqMLAHlsxEpZtIvr3LAKX++gKVNATzA6MmNL2WWgN928nT4v/GrKw0OUc+kmUhwIS3xWAI9ur0O+CIVWQxx5x4yyt40lXUvFWEmhvwfRPqI18YZFq/k4iP6c7XlVv1HT40VGGan/37L7enlkwzwPZPxFAMxVQYkSw1O5YdRHNE7xcHc86kE4/fH2CI0Zb5rCZ5gEAtteUWTcYEtBdvadDaaxR8NaR9uHF4pjGESBcS3skr0REIi1uDFcZgOcjJaublsVCGd4MpmqeFYXdjkt5DTn2zWXfGUYDwOkklExKmEqqccYTmDb4LBYrKX/d2LdvZOMM6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAXWXHgjpw744eVKukOUu2jTxbEVSUyIt674GtuASkg=;
 b=lyEbdWGOnJGNgJPmZ/6cT7ya5Oro1gcLXPsVPIULrSkT6uZSxYk4dbwx/JK/eRTK3CmmlyyHxbJaQwsJb92bBgBYenu3qi7Cg1UViRPVLGEpAxW9QVWuqEDJak7NenxA6GvWNdVn29cgWBnnXGDawAkXixJgsmXu12/zoLFzDEetwWP6+BFpfNhZE2BiSZGx+pUSXoqBFEaAtsYjpMASTjTWkfl0jtPfsdPhvquDGd9AhLQ9knJorNxcDP7WyiHBhG4xZXgB7bv5flfgSXYkC850u5vA89sq9oVQa/qoAZj6vD/684g1j0sQ3eVP2UkEt5a3dcJnOk3ggirdkwzw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAXWXHgjpw744eVKukOUu2jTxbEVSUyIt674GtuASkg=;
 b=djDV4a9ZEY7ZMhfHMAsAj9iU2t+vdIPOeAdQHUbVUwDSSWdvC9uHWhnyyBFA83Dc3jHCBlJXDLIU0i1G6PIu060wz+8/fH3lhXgshKw9uZnV5ylAZmv9i2ZTzokX+mt3AGvTpFU957vJ88QSJIkhitw1qmSdmQYba/CE1KiZrNcmWOHwZuk1KkVhRAGvIXZlTV4kkDxumHNSCovtLWqZPt7sFS8sqYZaLpe8OzRuiHoqraZfxJeom5uDogepMtqMg+oSSP3weBa10t1Bi8Z86yxAZLtlOaVoNKjrxTQuJpU9YUwr23FAFK+ukk9HlZXGYuWSMFbeltIjx0T75Ry3iQ==
Received: from HK2APC01FT034.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::41) by
 HK2APC01HT037.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::345)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 12:36:35 +0000
Received: from TYAPR03MB3214.apcprd03.prod.outlook.com
 (2a01:111:e400:7ebc::49) by HK2APC01FT034.mail.protection.outlook.com
 (2a01:111:e400:7ebc::191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Fri, 4 Sep 2020 12:36:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4B0FBDE920605730933162D0F42BE0D17ADADE2F3F918D746E90C8162E9B6444;
 UpperCasedChecksum:7B0A0CC6378C1A1E9917EB594F1ECF8F1DB867AF7C453DBF5BB57DC1CDC91CC8;
 SizeAsReceived:3284; Count:46
Received: from TYAPR03MB3214.apcprd03.prod.outlook.com
 ([fe80::20e6:9040:b49a:ec5d]) by TYAPR03MB3214.apcprd03.prod.outlook.com
 ([fe80::20e6:9040:b49a:ec5d%3]) with mapi id 15.20.3370.012; Fri, 4 Sep 2020
 12:36:35 +0000
From: Xie Benyi <xieby1@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Linux-user: umap redundant reserved memory in loading ELF
Date: Fri,  4 Sep 2020 20:36:25 +0800
Message-ID: <TYAPR03MB32149CA1C06336080FDBDFA3822D0@TYAPR03MB3214.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To TYAPR03MB3214.apcprd03.prod.outlook.com
 (2603:1096:404:18::21)
X-Microsoft-Original-Message-ID: <20200904123625.30273-1-xieby1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (202.189.3.253) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 12:36:34 +0000
X-Mailer: git-send-email 2.25.1
X-Microsoft-Original-Message-ID: <20200904123625.30273-1-xieby1@outlook.com>
X-TMN: [2h4SHPjpWyvAoI1LntMX/UhGUTvSq8xn]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 253b80df-954e-46ae-5a2d-08d850cf2904
X-MS-TrafficTypeDiagnostic: HK2APC01HT037:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBj648qAvmTDePGIvh2WkO+ELLJF6MxeCjipn9KaRmR/oa14M9LOtxKVLpSNHOOxhm31VsgQ8hyxXDWZ8QmqET7pGNWfmZkcgx2MrdwcGP9Hlc/kz0q4RPJq0TbVHYp2XV0+tKae8WlGRWSqxbvRJyVcmu9lxsYmjzKt5Ttyt0qmhmfkdu131+jrrOi9QuGm
X-MS-Exchange-AntiSpam-MessageData: UZHcV1mM28mTodrCtjAzV75ZJN56GrCdkL9YpPMWG+z8IqOYCMG1x12e+20bxtLb1sMQpkLLVnvcxuYG5YqMNHFSL9BgHg1V4xR4eb2cFp0K1eemZ3lvpjq4KyZPW8XxaIgxSoCAk65hsJM4dsoiSw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253b80df-954e-46ae-5a2d-08d850cf2904
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:36:35.2426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT034.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT037
Received-SPF: pass client-ip=40.92.254.42; envelope-from=xieby1@outlook.com;
 helo=APC01-PU1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:51:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2020 09:38:16 -0400
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
Cc: Xie Benyi <xieby1@outlook.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When loading ELF, linux-user reserves address space, from the lowest
address of all segments in the ELF, to the highest address of all
segments in the ELF. If the segments in some ELF file (for example,
wine) scatter among the whole guest address space, then Linux-user
will reserve almost the whole guest memory. As a result, the guest
application has nearly no memory, which causing mmap system failed.
So unmaps redundant memory which are not needed by the ELF segments.

Signed-off-by: Xie Benyi <xieby1@outlook.com>
---
 linux-user/elfload.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 04c28cb..6c5d449 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2494,6 +2494,26 @@ static void load_elf_image(const char *image_name, int image_fd,
         goto exit_perror;
     }
     load_bias = load_addr - loaddr;
+    /*
+     * Unmap the memory which not needed by ELF segments.
+     *
+     * Instead of directly reserving the needed memory space,
+     * we first target_mmap all space betwenn loaddr and hiaddr,
+     * then target_munmap the holes between space needed by segments.
+     * It is because directly reserving the needed memory will call
+     * target_mmap several times, which may result in different
+     * load_bias for different segments.
+     */
+    abi_ulong munmap_start = -1, munmap_end = 0;
+    for (i = 0; i < ehdr->e_phnum; ++i) {
+        if (phdr[i].p_type == PT_LOAD) {
+            munmap_end = phdr[i].p_vaddr - phdr[i].p_offset;
+            if (munmap_start != -1 && munmap_end > munmap_start) {
+                target_munmap(munmap_start, munmap_end - munmap_start);
+            }
+            munmap_start = phdr[i].p_vaddr + phdr[i].p_memsz;
+        }
+    }
 
     if (elf_is_fdpic(ehdr)) {
         struct elf32_fdpic_loadseg *loadsegs = info->loadsegs =
-- 
2.25.1


