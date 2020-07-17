Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415B7C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EDB20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="ubv3+rXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EDB20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRd9-0008RU-6T
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbl-0006mC-IF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:05 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:52288 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbj-0004y5-OE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opn2QAcAlnH5VJz3LRSBscV2XUJAfgReMLgmQWDGyie8JrL7P5xbHE/+/GEQCNM20kIrPPNK4DyDADx9fxtoGAbacsqWtGvRiaqR/zUCuIBdnvIgLo82JVlqe1d5/pM67I/Yt+ggvWTPt89cMaagTjSo1sSs7W5NUWyNPIyIJAu80bKyIbhxky0TM3uUEa5963lF63cbQBm3KlJOriJIkmT4y9YDyX+RZsvUik5zxaGzvYEQpEeoz0mNCuVxLRFSdB5kVFawEul0fVGRtGKO8aSzGjNh0Y+jps8KT1Zt9lUACr1f0mezg6HjDDpFdg+zEhwlGns/0mX07E/duDvNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlNif+Lsvzu+GFEQYqv/nNx09+o/yvx9BMWNNBtZ/3k=;
 b=AkmGpozvoMkgQGlnUEAP/Q0KwJYv8oDtHd3ApFSne3YiDLa62oQpAvSUhjCmk8ugUkMjIpa8aignsrV5tFORq6Puc8Un4LZv7K5IFPMqOy7FcIm5qVbAJx4JLKWECJT+tmws0Y+5nH2OBfLlCwO9USzzQGfYfXHmso9eivRiEmd/JyQYaKgKfRuiBLdulbTO6aZvwk0A8bw86RqhH3gVYW4/O68IvMXO1ew/ngGiWX7FQ32VxLS8/UT1q+ay7OVUQTDX6XDPLiZbBDy2IkCJxKxLYMwHevYP9N/CXgrDzxaJqsoQUf2YnnPBHbkIibQysC78nnFJ7OoTfGci0M8O4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlNif+Lsvzu+GFEQYqv/nNx09+o/yvx9BMWNNBtZ/3k=;
 b=ubv3+rXWU+30ZfPSnRuWpyiiVFG4vKcjxg+gAqzMP4hD6NHliExm+Dqn02jKYUMi1cF3ETzCgnsC/a4ctn5r5FZMrpOOvD9USUG77JDKP+kx5Qr7fGRf49ADVv6bwTfLiBXdLvtxPKDnkHtba0Ud5+EKbc7npc1eLyQcIDjFkK0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6414.eurprd03.prod.outlook.com (2603:10a6:800:19e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 14:44:55 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:44:55 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Fri, 17 Jul 2020 16:44:33 +0200
Message-Id: <20200717144435.268166-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
References: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::15) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 14:44:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd502941-c4d5-4bbc-e2c0-08d82a5ff854
X-MS-TrafficTypeDiagnostic: VI1PR03MB6414:
X-Microsoft-Antispam-PRVS: <VI1PR03MB64140EA59084027C45F9C1DAEB7C0@VI1PR03MB6414.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHlJgYo4KM2ds+0Dg4igXjzv9qFTeHv5tBcd7sN6lXiuwkozjNg/AfqQlZvB/I+/AxSoMVbHA7OjIPBXPjIqqiN4tA50Iu1nPObZHtdQ6W/UT7I6IcCb5zgieSOWlr/cPgCV6G+NSreF7LCPKdMud/Y1fsqiQF8Q2fXt/sqDE4xOAK9xNgVYEvNrj1P56DJ+NpTMENaf3Um9IlaJjpBJNRO6+eoyErQ4LPK/vcEOtMQ/210F/Jsy/oo0HeiL7aQAmk5sElB/Ybl7iPE0y3DoXEf3i48R1ZTzRtSW4qP49/5NNAit8cbR8xZj1hJ2XjbT/YDIrb4nfvHYbKzJ6NIysM5OrhgNDQx4pFi9jY8wld0OXcH2792hRAewd5Mfj7tJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(136003)(39830400003)(396003)(376002)(508600001)(66556008)(8936002)(8676002)(6512007)(2906002)(4326008)(66946007)(66476007)(5660300002)(26005)(186003)(956004)(6506007)(316002)(6666004)(86362001)(1076003)(6486002)(2616005)(36756003)(16526019)(6916009)(52116002)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: euTAeEEKmVN0XkuoCfpLayVpEnd8S7jxvwTPQ1zFftYgTSJqHObFFMB4VrXPVptqKFGAAV8Kkl2ZPhWFWcye4KIkdPykspHEWGAU6Rc9uCBTEqNRtroJd3YB4FlL+e0tZ01t4nRDq51XXHUf48RqgavLKh/qnmcE7REw2g9fDEpHd9RoTc3TPv9n2xF6z2WgsSrGsvAMYOxDoGVkVcdUaBgnkt9Bl/428oK7e7bfWQEqTZImmqyxrcHx/v3gFXbkEEJkD4C8ERoCfoP10j1qsriNzkiJIXIjZOHpe5bk/7J4pVRVs7hX6PegssZtPFhRpvddKR7ZsuP6v1B7Lc1AHrFDXn+ucQXsBvBVUmaWV3bWmQTVnPLnjzqGRtzywLgSQgSoPQlox9ebGJVmog9xt61wnX+D0fjDM4zD0Ydg/MD0LSJpejc6LA3uiFOyeTwg6otzUKhX92P+ms4SjLC7ngNRbdVQ5MXRbTuBJl08eIk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd502941-c4d5-4bbc-e2c0-08d82a5ff854
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:44:55.1816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOwBJs83XI12JXIaPPLtSxHnG+KB2CBbMwVXVhXwpsINJKFnFexlHwuyHVJ1w7zIgUtSip0epmsXPGE/PXyqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6414
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:44:54
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
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 22 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index a7f5664487..2c553103e6 100644
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
index 7bb105428b..f4b4fc4a20 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -984,6 +984,8 @@ struct target_rtc_pll_info {
                                                15, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                         18, struct btrfs_ioctl_ino_lookup_args)
+#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                                           19, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                                            25, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
@@ -1006,6 +1008,8 @@ struct target_rtc_pll_info {
                                        59, struct btrfs_ioctl_logical_ino_args)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                    60, struct btrfs_ioctl_get_subvol_info_args)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                61, struct btrfs_ioctl_get_subvol_rootref_args)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                    62, struct btrfs_ioctl_ino_lookup_user_args)
 
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 980c29000a..d2f1b30ff3 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -381,6 +381,17 @@ STRUCT(btrfs_ioctl_dev_info_args,
        MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
        MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
 
+STRUCT(rootref,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG) /* dirid */
+
+STRUCT(btrfs_ioctl_get_subvol_rootref_args,
+    TYPE_ULONGLONG, /* min_treeid */
+    MK_ARRAY(MK_STRUCT(STRUCT_rootref),
+             BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
+    TYPE_CHAR, /* num_items */
+    MK_ARRAY(TYPE_CHAR, 7)) /* align */
+
 STRUCT(btrfs_ioctl_get_dev_stats,
        TYPE_ULONGLONG, /* devid */
        TYPE_ULONGLONG, /* nr_items */
-- 
2.25.1


