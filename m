Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C94C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2A420739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="VwjsVisz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2A420739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl9DW-0001yC-O5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CN-0000ei-J0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:11 -0400
Received: from mail-db8eur05on2129.outbound.protection.outlook.com
 ([40.107.20.129]:5441 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CH-0004s0-Bn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsISQOXgUeaHG9BD66BJs2LdU44kzxFZFybMjuUXBhYdqxglg72CurexwpT2u8LXBoi6mmcha9XolV0oTBC9BsntnHniAxBwSBAbEe/ojnQZU/8XlyGYbGkmduo1uyxq9LvamsFE6Gcov3LUeDVWZnYAKJBOQlt9w9TZVqCeTyBa4AqnMHaW7AZQ0Pfhudc0ne3EaM7bE1HiTDmskgS9ka8Aag2UrZ0LpxYCAzv7L01FLjyVUvpkMOK8/w9GnG6PPTjioGCVXgfebif3q2/ogEGBydLmpz/MSyjqDHSpcaB2iEBF1REo1jN6qjIrQ6/YdYcI3M1iSPjgtEhmncgUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUjdwdFlYBaOHIC1YXMkUYrxgxT1uyV/HxBIfqutbhw=;
 b=DoXhPJUoBOg1tEmhMijIFb11e1ZjblgRGxtsND+75hmIFtWlIqmf646nEUZcRFwHIuAkEGwq7im0uc7MyAbLwdzHGdo9JOHni5mVLEysF9LYkpENvx/BLZ57JqLrHBnFo8fyF6hmHPiOKJQoiFxu6akEuR+a2iIudSWg4ax6XuLz8sIfmXMdNCmNeqteLHmTca4VyCnLFZuvohHvg13wwOMCM+pyrT2GUDlo0Q5k0haAB7A5SIexLDULY5ugtDShIKHmvmWzdYo0MZGDdloc6X+3L4aJ02JtlRV1buUcZ/uJ7ERglRvyVP9LhwvEEM+FuMYeQt5P7sG9sYvSeHbYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUjdwdFlYBaOHIC1YXMkUYrxgxT1uyV/HxBIfqutbhw=;
 b=VwjsViszPBQMUh5Xx55jGcWL7mgPVR3M0+Ng+wfvnSePSaL5QlmEML13+TS1vHxMDBoNGJSWlXa2Xkf0uArD673qY3rGedpwv+rzgMktoPO1OEcM/TqVTYePueFkhl4u44gwJ0haLu7zAEamJ8sFWIs3W/h6tg2lxUUzOYIlm3s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5014.eurprd03.prod.outlook.com (2603:10a6:20b:87::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 10:52:00 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:52:00 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Add thunk argument types for SIOCGSTAMP
 and SIOCGSTAMPNS
Date: Tue, 16 Jun 2020 12:51:46 +0200
Message-Id: <20200616105147.21736-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616105147.21736-1-filip.bozuta@syrmia.com>
References: <20200616105147.21736-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 10:52:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385cd527-6da2-478f-c60b-08d811e34c1a
X-MS-TrafficTypeDiagnostic: AM6PR03MB5014:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5014FD36A61CCF57172EE806EB9D0@AM6PR03MB5014.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwRMZOXnKLu9IOK35XtiyR7BJ4VMpAwVwK+9+DYKhVOLKsmvyaqTaSB+NfiZ6I4+C9eoNpZP5hSdaOmCRS1RiQemzVTxxhOHJzP9tH4BhzpfkXAcAuUUEtbomlHc76+ytD3wkvUqmd7AhfiwOgnliuSx1rmSpBEaeSBBYi3GReIHrDGrp9WviazhOD/3SAelf2oA6RD9+g8TLWK7gsWnH91i2IYQqjv+LVaSkOHeTZ2lMtBdMHhX1fDx2BvitghGIZvlemkTJ18laYzvcqBYeFwfgv1rrwizcH7HS/KAyKL4NILLQGARBhlF0IUc03w+DdWiZ7Lyj0FVmwV3xDc+jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(366004)(39840400004)(376002)(346002)(8676002)(8936002)(2906002)(6486002)(5660300002)(508600001)(4326008)(44832011)(2616005)(956004)(6916009)(66946007)(186003)(66556008)(26005)(16526019)(83380400001)(6666004)(66476007)(7696005)(86362001)(316002)(52116002)(36756003)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2uqAHO1g9cSTIgi4mbsIimLjXF/az8hrqQGjVhp34WnaU9oxWDiWZr6XgbfZs8YdydfGmbizeXlr+fNcF0/I1sq+PqXvkN0yyIHN+3zFuK4ahhl8VYfKcP5gGG2sVJByOju0Wc4nt17Y+Qk0QzWXiOtLhdqqy8GZCpf+lJaxD0x4v0Ie1cKsikn8hTEQ+xtbYFv/623jwIF7KMzBaCUgM0wCkkVdJSJEbc0rmDJxQ+Uq9lPURrAifd+8fTJHjwFtQkpfFZtHQiyS7ww/a9YHlB6DyS4fTXHkzmjwBVOGCw7LVmyPvYlQjfxgW9mk+3eKZQpCCv4NQnTZitKa0rWVv49CNvivDTYRbVn5EPCDmyM75uQQ/YgNDIpERI9gu6XBiL7TTE7e5MRgbhqSTDid76GDsmO/N9ePkvSz+EkB6XeNcjngCy3TpTdyQSm1ahFBNmlNCQFQvj+EzH7CdAO7v1i7SOyX81pXZz5UdV65Td0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385cd527-6da2-478f-c60b-08d811e34c1a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:52:00.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YJJQMpMkB+TTn8WtO9Hha+qyMGT6D1KZhj5G+37iQrwShCEIzcvwxxFqPu2UYXTiUz1D21EbzeplCGT9Ee0oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5014
Received-SPF: pass client-ip=40.107.20.129;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:52:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
    other is the 2038 safe variant used for 32-bit architectures. Corresponding
    structure definitions STRUCT_timespec/STRUCT__kernel_timespec and
    STRUCT_timeval/STRUCT__kernel_sock_timeval were added for these variants.
    STRUCT_timeval definition was already inside the file as it is used by
    another implemented ioctl. Two cases were added for definitions
    STRUCT_timeval/STRUCT__kernel_sock_timeval to manage the case when the
    "u_sec" field of the timeval structure is of type int.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 12 ++++++++----
 linux-user/syscall_types.h | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..edb7172207 100644
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
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_sock_timeval)) } },
   { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
-    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_timespec)) } },
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..d636561bf4 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -137,10 +137,32 @@ STRUCT(snd_timer_params,
        TYPE_INT, /* filter */
        MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
 
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+#else
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_LONG) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_usec */
+#endif
+
 STRUCT(timespec,
        TYPE_LONG, /* tv_sec */
        TYPE_LONG) /* tv_nsec */
 
+STRUCT(_kernel_timespec,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_nsec */
+
 STRUCT(snd_timer_status,
        MK_STRUCT(STRUCT_timespec), /* tstamp */
        TYPE_INT, /* resolution */
-- 
2.17.1


