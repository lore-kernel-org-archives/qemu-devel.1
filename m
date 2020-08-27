Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FEC207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FEC207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNXa-0007FD-Fm
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS9-0004IZ-Eg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS4-0000Hf-Hc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:53 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCKO4-1kKl7M3sxO-009Sui; Thu, 27 Aug 2020 21:20:39 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] linux-user: Add strace support for printing arguments
 for ioctls used for terminals and serial lines
Date: Thu, 27 Aug 2020 21:20:11 +0200
Message-Id: <20200827192018.2442099-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y4bw08JHfOGhNVxi32D3iGN7ty/cltgt5tSsq3spaUoCvb0udr2
 KV0YApc9HWFUjN+/+FBWVRi3ik/WBR1oBXcbR7C9vpY5F8Hh5RF2LRog3QqFfmpRZS4/ly3
 wuisP7a1R/FGROOJ3I06MiJZI/dOXBg/ssQ6OWmIabiN0VZC2Zvwg4DXyDe3rmS6PLg5njo
 mNoA2PUDCF2CaxyaoPspw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iylAp4DpNF4=:cAmYEnwEBRbeoDBWmMjp9G
 61Lhhg963qw+EV5IzLKjwQ3lQLuNKKhjlZb0IHgsqotK/y9ZPlym9LfN4eVKYvdEwZ/Sys4R9
 eIe5wa8uqVf1yKlzTtcSsh8Pa63IFBlQo/9FPCOtRChnBqV/CbuvYxmKUu5Zi2985hQ4RIfK+
 51Dm6k7n7pETY6/PyFe6GRAMpRuBNdVVOyOfDa6QwIWoHNo2Sq2NUU4whg2N3X8tRWyF2Yfxp
 SwZK9YMrIO43kYvoIKVLtUIr/nzXNMtpo8uA2Iz30qWL6pmsm0en/QQ9ek44V+HW2byLb0uIb
 O6GzteGcfVDk12WsM5Po5ovxyQTDUguYVLWRNFPTO81QuRkvXasfWmpjmH2+y+Dmu3EXqbZ0k
 rLjSbg+2R35tpJfB2QvbvwSvkaXoIDHZOSrKX2SrasORilmhTLu/2tQOiYrZW9+Kj8BRXlJq5
 lDgkpCIT8TXiD3hcEzc1PpaXj1tIYNq1yVt7638nMehhTrbLE7sXDPA3PA/+pAfOGmH9X5vAl
 nrDGL+N1BxXfKtWReEQ1Tzj7vyivobYEx1P1yv8VnWBFu0fAFn8nCJyMAotpvT/MIP7+1PfsF
 towtjUgw3FQNEI7ahviLnXwsXcE9ZHdihQLZh16fpGv0C8kILdvURBCpgmFG9ZDg4jTYqa/wI
 +W34Zcevt7v9lXj7nsJ/l6ZBQyr2LvhhBVG9Ng8Gl+OigfXJlQLMKQ/MzDqr9UX1U6Y3ZOM3L
 9tMwdlogNCDi66AnzzB7Ol5P4Tmiifg6xxcCvRSWuv5Bjyp05c6u6dGKWE+JIGo1p738+FMho
 2Jurdhsn6oz7KvkwFOualLpWLyBs2vV170VrwMJq4WMRXQ/N8ot7ZQMd2H8xJW8PZCQyp6b
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/user/thunk.h |   1 +
 linux-user/qemu.h         |   1 +
 linux-user/strace.c       | 195 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      |   1 +
 thunk.c                   |  23 +++--
 5 files changed, 212 insertions(+), 9 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 7992475c9f8a..a5bbb2c73331 100644
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
index f431805e573f..a69a0bd347c2 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,7 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+void print_termios(void *arg);
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
diff --git a/linux-user/strace.c b/linux-user/strace.c
index c7ef948b9451..4f77b0cf76eb 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1226,6 +1226,140 @@ UNUSED static struct flags falloc_flags[] = {
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
@@ -1553,6 +1687,67 @@ print_itimerval(abi_ulong it_addr, int last)
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
index 3a7eced7d858..78e404c23cad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5710,6 +5710,7 @@ static const StructEntry struct_termios_def = {
     .convert = { host_to_target_termios, target_to_host_termios },
     .size = { sizeof(struct target_termios), sizeof(struct host_termios) },
     .align = { __alignof__(struct target_termios), __alignof__(struct host_termios) },
+    .print = print_termios,
 };
 
 static bitmask_transtbl mmap_flags_tbl[] = {
diff --git a/thunk.c b/thunk.c
index c5d971974783..0718325d86e3 100644
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
2.26.2


