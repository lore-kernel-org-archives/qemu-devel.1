Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B46C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2443E20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="aeQY/ekc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2443E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cI4-00011Y-9v
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFl-0006N7-D5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFj-0008Cr-Eo
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:29 -0500
Received: from mail-bn8nam11on2118.outbound.protection.outlook.com
 ([40.107.236.118]:3988 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFj-0008AB-9U
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8fRoI5JaNsKEknJ95rDOBJxc0ng8tXAFhLixo70XKstUfUt9ukYtvaXSLFblKdzCbSCpqk20gcVhqkkNpuLVYC5NtOSzZp9xjuQGTlDvyD+fUT+xWZYrJ4n3GSullSragZUhGSGqkrKjbpu5ulo55h6EVfv8DjqARZDb76TeAAeoNAymV3FLYb1Q0qaRxAHKkm45LxUAAMNJ0DpXvaJTIkfl4koJkpGjzv7rSdWpjfAqGLHME4P0GDTmAB7NHzEUkUtQk5fzj1AADxGMw4HMsD0VfvWqPLYvEAIedB7EBYJhdtaKCXUcZHr1NVg2ob7Al8AfMowYNxWWHyS0ZWzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zAlL1Y8f6UQLppCwhd1T8uBK3hXFKCnVJjjBWDRtdU=;
 b=HqsG5KgZALkIm8qQ+Q3oBzZzRDvGQavuqVnfEQlPGSV2c4Eax4E1RMFB1/AYmCUlgp/3h4XX0nWEkpCKNXv7xhvSdWdV/qcnaFGbxT0zbWdDcDBpNUjlZWDtAwB6caBfitf2UK2PUnPEtOF4fIvfxjh2tVGFve/ejRETV9zPQCorHM0P+SKXmK5twbM49gqYO+I9db32LZCRD14di7ayXFKMb50bGPbx/I7lSJYIpVZIp0DMKK7gOuc+0PI7YwhtA/YVzwzBZpadNsxzXEmjgemgXqyFtZMpk6A207Vm5f5V369X+4FzdxXrgECg0pwLgJjnw5yWssZQdG/tBPvcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zAlL1Y8f6UQLppCwhd1T8uBK3hXFKCnVJjjBWDRtdU=;
 b=aeQY/ekc56ET4dbEvXx1qsEjSAmzXMJkwg1UN+kXRuvs1O7BzK6dqDeAAWS8ZkG3frtxjqaTjsuB1hv70U4eAaPjgh722CCwlrRNxkXDJXxc+ttogEgkdMyNjUIbyxRQqVRWhsXuqo74nP/ChifijkSr/KyS/75dE5bnBi/eCj8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:26 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:26 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/23] fuzz: add FUZZ_TARGET module type
Date: Tue, 11 Feb 2020 15:34:52 -0500
Message-ID: <20200211203510.3534-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:25 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d4ac70-d6dc-4dce-e90f-08d7af31ed26
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3599ADBDB5B0AD65095EAE08BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zEn0yHsRJK73Vdmsb9fsm8SiQG60OomYGp/2tzqfGNfSy3wy2YgxhN/DP1PZvlIPkQCP2lPT0Ad2jTV++R2otvTY5XiMoeYYdCD51pYGw4IyDV+327jRnViEHD4GwLR53hkfUNh9h5XlYOmsvWHXrP0cfjSCB3//P9/xeK4NWdcQ9Cy+8/Wts/csBI639HyI9jnTHFDdlVfWkeVbFWq5cd0hjW7Jj9QGbx9a4iNWVgb98iOIORFyT2CE7DOiLvaU9ENTaeCwxc3Cu5b7LURSlnYT7hyssXtdXlEFuHI+7zDrs/ovgZzZJqFqP+Mc1asUzhVn3a1BvXXustIUX8tLcTEjFGY0rmTQh6d0oro8vT4N+U9fxS1gQYImpG+v9vl5zBd/U8Df16BviL6NNhKyzYOZSYQlboFU0AE78jnHSwNecshhy3DrfhRC7IHuqhW
X-MS-Exchange-AntiSpam-MessageData: gatrjfpV6BlOdBNb98bsHAsbTRla5tJ6a/J/d7c+fT0xRW86dZRXqjs3RJyNT/CyRrQCVQ678p2TJf8bXmwkZKqdrksxlMK8qDGBziPS70PLmJQGevQUkBDf3mc36kw4AD+/sq0Eii77tkZz7Yz9Pw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d4ac70-d6dc-4dce-e90f-08d7af31ed26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:26.6261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t06rM76L3lO8cw6ILRp9qn6xCePdEfbc2UkmvEaxYFAYWQcJfuecznn08YLcOrUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.118
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/qemu/module.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 65ba596e46..684753d808 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -46,6 +46,7 @@ typedef enum {
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
+    MODULE_INIT_FUZZ_TARGET,
     MODULE_INIT_MAX
 } module_init_type;
=20
@@ -56,7 +57,8 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
-
+#define fuzz_target_init(function) module_init(function, \
+                                               MODULE_INIT_FUZZ_TARGET)
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
--=20
2.25.0


