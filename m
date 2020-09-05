Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62808C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5382078E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="u6TUXwg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5382078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEbPI-0002aT-Oq
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 12:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kEbOU-00029D-VX
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 12:50:26 -0400
Received: from mail-db8eur05on2129.outbound.protection.outlook.com
 ([40.107.20.129]:10465 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kEbOS-0004Ud-Q0
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 12:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwNk956sx+GKsUxDE7p20yQq33RhNY9OzMzIpVX8T3DWS3gvalJ8gtDvwAEh4fenLtEbrRrUolSgpN5+B5YmjW4oIeUDhGuBP3zDIakadH4r58Lkyau0XB/FU+hTTWTb744a3KS0i4U71ML2hy7pv8orinee7T57bkwerdtxBD3HGIrbiNRx8TLDFAOvMYXgZ3TdGu9CnhfWVBbmDb6ggNUbkpTte2dGP/ePmy8HEzxyGJJVy/jCaF+J1XRGrycIe42CdjG46fscvhrZ14bhRjQ6ssIebVJ9Nn+AJ4kKIZQpi1970UYBQM6T7itKxj1hk1rKFI88kWRBnH4GdDa/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KngzSkPY7g7JqAh1NZJ3frYv58vuiwfdLwtX7CAQbCc=;
 b=oYuc6qM56CwOe65POQqPZPTSOBs5APfBhF3dAbgk8J2qIdRuJtQt8YFq7nAxPcvJCCcfKR4ZEYZRDZVe4GfIIiNkgUgi57RrZN5cR3EW+snx3KQPwvPH7yX3v9O4AG/TjwSkOyAzoyRQg7+gs3o+MryDjONOv0FrTW32mRm4p8MZ6yNaSw60N/lt3yPiKEVAQ6PHF2uFhancPEPkZnndMe27xrSZHkkMMiMWsvg3oSgU5D5c0YNjjNusr8x23Fy/OwhHnm6XN1QRDUvsBrmaKotRMOyOOEwIDBzX+h4oxPiDR2mGBtVj4uWFaiu38lEes4SZlTBDFPjZ/q3iC5d1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KngzSkPY7g7JqAh1NZJ3frYv58vuiwfdLwtX7CAQbCc=;
 b=u6TUXwg3/H3rfsasDDfrueKs546Ym3g/zQYfCrAUAtS31jjyB8GaQUTad1CuAZAUJMxynlFgB9Qlj6p5PzteAXKL6VmGlFQVHl9ppFEXmCnQYnm2Cs3RGRr488u0/X9tdBmdIptxRgFlBNUY3PNS7dgY/V33jDFvtp9KspMfkB4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3462.eurprd03.prod.outlook.com (2603:10a6:209:1f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Sat, 5 Sep
 2020 16:38:17 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7918:e8f:d41f:6e68]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7918:e8f:d41f:6e68%4]) with mapi id 15.20.3348.017; Sat, 5 Sep 2020
 16:38:16 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Protect btrfs ioctl target definitions
Date: Sat,  5 Sep 2020 18:38:02 +0200
Message-Id: <20200905163802.2666-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47)
 To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Sat, 5 Sep 2020 16:38:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ce6e65-4f90-4a22-5592-08d851ba16ff
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB34623C8261F9E2CF808B1222EB2A0@AM6PR0302MB3462.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4SlU/aJMLz4cFCmun4NaI3dI7Rui2uBuGNHhqG3yX33/BQfvA0q+NZzAW+kjrQVkcvbJOdNb2CnnMobnMHDrvkCRIQd3KzsJsX7jmPN2cZF+iizh0oyl4lpN+bur1SUGgrDpNnllc+vQvA9RgNh7/EunJvHwSfwbJSODP+zimEmuosROeoTvIddLXNBFxjHxsHZG5ck/3PfxuzHc4glz4kM6scHQsuaJgmfXljYL7xRPzDZbYIibwkvlEPDQ1LsPFRg7OEL4NvmpsrWKDlxGGo59YGirL1hACoCXrgp9T6AnN/EyA7gyt2rF0p/O2z62b6rwTop4S3Y7GCUvyeXkmUnOcyXWYFdve4DZ0e6fMcYN6KuUx0c9GwUUVfVBpQI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(136003)(366004)(39830400003)(8936002)(316002)(54906003)(66556008)(2906002)(66476007)(66946007)(6916009)(52116002)(6512007)(69590400008)(107886003)(956004)(6506007)(4326008)(2616005)(1076003)(8676002)(6486002)(26005)(478600001)(6666004)(186003)(16526019)(86362001)(36756003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AO5UlqSsQhyN5khYTB1ggP7aBoyZvCDmb1zr2k8m5tjheW56r/GfiSMekj0Opo+7W1usjxc3aF7HMg1zaCWQgLvK578tRdMSD1M6lllukY3tmsV1ruTfWDhd4mAg4UZ1UjMPva/VZbZe0flF4fqN0s2bFBri8shRD8yLXN1qH2F/MoO1+E4YiSpoigTe35xnQoI4U5W7qF+MwwtWtVyJwQ52Nq0UjbPin+ErUgnU3wucdZmN5Mgb4tL51HzfXir4cky86fX4KjcEdVJqdvl9E3JL9iiYaJ3rLPqlAJoDU79/HfG2Aul30OUFIyfEwXsKJkTXWLIRMqTrCVtCog+V6pETolZBScmKHiq6gVGESPcUZ3dhAzwvnSVk5ubFiAdPaMMsacuDZTRmkivf5XC49MOnE+Y+3aM3o06TGU8/YN27Mez3v0QjroDWQRw5Y2rKEYq/dTqB55oTIiYjHX6HXGOFe9korq+l2N0hTFICWPMpxEFEsqfcWkUYiG55QLeUsCNkw7Fc52C6c0/9fNirMfW5t8Lze7hQNXkp/JZiFBz18Ebx+rZHjJ88KmflecotBOawqpgGneAOsTmOH7/W769l3LvBOygIl/Eh+slgGRQ1NOsCbuwlmW0PcKdOFzswyLkNpR5vz+v8MM79rhO9zQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ce6e65-4f90-4a22-5592-08d851ba16ff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2020 16:38:16.6913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXJol4djHVcjaG4qTZauLnNbh3OicPTZOD5itNpLV+32BRGCMWLvfd4aDqpT5zCJqs+mFFnRBdvGmcegMsiqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3462
Received-SPF: pass client-ip=40.107.20.129;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 12:50:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Target definitions of btrfs ioctls in 'syscall_defs.h' use
the value BTRFS_IOCTL_MAGIC that is defined header 'btrfs.h'.
This header is not available in kernel versions before 3.9.
For that reason, these target ioctl definitions should be
enwrapped in an #ifdef directive to check whether the 'btrfs.h'
header is available as to not cause build errors on older
Linux systems.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 33a414c50f..731c3d5341 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1006,6 +1006,7 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#ifdef CONFIG_BTRFS
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
 #define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOWU(BTRFS_IOCTL_MAGIC, 5)
@@ -1041,6 +1042,7 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
+#endif
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.17.1


