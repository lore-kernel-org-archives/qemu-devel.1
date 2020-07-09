Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FAAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7412C2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="T0+g6dP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7412C2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYuP-0007Ey-Fz
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr6-0002o9-QY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:53:00 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:3260 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr5-0006dz-2L
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA/wxuB2c/nOgDccEBU+vXPMNTSdrh9a5xbC0L5J/hcl2OX/k7FpXKYMIJyylNiw6upnFKVWRVS7gwkKcuuTAowFBl56dEmSRNmU1TujGXMKfeTMNIa6aF11nw3sUFkmtqsJ8wq3ogp/ZPIJ+eactr3HgkxWcZk2dYN1VtreZv+O+5/zVXcKWqTbi51lMMSdZI1Aj0JuwmPMQ5dNfgmYbLqhTUCprpjl/DKqpgYxQOhE3pmWz381usl0rHuIKumUGPhaMjvnNQhLXVgX7jXgTin0KRvltTmyzTVQaVkpaEj7PXa81+PjOzlC2UeWFBja7OjrIH+iy4p+suQTOliTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDKvmzteHQyUIXqkz82nv0D6pYmUcMzBdwDTo+H1uOI=;
 b=ni/4LhiilSLtTusqQQkIPh2fKFr2IfnyazLt0+gywLbawJOlG74fuHCUCMsy+llQIdl2LTKadD1TjJLImXvqKpwZC/xLLfulBFd3Q2sqbHyeSC+Dy0OwXpfzHW4C2XYW1aBB3k8ftrRsHwyRRSm5bFVbTkNfD37kZc9gNyMDFGKiJWpCBSNqfh9EsLjeb93GbhckL/LQrxW3wqgVVKiAOrjVUwyN0wS7Jf1I0izVxegxcbU76/Tga3FhWMwM4IHOzeuXl3QsXko9rkBt1243HZHcnA+FMSeJjMJdoTW5NApSThLWptlyAdwlNJndv0hFh1SnIBZteEt5pMX5E36DpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDKvmzteHQyUIXqkz82nv0D6pYmUcMzBdwDTo+H1uOI=;
 b=T0+g6dP9kddUi4Hdz34XCP/q/qUjXmMpz7FOWbr3oYlPBvGwACPkVMoE0jIXHC4SZxSKLoed9Ax2DAMC2eY01yei46k6ka88njHrWccWLeEyjKA0wrKXqOYshp4XQHGfCZJxODOdYzai7eOB+9t+mtPvDOyyCbXPGqa1w01w6do=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3223.eurprd03.prod.outlook.com (2603:10a6:209:1d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 9 Jul
 2020 15:52:23 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:52:23 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] linux-user: Add support for a group of btrfs ioctls used
 to manipulate with devices
Date: Thu,  9 Jul 2020 17:52:02 +0200
Message-Id: <20200709155203.21106-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
References: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.245.225.24) by
 AM3PR07CA0147.eurprd07.prod.outlook.com (2603:10a6:207:8::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Thu, 9 Jul 2020 15:52:22 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [109.245.225.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa2e9029-acc8-4dc2-953d-08d8242011d6
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB32233931E30C6D374082F63CEB640@AM6PR0302MB3223.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/bNX9HlKMa72twjRlxkfx+gU4gya77ftb/iRGUiIafzxCZUMWVfDK+zevkydyau1eGC6GybkOZKhPIqJjEqmGF2sEzWIaaQ144MutTN8VZy2peE1qPM6H7UWGQU+MUFPYLAgPmq1wi3Mzzb3Ddm5/xENJ9M6fqdslwtCTWskQTTbe2/XaHVDSrHBxSAWh179G1TkQntGzdPxZ26EJJdJk9fye8CZ5ZL6foT64/ez1cGXf2gTWoYrPvx53UAN23TizK8lef/JyIQ4VSo7r46scG+MjXVbOfD0h8QwzHyF2OVVUxDwGvHpo6y3Esj3BPj69DOR+ilwrr2h2YqenwrBpmBWy4xyqq1kypfGANbxS52/5c9QH9D2WcTMpHKbjoa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39830400003)(366004)(136003)(346002)(66946007)(66476007)(16526019)(186003)(66556008)(26005)(36756003)(52116002)(2616005)(956004)(6506007)(6916009)(107886003)(2906002)(6486002)(54906003)(6512007)(86362001)(1076003)(4326008)(8676002)(508600001)(5660300002)(316002)(6666004)(69590400007)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rcztZtNIDB/7odL/15gY1KoOs0a+fmBHHQE0aXlYx4+BV8tp9es/yQp3/a4vE4kDZHsjzaqDnj/fF7l2cKWFDS5slXHkAWslQuqVHwB3jlUj1yOYJnvkJcsYj5wVlTwfnH+ZDhIxk3qbME7iNKOUEANyKf8neJW23hCMA7XaNj/U0AD7/dXcOgRLEgS/r13t51rxuIf/sYifzTe2hOn9Ou+OAi3QNOQW18Q2zeBCl8wSp46NOyaI5+BWn/QjzvSUseu9IT4wiI35xTEnOzKzRdEh9Ztdo2yLYP5/tMKnUsQKHTbB1F43Fl0NPlk9fsReY3H/EIviLEKcjlv8S9pCVYlgQU5JziRRVLqN4aK/h9PhdHvnpPwX7p85xQOWqD1TFG1q45WANRywn6GpZgNZC429L4cdmx6Cfayas/kanHRn04a9nfO5tEqJvK1HYP6tsJju/SqRgMI/m7zQFBJCF4E3WQJWxgQ5Wz2WZS7WnzI=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2e9029-acc8-4dc2-953d-08d8242011d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:52:23.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9VhSN7oNkoOTlMJY5w6IO+eqHa6M89m1cXs08EvlfB7u6z5zJafIg7nb6EM34KUQjg1ZCq8WcST9sV4FnKzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3223
Received-SPF: pass client-ip=40.107.4.114;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:52:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
---
 linux-user/ioctls.h        | 24 ++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 12 ++++++++++++
 linux-user/syscall_types.h | 16 ++++++++++++++++
 3 files changed, 52 insertions(+)

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
index 21d8909fd6..20c03cd145 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -970,6 +970,14 @@ struct target_rtc_pll_info {
 /* btrfs ioctls */
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                 1, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                                4, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                                5, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_ADD_DEV                TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                               10, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                               11, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                14, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
@@ -978,6 +986,10 @@ struct target_rtc_pll_info {
                                                            25, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                            26, abi_ullong)
+#define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                          30, struct btrfs_ioctl_dev_info_args)
+#define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                          52, struct btrfs_ioctl_get_dev_stats)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                    60, struct btrfs_ioctl_get_subvol_info_args)
 
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


