Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1F5207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="J/dTAibv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1F5207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGFy-0003Rh-U2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDo-0007N9-Bx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:16 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDm-0003z4-7e
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxLSCedC/lUkkOJs0W9I4HI3MVcp+uc7iUaIWhMqM7GhwX9zZFLxo41zg1DD493m1di3uYrfCwShW6eaXLMsC6J3Xpg1XFL7c/cchd8qdBHB958jTRmMUFFZxhwOqo5+GqzWelAa+nI4hkQoM8o2Y2bB7cLGEmoUdbBYOD4UoVR0L9Zm5aaX4UgZolTq2jGoeuNj4rnPxWGtLXvWvB39o8dWPdXf8mylHmIDV6V8xRff9BnFDRspIfnDnzCqWMRq0tXmm4I4R5Q6J12OztaNeLDvzwUZSAe3UEQe61KrERAB3g/lPTOHs6CKTxX1qFxZKHxae4bqVAwxWfHY29Db0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuvlNwSiYxlMrbmmSksbl94NPcf+Xi96bVZzevzSh80=;
 b=CSq63wOrrDVmkaFWV+uHws1Qn18sAJiraCbWXVQBaqd2sjNmEb+D0tK81CEqimNjysmKbKwdlMonEX33VQjLLC0JGan5c0XjxvBzjXR2W49ZwcKDRZ7T0cvV6pcPa+qFGFvoAGODoETqbBlCdJu1wIRlinnb5ax/TqU12XTnROo/mVrp97O/BfMGZBKr923fX7B2lCp5ZXjYxY5T2ipCV88/04XxPbQVy0r2YmyYOS5is2vgKvlmd/wkyZEGct1JhK0bbkPcm58HLEKD/w5qfcs1rD5OK9eZa7DNlWty1zSkawdD0I5dS56YnzpK9cX5Yk8ydmL0U4anlFo6Veo5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuvlNwSiYxlMrbmmSksbl94NPcf+Xi96bVZzevzSh80=;
 b=J/dTAibv1VC+SkeIIYgvb0KQF0HM4Et3UhPZ9zXnvTGbjHwax+MwoXbaoWIhBapChhvr3xSm1f/MYHmPYqjr/IFAT3NJccoGNPTQw0KAbcClQBCn/WkjbH8qkWu6h6tdjhlF83OmCA6pOY+v1XHyBdwbeWdymEP98WsD9+H6ChM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:48 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:48 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/6] linux-user: Add strace support for printing arguments
 of fallocate()
Date: Fri, 19 Jun 2020 14:33:31 +0200
Message-Id: <20200619123331.17387-7-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0b4789b-4084-4961-f1d2-08d8144d0389
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB531503404F448C2FA437E74AEB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrfRFMnE33q2JNbU0n1mHCo2FmilPCWkeAUBELaGkMMLIgO1FGvSSAc4oJ9UJxJneU3G/+ljCwvdNDN2INw0NB1Onu4JdI09l8VN4vqSUgimTHHWWT5U+SOtKSEWiXZ7CAnndoGNy6uid0QRX4uwKF+9yYSt/crrIVn7J/MpvjtoxZhOXQOuQJjj67eLcHSoCzKg6BuFUVu1yPRhaM7ccVT+PZvXFlqJ9Vkn2js2jCv1FsGPHIphn7vxGtR0Km82h9YuB2ojiC+Q7Ccm/lsSIK7hJG5mrq2J6WHNelrK7+3X6eEhf9sPOZFc5hjqawMPCvAhhIOFV7HmQ0rwBYNjx/5+O+T2xFB4gSG192kzFUXz6N47g+xUjV6VODlG7mZ2/XnNMPVjUDja+gBFrKg1vuu02CxTZzzJyeelqd5U8+SQ6wYPMWsRi+gMvogQrWxQacike2oAiemDN4WFzNDBbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(966005)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Lior+6ex/kUkUSHsoSOg++aey22eDeIu8JnWAAwGgjNNUGSjKGvWEpsr75p7aA92io9d0k+WPrtwWK6wOIBbUH/ZFwFOxb3dbGSpGSwV2G6k7hi86Ue5pN196glkg5DAdG0zLl/JlFvKdP+1JJ+qamVP9byjHsZ9M4DCz43ffnJouHCRlOsIdIN184vf+ies7EgETgF1Kee3VWb/lfpDtN/qm9/UVCPshyLpUrimSenSKn//rpFFQUfZINTZtOVAugbv3kpV3HyLQZNmBghyDivC3gtuReuyobehszjYGmL1bsGWTMfNwxtm0vnpeILdifaM/CgOdED8T30mApg1s7tz6efK/WUT1x4Jqpm61nnrYP9PiO2SPbZ3kpbaUe/MHBLR6vCKT5172XIy6GVT84YQ+NAEc9y+CAE6ZkcMIJAPFQmdULJ9gt6102P/Koy1Fqv6W/TSK+l/GJtBwphkVF4licxJeAPqLj/Vi+Fr9Z0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b4789b-4084-4961-f1d2-08d8144d0389
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:47.8863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy9NcMF3lPyktI49UGFxJ2f8xgV1KQ9ofrJ8E4M9/Uz5b1eMOL5by2Ro9vaeE8X8yf6prppb/7Uskhzit9lTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.0.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:33:52
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscall:

    *fallocate - manipulate file space

        int fallocate(int fd, int mode, off_t offset, off_t len)
        man page: https://www.man7.org/linux/man-pages/man2/fallocate.2.html

Implementation notes:

    This syscall's second argument "mode" is composed of predefined values
    which represent flags that determine the type of operation that is
    to be performed on the file space. For that reason, a printing
    function "print_fallocate" was stated in file "strace.list". This printing
    function uses an already existing function "print_flags()" to print flags of
    the "mode" argument. These flags are stated inside an array "falloc_flags"
    that contains values of type "struct flags". These values are instantiated
    using an existing macro "FLAG_GENERIC()". Most of these flags are defined
    after kernel version 3.0 which is why they are enwrapped in an #ifdef
    directive.
    The syscall's third ant fourth argument are of type "off_t" which can
    cause variations between 32/64-bit architectures. To handle this variation,
    function "target_offset64()" was copied from file "strace.c" and used in
    "print_fallocate" to print "off_t" arguments for 32-bit architectures.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h      | 16 ++++++++++++++++
 linux-user/strace.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 linux-user/syscall.c   | 16 ----------------
 4 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 8f938b8105..be67391ba4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -670,6 +670,22 @@ static inline int is_error(abi_long ret)
     return (abi_ulong)ret >= (abi_ulong)(-4096);
 }
 
+#if TARGET_ABI_BITS == 32
+static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+#else
+    return ((uint64_t)word1 << 32) | word0;
+#endif
+}
+#else /* TARGET_ABI_BITS == 32 */
+static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
+{
+    return word0;
+}
+#endif /* TARGET_ABI_BITS != 32 */
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 957f08f1ad..32e5e987ac 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1135,6 +1135,26 @@ UNUSED static struct flags statx_mask[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags falloc_flags[] = {
+    FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
+    FLAG_GENERIC(FALLOC_FL_PUNCH_HOLE),
+#ifdef FALLOC_FL_NO_HIDE_STALE
+    FLAG_GENERIC(FALLOC_FL_NO_HIDE_STALE),
+#endif
+#ifdef FALLOC_FL_COLLAPSE_RANGE
+    FLAG_GENERIC(FALLOC_FL_COLLAPSE_RANGE),
+#endif
+#ifdef FALLOC_FL_ZERO_RANGE
+    FLAG_GENERIC(FALLOC_FL_ZERO_RANGE),
+#endif
+#ifdef FALLOC_FL_INSERT_RANGE
+    FLAG_GENERIC(FALLOC_FL_INSERT_RANGE),
+#endif
+#ifdef FALLOC_FL_UNSHARE_RANGE
+    FLAG_GENERIC(FALLOC_FL_UNSHARE_RANGE),
+#endif
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1552,6 +1572,26 @@ print_faccessat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_fallocate
+static void
+print_fallocate(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_flags(falloc_flags, arg1, 0);
+#if TARGET_ABI_BITS == 32
+    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
+    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+#else
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+#endif
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_fchmodat
 static void
 print_fchmodat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 633f43f490..10e3e4a814 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -182,7 +182,7 @@
 { TARGET_NR_fadvise64_64, "fadvise64_64" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_fallocate
-{ TARGET_NR_fallocate, "fallocate" , NULL, NULL, NULL },
+{ TARGET_NR_fallocate, "fallocate" , NULL, print_fallocate, NULL },
 #endif
 #ifdef TARGET_NR_fanotify_init
 { TARGET_NR_fanotify_init, "fanotify_init" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 009bb67422..7cc5a65b4f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6608,22 +6608,6 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
-
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg2,
-- 
2.17.1


