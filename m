Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02926C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B194D20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Y7WNg78Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B194D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X5n-0008RU-M7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3e-0003zx-Uw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:02 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3d-0008SR-3S
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0d1E9/Z+38Id1rRKAj4Oc0kx1ibgGFXId/uDvjT//hnnMYdq9/CinthOTrf9Vte+fD7oaoCRgzxZaKgvzNuAw4Mm+9Ys8P0yAbhVpEd1bH1B8FhHzfpeLvijOnND7LCpBkX1I2p0b1tJ9X7ni1vDngjAPCNb9JAW3sw11FfCB3GThYTRKFuzrO9zgumkppD3ZnVMDnCpL8YOUTp9T4/7UTdftwCFziCVEO0CQNz5uT9Hd5TBu0YH5XKIJ7AcSQ2K091Iko/4RN/YI+JNvBySiVYcP3ZT/n63/gwxPxNLL6o4wdigHi9gTHWOjzlb+GVZTTXkpnySOJNCSLTwuwx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTDxpich10Z4F0/R+tBZNMAryfrfTdES8TAj4x8YsEY=;
 b=lIo+QRWB/MRcM/Rm4v3VdpGM1LtarTDi23aM2b6Lqov+uwXQBiudBts9OAitgcdPm4nUp9hVBFSzLGElPAMGAi3nl7GAewvcEOIdEVJE56SxNw+rwPG0MLwp9q5cDrB4IylwV0xiFaMhmFFqnmvFmBUYvsebzX6WyGAbLL0BiADsaKE/Ok8Fpb8s9Ql3AKmhcL5C97wSPrbpG01aXXjTWGhWb1fOxJrPyZjtCJ/ziQRMxycpy0X6KrCDEQtAA4HkEaWTVdEkUeZU+REEiRNdU8p4oq81qZrRiJJdbfEOnNqmoO0z8Z2bmwW8d84g7gkZ8RMLUCtUvBiM7xS+z0XMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTDxpich10Z4F0/R+tBZNMAryfrfTdES8TAj4x8YsEY=;
 b=Y7WNg78YPOlU+TyXL4lM8Vv/O74OxSRShh1dVI9oAUgn+CNcJhSLVyvpxPP4unH7qhbTlKm0od5b0A2h+WLlY6ZjldtKuyX2GcmLvoO3I5vm17S+Sj1fHdOStwDGl50SFKDS9i7VcX8IjzxeTqaK0u6L18pHyNyJJD55vmx6jBw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:48 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:48 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] linux-user: Add support for a group of btrfs inode
 ioctls
Date: Mon,  3 Aug 2020 11:46:26 +0200
Message-Id: <20200803094629.21898-6-Filip.Bozuta@syrmia.com>
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
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b0ad3c7-7dcf-46bd-266f-08d8379223e9
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB545700942B8CC66E41147CC0EB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5J0gpgBLEerPcfFlR3AD3/GR1tEaXk6/G95b+fkwH5rV/dRqVq4KOQ6ETnt7LuzFeJGNqyrGSTLMPK6H7F9mLWF/YAjEZgLQ41XBafX7lYTUmhyUmeWXWDxUrUU9OEIb0vDjc3g+iHPOwvjiAmRNhGTg1lyxUyMkiUa6EHUvIjX6mWdw6S+BVMnQR7UwrUTUx2kJqPTSiPB7B6A9q16fbLCVhf+oJzHgCgiZEoyJXCuCe81LWG2bxvaM3ZO4s+1BOCHY/6hiH1aBckSROdWX9fubnouKGRC8vEqAjmkA0p9kbjpFJ4EweL6RmtLuhDcfVGE6WD+AFcCEe1MqntKNsgOBvIMwntAP9gPDDC/qdosaPVnGtOzN7iJ/qLjYNhJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(54906003)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Czw995iR+BcXoVWsLjZSsASPzzLMnK4TycLs2BRbusmYXP5J1RiXUjR2kzzhqGrXiyY3CdSYp/Z92cBEGvm94CbFOjoQE/pKydr1gmw3agpIIyn/T3mFTLknKXMpJuchTLu69wYkbXgk6BZCIki1ZYFhm7NOqYiPv0d1kb7lPD97aypuvynV4TcDeV99dHpZn5Kt2QT4g+VFObCNwdIhJdKW0eSj+3sPjlPr2Mqw2KaDmDY8zMstdkxd2h2z9MGZR1HIgACDsER+B1lPcKRz0jTOVsgJkGqvuXYquIFNUUVBZj3ZQcO+ALRDJcqQm3Dfc1kzBn4rS0p8aH8/H0PPByOfF5MVu572y1JRZwxk+kDzWa8TJIeiE9xfFuEIaR2ZaSALePB/5VDPtFkZhK+aMkV90DzQf1oSZAry6cF/UDI7zSl1vD/ezPSGymsk/q7hsHLnrvSmEESJrK6078F4SqFu23taBXFYGotcjqzGKIqVP2VusdU7neRZnPSIuI2SCATLREfl0RwtXvcWGJ+PvzB4md9KqAMl0eoFreeQTU/hxkX/WL1QxnfleZTMijm/GDNTp25KaQFTu1SLYD5uWPvDLOnKokvKvM0vOjwZOF2TIsfBtLx94yTv5jHzIjbLmzxp/PhCb6vkVYORUl683A==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0ad3c7-7dcf-46bd-266f-08d8379223e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:48.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI+lNPAC/oOsuRaJ4p1fhHY5b8B41APee4NrPCwEimMdhvBsxlRMcEo2gYcIZqlADy9zK+jPpTS1ulhJlmIqBw==
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
 linux-user/syscall_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c6303a0406..a7f5664487 100644
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
index 13a444356b..538b884b8f 100644
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
index e26ab01e8f..978f2d682c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -349,6 +349,30 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 
+STRUCT(btrfs_ioctl_ino_lookup_args,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG, /* objectid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_PATH_MAX)) /* name */
+
+STRUCT(btrfs_ioctl_ino_path_args,
+       TYPE_ULONGLONG, /* inum */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 4), /* reserved */
+       TYPE_ULONGLONG) /* fspath */
+
+STRUCT(btrfs_ioctl_logical_ino_args,
+       TYPE_ULONGLONG, /* logical */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 3), /* reserved */
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG) /* inodes */
+
+STRUCT(btrfs_ioctl_ino_lookup_user_args,
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
+
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
        MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
-- 
2.25.1


