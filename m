Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A59C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C942206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="THSDwb0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C942206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w1z-0004Z3-A7
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w14-0002v8-2O
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:59 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w12-0006Ij-6J
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBtZrVQYch38XSnWB0b0KaDbqbKunafy7gjqhsUOT67jnv1TiDIBI5eeUzkHaCo3HXyIGQM0/kPzIZotjvPjLrfXra85UINpyHneh5SNWRnWPPZnj5hE6pFKA6GIoVKge6QeB7CkRp9TCHvjck6EyMLL/R24+EdQ3qfibFCdivzumaC9S6RYSUh6fip0Yt29JRuDGLVLZq6xVMn8I4ZPd0+1T7YGcp8mCm5JUZSIsWqCme+8wXVyPfa3FJzTob3nbo+/SSTeFwnZQbbcb6ozusIL5GRIoqTlGoG4h1xBpTcQszxHL9n4T3Rwv5mbZVSaYLRcg064cLj1RYT0u/5rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt2j7P1JCoYkObSnkP84Yxn7Qou7UZx82gsylP6SxDU=;
 b=L/A2ydfHFzjfRR1rkLOelJCdll3lWP30AAVptJNy6ENDEW3TdyecIBEMjzq8KV2MzIvSEB4lQJK5g6xd/HjECzByGD3ugAAwo28+2Q8Ep8S3XgL24fjAfu5TU4OWl6n0vSVGPvEJF1EElsCKcEOT3JwlgJ+6tpedHunRVoWHytrSu2Zic11DOzWRKYXQVzZEvSEXieo5J4l+QNf6jEwcCClOnT1G1JLi6aeTROF7eHZ6eCFUn1JXsuDe7dYsboQ1BXNvmgcFvGfwEIXlRbHlOlkVWBXBTjhks57ktuswsirfgnOcI6bgePELhi/bkiHJ1fE+HtRd7NCLA1lpV/M1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt2j7P1JCoYkObSnkP84Yxn7Qou7UZx82gsylP6SxDU=;
 b=THSDwb0fJfz4Qv5Dvql06Or7MV4Nm3K45GJRfB4on8zFBNcAW0b4xrK3vsrfkSGDTOGnc96CiOUD3YRw3GwPzMB3cTg+7Nb38d38gkXEO8doEtaQrBfvhAt8kQpu2aPVgdzlzGpWTGiwBLK+tlPWtDhhpP+AmQzBB3Rgdkd8UIU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:37 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:37 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] linux-user: Add support for a group of btrfs inode
 ioctls
Date: Sun, 23 Aug 2020 21:50:11 +0200
Message-Id: <20200823195014.116226-6-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
References: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0d87b79-f49b-46fd-ddb5-08d8479dce90
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB614313B32C1F431AB19DDD1EEB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zyI8Qs/novJ4fG6B/ft3f1HFT5Q/X2TfeuKTb5xvpMSiAlVXVgPNWrkag4cv8N1aafpcxaGL7vG5KcpB9kaxBqYLcK/Lv9Mkheq4CJy63Xz4NYBdipIL7q4zK7Bta0HdoTogjkbFY+QfEOxGAwR7euKctcZR1sI2GrFcBvgEg3jdMY9DcCkPfLpEbeiz5Op4xMu14ZjR5fZYtfzfhfhjdJl4/IaLKCr/qRPcllZbboojwskGAh+bUr7RQobwypiH4jf4Vc/YQvthkw7JxsYtkcxascMe6zmQNwR3TwuYlhaX/VpCEfAbjYk5z3uu7ixQBgkdZgA0wHUCmyw/F05H6Ha6rB8e5GfK09af9y6cvqXebH0wTw6TjIsMBgrGxlE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(69590400007)(16526019)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vE4xSGwepkQ2CKclnexYnxTjx6+mYlQRsnKYCq58TR20Ewxg0zRbF/VzdPkVjCdTTkbmo0DTx+87neRe9f/tgeThe0sDX4g3v6tIbYT+CfjbokWiFvl0fDUyyxUwzZKAnZCF8TCCXwv0p8jE3eH+0nNdhMJSLUI1jhoj8AohXJAqArVAi/EawEUYzghmft/nW7v1RpW59OdKFR40pXZlQHa+vn6tdA3AMCgcW38cko6QLo9ZDMThnYkLuNOOogLZi47ecUUSzSLWCpAKDrZJy4kj1LBAhs+xqyID2nFY5WmQeA3umP8dBVcpqiaET9vJn9yuaXZ3vgQmnvfuYfhlIkIsV9JM6tZlKhbMM11BEr46w0j3sL2FUT8Gi9Uqi1L6JuEvZKPjWRoEb00RLnBXgGFgvIIXNxHoPWKQcnXFJ7BZ1yea6EMq1BL4A8DJgkhoPkjcSN0ft+KmF3tofPTu5k738LVq2zCKdySUDx6r602chH+hshII7j2fHx25y5BmWNnOJ0enJLZymSwiOUXWEns7JjgXBXLG/S+/e4pNOyxGMBBpiplj8KVo9p3oD8XZwt7zDeUt6e+LIbnNySoH44m2NeZHdl6I+Jccafz8PfunG9r8eFzrfzSN7MGxgL+rzgmFXOY5uYCmWkR1b+J2Lw==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d87b79-f49b-46fd-ddb5-08d8479dce90
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:37.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +w1P3R8YZz/gfizOEJpi9gcKcDsKGbhrobMnN34A99RGGrhVb8JUTL7u0keAe0089b4KGYmGBlHBOSoFAm3KGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6143
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:50:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality of following ioctls:

BTRFS_IOC_INO_LOOKUP - Reading tree root id and path

    Read tree root id and path for a given file or directory.
    The name and tree root id are returned in an ioctl's third
    argument that represents a pointer to a following type:

    struct btrfs_ioctl_ino_lookup_args {
	__u64 treeid;
	__u64 objectid;
	char name[BTRFS_INO_LOOKUP_PATH_MAX];
    };

    Before calling this ioctl, field 'objectid' should be filled
    with the object id value for which the tree id and path are
    to be read. Value 'BTRFS_FIRST_FREE_OBJECTID' represents the
    object id for the first available btrfs object (directory or
    file).

BTRFS_IOC_INO_PATHS - Reading paths to all files

    Read path to all files with a certain inode number. The paths
    are returned in the ioctl's third argument which represents
    a pointer to a following type:

    struct btrfs_ioctl_ino_path_args {
	__u64				inum;		/* in */
	__u64				size;		/* in */
	__u64				reserved[4];
	/* struct btrfs_data_container	*fspath;	   out */
	__u64				fspath;		/* out */
     };

     Before calling this ioctl, the 'inum' and 'size' field should
     be filled with the aproppriate inode number and size of the
     directory where file paths should be looked for. For now, the
     paths are returned in an '__u64' (unsigned long long) value
     'fspath'.

BTRFS_IOC_LOGICAL_INO - Reading inode numbers

     Read inode numbers for files on a certain logical adress. The
     inode numbers are returned in the ioctl's third argument which
     represents a pointer to a following type:

     struct btrfs_ioctl_logical_ino_args {
	__u64				logical;	/* in */
	__u64				size;		/* in */
	__u64				reserved[3];	/* must be 0 for now */
	__u64				flags;		/* in, v2 only */
	/* struct btrfs_data_container	*inodes;	out   */
	__u64				inodes;
     };

     Before calling this ioctl, the 'logical' and 'size' field should
     be filled with the aproppriate logical adress and size of where
     the inode numbers of files should be looked for. For now, the
     inode numbers are returned in an '__u64' (unsigned long long)
     value 'inodes'.

BTRFS_IOC_LOGICAL_INO_V2 - Reading inode numbers

     Same as the above mentioned ioctl except that it allows passing
     a flags 'BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET'.

BTRFS_IOC_INO_LOOKUP_USER - Reading subvolume name and path

     Read name and path of a subvolume. The tree root id and
     path are read in an ioctl's third argument which represents a
     pointer to a following type:

     struct btrfs_ioctl_ino_lookup_user_args {
	/* in, inode number containing the subvolume of 'subvolid' */
	__u64 dirid;
	/* in */
	__u64 treeid;
	/* out, name of the subvolume of 'treeid' */
	char name[BTRFS_VOL_NAME_MAX + 1];
	/*
	 * out, constructed path from the directory with which the ioctl is
	 * called to dirid
	 */
	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
     };

     Before calling this ioctl, the 'dirid' and 'treeid' field should
     be filled with aproppriate values which represent the inode number
     of the directory that contains the subvolume and treeid of the
     subvolume.

Implementation notes:

     All of the ioctls in this patch use structure types as third arguments.
     That is the reason why aproppriate thunk definitions were added in file
     'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 20 ++++++++++++++++++++
 linux-user/syscall_defs.h  |  5 +++++
 linux-user/syscall_types.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 50fae1e33b..169f98f7a3 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -202,6 +202,10 @@
      IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_INO_LOOKUP
+     IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -212,6 +216,14 @@
      IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
 #endif
+#ifdef BTRFS_IOC_INO_PATHS
+     IOCTL(BTRFS_IOC_INO_PATHS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_path_args)))
+#endif
+#ifdef BTRFS_IOC_LOGICAL_INO
+     IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
+#endif
 #ifdef BTRFS_IOC_GET_DEV_STATS
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
@@ -228,10 +240,18 @@
      IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
            MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
 #endif
+#ifdef BTRFS_IOC_LOGICAL_INO_V2
+     IOCTL(BTRFS_IOC_LOGICAL_INO_V2, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
 #endif
+#ifdef BTRFS_IOC_INO_LOOKUP_USER
+     IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
+#endif
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 44811fdcbb..a6a9454b85 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -975,16 +975,21 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
+#define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
+#define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
+#define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+#define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 925054cfd4..b84e14235f 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -389,6 +389,38 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 #endif
 
+#ifdef BTRFS_IOC_INO_LOOKUP
+STRUCT(btrfs_ioctl_ino_lookup_args,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG, /* objectid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_PATH_MAX)) /* name */
+#endif
+
+#ifdef BTRFS_IOC_INO_PATHS
+STRUCT(btrfs_ioctl_ino_path_args,
+       TYPE_ULONGLONG, /* inum */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 4), /* reserved */
+       TYPE_ULONGLONG) /* fspath */
+#endif
+
+#if defined(BTRFS_IOC_LOGICAL_INO) || defined(BTRFS_IOC_LOGICAL_INO_V2)
+STRUCT(btrfs_ioctl_logical_ino_args,
+       TYPE_ULONGLONG, /* logical */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 3), /* reserved */
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG) /* inodes */
+#endif
+
+#ifdef BTRFS_IOC_INO_LOOKUP_USER
+STRUCT(btrfs_ioctl_ino_lookup_user_args,
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
+#endif
+
 #ifdef BTRFS_IOC_DEV_INFO
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
-- 
2.25.1


