Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2552C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8342064C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="ERWA6yW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8342064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRPu-0002o4-Lg
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jvRPI-0002In-BR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:04 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:14852 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jvRPF-0006DT-RO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKiZaGu/vZ+qFkBCpD5qJs4bmPBUYIIdETKk0LMRZ2nzIg/mLqv11eeJrsNdwNS4K4fHLILMcEtxpsx2VLe+25RyrLzDD6d5LwLQ4BA+hNpTsCKi6pjBwIxnjojd5wlsriLXhKR4dxzA6gM2LVBRA4Ygb4gjtyMjAjLiTQTjzoRyS+MtrXtIbRfzXJ4x34CB+1YVN7cvM8iGOMyJ3NgUwL6q6C/KN0jbBJCsZvVh+JaIilik2Yk3X6qZUl9a7wF1/qFfH0IfsHhSCckcEYbbfz5I/JAF/L820D15YuBSpZMWVfFdPhE7PpPS0zVm3EnLsx1+qgOEHrNSYVeGgRZjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNXPoBK/ZAvOvw/u+vtYho0pVkPMPoB/mvhB+X9iGYg=;
 b=B2uWNQv31xCLs/U1oM4YI8mixjeXXs6irOf8QkzDf9uZ6ss5I9I5O4Ge32OSr23HyY82mA+ddnBxoYbBoxrC0rOIaTM0FcIRs0FfIbpBThTn7OnM9sSwdQZJbIJBrYbKZdW2ChGjYid8j45WZD5sYrlRiA92DJCTaQQs5LJgmdooM4dxqYhahHyltKm52vRIjQR2ZrLlCQLoaHO1iLpn6A7N7A5XvE4ZeavHX3kdc46bfyFvqNMPluscRuDfYi+20efH1/C1HeckY6fxLKSVgw+zpXWXPDJmvXgED9mDoSHl0i3A0xuj4O20dSPfrAR0q+H+rWOPt143D5+6pKWNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNXPoBK/ZAvOvw/u+vtYho0pVkPMPoB/mvhB+X9iGYg=;
 b=ERWA6yW2GPlwEYtW9D3xpTQfctqLmy3YaUXgC0+QX+j6K+FSoKdhDBya5knO32sA5tDJM+OHRdFC3HpJOxxjOtfqayawx+rTY5WSy1eRIpXPD3+PqafqWrBADJ/FwQ91Wnb+bsjdqLVuoGrtSFeaiXz3La/yTyNDFk7JDHHiAs8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3304.eurprd03.prod.outlook.com (2603:10a6:209:17::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 14 Jul
 2020 20:04:55 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 20:04:55 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add strace support for printing arguments for
 ioctls used for terminals and serial lines
Date: Tue, 14 Jul 2020 22:04:38 +0200
Message-Id: <20200714200439.11328-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 20:04:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e92115-e8e0-4cac-4a6f-08d828312d35
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB3304430F3ADC3DCFC41778BFEB610@AM6PR0302MB3304.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5HaxHYRpSk0jrnGtDwdWhrcsQh2Adw90lyhdzu24fTLsAtt13sukD/wG9CBgFKjSE2UcXzvl9m+AFW+Ste2GHhpT97yqAFSWQ6zSUx6uDWdsCh9BnHESBCeui8jnmOaDBxYWMaTGbc9cQIA9cJxrAZkPtSK8zJPC1UuaouLLlK3sSYZzc73rNmrpS8ns4UbHVqyBTAMgQpjnBF66D7VVmj4DSm1u9khy4LqCVS6HwLcP2FoH11ERC7NX68DZDjIA1ipCzPZBLt8aXhWVdiOzFo1XsIvpxvnO1bLWDkYmtUqoJfyrBe8YV629K/WDu1BNHWP9fwiIKs4C6XJgg4hvH5M9Kvcx1UV0G7aEyjvVdL7gBDjTQZxjVygjaXBKlgcBFlvkGWFNAcanXKWSoNwePdFVw2a5dUrUIqMnd3Gsb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(39830400003)(376002)(136003)(346002)(396003)(66476007)(4326008)(86362001)(16526019)(83380400001)(52116002)(186003)(107886003)(69590400007)(66556008)(6486002)(66946007)(2906002)(2616005)(508600001)(956004)(26005)(6506007)(36756003)(6666004)(6916009)(5660300002)(54906003)(316002)(8936002)(6512007)(8676002)(1076003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: liufgELQHcVegjxO7T9IZ1id89MdQKpbJ24UVgPEDbjyzWhXsLF0Y8crqZskoeI5S45YB1EQ7AjHSwvFOAyQdjSXwoMgEzvqt5XymlqUApG8RPXtTJUgyqS7GgewagYf28pXU4KM7rZXUd7wS91jkydazZ0bQTfM+Dx01ZfATBSGJhkWhFM+QSLIMuKU1+VHMd5SnEwWYQPlvT7Ea9++Zcno3wp485Gqu1TVzZH6iEN71705UNlhr1FOSnN9cFpZlaKpSE912uHcI97wQqoy+uEN/sYs7BKTtHExhW0ot1+vUYIvApDcVUVvj95bkcKd/a3NwxLw3rVZKxUPU56MKB8VXpa+jNFNtZ/9zsLbCGMbB4K7gkAS9SEmDDmLVV3Yn0uszkaD3iO6CZ8sLJHrFn7ial1UQjZeg07pbs9+aiHdm6Jf0NLpYTyMARe+OuSPtJo/JWNmb1D2fxKeJeatRw4OB1+XYLW9ot8mOW7Q7js=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e92115-e8e0-4cac-4a6f-08d828312d35
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 20:04:55.2029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mHm4WvnvbpIJ1R2k2ZqEAjQy+CvQ5w9t2wPdYOGbdvItHl43bJ9OTld0YKAk7VFbCQT+dbXjmR9cScX66u1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3304
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 16:19:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Functions "print_ioctl()" and "print_syscall_ret_ioctl()" are used
to print arguments of "ioctl()" with "-strace". These functions
use "thunk_print()", which is defined in "thunk.c", to print the
contents of ioctl's third arguments that are not basic types.
However, this function doesn't handle ioctls of group ioctl_tty which
are used for terminals and serial lines. These ioctls use a type
"struct termios" which thunk type is defined in a non standard
way using "STRUCT_SPECIAL()". This means that this type is not decoded
regularly using "thunk_convert()" and uses special converting functions
"target_to_host_termios()" and "host_to_target_termios()", which are defined
in "syscall.c" to decode it's values. For simillar reasons, this type is
also not printed regularly using "thunk_print()". That is the reason
why a separate printing function "print_termios()" is defined in
file "strace.c". This function decodes and prints flag values of the
"termios" structure.

Implementation notes:

    Function "print_termios()" was implemented in "strace.c" using
    an existing function "print_flags()" to print flag values of
    "struct termios" fields. These flag values were defined
    using an existing macro "FLAG_TARGET()" that generates aproppriate
    target flag values and string representations of these flags.
    This function was declared in "qemu.h" so that it can be accessed
    in "syscall.c". Type "StructEntry" defined in "exec/user/thunk.h"
    contains information that is used to decode structure values.
    Field "void print(void *arg)" was added in this structure as a
    special print function. Also, function "thunk_print()" was changed
    a little so that it uses this special print function in case
    it is defined. This printing function was instantiated with the
    defined "print_termios()" in "syscall.c" in "struct_termios_def".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 include/exec/user/thunk.h |   1 +
 linux-user/qemu.h         |   2 +
 linux-user/strace.c       | 193 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      |   1 +
 thunk.c                   |  23 +++--
 5 files changed, 211 insertions(+), 9 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 7992475c9f..a5bbb2c733 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -55,6 +55,7 @@ typedef struct {
     int *field_offsets[2];
     /* special handling */
     void (*convert[2])(void *dst, const void *src);
+    void (*print)(void *arg);
     int size[2];
     int align[2];
     const char *name;
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5c964389c1..e51a0ededb 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,8 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+extern void print_termios(void *arg);
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5235b2260c..7b5408cf4a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1193,6 +1193,138 @@ UNUSED static struct flags falloc_flags[] = {
 #endif
 };
 
+UNUSED static struct flags termios_iflags[] = {
+    FLAG_TARGET(IGNBRK),
+    FLAG_TARGET(BRKINT),
+    FLAG_TARGET(IGNPAR),
+    FLAG_TARGET(PARMRK),
+    FLAG_TARGET(INPCK),
+    FLAG_TARGET(ISTRIP),
+    FLAG_TARGET(INLCR),
+    FLAG_TARGET(IGNCR),
+    FLAG_TARGET(ICRNL),
+    FLAG_TARGET(IUCLC),
+    FLAG_TARGET(IXON),
+    FLAG_TARGET(IXANY),
+    FLAG_TARGET(IXOFF),
+    FLAG_TARGET(IMAXBEL),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags[] = {
+    FLAG_TARGET(OPOST),
+    FLAG_TARGET(OLCUC),
+    FLAG_TARGET(ONLCR),
+    FLAG_TARGET(OCRNL),
+    FLAG_TARGET(ONOCR),
+    FLAG_TARGET(ONLRET),
+    FLAG_TARGET(OFILL),
+    FLAG_TARGET(OFDEL),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_NLDLY[] = {
+    FLAG_TARGET(NL0),
+    FLAG_TARGET(NL1),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_CRDLY[] = {
+    FLAG_TARGET(CR0),
+    FLAG_TARGET(CR1),
+    FLAG_TARGET(CR2),
+    FLAG_TARGET(CR3),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_TABDLY[] = {
+    FLAG_TARGET(TAB0),
+    FLAG_TARGET(TAB1),
+    FLAG_TARGET(TAB2),
+    FLAG_TARGET(TAB3),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_VTDLY[] = {
+    FLAG_TARGET(VT0),
+    FLAG_TARGET(VT1),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_FFDLY[] = {
+    FLAG_TARGET(FF0),
+    FLAG_TARGET(FF1),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_oflags_BSDLY[] = {
+    FLAG_TARGET(BS0),
+    FLAG_TARGET(BS1),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_cflags_CBAUD[] = {
+    FLAG_TARGET(B0),
+    FLAG_TARGET(B50),
+    FLAG_TARGET(B75),
+    FLAG_TARGET(B110),
+    FLAG_TARGET(B134),
+    FLAG_TARGET(B150),
+    FLAG_TARGET(B200),
+    FLAG_TARGET(B300),
+    FLAG_TARGET(B600),
+    FLAG_TARGET(B1200),
+    FLAG_TARGET(B1800),
+    FLAG_TARGET(B2400),
+    FLAG_TARGET(B4800),
+    FLAG_TARGET(B9600),
+    FLAG_TARGET(B19200),
+    FLAG_TARGET(B38400),
+    FLAG_TARGET(B57600),
+    FLAG_TARGET(B115200),
+    FLAG_TARGET(B230400),
+    FLAG_TARGET(B460800),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_cflags_CSIZE[] = {
+    FLAG_TARGET(CS5),
+    FLAG_TARGET(CS6),
+    FLAG_TARGET(CS7),
+    FLAG_TARGET(CS8),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_cflags[] = {
+    FLAG_TARGET(CSTOPB),
+    FLAG_TARGET(CREAD),
+    FLAG_TARGET(PARENB),
+    FLAG_TARGET(PARODD),
+    FLAG_TARGET(HUPCL),
+    FLAG_TARGET(CLOCAL),
+    FLAG_TARGET(CRTSCTS),
+    FLAG_END,
+};
+
+UNUSED static struct flags termios_lflags[] = {
+    FLAG_TARGET(ISIG),
+    FLAG_TARGET(ICANON),
+    FLAG_TARGET(XCASE),
+    FLAG_TARGET(ECHO),
+    FLAG_TARGET(ECHOE),
+    FLAG_TARGET(ECHOK),
+    FLAG_TARGET(ECHONL),
+    FLAG_TARGET(NOFLSH),
+    FLAG_TARGET(TOSTOP),
+    FLAG_TARGET(ECHOCTL),
+    FLAG_TARGET(ECHOPRT),
+    FLAG_TARGET(ECHOKE),
+    FLAG_TARGET(FLUSHO),
+    FLAG_TARGET(PENDIN),
+    FLAG_TARGET(IEXTEN),
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1420,6 +1552,67 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+void
+print_termios(void *arg)
+{
+    const struct target_termios *target = arg;
+
+    abi_long iflags = tswap32(target->c_iflag);
+    abi_long oflags = tswap32(target->c_oflag);
+    abi_long cflags = tswap32(target->c_cflag);
+    abi_long lflags = tswap32(target->c_lflag);
+
+    qemu_log("{");
+
+    qemu_log("c_iflag = ");
+    print_flags(termios_iflags, iflags, 0);
+
+    qemu_log("c_oflag = ");
+    abi_long oflags_clean =  oflags & ~(TARGET_NLDLY) & ~(TARGET_CRDLY) &
+                                      ~(TARGET_TABDLY) & ~(TARGET_BSDLY) &
+                                      ~(TARGET_VTDLY) & ~(TARGET_FFDLY);
+    print_flags(termios_oflags, oflags_clean, 0);
+    if (oflags & TARGET_NLDLY) {
+        print_flags(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
+    }
+    if (oflags & TARGET_CRDLY) {
+        print_flags(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
+    }
+    if (oflags & TARGET_TABDLY) {
+        print_flags(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
+    }
+    if (oflags & TARGET_BSDLY) {
+        print_flags(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
+    }
+    if (oflags & TARGET_VTDLY) {
+        print_flags(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
+    }
+    if (oflags & TARGET_FFDLY) {
+        print_flags(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
+    }
+
+    qemu_log("c_cflag = ");
+    if (cflags & TARGET_CBAUD) {
+        print_flags(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
+    }
+    if (cflags & TARGET_CSIZE) {
+        print_flags(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
+    }
+    abi_long cflags_clean = cflags & ~(TARGET_CBAUD) & ~(TARGET_CSIZE);
+    print_flags(termios_cflags, cflags_clean, 0);
+
+    qemu_log("c_lflag = ");
+    print_flags(termios_lflags, lflags, 0);
+
+    qemu_log("c_cc = ");
+    qemu_log("\"%s\",", target->c_cc);
+
+    qemu_log("c_line = ");
+    print_raw_param("\'%c\'", target->c_line, 1);
+
+    qemu_log("}");
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82afadcea0..0c79011727 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5633,6 +5633,7 @@ static const StructEntry struct_termios_def = {
     .convert = { host_to_target_termios, target_to_host_termios },
     .size = { sizeof(struct target_termios), sizeof(struct host_termios) },
     .align = { __alignof__(struct target_termios), __alignof__(struct host_termios) },
+    .print = print_termios,
 };
 
 static bitmask_transtbl mmap_flags_tbl[] = {
diff --git a/thunk.c b/thunk.c
index c5d9719747..0718325d86 100644
--- a/thunk.c
+++ b/thunk.c
@@ -404,19 +404,24 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
             const int *arg_offsets;
 
             se = struct_entries + *type_ptr++;
-            a = arg;
 
-            field_types = se->field_types;
-            arg_offsets = se->field_offsets[0];
+            if (se->print != NULL) {
+                se->print(arg);
+            } else {
+                a = arg;
 
-            qemu_log("{");
-            for (i = 0; i < se->nb_fields; i++) {
-                if (i > 0) {
-                    qemu_log(",");
+                field_types = se->field_types;
+                arg_offsets = se->field_offsets[0];
+
+                qemu_log("{");
+                for (i = 0; i < se->nb_fields; i++) {
+                    if (i > 0) {
+                        qemu_log(",");
+                    }
+                    field_types = thunk_print(a + arg_offsets[i], field_types);
                 }
-                field_types = thunk_print(a + arg_offsets[i], field_types);
+                qemu_log("}");
             }
-            qemu_log("}");
         }
         break;
     default:
-- 
2.25.1


