Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06312C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BDA22D2A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="GpwnuCui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BDA22D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwR1T-0004tD-2U
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0S-0003fP-8h
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:32 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:44942 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0O-0005Go-Cm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvdUIsD+f2rZH29+Mp2l756xhnouu+8A17VtC9nRgQ6X9esDQi34ci3bB7i8X4NIv7kMJmX4wTOVI6ErP+x62Tiq8gSHccmjSpXGIO8JQUibNOOqZ7L03nfVj1ZONKglYWBYOOJWxE5cKIgl0qEwZ4X59x1iUN6XupLByx3hejmQR0iePKrDumAgNPn+4+PTI0mmiLMTpyzTBtpw9aE8CSKLmdcOGFFR/YN0BEZAbewk7C/YjrRGbpYTrGTeC+3b06j6iODrm8BA+VEMkj7guHFrDcf0UBVWBQTGTrfKmoVc5onWHqcEgjYWfNmL8hpWNFGRb8KyuUgHQDsG3bCoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inke6FYYZsdCMuToWXbMgGmtZA1DzE/VVxDRLLLLh2I=;
 b=Q66MVt0aqJBxcsmrRo1tq0DFSQtObijVwEiYxoKsObsj14gMJqyRKS/LSJeQU1iQOTzeEf0LlpAJFfVOfRKKQ/yyvPdx5wfDWFYIZ36eDeJ9ADnFsYDC7Fbw+IDHWvTzKF4lxfeYvQ4Rfln+y7ZC3T0TgUPpLMvpFJ/3gy95bcSDsdAM3LAphuq8ISxbRckY6ux7bo0Db8fXMidx9W9Yl7VRlNxYqBA/wlpKhfEMMNRdi5DNAxOuh5Ub1HaibmtYOtQSelb2cnYOdOWso5XtDNayUtaK+q26Vqw1BbpQMTK492Hkcgc0lrmx/v6b80AJoBsxiYqFalDFibu2vJAbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inke6FYYZsdCMuToWXbMgGmtZA1DzE/VVxDRLLLLh2I=;
 b=GpwnuCuirLNjEJfKE/DJyorEfVc6thC7qgH17quhKp9R7yfSYzLx4tleKelxt+ldtJo6otuXDaG0mxi1XgkqkRL1mV7UWQNEOg88uyZfc+H0AJcMF6wGxYQXeWInCshD7LODKBDEpjncP6u+A5Kckqe6DreuUz9BNyChS6cb2MM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5967.eurprd03.prod.outlook.com (2603:10a6:803:108::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 14:05:51 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:05:51 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Fri, 17 Jul 2020 16:04:31 +0200
Message-Id: <20200717140433.265599-3-Filip.Bozuta@syrmia.com>
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
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 14:05:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f6f1736-903e-45f3-9731-08d82a5a8365
X-MS-TrafficTypeDiagnostic: VE1PR03MB5967:
X-Microsoft-Antispam-PRVS: <VE1PR03MB5967355AD678C127D26F778FEB7C0@VE1PR03MB5967.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CSQNS2qcHp/KnnWculakvAB0pRD2vd1gUKJKRpCfI3qT2LAX0+lUQ42ROxxQlEIBpZZ+MTpzMztACF0o/QV1rA5xXk4MYfaq0Nqkg3FP0b+I+bxlkSD1rb9ZLdd8GiNKjjtMKgDV2u0AzoUbVcgORNcTnwZWn2mpQY9IbZTrl1xl9NQnIo5hIWSognQcAZJ15AZiKHAsly0F82Bqh+Xu9RGucrzPhcDNtIMRj2HPm3gBXBstpmeAw+LJKDr18BLuPWlVAAriWQzeinn76mYCXpIf4+OQ/+EhBLXinLH/Mbq8GfdaouI6dZg+OLkVnp7ZrnLR3deanOAm3snpjXSW0llbzajgRy5ZzT1Sv5cyjENicg9V1AC7PDmouxBYUbI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(136003)(366004)(346002)(396003)(376002)(2906002)(1076003)(52116002)(8936002)(66946007)(956004)(316002)(66476007)(36756003)(66556008)(508600001)(6512007)(6916009)(6666004)(2616005)(69590400007)(26005)(8676002)(6486002)(6506007)(16526019)(5660300002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZgXPcKKwv8Ncmzq8Ufn4GztpNp5/HL0o7pk916IXaiSdHotDS6NFdTAjSGb5Ndg6HhwlrfZjPuuSoAyvvM9RtXxX4zd0u4iecdxucHRtN6rxO1uNNUaQgDkV/8litnovkUZp7IUfICs045MlbtwjJ8+tKU3ZltIQ70A71l08MXMA2pag3sQALuCE/U+SXWNIGEXLD5I5EayJyrYFRHG59CXIgNrQQDFB+P9zavUzDLxa2z8eJxDRuzC+m4PfOu4QwDIgVFv0C8ujj2hPZU3VGzljs7/j/NM/BIL7Q/WQvwRwDY7bdPF/0l2Q39sQ018h3B5WiAG4tNUzrTEkjW6eIEQ9b6b2mI9arbKNsPkoblk0e0Qy+wUL91yC4pW+IF1r3ggslk1fHHJOQzMZTFdckBS9DtO8bXDs6tHxm5xHyfOsonckNr9bxNbo/5TRh1PDG9MaM8Lh3p8Sig9WvIGzHpxJICGZpuMn4yWPYUp9fNk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f1736-903e-45f3-9731-08d82a5a8365
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:05:51.5390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvtBlb9cNddEDt6/KJI2q1KGsBqehWrg1WZfbTJ8hG1MyHzIb+Q673Xmo7sSHZd/pTb6tF9Ld3rZm9dgv1soUw==
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


