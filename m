Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160E420578
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="zIdoyzco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160E420578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X6q-00027B-34
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3g-00044e-UX
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:04 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3f-0008SR-6L
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU3osbrkRExZC+IwU4+BtIyuM0d6CJSzno22SnxaUPcPTGVAfgMuIb+06QklJWkePj/0/RWnFta7ysrReGU3W0fSviaQjkYhcfHLmPgrKfT3nWDJ0vrggBOcRub6TpnESs4Qs3lAfB/JvE0vyBCm1DNKRyYiHuK5YyBg8sP60AUS9Mqe/tgLYkssmytEdqjD6kujBK8h6T6vM32C2SMJYQU402pnTaYiCltMgc3d6LywdcOkIjdS1iSbiOJDaudWmjvePbFn9Px+bg7QDCQ+Ok61amWkoXx5yit4nsUTstlFHWH79kmfmrbl5N6p0WGYGutoi6PwEYl6TAMd3jrrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU2VpYzchRAcOrJyHZQWVTDkaK1yLepwx0V97YQrVLg=;
 b=TB5T3UPwzTuOTG5Bdkb2RK+G7q/ayzxK9abtM2mht2dqNRHsiqSbc0+GorR30ZRUu1f18PbpFYsyYQqLciwK//4tyA3+r5AI2/zie3H2LqdkDAK1X3kI2F7yiDW2c0RWtHIEHeiB3M1R1cVU7dNyfIiBcsB8448G4aTTuEyzHE4/HRfe5nylb64O2Gp4tBnQJBVsxdRmoy48E/EVM01KGHg2+q/ra4LvFRfnRoKXlTq/STkbtkqMUlyTSc/gz3StexGty9uytwwlh3oEO45zI8kA4uEl6WXoay1sDOTLoo48krtQRQn3Ru6k+O8xbBTgaPAsvt93l6T1BA+LQYphBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU2VpYzchRAcOrJyHZQWVTDkaK1yLepwx0V97YQrVLg=;
 b=zIdoyzcovxa03zC6puRzQFpKqcwXH3h0DpUWC4zKBs0ZbeykVMuR9tQNu8F+MQ6Ycq3fam+eUYy1pW5MJKVJC7i1DRFPe4KrMcEHfTPht8funpgUVSj21oVwp16wiySQglZWCBkoMvCPR+rjcFLf88ox3aU+Nk9PWZekTpe7VmY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:49 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:49 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Mon,  3 Aug 2020 11:46:27 +0200
Message-Id: <20200803094629.21898-7-Filip.Bozuta@syrmia.com>
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
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850cca37-0bbc-4feb-e50a-08d837922477
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB545796A0488D7C82AA1B0979EB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2zn+n0S8VdDlxyYNNncda0YSklJ/72p2ne3bXrcrBO/ysSip/6Tm0MC1ZmdWufXPsMa/LYjU64Gq54Hcgi0uuMd22PGxuzRCcEgB1V1wQ0vYGYNQpucJWlDvv+YO5dRrYT2M1vDSVKi0+H80YprpBVwinPyxQOMk+rVntF9y6BOZ66LT5qw/rG2BGauuvza2X5Ar46kUhtoOd4SNQX8dhQEe2Imvy+O+dNmAETtETzh6nmQIDi7e5NCp3TlQI/epi/V2MpQ2S6E3R9DNNiVn/xyz5Wu9TLEQTmAMHqiKsaIfg6T/sjIwCX3iWl5u/yl2UoSIbHWv515uB1dDNp0+9KXHVb2Rg0Dt3qndNTUeG3Zhbqc07d76RLtp5p/5jEg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(54906003)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /Nl/ujqM6egRqRa3EcngB9rqU2DXJgslqm73x51aoEYD3+2VwDijJMOWvqHHJVrLSsyn/13wyiwNGmocNRMpML+B4aKK3MfUqYu8bmGOL2VJN6AZxtOfyeRvFr/p88/ximc5Cgkq1WP7aGTZeFv+wl+sDHOcASnwoYkHvdhp3RDRgaW/0WVLNjABnJjI6gWXJwK+Rkr6RNZXZ3R9AjlnzqGh2P1OdVCn16G5f9OC4psa5ejliLke+FFOViETFWe3id2n9PmrHBn5uZaihMpnY+ioU2ZzSjOqBm+iJpKa/oonSNrJoWkN12aDfK9Ucgmpak7LQvPeErVDVUqpfqsDCcePJCAPm33fpiaKAVsLHre2f5JKeOHBGGukToWxIATlLS7kTm7ztr6oRmPHXdBZ8QJDPuLprLsb6GqYHfk7CHaq689VTz04Q0CJEdp8Y52thrm6KPRqYfiUNNW+Lf1G0LNBWD9qRaJk9xCtqD1M2DCdg0rv8h9CuJUDM6iIfWgf/b4KThdbcOzv2kGr+UPwpUQk5YCAVtQTCIKKgZSNP45a1cIObPdaid2JIytEE10lJpn5mgiiUnEAOqlK2hVb1UIW0/KcBqgYtYwzOqv9I/S28objpVM+u/3lj4+aWHbegq1BSiWlvEBP+kXqc7NCkA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850cca37-0bbc-4feb-e50a-08d837922477
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:49.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTl4/PI7NPbw5Do/Yf/y0sDYlmh9q0jmIwn+tsJt28f3GR1SdokjJjG/QVk3BcB6x/qDlBmo1YZPbwdyjPyY5g==
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  7 +++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 21 insertions(+)

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
index 538b884b8f..f1718ac521 100644
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
index 978f2d682c..6bac8f46bb 100644
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
+       TYPE_ULONGLONG, /* min_treeid */
+       MK_ARRAY(MK_STRUCT(STRUCT_rootref),
+                BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
+       TYPE_CHAR, /* num_items */
+       MK_ARRAY(TYPE_CHAR, 7)) /* align */
+
 STRUCT(btrfs_ioctl_get_dev_stats,
        TYPE_ULONGLONG, /* devid */
        TYPE_ULONGLONG, /* nr_items */
-- 
2.25.1


