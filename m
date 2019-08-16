Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B622077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B622077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyWNW-0004Ii-Mp
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWMm-0003ai-9m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWMh-0006qA-2W
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:09:40 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.235]:55508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWM9-0006cq-MI; Fri, 16 Aug 2019 03:09:02 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 16 Aug 2019 08:14:54 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:08:58 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:08:58 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 01/42] configure: Define
 TARGET_ALIGNED_ONLY
Thread-Index: AQHVVAF5i4oYfhiDzEeoIHrQlSlk7Q==
Date: Fri, 16 Aug 2019 07:08:58 +0000
Message-ID: <1565939336110.11174@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.235
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 01/42] configure: Define TARGET_ALIGNED_ONLY
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

?

