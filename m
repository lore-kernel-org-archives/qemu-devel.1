Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFFC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C1922D03
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="MxH0YKYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C1922D03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwR1N-0004ic-DK
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0O-0003cI-4E
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:28 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:44942 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0L-0005Go-R9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUcAH/OBfQub8siDTRzOsEfrCRHvow7tjG6Hbh7yvonUDs9g2U7gpPH3uK4hZW3dvJmR3D8Na5LYZakcqjoODM3S5sirppNODsUkBPw/TmX+OAkDhaSCZGmPlbVt1g2fXd+MN+rbaUV7BDQjVy7Jnwa6Px5OjR9tVN3hJeMw7b6m3RTcaEWcMWoQVU0olm7tC5ppUO7OFNlzJ6XV3/PVUHBMBk28kmaqZyH8WGUTtLTaRBdKSNT0GvUCEfVcg38EfnEGrHVYXFA8k5QgEPJacFSsyTtNl+DPdy9do0IILpqAQAEXznxUYKYR68iRT2Xo2iGevmPASeprkNmYWBI6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEuqKS/m1H5zPxi+MxLPJlsrpn+MuYJrx9fjuCgtlHU=;
 b=CCEbC4onfP0yJoEGJmEErEJGAZbOxmdsxgxgruomOfS3IVxodtTdRmCvcx9Lt4eI2KK1G0qY+LFWIq1VsesmkILDpn58Fi/c2xoH1Ij1jIDlFgQg84fRV0M8S1ZBVBB6rHYtDLDUeNo5+zJlsdrhnfD8yfgy2TZcKSEYwQvmLwUfT0CFQ9iLeS2LnqryWhNYqtQX0w2JiV2VvRN+EKOyA+Lmf4wzhUlelSik1SKPdPQmgHarbDQC0ZP10EhFBsO7K/HeI9hHeqzKwaWdSzHAcGxoh5J3syvXfIGYo+86iAvKcbCdEMtAIaHrLzhK3p0f9NbkNdkLBTXu+is1K9nJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEuqKS/m1H5zPxi+MxLPJlsrpn+MuYJrx9fjuCgtlHU=;
 b=MxH0YKYDmYUPVmJBNkvRxjzK/g7OGkp2cMb0A3d145kfV1MUJL2JhufFibCcBHHKAR+RuPdpiWNRo4qlCSqhNZARGYarh7f+gnyVDJVe6lEh3T8W5NMaQHYNxpRuAYIVUS1IR8IHiVHuNCCvCRnytWRCnG6g/pBFnDNuyzBvTis=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5967.eurprd03.prod.outlook.com (2603:10a6:803:108::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 14:05:50 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:05:50 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user: Add support for a group of btrfs inode ioctls
Date: Fri, 17 Jul 2020 16:04:30 +0200
Message-Id: <20200717140433.265599-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717140433.265599-1-Filip.Bozuta@syrmia.com>
References: <20200717140433.265599-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 14:05:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd373a1-ad86-4647-f61d-08d82a5a82b8
X-MS-TrafficTypeDiagnostic: VE1PR03MB5967:
X-Microsoft-Antispam-PRVS: <VE1PR03MB5967EAF522A1042D9001932BEB7C0@VE1PR03MB5967.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdWWjGVYGBnEUuIcezqSp9uIfwIxMw9D2gJMsGUKwCVqIIP5CyqkBJR/MCQu3XBRmludq/c8R/yJ5xf7VRuzHLRJWBgbn6kwiXZRuY7DWHYZNWm1NdDhPAbORTcwqi7QoJEvp+/f0afv2SyVs3FfWkzhec89gHWYTop1dMjDrc61lNariesFC9kGPzqmQS8zaAQ3mfomP4VSDet38/6ppQrV/cIdg2gWpGE6eURFGDgfZ++2mMp5Sztz588aFv9gJ2rUhUse0I3MJsfd0QiNSePEKLIei0AUrUNhAWi9O2UWV3Q5NO5ZbJvS9MdIFlapCGsuy+VwAAti6ZKmqSaMjXwB2TNShk9HiRtq94FdOSzdQyw5cAUkbbKr02g6Uq6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(136003)(366004)(346002)(396003)(376002)(2906002)(1076003)(52116002)(8936002)(66946007)(956004)(316002)(66476007)(36756003)(66556008)(508600001)(6512007)(6916009)(6666004)(2616005)(69590400007)(26005)(8676002)(6486002)(6506007)(16526019)(5660300002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zWvmF68/LVcylpgzvt1aFNkwt7G9CnC5g3D6xc7O4c74Fd4I6cvIVx8z9/99p66Zw9aDVLtuO0H0UNExYDPbpbeV8RXv7KXEDxU6XEuHV0IXnT+1crYA3RLAQD+KkRYEbHeuRbc0Qd/pE5J/LHduSVu5tGFyRtxbJhM049XCnFww+gJQNb6XOmMhtnIoEwxdqeiMrvoHXXqOQzCaDstPsItdv/y63/nd2bbVISqH6+vsbN/gI74TFYBoqkRYXEkpHvzj1oRKIop00zDH2NJ0qe5mrYMzvcNawZqGIKaUh4ez7S8tCWOCSnhANuZCFkAjpEwe5BZFwlKXPncMKaKGByW9Igg0uOA2nvGDWRSEH9PjsHEAVVovTJ6D8RGw7IU94EUDx1Gj0NTnQo1D8GcDJ9+yPn+1VtdzacXJdKpGP1ek/jLuyyWgTPXBj9/40RuIq7xijo1TrL/BhJCIw9sGjVSIJsqK2KeUIIUXAgZrSuA=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd373a1-ad86-4647-f61d-08d82a5a82b8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:05:50.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv0am+ltE7nNeK7j256k6Def8v7VErYii0xE0BeYcXdkytpW4rsqa49aSVRZSyhekZsWbFZ0Z5YyAMYESVe+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5967
Received-SPF: pass client-ip=40.107.3.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:06:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: riku.voipio@iki.fi, laurent@viver.eu
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
---
 linux-user/ioctls.h        | 20 ++++++++++++++++++++
 linux-user/syscall_defs.h  | 10 ++++++++++
 linux-user/syscall_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

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
index 9db6f46cba..7bb105428b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -982,12 +982,18 @@ struct target_rtc_pll_info {
                                                14, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                15, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                        18, struct btrfs_ioctl_ino_lookup_args)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                                            25, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                            26, abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                           30, struct btrfs_ioctl_dev_info_args)
+#define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                          35, struct btrfs_ioctl_ino_path_args)
+#define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                       36, struct btrfs_ioctl_logical_ino_args)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                           52, struct btrfs_ioctl_get_dev_stats)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
@@ -996,8 +1002,12 @@ struct target_rtc_pll_info {
                                        57, struct btrfs_ioctl_feature_flags[2])
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                        57, struct btrfs_ioctl_feature_flags[3])
+#define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                       59, struct btrfs_ioctl_logical_ino_args)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                    60, struct btrfs_ioctl_get_subvol_info_args)
+#define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                   62, struct btrfs_ioctl_ino_lookup_user_args)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index e26ab01e8f..980c29000a 100644
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
+       TYPE_ULONGLONG, /* reserved */
+       TYPE_ULONGLONG) /* fspath */
+
+STRUCT(btrfs_ioctl_logical_ino_args,
+       TYPE_ULONGLONG, /* logical */
+       TYPE_ULONGLONG, /* size */
+       TYPE_ULONGLONG, /* reserved */
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


