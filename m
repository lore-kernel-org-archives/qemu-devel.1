Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A853420771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A853420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6FbP-0004Xw-VF
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k6FZl-0002iq-JD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:55:33 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:45829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k6FZj-0005M8-6f
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 11:55:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-CeR_dc2aPdCgVD1Ru8TxpQ-1; Thu, 13 Aug 2020 11:55:25 -0400
X-MC-Unique: CeR_dc2aPdCgVD1Ru8TxpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98DA21854FD8;
 Thu, 13 Aug 2020 15:55:23 +0000 (UTC)
Received: from bahia.lan (ovpn-113-39.ams2.redhat.com [10.36.113.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB65C1055802;
 Thu, 13 Aug 2020 15:55:20 +0000 (UTC)
Subject: [PATCH] nvram: Exit QEMU if NVRAM cannot contain all -prom-env data
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Date: Thu, 13 Aug 2020 17:55:19 +0200
Message-ID: <159733411975.310189.16449844820314232863.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 11:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
support the -prom-env parameter"), pseries machines can pre-initialize
the "system" partition in the NVRAM with the data passed to all -prom-env
parameters on the QEMU command line.

In this case it is assumed that all the data fits in 64 KiB, but the user
can easily pass more and crash QEMU:

$ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
  echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
  done) # this requires ~128 Kib
malloc(): corrupted top size
Aborted (core dumped)

This happens because we don't check if all the prom-env data fits in
the NVRAM and chrp_nvram_set_var() happily memcpy() it passed the
buffer.

This crash affects basically all ppc/ppc64 machine types that use -prom-env=
:
- pseries (all versions)
- g3beige
- mac99

and also sparc/sparc64 machine types:
- LX
- SPARCClassic
- SPARCbook
- SS-10
- SS-20
- SS-4
- SS-5
- SS-600MP
- Voyager
- sun4u
- sun4v

Add a max_len argument to chrp_nvram_create_system_partition() so that
it can check the available size before writing to memory.

Since NVRAM is populated at machine init, it seems reasonable to consider
this error as fatal. So, instead of reporting an error when we detect that
the NVRAM is too small and adapt all machine types to handle it, we simply
exit QEMU in all cases. This is still better than crashing. If someone
wants another behavior, I guess this can be reworked later.

Tested with:

$ yes q | \
  (for arch in ppc ppc64 sparc sparc64; do \
       echo =3D=3D $arch =3D=3D; \
       qemu=3D${arch}-softmmu/qemu-system-$arch; \
       for mach in $($qemu -M help | awk '! /^Supported/ { print $1 }'); do=
 \
           echo $mach; \
           $qemu -M $mach -monitor stdio -nodefaults -nographic \
           $(for ((x=3D0;x<128;x++)); do \
                 echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
             done) >/dev/null; \
        done; echo; \
   done)

Without the patch, affected machine types cause QEMU to report some
memory corruption and crash:

malloc(): corrupted top size

free(): invalid size

*** stack smashing detected ***: terminated

With the patch, QEMU prints the following message and exits:

NVRAM is too small. Try to pass less data to -prom-env

It seems that the conditions for the crash have always existed, but it
affects pseries, the machine type I care for, since commit 61f20b9dc5b7
only.

Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support the =
-prom-env parameter")
RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1867739
Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This replaces the following series:

[PATCH v2 0/2] spapr/nvram: Fix QEMU crash
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D195269
---
 hw/nvram/chrp_nvram.c         |   24 +++++++++++++++++++++---
 hw/nvram/mac_nvram.c          |    2 +-
 hw/nvram/spapr_nvram.c        |    3 ++-
 hw/sparc/sun4m.c              |    2 +-
 hw/sparc64/sun4u.c            |    2 +-
 include/hw/nvram/chrp_nvram.h |    3 ++-
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/chrp_nvram.c b/hw/nvram/chrp_nvram.c
index d969f267048e..d4d10a7c03c7 100644
--- a/hw/nvram/chrp_nvram.c
+++ b/hw/nvram/chrp_nvram.c
@@ -21,14 +21,21 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "sysemu/sysemu.h"
=20
-static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str)
+static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str,
+                              int max_len)
 {
     int len;
=20
     len =3D strlen(str) + 1;
+
+    if (max_len < len) {
+        return -1;
+    }
+
     memcpy(&nvram[addr], str, len);
=20
     return addr + len;
@@ -38,19 +45,26 @@ static int chrp_nvram_set_var(uint8_t *nvram, int addr,=
 const char *str)
  * Create a "system partition", used for the Open Firmware
  * environment variables.
  */
-int chrp_nvram_create_system_partition(uint8_t *data, int min_len)
+int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int max=
_len)
 {
     ChrpNvramPartHdr *part_header;
     unsigned int i;
     int end;
=20
+    if (max_len < sizeof(*part_header)) {
+        goto fail;
+    }
+
     part_header =3D (ChrpNvramPartHdr *)data;
     part_header->signature =3D CHRP_NVPART_SYSTEM;
     pstrcpy(part_header->name, sizeof(part_header->name), "system");
=20
     end =3D sizeof(ChrpNvramPartHdr);
     for (i =3D 0; i < nb_prom_envs; i++) {
-        end =3D chrp_nvram_set_var(data, end, prom_envs[i]);
+        end =3D chrp_nvram_set_var(data, end, prom_envs[i], max_len - end)=
;
+        if (end =3D=3D -1) {
+            goto fail;
+        }
     }
=20
     /* End marker */
@@ -65,6 +79,10 @@ int chrp_nvram_create_system_partition(uint8_t *data, in=
t min_len)
     chrp_nvram_finish_partition(part_header, end);
=20
     return end;
+
+fail:
+    error_report("NVRAM is too small. Try to pass less data to -prom-env")=
;
+    exit(EXIT_FAILURE);
 }
=20
 /**
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index beec1c4e4d11..11f2d31cdb20 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -141,7 +141,7 @@ static void pmac_format_nvram_partition_of(MacIONVRAMSt=
ate *nvr, int off,
=20
     /* OpenBIOS nvram variables partition */
     sysp_end =3D chrp_nvram_create_system_partition(&nvr->data[off],
-                                                  DEF_SYSTEM_SIZE) + off;
+                                                  DEF_SYSTEM_SIZE, len) + =
off;
=20
     /* Free space partition */
     chrp_nvram_create_free_partition(&nvr->data[sysp_end], len - sysp_end)=
;
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 15d08281d411..386513499f59 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -188,7 +188,8 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, Er=
ror **errp)
         }
     } else if (nb_prom_envs > 0) {
         /* Create a system partition to pass the -prom-env variables */
-        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4)=
;
+        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4,
+                                           nvram->size);
         chrp_nvram_create_free_partition(&nvram->buf[MIN_NVRAM_SIZE / 4],
                                          nvram->size - MIN_NVRAM_SIZE / 4)=
;
     }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 9be930415f8e..7d791ee82368 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -143,7 +143,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
     memset(image, '\0', sizeof(image));
=20
     /* OpenBIOS nvram variables partition */
-    sysp_end =3D chrp_nvram_create_system_partition(image, 0);
+    sysp_end =3D chrp_nvram_create_system_partition(image, 0, sizeof(image=
));
=20
     /* Free space partition */
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9e30203dcc44..bd0a6283f339 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -136,7 +136,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_=
t NVRAM_size,
     memset(image, '\0', sizeof(image));
=20
     /* OpenBIOS nvram variables partition */
-    sysp_end =3D chrp_nvram_create_system_partition(image, 0);
+    sysp_end =3D chrp_nvram_create_system_partition(image, 0, sizeof(image=
));
=20
     /* Free space partition */
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.h
index 09941a9be454..4a0f5c21b884 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -50,7 +50,8 @@ chrp_nvram_finish_partition(ChrpNvramPartHdr *header, uin=
t32_t size)
     header->checksum =3D sum & 0xff;
 }
=20
-int chrp_nvram_create_system_partition(uint8_t *data, int min_len);
+/* chrp_nvram_create_system_partition() failure is fatal */
+int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int max=
_len);
 int chrp_nvram_create_free_partition(uint8_t *data, int len);
=20
 #endif



