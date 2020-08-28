Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1297C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC0B207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC0B207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBecx-0002lD-L0
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea9-00041l-Ob
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea7-0007HA-3f
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:17 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUl4z-1k2gQu2QbJ-00Qg2V; Fri, 28 Aug 2020 15:38:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] linux-user: Add strace support for printing arguments
 for ioctls used for terminals and serial lines
Date: Fri, 28 Aug 2020 15:37:46 +0200
Message-Id: <20200828133753.2622286-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OfUFSBpm2VR7XPGxzZ7e8xz1nAelExVYE7Pe3fGgOI44tiGI6f+
 AfAwTjch9uGZQ7xVDe0pS2SxpRr+/113IVWaFjobTunDU0GQsRMqhZ7zuxDc80bWK7OD9vW
 TdthtuCwQwNd+xrU9cQis6Oc1vACN9HibX4ocprzkgBerM+baUyr0kWkQ5QPLTGMTDdXlZP
 TTV6FFSrFLwMp6un8eSUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FshvhUZA+3Y=:anyHnDESc60UjRwHcaQ2XJ
 c9Y+y2uI5dafbRKR5nHzpJsINTK8vLo2nOmpCz3GMDnr/ja+di4HlWCb63HheAcqkRZaRq337
 CJuurT+wwclKfKZNbFblEeta54wZVV4u81l0WgoaJmrKt/++0ZXwwqlsvUIUnHjNyjJtxb76U
 gh5OGuxQYfpFBwnXgEZS86AT3cQCl/MPyt7ysBKE20AbzadoPdXLMbKO+oKxtb7CNTVEU6bz0
 poS55HdjtuAsraFS0dtbfQy2ZOHOvVlTPJKAifcd4R/LhKIAEGsuogsOfY1losPxW30OYx4Gd
 5pgGBdOpWPQ7dFc2mcvaWzS5Ziwy2pbYeMJAX3EK5IDw8Ux8jBO/15ks7FcU7iO+gBa4t6nbq
 hhZOoLelPL7YsDh16/AsU8thNZVyQmJgz1JToap2M6xAf0D+Ir/nNTFkhVfgOOS5KAt0F5kMj
 8ZDDaGDg2Y9aKz0ja/40gdDf1TewDDhX1s3AbVcHQwltbVOtepd+/moS6w+I/sDnulH0Med8+
 gBWbaBGmm0FAQNgAKMfWqyFYpJXnU41+BII+AQdxi4u0gvI3IWH32eXdhz4elLDy+ZKa3SquB
 wtJM0Sx8ypZsAyRpXINfDPUWCkOq1AAuXOypLE00hgp8GAjmEc9w5LaOy4jR+suf5fGEpTpBG
 KxMFqIh8H7/9F8qqOipQn1uPSYv+NDSrTgekqdTlYKwzguhG2nEsSK8u96XvXcKKThaSoiYoG
 vX3yMIrF/4o5KIvZgsmClft5xeh71IUblgFRkQLWgCR5Gg4BvdmJCPjbA+67mkfFgGGvlC2FZ
 HNHCGENWPjAB97WhV4Doe7iGTDShF5VVZ945/+jVS9AdaZZ9OfDO0bZg3aGJAcgeb/c+SZ1
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:02
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


