Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD2C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3105921921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 03:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3105921921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpOzD-0007Ns-9T
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 23:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpOyz-0006qK-Kq
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpOyy-0007qI-7m
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:27:25 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:41456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hpOyx-0007nE-VC
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 23:27:24 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 22 Jul 2019 04:23:43 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 04:27:21 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 04:27:21 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 1/2] configure: Define target access
 alignment in configure
Thread-Index: AQHVQD1fPxYEHSQpNkukvGKERP01mw==
Date: Mon, 22 Jul 2019 03:27:21 +0000
Message-ID: <1563766040903.29641@bt.com>
References: <945056df7ff54ce6b272dce64721d916@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <945056df7ff54ce6b272dce64721d916@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Subject: [Qemu-devel] [PATCH v2 1/2] configure: Define target access
 alignment in configure
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
Cc: ehabkost@redhat.com, arikalo@wavecomp.com, mark.cave-ayland@ilande.co.uk,
 jcmvbkbc@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com,
 atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the define of target access alignment earlier from=0A=
target/foo/cpu.h to configure.=0A=
=0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
---=0A=
 configure             | 10 +++++++++-=0A=
 include/exec/poison.h |  1 +=0A=
 include/qom/cpu.h     |  2 +-=0A=
 target/alpha/cpu.h    |  2 --=0A=
 target/hppa/cpu.h     |  1 -=0A=
 target/mips/cpu.h     |  2 --=0A=
 target/sh4/cpu.h      |  2 --=0A=
 target/sparc/cpu.h    |  2 --=0A=
 target/xtensa/cpu.h   |  2 --=0A=
 tcg/tcg.c             |  2 +-=0A=
 tcg/tcg.h             |  8 +++++---=0A=
 11 files changed, 17 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/configure b/configure=0A=
index eb635c3..8316a16 100755=0A=
--- a/configure=0A=
+++ b/configure=0A=
@@ -7424,8 +7424,13 @@ for target in $target_list; do=0A=
 target_dir=3D"$target"=0A=
 config_target_mak=3D$target_dir/config-target.mak=0A=
 target_name=3D$(echo $target | cut -d '-' -f 1)=0A=
+target_aligned_only=3D"no"=0A=
+case "$target_name" in=0A=
+  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc=
|sparc64|sparc32plus|xtensa|xtensaeb)=0A=
+  target_aligned_only=3D"yes"=0A=
+  ;;=0A=
+esac=0A=
 target_bigendian=3D"no"=0A=
-=0A=
 case "$target_name" in=0A=
   armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1=
k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)=0A=
   target_bigendian=3Dyes=0A=
@@ -7710,6 +7715,9 @@ fi=0A=
 if supported_whpx_target $target; then=0A=
     echo "CONFIG_WHPX=3Dy" >> $config_target_mak=0A=
 fi=0A=
+if test "$target_aligned_only" =3D "yes" ; then=0A=
+  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak=0A=
+fi=0A=
 if test "$target_bigendian" =3D "yes" ; then=0A=
   echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak=0A=
 fi=0A=
diff --git a/include/exec/poison.h b/include/exec/poison.h=0A=
index b862320..955eb86 100644=0A=
--- a/include/exec/poison.h=0A=
+++ b/include/exec/poison.h=0A=
@@ -35,6 +35,7 @@=0A=
 #pragma GCC poison TARGET_UNICORE32=0A=
 #pragma GCC poison TARGET_XTENSA=0A=
 =0A=
+#pragma GCC poison TARGET_ALIGNED_ONLY=0A=
 #pragma GCC poison TARGET_HAS_BFLT=0A=
 #pragma GCC poison TARGET_NAME=0A=
 #pragma GCC poison TARGET_SUPPORTS_MTTCG=0A=
diff --git a/include/qom/cpu.h b/include/qom/cpu.h=0A=
index 5ee0046..9b50b73 100644=0A=
--- a/include/qom/cpu.h=0A=
+++ b/include/qom/cpu.h=0A=
@@ -89,7 +89,7 @@ struct TranslationBlock;=0A=
  * @do_unassigned_access: Callback for unassigned access handling.=0A=
  * (this is deprecated: new targets should use do_transaction_failed inste=
ad)=0A=
  * @do_unaligned_access: Callback for unaligned access handling, if=0A=
- * the target defines #ALIGNED_ONLY.=0A=
+ * the target defines #TARGET_ALIGNED_ONLY.=0A=
  * @do_transaction_failed: Callback for handling failed memory transaction=
s=0A=
  * (ie bus faults or external aborts; not MMU faults)=0A=
  * @virtio_is_big_endian: Callback to return %true if a CPU which supports=
=0A=
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h=0A=
index b3e8a82..16eb804 100644=0A=
--- a/target/alpha/cpu.h=0A=
+++ b/target/alpha/cpu.h=0A=
@@ -23,8 +23,6 @@=0A=
 #include "cpu-qom.h"=0A=
 #include "exec/cpu-defs.h"=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
-=0A=
 /* Alpha processors have a weak memory model */=0A=
 #define TCG_GUEST_DEFAULT_MO      (0)=0A=
 =0A=
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h=0A=
index aab251b..2be67c2 100644=0A=
--- a/target/hppa/cpu.h=0A=
+++ b/target/hppa/cpu.h=0A=
@@ -30,7 +30,6 @@=0A=
    basis.  It's probably easier to fall back to a strong memory model.  */=
=0A=
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
 #define MMU_KERNEL_IDX   0=0A=
 #define MMU_USER_IDX     3=0A=
 #define MMU_PHYS_IDX     4=0A=
diff --git a/target/mips/cpu.h b/target/mips/cpu.h=0A=
index 21c0615..c13cd4e 100644=0A=
--- a/target/mips/cpu.h=0A=
+++ b/target/mips/cpu.h=0A=
@@ -1,8 +1,6 @@=0A=
 #ifndef MIPS_CPU_H=0A=
 #define MIPS_CPU_H=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
-=0A=
 #include "cpu-qom.h"=0A=
 #include "exec/cpu-defs.h"=0A=
 #include "fpu/softfloat.h"=0A=
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h=0A=
index aee733e..ecaa7a1 100644=0A=
--- a/target/sh4/cpu.h=0A=
+++ b/target/sh4/cpu.h=0A=
@@ -23,8 +23,6 @@=0A=
 #include "cpu-qom.h"=0A=
 #include "exec/cpu-defs.h"=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
-=0A=
 /* CPU Subtypes */=0A=
 #define SH_CPU_SH7750  (1 << 0)=0A=
 #define SH_CPU_SH7750S (1 << 1)=0A=
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h=0A=
index 8ed2250..1406f0b 100644=0A=
--- a/target/sparc/cpu.h=0A=
+++ b/target/sparc/cpu.h=0A=
@@ -5,8 +5,6 @@=0A=
 #include "cpu-qom.h"=0A=
 #include "exec/cpu-defs.h"=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
-=0A=
 #if !defined(TARGET_SPARC64)=0A=
 #define TARGET_DPREGS 16=0A=
 #else=0A=
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h=0A=
index 2c27713..0459243 100644=0A=
--- a/target/xtensa/cpu.h=0A=
+++ b/target/xtensa/cpu.h=0A=
@@ -32,8 +32,6 @@=0A=
 #include "exec/cpu-defs.h"=0A=
 #include "xtensa-isa.h"=0A=
 =0A=
-#define ALIGNED_ONLY=0A=
-=0A=
 /* Xtensa processors have a weak memory model */=0A=
 #define TCG_GUEST_DEFAULT_MO      (0)=0A=
 =0A=
diff --git a/tcg/tcg.c b/tcg/tcg.c=0A=
index be2c33c..8d23fb0 100644=0A=
--- a/tcg/tcg.c=0A=
+++ b/tcg/tcg.c=0A=
@@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =3D=0A=
 };=0A=
 =0A=
 static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] =3D =
{=0A=
-#ifdef ALIGNED_ONLY=0A=
+#ifdef TARGET_ALIGNED_ONLY=0A=
     [MO_UNALN >> MO_ASHIFT]    =3D "un+",=0A=
     [MO_ALIGN >> MO_ASHIFT]    =3D "",=0A=
 #else=0A=
diff --git a/tcg/tcg.h b/tcg/tcg.h=0A=
index b411e17..529acb2 100644=0A=
--- a/tcg/tcg.h=0A=
+++ b/tcg/tcg.h=0A=
@@ -333,10 +333,12 @@ typedef enum TCGMemOp {=0A=
     MO_TE    =3D MO_LE,=0A=
 #endif=0A=
 =0A=
-    /* MO_UNALN accesses are never checked for alignment.=0A=
+    /*=0A=
+     * MO_UNALN accesses are never checked for alignment.=0A=
      * MO_ALIGN accesses will result in a call to the CPU's=0A=
      * do_unaligned_access hook if the guest address is not aligned.=0A=
-     * The default depends on whether the target CPU defines ALIGNED_ONLY.=
=0A=
+     * The default depends on whether the target CPU defines=0A=
+     * TARGET_ALIGNED_ONLY.=0A=
      *=0A=
      * Some architectures (e.g. ARMv8) need the address which is aligned=
=0A=
      * to a size more than the size of the memory access.=0A=
@@ -353,7 +355,7 @@ typedef enum TCGMemOp {=0A=
      */=0A=
     MO_ASHIFT =3D 4,=0A=
     MO_AMASK =3D 7 << MO_ASHIFT,=0A=
-#ifdef ALIGNED_ONLY=0A=
+#ifdef TARGET_ALIGNED_ONLY=0A=
     MO_ALIGN =3D 0,=0A=
     MO_UNALN =3D MO_AMASK,=0A=
 #else=0A=
-- =0A=
1.8.3.1=0A=

