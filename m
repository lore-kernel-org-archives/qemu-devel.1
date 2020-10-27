Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5480C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7290420738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1o2qWm7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7290420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJkb-0005Dk-73
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvd-00079D-T0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:53 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvc-000447-DH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoZFOcvnnA1xSGUXzSLZAv/0/hnYQ27a4PYtykgnmbzmSXmVqHIl6Vxux3sfPUCB3EbK/f6Rp6IRGvWaBFoZaJrehr9c+lWMbpI6DvhiKQaSdJ6WTItND6jKyPitXduK+8filsNXff4Boxb0EN96b1Z6t0GdR29x8fF5qSYko/3WyUoVd3yIUUH7ccyZc83/cVTjvs7ozhZiKh0haWBkezVkJY4TA47FTgmCbbZReIMJsrKNciZ/O9CucKx82LVkg6jiW0hG6xtTCDVr7ECtFLBF1cA/KKMKN/bnF3ns+ddm6rcth3M4itkxIIAzJWkS2UMp3cPk/FXwV2UWuhxj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvURRAXY6tCDaFtyipFewJM06PhlZ7/CBjX8k6s9Ugs=;
 b=S5WBTjuC9JdiTxkIo3X47doAngKiEeSkWGhc5TQyH4HxKmPdfVmqs+a8QhUzAXOX7ayxnzsHuhQEOnaKXZNHpe3Bwv24xVCIJIRecavXHbud+KthmGFHe1Zx+1s4azfpOg2eFAeLQFZwevFJ4FS9Y6QrA91OY8hpWvbS4LPv/Q0clu8BqOt1phf7RzWlv9iPetgmYCC49ViaM87LZ4Ee0FgghLieIpi4PzDracDzh7jILyEQ/1f58GHz6p+jF2xuC4T9kEhlfPVBissgejULeBD73pd0qmUylJIDNsZ2dfOSnQe529G8ZAYlNX+ll+oS212lwOopvgQfjQyQrCAzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvURRAXY6tCDaFtyipFewJM06PhlZ7/CBjX8k6s9Ugs=;
 b=1o2qWm7+/WxHWJ7mylTKlLdsSexwZOinNqx6OxTovJWukTGZuLSfNfBwF6/mykIeoYzh5RI6D6qUkGGvUqLH3VWCdv9LWHcqH2xA3jJii7ggWu4ak/aYwltsTEFiDwp36EGnoenDRr8WCc3TX1sVBSt5QemX4A+QOCM8z7wW1Xw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:40 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:40 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] meson: minor simplification
Date: Tue, 27 Oct 2020 00:53:16 -0500
Message-Id: <20201027055317.351868-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN4PR0501CA0029.namprd05.prod.outlook.com (2603:10b6:803:40::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.11 via Frontend
 Transport; Tue, 27 Oct 2020 05:53:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da175b90-e27a-4813-7493-08d87a3ca7c4
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50044658633C8F12D5839D7095160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djRaNK5tQVULPT+CQplKiuT588oX0U6K4k+jN2UBqYJSm39Vm8a7cap0T3dyKQFf8rrGxN3SWNFmEbv2O1ry2DmKWQ5p825PWuVMI8k9DasA1sLd96dEP2j+mEQx9xrada6W0EDiRI4hM55x3v1V7Iypif98bUccuKbaNPp5Qx+8MpQNhXK8v5ZjvgTYY42jOwu9+2tXw9w0O3sz2xXfrLrN4vYvJVlBulXeEswljkBSq/CUDWBnnLcUkdoI/5dY3/D6FZ51WCFXaKyD5xSHWV7zTAGa/k8cX02xlwJnxEJ6emhvpA9CPN8mkJ5FsQYFyPFFeHiE5d2ZzFF099zIkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(4744005)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hqAKr42VqKxVFpEjkN1Z/rXgo0asRgcP/lL57xv7V5E65pedpZV1m5bExsYbxO1eM2zFYlsor0Dtwc/4xDXYWtHD+aMlFb1noM6KZpOVG9r6610LWkBCAyFqI/2bzVanShH+KTyRapq7t9z0nMWRC47tpEsFrrZeZvWTJ48ERlgMj3i+5qJHAFyBTupidGATNwBsrKQHlgj9C1ssXPH2oRQg2ehshGbaVKN86vG1vDH9CW2ZtSAaD+CxyeSKU74Qn/wgD2pSXB5m0A1LIe1zn9VaWpj7FiAU+PfK3JWwX8isrihxkT3wQFiHZrGFgqEh7uaAKUERwwkfrJHvMT56lVCJAU6MKl3OaQA94VaesoB7fg1m02bEyW+ByVbQ1ScpH/i1ASfhhXOugbrLJ7pbAyfCpvBiI6VyXhuDbiA+4wXp2Sm4awTVcQoY4DB8BwUWlAq1OUrFTqyGAr3T5d7AQH7MYemSx1q3xi/zc6cHtS417zF49ey7B8Jba39OQRiWQn0215d7sc89CKcnhXPuXMI/VjKuRnk9a1KBFIyxMI5scuHUbkNw80cB0e8z6xXl4S62uzCleN4OoGU9gDvzNkJTeEQu4x3lGMJgC8nbGQzJoY4G6zXqsIyvAfaG702r6myJGwsmNBagpzkelxwJ7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da175b90-e27a-4813-7493-08d87a3ca7c4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:40.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqgtJ2zQ/Mqg5LG88BhJduWXgAaAa8fjM4wG4CcjAbLsJwFZankqN+mVY8VuA4cnIYoBGOmZB2xwKCkbEqBodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:32 -0400
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/meson.build | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 6315bb357e..8340892139 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -22,12 +22,7 @@ qga_qapi_files = custom_target('QGA QAPI files',
                                depend_files: qapi_gen_depends)
 
 qga_ss = ss.source_set()
-i = 0
-foreach output: qga_qapi_outputs
-  qga_ss.add(qga_qapi_files[i])
-  i = i + 1
-endforeach
-
+qga_ss.add(qga_qapi_files.to_list())
 qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
-- 
2.25.1


