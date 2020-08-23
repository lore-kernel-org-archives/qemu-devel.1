Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A84C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45653206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="nwrIHUe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45653206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w3C-0007Q9-Ji
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w11-0002tc-OC
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:56 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w10-0006Ij-0a
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVIh0fRJEYdtUoHhTN2kpC2dEN0s3IX7yMWxYsPEqOdT8/sJXYc5YdIYjObQa4TEyjqJIdMmDvY8TqhBZsdfwOy/S+FOb0dw8FrPU0hAijKnOox5xWbp5QMRNwrOdi2G3LCyAGlvMSs6kv6u04lHfQNNuh/5eGd1aZ1o4mQOSWH2akbDy4m2v1q2gToRO/L+z9roaMSj31BB+kZfI3MzVmTEFwcVzznEGPfLhWio+cHPcBCCC7SRuBYBGfGvP3bO3M1HsTBgEgqDClDTNTTFD8A85Y8ZyEQk5mVnhRDME/+lEwwBfLfJvBHJvIrZRF8EUhzfarPobqsRkO8eUWfb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceRdM53eFagBClB7G2OUNlVDzcVsA1yhFezPqlwXcUM=;
 b=VMAKpIeMz+kHy0goXSb9Rit05nBsu4bAXqzPmXtszQpnKLolyQwsnF4iNjtYvUm/jIcGVYPcqueCk2wO9w7nsZQ3FKRbPQb/IVzXIrealmrk7CiFbDUkGXxZvFTyx/xexwWrtg5Y4+H0TjnWmCIovqzE4AgjpnElbn/ZV/oPck9zKQbZKai2xn4ZMKmpdhQiyBkWi9BlYpqtcq/9hvkxg7sC03q03dpNRajnwS540rfW7jh5VPEqLy1DOLaYtzJHSDY9xh651G/J097/8dJLD4LFymJNCsrSmeRQnXuXJ4RO6p7vkq4Ij0q3cNCTOcd0/GApqdf0OBdRqH3v+4zucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceRdM53eFagBClB7G2OUNlVDzcVsA1yhFezPqlwXcUM=;
 b=nwrIHUe8WnoB84wORdyv0a+2Bt3YWc+hhe8iBLMQd26Rsx522hoQ3WnKvPUclw5GN6ISTzCUWcbJapZX3xgC8u58yzIK3XAXuJafiJg0y4TrccKUzWlURhNJdAwNECeVrJl2BBHpUcJl3sib8B9KZbn/lhGlQNK1iuJeHVgyg9k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:36 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:36 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] linux-user: Add support for btrfs ioctls used to
 get/set features
Date: Sun, 23 Aug 2020 21:50:10 +0200
Message-Id: <20200823195014.116226-5-Filip.Bozuta@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f691e3ed-5ea5-4f9a-d1d9-08d8479dce0a
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB61435E464E13EFE944735C21EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnI1P1xjztQ++Uhvy6+fCzjR/52iRwjzQr5UqAdH4Q8CmSn/D3H0blAQuzlxUiVvnSlFnBUuELoHtkTQ4L0YkQ+5zeYOUFuIRWS/3QSEAxgO6A7W7hO304LHmw27yGlQmUuPceanXSFE1PwYkBJBHRxInrtUx59fgKmDJMc/aa0IWJle+8yOYlk1ybvsVikih90ZMafXDW4NW64Vxm6HmTA1i8w8P2TFDUcoMM/6rctTW1ecRKHfdddrx6WcvRUEnID7gWjNlHt4qiXX2IVxtKALb0Tri5mTk99k46LdriXhGP8c8+CRUG5M1pe2PLvtvFjjZPTueLY9mKZE72QxvP7lHBn9AxMw2VLF7bo5+7NuTYM2ma+wCbtHFDeiMO0o4Nv85hR9y0tKJyQmCqIWV1Dw3P3iEa+/THmhT3MmIfIeWMsVBVTc+vw0ZkQ8g+QhEmWQonzsBQC/6E5Xfohtew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(966005)(69590400007)(16526019)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UtGggjWgxSigMbD6ERXfq8vxATKi0MAjz/nJC67pehrzuT5LOqxtaF+Lqex7OINhiz+36Ab84TFSspOU9olZlkhqSt+cdkmjGY0kRW0bO7mzuv0FsagFsRepkb/PzJtNww2P3lj8P/MXeA+KIuGT0BO0U1WcX7EzZ5SUdoTqpiXvbcTXP4Htr0R8GdkU5DuTdO31IZs7sdEUC/xoUmfUiJcn+8l92iJrdNVIS637W+Dh/qG8kZRGt3X2jVGfHwJEjdFP2sq4Ih+BJuPZw9klQdscdKIag0R6A5VoKS6FSWGtyc7Th/h8l6Cj0LMqtCzb8F51ZWB719OtZuNubTv1CY3r5Y6OR0UnJACtYnhDcf+6x8ti7cvdXPTxd3s3eeSnvo4gSF3YG33oz4oFpRHj7Nn+0+g7W/UOsJqq7M+0f1Bz1JplQkhbeaTIdtLhwtolgay0LeJWpEN0X+0wbX0aNBzMgIcgMsf2KzOKWC1KmrmEZfCfUouWn4BnPveh9OK8BqzLT/wpCqL0Hq6rK/CYs0b9mwM5sF+iGRdKPoF3J9yu5bzGi93bVJJ4M7eo/fI0A20gYdUTmmW62leU3JnedfuwVcRrRlPb0/bALksU3+yXRxkKSC9EPJPcxearu+HGEKyqpUw3Vn1cjO7r+D3+uw==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f691e3ed-5ea5-4f9a-d1d9-08d8479dce0a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:36.7896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8pRJ9lGZDQWgOvssXWyZn12oVfpOfDheiSSTxZHSgHk3RGwQmmVqVJI3qEUyvPsXZfd4OA1iGkUSR0izeb7AA==
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

This patch implements functionality for following ioctls:

BTRFS_IOC_GET_FEATURES - Getting feature flags

    Read feature flags for a btrfs filesystem. The feature flags
    are returned inside the ioctl's third argument which represents
    a pointer to a following structure type:

    struct btrfs_ioctl_feature_flags {
	__u64 compat_flags;
	__u64 compat_ro_flags;
	__u64 incompat_flags;
    };

    All of the structure field represent bit masks that can be composed
    of values which can be found on:
    https://elixir.bootlin.com/linux/latest/source/fs/btrfs/ctree.h#L282

BTRFS_IOC_SET_FEATURES - Setting feature flags

    Set and clear feature flags for a btrfs filesystem. The feature flags
    are set using the ioctl's third argument which represents a
    'struct btrfs_ioctl_feature_flags[2]' array. The first element of the
    array represent flags which are to be cleared and the second element of
    the array represent flags which are to be set. The second element has the
    priority over the first, which means that if there are matching flags
    in the elements, they will be set in the filesystem. If the flag values
    in the third argument aren't correctly set to be composed of the available
    predefined flag values, errno ENOPERM ("Operation not permitted") is returned.

BTRFS_IOC_GET_SUPPORTED_FEATURES - Getting supported feature flags

    Read supported feature flags for a btrfs filesystem. The supported
    feature flags are read using the ioctl's third argument which represents
    a 'struct btrfs_ioctl_feature_flags[3]' array. The first element of this
    array represents all of the supported flags in the btrfs filesystem.
    The second element represents flags that can be safely set and third element
    represent flags that can be safely clearead.

Implementation notes:

    All of the implemented ioctls use 'struct btrfs_ioctl_feature_flags' as
    third argument. That is the reason why a corresponding defintion was added
    in file 'linux-user/syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 12 ++++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 55a6cbeca5..50fae1e33b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -216,6 +216,18 @@
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
 #endif
+#ifdef BTRFS_IOC_GET_FEATURES
+     IOCTL(BTRFS_IOC_GET_FEATURES, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags)))
+#endif
+#ifdef BTRFS_IOC_SET_FEATURES
+     IOCTL(BTRFS_IOC_SET_FEATURES, IOC_W,
+           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 2)))
+#endif
+#ifdef BTRFS_IOC_GET_SUPPORTED_FEATURES
+     IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
+           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4c7bfa0391..44811fdcbb 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -981,6 +981,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
+#define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index ea6898979b..925054cfd4 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -409,6 +409,11 @@ STRUCT(btrfs_ioctl_get_dev_stats,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 #endif
 
+STRUCT(btrfs_ioctl_feature_flags,
+       TYPE_ULONGLONG, /* compat_flags */
+       TYPE_ULONGLONG, /* compat_ro_flags */
+       TYPE_ULONGLONG) /* incompat_flags */
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.25.1


