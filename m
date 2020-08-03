Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07464C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA35920738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="pA9k4NGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA35920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X4W-0005Xn-Ln
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3Z-0003pF-KV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:57 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3X-0008SR-RO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irnQ0K8LdbXEmptu0ngInm380X8macx7I2s+Fqv40oV60bk7OlDFfAekn84Tn7DqIAJdXSgvpDb0+BwtqSFsbYyJ6Ujb0Rtwgro+UNbrLWXUl7T0dtzLXHJx5mNSi4WA/Rftrzcix5oX+wtlTzj7c53ANlk813v4M9+7Pmf3IwIGPL6mTrtaZLSW09G4V/DhztIxTbs6GQZkjGS9uk7mvs8zRI+S5PIkx1AmZPPsFfPd3CyxVr7z+iZW0tQXMEicudrjUfsUAXlaI4LI0ognhiWbdq/ywZl/PuHv4xE+fApm9meITuMoTpRt7dFNRDOVQ92aO81K33MDlLXnAhItvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF/s6LKzFEFfPKsYB6ijWIBuiDLFJ+2eALxXTWzKV7U=;
 b=HuawQWA4OTtSXQkRg2qS6nCpEa9vLtr/PbGB0H7iLMAgVXb3Lts/MyChlzDyyWJUUMyna0R5mbeEm7s5C5aeefZ9BAcXU3cMXXnSxoCyJkmv59HT7QswVUUdobw94JnnZhtB2uwz6+QxfYl2ItcZUNEmZCg5krBn0cf7n4aZzqBMNy5rziem/jkkp37EBuzGFsYc157lt/NM4jQTQp2oZsHi+EW+PZZdhTSwjgb0r8x/2a7SzXigCUw88Fox35oThupvEqnqnIQ4Rr123wPZvW/JKl2cagSY5ubHeSFfzRq3AgJ4UvogxOnyJnCPXlrYYUFFwCq9kh5DfLb9NwZ6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF/s6LKzFEFfPKsYB6ijWIBuiDLFJ+2eALxXTWzKV7U=;
 b=pA9k4NGjB1Rif99FSxGkiYQEPIt9S6L4fdVH4d3FsVMlSspy+6BSLMuJDleVzMzoD19+GBG7h9LPcvaOBI+f+c5eO+O/RYc/aIu/b3FAenq0ZvrVBasg6xJtL5GMBExsvTqdCXH+E4oV93KVEkm5WxC4VIZWbL4/dbybsAv6XJU=
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
 09:46:46 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] linux-user: Add support for btrfs ioctls used to
 manipulate with devices
Date: Mon,  3 Aug 2020 11:46:24 +0200
Message-Id: <20200803094629.21898-4-Filip.Bozuta@syrmia.com>
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
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:46 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936e60c5-c723-404d-e717-08d8379222fe
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5457AE61B5276FC923AFF380EB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXwIyYS7j3XTt4uNulEbIZQKuHGW/56RZze98NleFJs1kgv9MCb4trB1mKWk4mrjfL0whmQforuKBHlRI5ozCsZf7zpF067S/u6+iaXf7/m4BK2ALNbTmitkx4Ctyo5fm35ypwksKfWlPK8w6fVYXSytWj1dZUgan8KX2ygh26P/U+qjgdaLdT919Ab4gs7Q8oFq/T87/GXaFe8EePPLHTD2mbMlRnKyZDLWp5WYTQpfMFr12iO7H6BAFn0kePh06GavAAw6nqwkZc/mB8hPS8FWhgFNx/LAvuSuHR42EFafLKeBTc6cRXpYMNAwpXrHX4AM+8wUlpo9GLDCirxTCdO4L9YylxaA+mFLzHN65q9pxN+bNdh3VUNNzxZVHNZJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(54906003)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3cOh6UAuhgnXZABhWyVUmJoZlLbIfU1lXlNOt8dQSa+jsvRIc0aKDC6251Nyv4CmqNdJ42dck6yBHGfRaC6w2uq3NUFqdXl303XpuhhV1H/qka39aKzZ0CEDF05r0XjTHJixCyWfiXUpMGx3G9YU2yyh/JCU1gLDA3wUM5XfMyCVbsE13N+65B9gaPQTUg4i3iwINcwkuleuDYGVNNG+s88FffCqtBuy1cVq+yLbkIkRVlTiV6PiNbiGK04P9lEL+Pv4GCW4xh7Z42DJHpQWxszu0KmX18EyC9pJ/iyOn5IqO5hiegZO+S69DGfxpc2qgfKeNwcnRXTaS6nazTqK0FXwgDM4+reN5KIBxwrBikZnWXXgXVE8tw7INBL6Nsnt9w6PvwoTmO5mfmy5b4h5aW6r3ssHTXo3guIlFld1RMX7aL0gatIunKG/q1JsbPlt/4uNxZ2mLB5fYzpv6NdbRTEgOWrg+JVGC4lLHdgup3NifTZ+d5/Eqm5WFlNzBb7XBxQBSnxWe6SczQx1VEn5AbjxkOXnXH9oy/KU94SeXx5eFwNOihCSLQAuRdB7RY+pgr8opg/SOcY4725FB51GqC3wlIgvUXJSvYSFN2NB2LfoBp7Hk26i3d4YsqqpnNHsVMKLAatJB3mGF+dvl/otpA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936e60c5-c723-404d-e717-08d8379222fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:46.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH4Vl882lqWEeNjVl3YUwvK/krLhGdoPcVgKdoAZYP1WK0473XiKB44N6yIU2+g/MMqbbebZGijw0daNmHnGPg==
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

BTRFS_IOC_SCAN_DEV - Scanning device for a btrfs filesystem

    Scan a device for a btrfs filesystem. The device that is to
    be scanned is passed in the ioctl's third argument which
    represents a pointer to a 'struct ioc_vol_args' (which was
    mentioned in a previous patch). Before calling this ioctl,
    the name field of this structure should be filled with the
    aproppriate name value which represents a path for the device.
    If the device contains a btrfs filesystem, the ioctl returns 0,
    otherwise a negative value is returned.

BTRFS_IOC_ADD_DEV - Adding a device to a btrfs filesystem

    Add a device to a btrfs filesystem. The device that is to be
    added is passed in the ioctl's third argument which represents
    a pointer to a 'struct ioc_vol_args' (which was mentioned in
    a previous patch). Before calling this ioctl, the name field of
    this structure should be filled with the aproppriate name value
    which represents a path for the device.

BTRFS_IOC_RM_DEV - Removing a device from a btrfs filesystem

    Remove a device from a btrfs filesystem. The device that is to be
    removed is passed in the ioctl's third argument which represents
    a pointer to a 'struct ioc_vol_args' (which was mentioned in
    a previous patch). Before calling this ioctl, the name field of
    this structure should be filled with the aproppriate name value
    which represents a path for the device.

BTRFS_IOC_DEV_INFO - Getting information about a device

    Obtain information for device in a btrfs filesystem. The information
    is gathered in the ioctl's third argument which represents a pointer
    to a following structure type:

    struct btrfs_ioctl_dev_info_args {
	__u64 devid;				/* in/out */
	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
	__u64 bytes_used;			/* out */
	__u64 total_bytes;			/* out */
	__u64 unused[379];			/* pad to 4k */
	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
    };

    Before calling this ioctl, field "devid" should be set with the id value
    for the device for which the information is to be obtained. If this field
    is not aproppriately set, the errno ENODEV ("No such device") is returned.

BTRFS_IOC_GET_DEV_STATS - Getting device statistics

    Obtain stats informatin for device in a btrfs filesystem. The information
    is gathered in the ioctl's third argument which represents a pointer to
    a following structure type:

    struct btrfs_ioctl_get_dev_stats {
	__u64 devid;				/* in */
	__u64 nr_items;				/* in/out */
	__u64 flags;				/* in/out */

	/* out values: */
	__u64 values[BTRFS_DEV_STAT_VALUES_MAX];

	/*
	 * This pads the struct to 1032 bytes. It was originally meant to pad to
	 * 1024 bytes, but when adding the flags field, the padding calculation
	 * was not adjusted.
	 */
	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
    };

    Before calling this ioctl, field "devid" should be set with the id value
    for the device for which the information is to be obtained. If this field
    is not aproppriately set, the errno ENODEV ("No such device") is returned.

BTRFS_IOC_FORGET_DEV - Remove unmounted devices

    Search and remove all stale devices (devices which are not mounted).
    The third ioctl argument is a pointer to a 'struct btrfs_ioctl_vol_args'.
    The ioctl call will release all unmounted devices which match the path
    which is specified in the "name" field of the structure. If an empty
    path ("") is specified, all unmounted devices will be released.

Implementation notes:

    Ioctls BTRFS_IOC_DEV_INFO and BTRFS_IOC_GET_DEV_STATS use types
    'struct btrfs_ioctl_dev_info_args' and ' struct btrfs_ioctl_get_dev_stats'
    as third argument types. That is the reason why corresponding structure
    definitions were added in file 'linux-user/syscall_types.h'.
    Since the thunk type for 'struct ioc_vol_args' was already added in a
    previous patch, the rest of the implementation was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 24 ++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  6 ++++++
 linux-user/syscall_types.h | 16 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 2422675dd0..c20bd97736 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,6 +178,22 @@
      IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_SCAN_DEV
+     IOCTL(BTRFS_IOC_SCAN_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_FORGET_DEV
+     IOCTL(BTRFS_IOC_FORGET_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_ADD_DEV
+     IOCTL(BTRFS_IOC_ADD_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_RM_DEV
+     IOCTL(BTRFS_IOC_RM_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_CREATE
      IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
@@ -192,6 +208,14 @@
 #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_DEV_INFO
+     IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
+#endif
+#ifdef BTRFS_IOC_GET_DEV_STATS
+     IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 16966c323f..23f966d552 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -969,12 +969,18 @@ struct target_rtc_pll_info {
 
 /* btrfs ioctls */
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
+#define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
+#define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOWU(BTRFS_IOCTL_MAGIC, 5)
+#define TARGET_BTRFS_IOC_ADD_DEV                TARGET_IOWU(BTRFS_IOCTL_MAGIC, 10)
+#define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
+#define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 75ce6482ea..b5718231e5 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -349,6 +349,22 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 
+STRUCT(btrfs_ioctl_dev_info_args,
+       TYPE_ULONGLONG, /* devid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
+       TYPE_ULONGLONG, /* bytes_used */
+       TYPE_ULONGLONG, /* total_bytes */
+       MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
+       MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
+
+STRUCT(btrfs_ioctl_get_dev_stats,
+       TYPE_ULONGLONG, /* devid */
+       TYPE_ULONGLONG, /* nr_items */
+       TYPE_ULONGLONG, /* flags */
+       MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
+       MK_ARRAY(TYPE_ULONGLONG,
+                128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.25.1


