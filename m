Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F2CC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E498F229FA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E498F229FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHHN-0006Mh-8d
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hvHGj-0005qW-0u
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hvHGh-0007XH-3b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:26:00 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:37073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hvHGO-0007Q4-19; Wed, 07 Aug 2019 04:25:40 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 09:25:30 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 7 Aug 2019 09:25:37 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 7 Aug 2019
 09:25:37 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v6 01/26] configure: Define
 TARGET_ALIGNED_ONLY
Thread-Index: AQHVTPmwA9I8SFw7ZEyFe+TCySKK0g==
Date: Wed, 7 Aug 2019 08:25:37 +0000
Message-ID: <1565166336833.46550@bt.com>
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.44]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.74
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v6 01/26] configure: Define TARGET_ALIGNED_ONLY
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 cohuck@redhat.com, sagark@eecs.berkeley.edu, david@redhat.com,
 jasowang@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 i.mitsyanko@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com,
 frederic.konrad@adacore.com, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 xiaoguangrong.eric@gmail.com, peter.chubb@nicta.com.au, philmd@redhat.com,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 jcd@tribudubois.net, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, lersek@redhat.com, green@moxielogic.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, marex@denx.de, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 pbonzini@redhat.com, andrew@aj.id.au, kbastian@mail.uni-paderborn.de,
 crwulff@gmail.com, laurent@vivier.eu, Andrew.Baumann@microsoft.com,
 sundeep.lkml@gmail.com, andrew.smirnov@gmail.com, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, imammedo@redhat.com, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
defines out of target/foo/cpu.h into configure, as we do with
TARGET_WORDS_BIGENDIAN, so that it is always defined early.

Poisoned TARGET_ALIGNED_ONLY to prevent use in common code.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 configure             | 10 +++++++++-
 include/exec/poison.h |  1 +
 include/qom/cpu.h     |  2 +-
 target/alpha/cpu.h    |  2 --
 target/hppa/cpu.h     |  1 -
 target/mips/cpu.h     |  2 --
 target/sh4/cpu.h      |  2 --
 target/sparc/cpu.h    |  2 --
 target/xtensa/cpu.h   |  2 --
 tcg/tcg.c             |  2 +-
 tcg/tcg.h             |  8 +++++---
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 714e7fb..482ba0b 100755
--- a/configure
+++ b/configure
@@ -7431,8 +7431,13 @@ for target in $target_list; do
 target_dir=3D"$target"
 config_target_mak=3D$target_dir/config-target.mak
 target_name=3D$(echo $target | cut -d '-' -f 1)
+target_aligned_only=3D"no"
+case "$target_name" in
+  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc=
|sparc64|sparc32plus|xtensa|xtensaeb)
+  target_aligned_only=3D"yes"
+  ;;
+esac
 target_bigendian=3D"no"
-
 case "$target_name" in
   armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1=
k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=3Dyes
@@ -7717,6 +7722,9 @@ fi
 if supported_whpx_target $target; then
     echo "CONFIG_WHPX=3Dy" >> $config_target_mak
 fi
+if test "$target_aligned_only" =3D "yes" ; then
+  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
+fi
 if test "$target_bigendian" =3D "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
 fi
diff --git a/include/exec/poison.h b/include/exec/poison.h
index b862320..955eb86 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -35,6 +35,7 @@
 #pragma GCC poison TARGET_UNICORE32
 #pragma GCC poison TARGET_XTENSA

+#pragma GCC poison TARGET_ALIGNED_ONLY
 #pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046..9b50b73 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -89,7 +89,7 @@ struct TranslationBlock;
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed inste=
ad)
  * @do_unaligned_access: Callback for unaligned access handling, if
- * the target defines #ALIGNED_ONLY.
+ * the target defines #TARGET_ALIGNED_ONLY.
  * @do_transaction_failed: Callback for handling failed memory transaction=
s
  * (ie bus faults or external aborts; not MMU faults)
  * @virtio_is_big_endian: Callback to return %true if a CPU which supports
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b3e8a82..16eb804 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -23,8 +23,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"

-#define ALIGNED_ONLY
-
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index aab251b..2be67c2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,7 +30,6 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL

-#define ALIGNED_ONLY
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     3
 #define MMU_PHYS_IDX     4
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 21c0615..c13cd4e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1,8 +1,6 @@
 #ifndef MIPS_CPU_H
 #define MIPS_CPU_H

-#define ALIGNED_ONLY
-
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index aee733e..ecaa7a1 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -23,8 +23,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"

-#define ALIGNED_ONLY
-
 /* CPU Subtypes */
 #define SH_CPU_SH7750  (1 << 0)
 #define SH_CPU_SH7750S (1 << 1)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8ed2250..1406f0b 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -5,8 +5,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"

-#define ALIGNED_ONLY
-
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #else
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 2c27713..0459243 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -32,8 +32,6 @@
 #include "exec/cpu-defs.h"
 #include "xtensa-isa.h"

-#define ALIGNED_ONLY
-
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c..8d23fb0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =3D
 };

 static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] =3D =
{
-#ifdef ALIGNED_ONLY
+#ifdef TARGET_ALIGNED_ONLY
     [MO_UNALN >> MO_ASHIFT]    =3D "un+",
     [MO_ALIGN >> MO_ASHIFT]    =3D "",
 #else
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17..529acb2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -333,10 +333,12 @@ typedef enum TCGMemOp {
     MO_TE    =3D MO_LE,
 #endif

-    /* MO_UNALN accesses are never checked for alignment.
+    /*
+     * MO_UNALN accesses are never checked for alignment.
      * MO_ALIGN accesses will result in a call to the CPU's
      * do_unaligned_access hook if the guest address is not aligned.
-     * The default depends on whether the target CPU defines ALIGNED_ONLY.
+     * The default depends on whether the target CPU defines
+     * TARGET_ALIGNED_ONLY.
      *
      * Some architectures (e.g. ARMv8) need the address which is aligned
      * to a size more than the size of the memory access.
@@ -353,7 +355,7 @@ typedef enum TCGMemOp {
      */
     MO_ASHIFT =3D 4,
     MO_AMASK =3D 7 << MO_ASHIFT,
-#ifdef ALIGNED_ONLY
+#ifdef TARGET_ALIGNED_ONLY
     MO_ALIGN =3D 0,
     MO_UNALN =3D MO_AMASK,
 #else
--
1.8.3.1



