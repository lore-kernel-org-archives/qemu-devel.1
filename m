Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E754C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271752065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="0ZaXCsQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271752065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyiQ0-0004wD-Ez
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 17:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyiNE-0001OG-QX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:03:28 -0400
Received: from mail-db8eur05on2102.outbound.protection.outlook.com
 ([40.107.20.102]:7264 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyiNC-0006NN-FX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDZI4BG5hcmcFID+kzVQubDxazLJxMJJsEalolPFpmO+YuHqWou2b9QJHZJD+oKFocrO9TvwqRWFavlLJKgnyDdNFrIG4LNVkIyOn5aJg3EmnkkHiFuYoLdCqpLubPIVP7nDTZa0xy/wDsuxGhr43w8q/1DZWLKeZmnQXuyTqJqL+Si8lk3CZQCZ8lBb8NC5eaXcZ62RhPFH9io/EGi07i+beheY3W9gAWKRm80LaQ27qipysVTN9yvhyVcCuzOtdqPYlgRiAuSg52Yay8WHVwRirNRnn5uYzRRfyjOHhKFH/j+VyMftJ5xNCyAu212xs6qjL/bq4DyhnOSWm0fWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWUDAeHx0KsWCWciSfPGaKqZO7NXSiZtJ2Col7cYThs=;
 b=a4ZSNc5bCYavnGjeGwbv8Ojs+9PfDoTxRuDb8cPF/EwvoFlU9pSxjCPQaYW2qiI6EhkuXWxe5regjYDbrZeQJy74r5OnLSyAXjW0p9d8yDTqqr+NCUschKhP17WaIYk3UHfFLx8gLe+alqvhTU915LIVvefciqFF7x8D47jqjIE6FuNKJUZHLlDQN8YEklCqW+3jwU0dH7WDw6hTThDdVP0UcdkQ4x0R4HXNjvpEfr0LzPOWWQKjbEO5m/jW+PZL4GT4+7uqgGH8jNU41A4e0uC4CudUa/wjglWxx0+OR3usuuletYIXhHVSRK1zn+BlkWkBUkRGbT22H1nmsbty2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWUDAeHx0KsWCWciSfPGaKqZO7NXSiZtJ2Col7cYThs=;
 b=0ZaXCsQk08IVMps39BFnCIIPH083kTOLG2qrF8OAn+O4i/m+oaGtH6mROZfarEXO/99IV3iwTLYzBlYC36puTLwhhKMXsQ2NVMeYoUYL623vdGzzNouXHk+6bp90iQBiUoibUXIpeEYXMtNaeSkfEduNRFfbLFeTSzpGNy/V7dw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5687.eurprd03.prod.outlook.com (2603:10a6:20b:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 21:02:50 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Thu, 23 Jul 2020
 21:02:50 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] linux-user: Add strace support for printing arguments
 for ioctls used for terminals and serial lines
Date: Thu, 23 Jul 2020 23:02:33 +0200
Message-Id: <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
References: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.236) by
 LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 21:02:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c240755-4dae-4f36-e717-08d82f4bc27e
X-MS-TrafficTypeDiagnostic: AM6PR03MB5687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5687B400EBB0792EDF3D8F3DEB760@AM6PR03MB5687.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWZkkwKYWnX7u22nLU0negJKHEhJalPHZ6U/x7tg9UqXDHZrb5wo4fazquFR2tje+n3gstoV6bbTGMT6irzhEeZxAiRckFq36Paf51JxcCKTXwzjCGJWCtYVSGeqLcO7ZGfog2mewy/OAqiuF31x0D/hzyx0m2evkUGOj9cZ1jo/w0v3449kru3kFM56LAqtORoW6mnvyABCmxE/mnPYfghabLpdOx8rmq5hNj+5TyGtRazc5/wCb7kUuqP/u0ngtG35f7FqOPpu4cxZWsFeTTxxQWlmLo6Cjb2N5vqfr8kptyzvEYRuDI0WEIAwHb4GRJ0CFWSA0cHhcFjJTrGFg5PmMvUmSTcOD//pYzu8nD2gbjNqh2XDemgZzEzwhSqd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(39830400003)(346002)(396003)(69590400007)(6486002)(86362001)(6916009)(6666004)(26005)(66556008)(956004)(66946007)(66476007)(2616005)(83380400001)(1076003)(54906003)(508600001)(316002)(4326008)(6512007)(2906002)(5660300002)(6506007)(8936002)(52116002)(8676002)(16526019)(186003)(107886003)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D7driFXvxFHKqO0I3B/sdd7MDq2sM97hxGX6zFQIVgvZnQHAIkQAiwUge59BLkHF21w79IkRnu0H16Fe+Lkhl2+txAtC5xEiOSQqrDyLexT5uxZQ5Ee9BB/SCe6bc7MUboaxJcTTGpsmwfCQAm8FZO3jseYY0mhffZtEeveRp2DFjD9SLk/CSFcwXKCSjfW14PGoTopvzqIqG2gOd1XjH/M3xrMmS1n37qY8d11Vmx6dejS95jdGRIbwoau04t1L4yL9G1yWdmtYG9Sv/s0cZuiOmbm+z5vPHFoT2htdU6wDf3AtYwq0Jx5s70kuCew1Aif7w+Ojah+a9i+l7jxCucXNTvgwUiXJmNRpMVTgpu5zO7blt7XQyDJnISbonZ0T7cB+klLTFEod2n3yB6ItExT0A8aIU/lwcNpJSAlk2lh1mPNDG8NVJz2HU0s3xh77qFeXnG+9yST8M5L07nJGoJqXb+l+rvLdPwAHuT6VeuE=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c240755-4dae-4f36-e717-08d82f4bc27e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 21:02:50.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zsZr/KMWa/bj3BdK36dFIOORAwFs5QvPVPi8hC/8+ihh2zFHkkEsfPp+SOeUR26AfQDBb+TqPOHKpCJRg7N5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5687
Received-SPF: pass client-ip=40.107.20.102;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 17:03:22
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
in "syscall.c" to decode it's values.

For simillar reasons, this type is also not printed regularly using
"thunk_print()". That is the reason why a separate printing function
"print_termios()" is defined in file "strace.c". This function decodes
and prints flag values of the "termios" structure.

Implementation notes:

    Function "print_termios()" was implemented in "strace.c" using
    an existing function "print_flags()" to print flag values of
    "struct termios" fields. Also, recently implemented function
    "print_enums()" was also used to print enumareted values which
    are contained in the fields of 'struct termios'.

    These flag values were defined using an existing macro "FLAG_TARGET()"
    that generates aproppriate target flag values and string representations
    of these flags. Also, the recently defined macro "ENUM_TARGET()" was
    used to generate aproppriate enumarated values and their respective
    string representations.

    Function "print_termios()" was declared in "qemu.h" so that it can
    be accessed in "syscall.c". Type "StructEntry" defined in
    "exec/user/thunk.h" contains information that is used to decode
    structure values. Field "void print(void *arg)" was added in this
    structure as a special print function. Also, function "thunk_print()"
    was changed a little so that it uses this special print function
    in case it is defined. This printing function was instantiated with
    the defined "print_termios()" in "syscall.c" in "struct_termios_def".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 include/exec/user/thunk.h |   1 +
 linux-user/qemu.h         |   1 +
 linux-user/strace.c       | 195 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      |   1 +
 thunk.c                   |  23 +++--
 5 files changed, 212 insertions(+), 9 deletions(-)

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
index f431805e57..a69a0bd347 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,7 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+void print_termios(void *arg);
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3f16bb2c53..b9ba39ce6e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1284,6 +1284,140 @@ UNUSED static struct flags falloc_flags[] = {
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
+    FLAG_TARGET(IUTF8),
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
+UNUSED static struct enums termios_oflags_NLDLY[] = {
+    ENUM_TARGET(NL0),
+    ENUM_TARGET(NL1),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_oflags_CRDLY[] = {
+    ENUM_TARGET(CR0),
+    ENUM_TARGET(CR1),
+    ENUM_TARGET(CR2),
+    ENUM_TARGET(CR3),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_oflags_TABDLY[] = {
+    ENUM_TARGET(TAB0),
+    ENUM_TARGET(TAB1),
+    ENUM_TARGET(TAB2),
+    ENUM_TARGET(TAB3),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_oflags_VTDLY[] = {
+    ENUM_TARGET(VT0),
+    ENUM_TARGET(VT1),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_oflags_FFDLY[] = {
+    ENUM_TARGET(FF0),
+    ENUM_TARGET(FF1),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_oflags_BSDLY[] = {
+    ENUM_TARGET(BS0),
+    ENUM_TARGET(BS1),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_cflags_CBAUD[] = {
+    ENUM_TARGET(B0),
+    ENUM_TARGET(B50),
+    ENUM_TARGET(B75),
+    ENUM_TARGET(B110),
+    ENUM_TARGET(B134),
+    ENUM_TARGET(B150),
+    ENUM_TARGET(B200),
+    ENUM_TARGET(B300),
+    ENUM_TARGET(B600),
+    ENUM_TARGET(B1200),
+    ENUM_TARGET(B1800),
+    ENUM_TARGET(B2400),
+    ENUM_TARGET(B4800),
+    ENUM_TARGET(B9600),
+    ENUM_TARGET(B19200),
+    ENUM_TARGET(B38400),
+    ENUM_TARGET(B57600),
+    ENUM_TARGET(B115200),
+    ENUM_TARGET(B230400),
+    ENUM_TARGET(B460800),
+    ENUM_END,
+};
+
+UNUSED static struct enums termios_cflags_CSIZE[] = {
+    ENUM_TARGET(CS5),
+    ENUM_TARGET(CS6),
+    ENUM_TARGET(CS7),
+    ENUM_TARGET(CS8),
+    ENUM_END,
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
+    FLAG_TARGET(EXTPROC),
+    FLAG_END,
+};
+
 UNUSED static struct flags mlockall_flags[] = {
     FLAG_TARGET(MCL_CURRENT),
     FLAG_TARGET(MCL_FUTURE),
@@ -1579,6 +1713,67 @@ print_itimerval(abi_ulong it_addr, int last)
     }
 }
 
+void
+print_termios(void *arg)
+{
+    const struct target_termios *target = arg;
+
+    target_tcflag_t iflags = tswap32(target->c_iflag);
+    target_tcflag_t oflags = tswap32(target->c_oflag);
+    target_tcflag_t cflags = tswap32(target->c_cflag);
+    target_tcflag_t lflags = tswap32(target->c_lflag);
+
+    qemu_log("{");
+
+    qemu_log("c_iflag = ");
+    print_flags(termios_iflags, iflags, 0);
+
+    qemu_log("c_oflag = ");
+    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | TARGET_CRDLY |
+                                               TARGET_TABDLY | TARGET_BSDLY |
+                                               TARGET_VTDLY | TARGET_FFDLY);
+    print_flags(termios_oflags, oflags_clean, 0);
+    if (oflags & TARGET_NLDLY) {
+        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
+    }
+    if (oflags & TARGET_CRDLY) {
+        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
+    }
+    if (oflags & TARGET_TABDLY) {
+        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
+    }
+    if (oflags & TARGET_BSDLY) {
+        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
+    }
+    if (oflags & TARGET_VTDLY) {
+        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
+    }
+    if (oflags & TARGET_FFDLY) {
+        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
+    }
+
+    qemu_log("c_cflag = ");
+    if (cflags & TARGET_CBAUD) {
+        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
+    }
+    if (cflags & TARGET_CSIZE) {
+        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
+    }
+    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
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
index e815f14bac..6dc230cd0b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5669,6 +5669,7 @@ static const StructEntry struct_termios_def = {
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


