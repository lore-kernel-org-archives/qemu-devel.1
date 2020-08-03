Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC0D20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="F0g0cizc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC0D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X4U-0005RA-M2
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3X-0003lr-HS
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:55 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3V-0008SR-V6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSTnyr/AeR2jZHdkKiUDjoU7YD7ZONZFElJRbrJKw2gg6RIAh8eGzm+ydLG/VTVW358Ib0PL6c0a9XTX+x9qAYNjyV9mG9fUvhVA5QAy7PmA+Ps4HFJlrc2S2pTsQY0FkIOlLQVGP1xpyEbbxD8q+H59/Ly2UajjxGuCoS1h4EZNQ/T+WOZ0PB5FFkEfAqEO4DLL76+AKGOt/vNEzQnAweIFY9cQIApm+rBdZP0tvIaeA1H6GNdj9ltofePsj9rkKGChSCO0aNpBV3Kb++rjHLyUK2XvMwwgXokN6SReMkv2pYeCd23f7Fmq0RIRYDiNgVrfD59BT+1Ekbj5qsAMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7PalCj7fTPERZKm3xED+YdcUAhFgc9h8BqdiUhbaTQ=;
 b=J8AiMvDIw8v2fK2GlSMmTtyDjnR71qZCBfK/FVDZWn3v95Idno0T9aVYHoe9igmO4gqtV3QCfzfE4pPUJ//pQGwJ31YaKBbGhW8Zd62jf8Bc9GA6M4Gh2XQvHdxaL03syAW2XR8UckW1OXAiNyLYZhCEBdHmhEJuzyRPk3EnDu2149Bn7VkGAn9zp+/pflVHWn/76ZvOi8ZXN0a09oClfY960aAJi9sxuohgMQVIIwvp8k1EQeiEFyoPN/1wJAV52nahiepOV1KbBfqeEpXFcT6VwfvOlH6e5XHFed76ep8X7UuHxemPqy8YP5IyLOWW1/0adS//qde4q0+DuMkVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7PalCj7fTPERZKm3xED+YdcUAhFgc9h8BqdiUhbaTQ=;
 b=F0g0cizcpJ1ZuLvZtE9aIxOPenKRmnUNJhmRNSac9sOQTVaZErumNIwBGX29lHC2s1oxpBEKerLOf2BTHMeazshnSSG8JrLIQFS3cqGbNPC2YQlUh3TbhLoZ/XxLW47ro9SuQr82zrDsbEXsvv1hT5EdkVVEZlljBR7J2oawOHk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:46 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:45 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] linux-user: Add support for a group of btrfs ioctls
 used for snapshots
Date: Mon,  3 Aug 2020 11:46:23 +0200
Message-Id: <20200803094629.21898-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:45 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee22879-21e4-4908-d8bb-08d83792228a
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB545733477C5BFA2C492C554FEB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1QMqQnWu24wZULaUZ80MRlrlPgsDx9HCuGLhRb22UK305+QcmUadhjZvg0KKRSKavxEizIC0l5KvPz7fPwFOZneucER2wh3akk+xKbaE4EjDOsDV4FVAmuD4VfkV+1qV0457j1bZ9W6sspE4wB8Xkb+xpx0hwsaNB6itH8dJBI2K6ntpsZrvC2j/PKbz9Hr5Acy+si97dX8sXSx061T9n4IDYFepg8jsxDw6NSPgS63D/9IVUcZP6hPl6saAeu7O5KL+Nmy8yNgyB4M5koyQssQ7GswBRlq0SBF0+MCoK/0ebEooyLMIcXK2ZLMhYIuK/3Ptn3OW39rubcqmdyRJyE+fiOeu5gWuk3s4osfFmQYvyvI3dbMa0RIQ/vVf4ZN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(83380400001)(54906003)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Cdr6CnLAO9hzTy9A/FZGwNqoYCjMIoLmTCgwEfjqpTlxYici8jo3QNd7iigPlURCpZ0s5ZsnOXHUgdyO3FZzRH6vhvR31yiBz4/eQUg+AK7MbJ6g9GU4MEfAC6lnej/ZOOrMLHkdQLJLwpTeMjhJzupA+bzRp1V3nrFg1b2pdz5YjVj/FT09OzwokSEoWSnTmviDeQuoapYIST83p1PRrtdgaLXI5maqfJ6PoAHYIoNxlFeK8W/6OvZsytuL45lRLY5HqLcny0xjjIkXBMAqNdUYIIdydTBKik0kJmsi662wixV6fPgX4AKbMzzI5ptrWJeXmbzjk3cs/VCbIB/ZLaf7PyoyYlSOhF+3llDGHO5fhLO7ukbyr/PueHlkxJ/lyVbY0pq8Zy2FzmTUaiEkFfbBF/Y9Abt0u009zN1scweRieOk3FzyLAexi9Ri1Ac8lUnvJ8x9SG2BKsnoVR5+ie14jAX5TyxzznNE4qt9B3xJqsupRJoAtqOLD8Yx95D3vuH/szp0VOapEd8qQbpptn9E62IpGqp2LQAV1lYCW3PM/tEsMPqO7CnIoqFBmNw0h5ylyrAJ2xVwU67dRtaPHYC7dtyaLVcqfqapTr0SIB590BBZF5gspfcvIWidufARRfuYvDMFt2mbZP7yu331AA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee22879-21e4-4908-d8bb-08d83792228a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:45.8642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrhG/AkFDX2ScplztyXF6b48UFD4qCJoOJN7qOjH++yKZJGId//JSHb1FgZmNN1j3iH+Ft/13u63I3uPdc3urA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5457
Received-SPF: pass client-ip=40.107.1.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 05:46:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality for following ioctls:

BTRFS_IOC_SNAP_CREATE - Creating a subvolume snapshot

    Create a snapshot of a btrfs subvolume. The snapshot is created using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be created.

BTRFS_IOC_SNAP_DESTROY - Removing a subvolume snapshot

    Delete a snapshot of a btrfs subvolume. The snapshot is deleted using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be deleted.

Implementation notes:

    Since the thunk type 'struct btrfs_ioctl_vol_args' is defined in the
    previous patch, the implementation for these ioctls was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 8 ++++++++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 544184ff95..2422675dd0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -174,10 +174,18 @@
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef BTRFS_IOC_SNAP_CREATE
+     IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_CREATE
      IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_SNAP_DESTROY
+     IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 67a3c110b6..16966c323f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -968,7 +968,9 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
-- 
2.25.1


