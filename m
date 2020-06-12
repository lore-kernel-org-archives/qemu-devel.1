Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF38207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="QnU/K7TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF38207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmkV-0007BQ-He
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjmjf-0006Wd-Ij
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:40:55 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com
 ([40.107.5.134]:25837 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjmjd-0007g9-DW
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibt6+y7fGF+s+wxGr+bOPyxLQTXDb00EBrjdDPv1/z8niR6bAlwIVlP1NxgCfNCFARBLZE7Jtf31VTLD7CQ8e3tAT5aMtDA3XsDXoDVmJokB0SHFHXXBwuC9zJSMzOJCjQwdSdVAL4lZ7CgtN8/R6fsnJvE1E1aRMOwB4idbT9hEosxuA8NM6nRu2yV2egAaTjxltwD0nG6wwNNe/nXlYOmpznhXh6NqvgkUaPHkt2Dj2yeQsIxiU069bOBqC6dG04xACxvb55btbeD+GjsLyPuDtNs9u9881Kf3z8+QOSil7n6Ypxgm8FNXyckTVC2m2DZhBJm4/XBD/Jqb5BZitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/D83u8MP/6De2mojCuZdYBZpjqTWXoK/aHqMgf0uR4=;
 b=HXYXBMAkzBbudRn1NkfPE/BlE4SgdDBN/fPjVlBiegipyrzvjMN+RhUol4GZUb1H9ghJlqigu0dImoCfqgvg4mUWtGcH6cx5HuPETRPOkp0NZIQYfm8Wib3r+UkaJE9zpLwCf8pNvaaXMpS/KKx7pUNaif/NUCD4CBxlkuk+iuOnZK6lGjHIA4gt1qf7db/M75R2jV7SN//d44Dt7yfu7JcHv//Lt6gEUjouqmH6hcX+jPvfQQ62p+ADAl1VMDn8VJ5mZbAILanfOSXkmzcGZOuPPcGvjlzsY4N0Iu/NyqIC+HAUudf9KWalKJAP8xMOXaA9BW6cjZ+XRxein32wRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/D83u8MP/6De2mojCuZdYBZpjqTWXoK/aHqMgf0uR4=;
 b=QnU/K7TJAD5PRasD5ArtrlwBa+UcGAZg/BZOyj5AClW6DObeovBONBYErQijoS6qPD7pobAyBihZuAOmNVu6utssd3BmWmIYtQmPCugkAssTuceyEcS0zLnYOAcUD9iTQwCHlzHusSPsJAP84TRNV45nP1Qqh4ru2VCyVkpZhGk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4072.eurprd03.prod.outlook.com (2603:10a6:20b:24::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 16:40:16 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 16:40:16 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Add thunk argument types for SIOCGSTAMP and
 SIOCGSTAMPNS
Date: Fri, 12 Jun 2020 18:40:00 +0200
Message-Id: <20200612164001.27405-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612164001.27405-1-filip.bozuta@syrmia.com>
References: <20200612164001.27405-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::24) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Fri, 12 Jun 2020 16:40:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a63c1f-4eb5-438b-773d-08d80eef4958
X-MS-TrafficTypeDiagnostic: AM6PR03MB4072:
X-Microsoft-Antispam-PRVS: <AM6PR03MB407223BE18C5352E13E9EAF4EB810@AM6PR03MB4072.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9/VE7EInpfMqNNTFfMpy/EPpoGTbIC8u/yLcpFyrao4s3cOrvkbYCAb3Q4r+XBSGuAdKE82tKQoPdt1Te6x2yJzAlSBW2mE35IrbqqzvBg2NkdfRMWlVhC7wpL7aUS64yDPoictPiSO1UfPlMbf1Qfs1yLlSkwmf3JSccS5LMpJU1B0Qian3Gpx6+uMyv/XT5yoWiuiU5gth2WZTwvKOjaZn+pUqHZ+5AnkOnMqGiMsUhLvluwK69vCRfTXFPJvyl4xMZPHEsXmFKQ0apQaw0pZOhixYtjErdY3TSTBUVL737KZ1PAoTTWfIGJqtzjmf8Shejfwv4aLioRzKSdSbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39830400003)(376002)(396003)(366004)(8936002)(66476007)(86362001)(2616005)(52116002)(66556008)(956004)(66946007)(36756003)(26005)(6666004)(83380400001)(508600001)(44832011)(186003)(16526019)(7696005)(316002)(4326008)(5660300002)(8676002)(2906002)(6916009)(6486002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 79qzpJ6So8l1RxkK/lIIK1G4xHTyrhIVLpznupsNlAOn7RDERXTYAHTdu+we6uwEUksT/7ZozPiYba1NpcbGMpYcz2F3fafUa0nR2MJgADrzTJ/4vQQTfHSJ92tB56nupWmnzpBVnI0T0ifhaynnS5G7PpS+ZHhwnLHTcj0PYiZnT/utQtvNk6jyTUy0FlzDCbOAZ9DnBbJxWWB829peXDU+xRxYKmS3XT4kRvgftSPu1ZnNTUK+8GqwIUqiGgGX/vKmrxCmFdR7fseFpFaaosZEsu+sEKkgLcBngJkUzjSu8D/V9C518rxDSIfpoo2GeGeR5tnIvK8WyBQ/NMcBRVtLJHr30sB4WXY+DD67tIeTYIT70bfgUVWs3yilKwPI74xq7t7IiQHemsgpY4lANx013gwaLhUDVonRXmHLk7EZsFFHpfqpvPyrKZewpNGktJorow8ao8CDLRAOPeXZYxarb4ULJiSSccN/KeOOekw=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a63c1f-4eb5-438b-773d-08d80eef4958
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 16:40:16.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUhUuHAJm4V0EGIqUsLdpVDkx+Ah4YxjMPNnvPSGIbBOEBYDEQFTUEqx2U7bhWHmDL/A7Glk8sGBAPyPXH2Oag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4072
Received-SPF: pass client-ip=40.107.5.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 12:40:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Socket ioctls SIOCGSTAMP and SIOCGSTAMPNS, used for timestamping the socket
connection, are defined in file "ioctls.h" differently from other ioctls.
The reason for this difference is explained in the comments above their definition.
These ioctls didn't have defined thunk argument types before changes from this
patch. They have special handling functions ("do_ioctl_SIOCGSTAMP" and
"do_ioctl_SIOCGSTAMPNS") that take care of setting values for approppriate argument
types (struct timeval and struct timespec) and thus no thunk argument types were
needed for their implementation. But this patch adds those argument type definitions
in file "syscall_types.h" and "ioctls.h" as it is needed for printing arguments
of these ioctls with strace.

Implementation notes:

    There are two variants of these ioctls: SIOCGSTAMP_OLD/SIOCGSTAM_NEW and
    SIOCGSTAMPNS_OLD/SIOCGSTAMPNS_NEW. One is the old existing definition and the
    other is the 2038 safe variant used for 32-bit architectures. These variants
    use types "struct timeval/timeval64" and "struct timespec/timespec64" respectively.
    That is the reason why corresponding structure definitions were added in file
    "syscall_types.h". STRUCT_timeval definition was already inside the file as
    it is used by another implemented ioctl.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 12 ++++++++----
 linux-user/syscall_types.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..68d43f71cc 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -279,13 +279,17 @@
    * FIXME: create a macro to define this kind of entry
    */
   { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
-    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT_timeval)) } },
   { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
-    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT_timespec)) } },
   { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
-    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT_timeval64)) } },
   { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
-    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT_timespec64)) } },
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..a5ad5a9ddc 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -137,10 +137,22 @@ STRUCT(snd_timer_params,
        TYPE_INT, /* filter */
        MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
 
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_LONG) /* tv_usec */
+
+STRUCT(timeval64,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_usec */
+
 STRUCT(timespec,
        TYPE_LONG, /* tv_sec */
        TYPE_LONG) /* tv_nsec */
 
+STRUCT(timespec64,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_nsec */
+
 STRUCT(snd_timer_status,
        MK_STRUCT(STRUCT_timespec), /* tstamp */
        TYPE_INT, /* resolution */
-- 
2.17.1


