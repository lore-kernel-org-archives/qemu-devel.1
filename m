Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305FC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE2206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="wupMTD9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE2206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w20-0004dg-ED
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w16-0002wu-9z
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:51:00 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w14-0006Ij-Q0
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1syOeHF1idvMtx4MAHO+DeQqdscMtD2ust80CfierIq4iP209gvOlhIq8NjpluP1pU8DjnDi19mKb+2ScvWe/pvlapF5mh3o2JqBf2zYdYEK/XYxLBSIRp4Zxx7Q3kpb3R5JuMTerd0/vephWGZABnP5zM39Jxchz2DFzYul07JwljIj9h8DmqU/0Zcynk4Uu8VJm8kTCihMGc8cOuOXUEHDbbm2pVDaIkl+KutX2f36rMwHpV/RB98SXf06tqMYEVgozz5C/snvC+QKA4VlznLlxmw1KvFBvOsaaN8rYGdUpgnOdNpeYyGLW3cePyWeJzqce3UhhJP5KV0dRlc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzwN1+s/TNQUzBHaeNPOKOavSXnqrmMpZjmMpCMpLn8=;
 b=WWDq7N+1zdSCe9KIC61VSLG+n0vFrk7mwzwzrz9MkHfonpbDZYoA8R9N9fnu5Dj5yli80drCYPEzCValkM5TOWAMxkrvJOFlsfA/AnpFeA2xJZNBOXk5p95OykeDzvf6ppNXWpmrsoYrU6b5skAidU4V5BNw3DnTG08a9Hd1gkUIeeq30jrXnGmkkI7tqrOqpNVQCJ7dQ+D53pNThtrSNG1v1HEPAq8jiGZD5gD6SFi8xRQGF2nO5UWgA9tBCFoqgW10HtwMLveoh3l89/GPEqBgeSsrx6VXuJ5XgpW65VnaWXeLsjL+g8aPO+DBNhGnF4ss2QVi8WKJ+2qpzFtfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzwN1+s/TNQUzBHaeNPOKOavSXnqrmMpZjmMpCMpLn8=;
 b=wupMTD9Cf8wM19ucZ7lX83tHvPzmGcY+Y7p+JqoYU+1sgS6BcSrIQtDdY3AwIA4xXDaRlVIKx1tX3J3Wop7zfOxUvCqKqaQ/XDngxqGYiO6qUHaNptAjgG+jPZp53Z2LCQkh79jgcx2BZrejsp+fxVI0vUTFGlsdjN29KhBUZ4c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:38 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:38 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Sun, 23 Aug 2020 21:50:12 +0200
Message-Id: <20200823195014.116226-7-Filip.Bozuta@syrmia.com>
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
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7aaf28a-561d-4705-0851-08d8479dcf12
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB6143E4C54268C2BC0112D9C3EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epJ/173EVvwGH1/K4qvLfE+7wLJqe0hXy1ViNzen2Ek4IP6ESyhyFCpsNSoOZ90CuPrRmMn4ScpXPQn1N6CD5P4/qd8oXycy1QjXrIzDKpF29mJ590X6VCoTCwE0OcIDLBt3I3PGQdc3a5yQJGSwM94u0Q/6GJef0GjwO/qR+ijwALMuD/kM5OFIGqalNaQC4bLF3ofLSXPQa/XybN250Nzv6K9bX4ewTDAU5q5sdr1BYkfCYReoqbsdUOtTA5QsgzHeeIlamfEqM8m6SAIzsRlec0tcqQ3ub2TrL0hCxLAjeiZbiuucJIHC+znQuL8LomJ6nhNNgr/1pgja82dM80py8mwx717sen3vqfI7smgVxkbVBQJYKIY2fEAGtByK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(69590400007)(16526019)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: R+vmvV6fVaiUwmmH+6goePspSOe0jny/cAbG2WgqeS/sFhX0FVVos3GKibk53uViO+LoWUFZEQw+I9XLlMkhFF4+xFJDMWV+1N3mfGzCJBcfUGaHQbgic5BM0ZEycfjTWg8XKefXCTqcGjD+63ejyhizdFgDFoH3CPhKYsh4tpM7QW2iNsiti84hkFMD+YypkndWB/jil5S8RlUdP5TkrV/FwZMxKFGl61Axr3pecQKkfUuPEJDvGmO4Zk24T4x/fkQylN31/wUoYuQVpde1pQQqWGUDHHKgtk1yRm0NeqTH+joVLFOZqcTbQOpf//avXAGfePOP28Upn9QkFQTh1hR1uMQJgGOOFzz3qSK1/Ci7AFq3pu4412xamjtPi4Zv8i9rCaicC/dQ2aptbtDTmE/Iu7hmOkQLsIkGTZnh5lqbR8i7/gnsx8VtSk7kcEh1N2l1yIO4oF/U+WVu1MVvL0ERoSC8o2aAkR/w1SBNW5RC2Ac5l6bD5wSk+2Ow6+yKkkDm8eYA7BnsxUyRyMqja9UAZRkoeBabNmLa5tWmxI5YdgN3tdYHDx0L8ekZHMIytdyNWRM8XruGu8V5+UQpCMRxTAHZ587/9YHHHBfCr9yDuNXinO8KrmFHD6Xsyklutdex+/thOEbuo4uxYY4h9Q==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aaf28a-561d-4705-0851-08d8479dcf12
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:38.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm2sgKmtL+KD9bDfMBOek6KYfdoQraWtUDji+bEsc65rXw8uwe8pu5bnNosaNfqJN9ltX+MoNrzf3SeqOxfB7Q==
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

This patch implements functionality for following ioctl:

BTRFS_IOC_DEFAULT_SUBVOL - Setting a default subvolume

    Set a default subvolume for a btrfs filesystem. The third
    ioctl's argument is a '__u64' (unsigned long long) which
    represents the id of a subvolume that is to be set as
    the default.

BTRFS_IOC_GET_SUBVOL_ROOTREF - Getting tree and directory id of subvolumes

    Read tree and directory id of subvolumes from a btrfs
    filesystem. The tree and directory id's are returned in the
    ioctl's third argument which represents a pointer to a
    following type:

    struct btrfs_ioctl_get_subvol_rootref_args {
		/* in/out, minimum id of rootref's treeid to be searched */
		__u64 min_treeid;

		/* out */
		struct {
			__u64 treeid;
			__u64 dirid;
		} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];

		/* out, number of found items */
		__u8 num_items;
		__u8 align[7];
     };

     Before calling this ioctl, 'min_treeid' field should be filled
     with value that represent the minimum value for the tree id.

Implementation notes:

    Ioctl BTRFS_IOC_GET_SUBVOL_ROOTREF uses the above mentioned structure
    type as third argument. That is the reason why a aproppriate thunk
    structure definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        |  7 +++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 13 +++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 169f98f7a3..728880b9f3 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -206,6 +206,9 @@
      IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
 #endif
+#ifdef BTRFS_IOC_DEFAULT_SUBVOL
+     IOCTL(BTRFS_IOC_DEFAULT_SUBVOL, IOC_W, MK_PTR(TYPE_ULONGLONG))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -248,6 +251,10 @@
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
 #endif
+#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
+     IOCTL(BTRFS_IOC_GET_SUBVOL_ROOTREF, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_rootref_args)))
+#endif
 #ifdef BTRFS_IOC_INO_LOOKUP_USER
      IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a6a9454b85..1d0bfb5479 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -976,6 +976,8 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
+#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
+                                                           abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
@@ -989,6 +991,7 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b84e14235f..5566d101c2 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -431,6 +431,19 @@ STRUCT(btrfs_ioctl_dev_info_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
 #endif
 
+#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
+STRUCT(rootref,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG) /* dirid */
+
+STRUCT(btrfs_ioctl_get_subvol_rootref_args,
+       TYPE_ULONGLONG, /* min_treeid */
+       MK_ARRAY(MK_STRUCT(STRUCT_rootref),
+                BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
+       TYPE_CHAR, /* num_items */
+       MK_ARRAY(TYPE_CHAR, 7)) /* align */
+#endif
+
 #ifdef BTRFS_IOC_GET_DEV_STATS
 STRUCT(btrfs_ioctl_get_dev_stats,
        TYPE_ULONGLONG, /* devid */
-- 
2.25.1


