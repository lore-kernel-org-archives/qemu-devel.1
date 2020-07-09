Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27092077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="GVjTUsTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27092077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYtH-0005NL-0o
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr9-0002tZ-29
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:53:03 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:3260 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr7-0006dz-1A
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:53:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+LDxif9TsHQJ7ygeMRteY4vJtAZ9rFNIwPVAFYSUP5zwGk8bnDlmvjpdl+pGnjbc+pgWtxYOmcgD6/Add8ntYQ+wrrxxLdHOk88YEtQzOVKkYiCWwQQ9DSuFZ9cvVVro+/E/e45g6oLpwJretq04MU1uHFkszLypRgwWjlgTafrFibbQcXHikFEgwSiTZUs1T9JB+LX1xeNChrVaeOvgBwE5KWFwuXdAbhcZnQHzdhrp6QqDkl9/bT1Q0zpgcWFBA0Z7Xg+RV9+85KmkKJ0gibe7dGa+ui1Jyg7/FlJDiQr7NH9NLUjxWFE/NgVlBG3Yu4dF02iRA0X6AH9+rO3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfoaKSfdP+I+cOvQUxQemrNNZOo1EGm2i7J7QyBhX+8=;
 b=LeXhZ8vm4zJDCEPPM55U20xgCVjwqCWBaPP/5ADkkJblGqxTKGUTkGAYoPVuqoI05y4+XvNIL9f06nuH7021HfHaZLTfzqEHYk7P94UU/njrbJjsDsVRxnq1yLEfiTO3QWzjXPm4GXgzHM14DawHPkkHUn9eu4l7jqoPTJCUqgFqpDYL6hMKRJIumW+Nby6iqeVUjp0KKuv2FcHhtJcnhcreBRC+lzWGE8Ng23NIw+u2FG0arHkVkFq6akUOfXSUIuCyztRMuYNJ0m8/FkAEQ4YEoWWx02g0q0mP9e1CPwEaTDbyKUB+AATZMvFI6hxq6hEJ04LPYSFFS5UV1zxhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfoaKSfdP+I+cOvQUxQemrNNZOo1EGm2i7J7QyBhX+8=;
 b=GVjTUsTeTp+INGWVrnNu7VwyZLppt8CJnYXPKZ9dToKe6VJ20n5zLtX/ytnXZqeWas6BlWpjW9A/jV6Y3vxWIxXuABFBetU6jtg09N2slhWgfgYHjR4IxfDaxvfcw3+bkyXEpkf3zVbetGgiIRxO7MKoz1DmftjdQIrmvyr8uXw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3223.eurprd03.prod.outlook.com (2603:10a6:209:1d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 9 Jul
 2020 15:52:24 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:52:24 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user: Add support for a group of btrfs ioctls used
 to get/set features
Date: Thu,  9 Jul 2020 17:52:03 +0200
Message-Id: <20200709155203.21106-5-Filip.Bozuta@syrmia.com>
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
 15.20.3174.8 via Frontend Transport; Thu, 9 Jul 2020 15:52:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [109.245.225.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ddf253-1b00-4645-24ad-08d824201257
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB3223A2B9A67386D6A49B8416EB640@AM6PR0302MB3223.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpSXjQcM3vUBuAI8VnrP2jYePfpsXikC1zKff52tPOhFuhmTSs4sHLtkvUlY3g5zL7t1nudizyV9JKTWwHC+01OhOBpxOOnxRIQEvbC6As9IiYJ0sWbWuz9CNaOB5PHf1I4U7RxllktJkU3Pdm56hqgz3+laYBIGArx+q2R83tFu4ZalO0A8GNavJgvs+2CZt+pQVyEniP3zWWp0Tp2NvybFWmyL1l0SwhyfoMkSC3kWcVbIw5m+sHjkAk/fETbWZ0RgzanC1tApP4BEKSGcf2DBxUBH4BBYPWel1yeUrc5u9HDnljyLUEICNLGiTLEJDbhZVqCLL4NZjpgkzEe0icIX2S0zBd60SBrjOjyVmAptYTC18P5oFoqqYn8Ld4CNQCAzMLeyGY6fsRwyOgqG7IV/w96KiI/lhiipXZNnr3ylt1i28P7ZxgezAfHpumz2OUSyS5z5FVVD+9hmIB7U6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39830400003)(366004)(136003)(346002)(66946007)(66476007)(16526019)(186003)(66556008)(26005)(36756003)(52116002)(2616005)(966005)(956004)(6506007)(6916009)(107886003)(2906002)(6486002)(54906003)(6512007)(86362001)(1076003)(4326008)(8676002)(508600001)(5660300002)(316002)(6666004)(69590400007)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mqmMjRXDFmMs/KPhZg1oPgcEHHghr63qXIfmoKBM+Iqwnf0Pi2c6vu6cKcp0HQfg3Fkq2vZUjlwXtMON0AGQFFZZlOIwt/34E6VP0qMlOjzvM+9YTGQJk/78uxh3PlVYE4kEPgkim3mrvPX27xqeGmy4d5RJvi92Z8B8HKwkQMKzd9TJm6gLLuIU3We3xBCwZ4ajDE1xvl145NC9Cxsg3YN+o6R5RZ9Lk+4D65OcFk2B0epgyiXU5g7Ai/jHERYTllpUZXdjm+wZbEPKXbF9C8Qq3Hi0zIrdTFtJOGxtNq1L02u6VOEprqIs+9/3VbYAFSYhok9tRthsJPV3QdghSTglnesRJGx0aGDQOmdkpxY7HPd5oOQp5OQAgP4deKXSvInHCEj0iC5XNQxYfz7cXRmwPOAq93v+8fPY0o4QtQvLqNoblyin/RYta8lIY7BGdcHB4o6zMOWAG7jQeMDiEWrs4TA03YMJ//uIRdt0uOs=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ddf253-1b00-4645-24ad-08d824201257
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:52:23.9908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4aiMQiFo1ZJf9h28YYEt1jPRI7qT5DqgK34j8DAOL2zKBfH0qzKXf1n5M0LxHkVIV50kEsvTAwXazSrSZpF3Q==
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
 linux-user/syscall_defs.h  |  6 ++++++
 linux-user/syscall_types.h |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c20bd97736..c6303a0406 100644
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
index 20c03cd145..9db6f46cba 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -990,6 +990,12 @@ struct target_rtc_pll_info {
                                           30, struct btrfs_ioctl_dev_info_args)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                           52, struct btrfs_ioctl_get_dev_stats)
+#define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                         57, struct btrfs_ioctl_feature_flags)
+#define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                       57, struct btrfs_ioctl_feature_flags[2])
+#define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                       57, struct btrfs_ioctl_feature_flags[3])
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                    60, struct btrfs_ioctl_get_subvol_info_args)
 
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b5718231e5..e26ab01e8f 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -365,6 +365,11 @@ STRUCT(btrfs_ioctl_get_dev_stats,
        MK_ARRAY(TYPE_ULONGLONG,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 
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


