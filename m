Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600E6C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D548217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgfUNWqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D548217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HPT-0006YC-4h
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j2HNL-0004xh-ST
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j2HNG-0005Pw-TR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:30:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j2HNG-0005NF-M9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581611397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDv538WkfqBw1ByGxv25dI2UOalSo5k7Dv7uM94eajQ=;
 b=bgfUNWqDs1Vx3Ccq/4tuUFUP7BH7SmEC2RgM5t9Q8eHdG3qg/TGVTy5bHXeuRXnspA1n/h
 7S4F+IgRxxR3/yOoLRDfkNI+GdoeATwaOfcWOOtcuhM9Yz6bncR7elXRskHHd352DzzA3R
 EEN7kuv5DqwTe54EoFwCkVLOAiyrcAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Q3m1kwg2NymC1gh_WOI0xw-1; Thu, 13 Feb 2020 11:29:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53B75107ACC4;
 Thu, 13 Feb 2020 16:29:53 +0000 (UTC)
Received: from localhost (ovpn-117-100.ams2.redhat.com [10.36.117.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A9615C1BB;
 Thu, 13 Feb 2020 16:29:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v2 2/2] docs: rstfy vfio-ap documentation
Date: Thu, 13 Feb 2020 17:29:42 +0100
Message-Id: <20200213162942.14177-3-cohuck@redhat.com>
In-Reply-To: <20200213162942.14177-1-cohuck@redhat.com>
References: <20200213162942.14177-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Q3m1kwg2NymC1gh_WOI0xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move to system/, as this is mostly about configuring vfio-ap.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                              |   2 +-
 docs/system/index.rst                    |   1 +
 docs/{vfio-ap.txt =3D> system/vfio-ap.rst} | 796 ++++++++++++-----------
 3 files changed, 420 insertions(+), 379 deletions(-)
 rename docs/{vfio-ap.txt =3D> system/vfio-ap.rst} (55%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34b766f89d32..da6d0f412356 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1554,7 +1554,7 @@ F: hw/s390x/ap-bridge.c
 F: include/hw/s390x/ap-device.h
 F: include/hw/s390x/ap-bridge.h
 F: hw/vfio/ap.c
-F: docs/vfio-ap.txt
+F: docs/system/vfio-ap.rst
 L: qemu-s390x@nongnu.org
=20
 vhost
diff --git a/docs/system/index.rst b/docs/system/index.rst
index f66e6ea585cd..1a4b2c82acef 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -15,3 +15,4 @@ Contents:
    :maxdepth: 2
=20
    qemu-block-drivers
+   vfio-ap
diff --git a/docs/vfio-ap.txt b/docs/system/vfio-ap.rst
similarity index 55%
rename from docs/vfio-ap.txt
rename to docs/system/vfio-ap.rst
index b1eb2deeaf2f..3cd84179a2df 100644
--- a/docs/vfio-ap.txt
+++ b/docs/system/vfio-ap.rst
@@ -1,17 +1,11 @@
 Adjunct Processor (AP) Device
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
-Contents:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-* Introduction
-* AP Architectural Overview
-* Start Interpretive Execution (SIE) Instruction
-* AP Matrix Configuration on Linux Host
-* Starting a Linux Guest Configured with an AP Matrix
-* Example: Configure AP Matrices for Three Linux Guests
-
-Introduction:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+.. contents::
+
+Introduction
+------------
+
 The IBM Adjunct Processor (AP) Cryptographic Facility is comprised
 of three AP instructions and from 1 to 256 PCIe cryptographic adapter card=
s.
 These AP devices provide cryptographic functions to all CPUs assigned to a
@@ -21,8 +15,9 @@ On s390x, AP adapter cards are exposed via the AP bus. Th=
is document
 describes how those cards may be made available to KVM guests using the
 VFIO mediated device framework.
=20
-AP Architectural Overview:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+AP Architectural Overview
+-------------------------
+
 In order understand the terminology used in the rest of this document, let=
's
 start with some definitions:
=20
@@ -75,7 +70,8 @@ start with some definitions:
   must be one of the control domains.
=20
 Start Interpretive Execution (SIE) Instruction
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+----------------------------------------------
+
 A KVM guest is started by executing the Start Interpretive Execution (SIE)
 instruction. The SIE state description is a control block that contains th=
e
 state information for a KVM guest and is supplied as input to the SIE
@@ -114,246 +110,278 @@ The APQNs can provide secure key functionality - i.=
e., a private key is stored
 on the adapter card for each of its domains - so each APQN must be assigne=
d to
 at most one guest or the linux host.
=20
-   Example 1: Valid configuration:
-   ------------------------------
-   Guest1: adapters 1,2  domains 5,6
-   Guest2: adapter  1,2  domain 7
+Example 1: Valid configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
++----------+--------+--------+
+|          | Guest1 | Guest2 |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D+
+| adapters |  1, 2  |  1, 2  |
++----------+--------+--------+
+| domains  |  5, 6  |  7     |
++----------+--------+--------+
+
+This is valid because both guests have a unique set of APQNs:
+
+* Guest1 has APQNs (1,5), (1,6), (2,5) and (2,6);
+* Guest2 has APQNs (1,7) and (2,7).
+
+Example 2: Valid configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
++----------+--------+--------+
+|          | Guest1 | Guest2 |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D+
+| adapters |  1, 2  |  3, 4  |
++----------+--------+--------+
+| domains  |  5, 6  |  5, 6  |
++----------+--------+--------+
=20
-   This is valid because both guests have a unique set of APQNs: Guest1 ha=
s
-   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
+This is also valid because both guests have a unique set of APQNs:
=20
-   Example 2: Valid configuration:
-   ------------------------------
-   Guest1: adapters 1,2 domains 5,6
-   Guest2: adapters 3,4 domains 5,6
+* Guest1 has APQNs (1,5), (1,6), (2,5), (2,6);
+* Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)
=20
-   This is also valid because both guests have a unique set of APQNs:
-      Guest1 has APQNs (1,5), (1,6), (2,5), (2,6);
-      Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)
+Example 3: Invalid configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-   Example 3: Invalid configuration:
-   --------------------------------
-   Guest1: adapters 1,2  domains 5,6
-   Guest2: adapter  1    domains 6,7
++----------+--------+--------+
+|          | Guest1 | Guest2 |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D+
+| adapters |  1, 2  |  1     |
++----------+--------+--------+
+| domains  |  5, 6  |  6, 7  |
++----------+--------+--------+
=20
-   This is an invalid configuration because both guests have access to
-   APQN (1,6).
+This is an invalid configuration because both guests have access to
+APQN (1,6).
+
+AP Matrix Configuration on Linux Host
+-------------------------------------
=20
-AP Matrix Configuration on Linux Host:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 A linux system is a guest of the LPAR in which it is running and has acces=
s to
 the AP resources configured for the LPAR. The LPAR's AP matrix is
 configured via its Activation Profile which can be edited on the HMC. When=
 the
 linux system is started, the AP bus will detect the AP devices assigned to=
 the
-LPAR and create the following in sysfs:
+LPAR and create the following in sysfs::
=20
-/sys/bus/ap
-... [devices]
-...... xx.yyyy
-...... ...
-...... cardxx
-...... ...
+  /sys/bus/ap
+  ... [devices]
+  ...... xx.yyyy
+  ...... ...
+  ...... cardxx
+  ...... ...
=20
 Where:
-    cardxx     is AP adapter number xx (in hex)
-....xx.yyyy    is an APQN with xx specifying the APID and yyyy specifying =
the
-               APQI
+
+``cardxx``
+  is AP adapter number xx (in hex)
+
+``xx.yyyy``
+  is an APQN with xx specifying the APID and yyyy specifying the APQI
=20
 For example, if AP adapters 5 and 6 and domains 4, 71 (0x47), 171 (0xab) a=
nd
 255 (0xff) are configured for the LPAR, the sysfs representation on the li=
nux
-host system would look like this:
-
-/sys/bus/ap
-... [devices]
-...... 05.0004
-...... 05.0047
-...... 05.00ab
-...... 05.00ff
-...... 06.0004
-...... 06.0047
-...... 06.00ab
-...... 06.00ff
-...... card05
-...... card06
+host system would look like this::
+
+  /sys/bus/ap
+  ... [devices]
+  ...... 05.0004
+  ...... 05.0047
+  ...... 05.00ab
+  ...... 05.00ff
+  ...... 06.0004
+  ...... 06.0047
+  ...... 06.00ab
+  ...... 06.00ff
+  ...... card05
+  ...... card06
=20
 A set of default device drivers are also created to control each type of A=
P
-device that can be assigned to the LPAR on which a linux host is running:
-
-/sys/bus/ap
-... [drivers]
-...... [cex2acard]        for Crypto Express 2/3 accelerator cards
-...... [cex2aqueue]       for AP queues served by Crypto Express 2/3
-                          accelerator cards
-...... [cex4card]         for Crypto Express 4/5/6 accelerator and coproce=
ssor
-                          cards
-...... [cex4queue]        for AP queues served by Crypto Express 4/5/6
-                          accelerator and coprocessor cards
-...... [pcixcccard]       for Crypto Express 2/3 coprocessor cards
-...... [pcixccqueue]      for AP queues served by Crypto Express 2/3
-                          coprocessor cards
+device that can be assigned to the LPAR on which a linux host is running::
+
+  /sys/bus/ap
+  ... [drivers]
+  ...... [cex2acard]        for Crypto Express 2/3 accelerator cards
+  ...... [cex2aqueue]       for AP queues served by Crypto Express 2/3
+                            accelerator cards
+  ...... [cex4card]         for Crypto Express 4/5/6 accelerator and copro=
cessor
+                            cards
+  ...... [cex4queue]        for AP queues served by Crypto Express 4/5/6
+                            accelerator and coprocessor cards
+  ...... [pcixcccard]       for Crypto Express 2/3 coprocessor cards
+  ...... [pcixccqueue]      for AP queues served by Crypto Express 2/3
+                            coprocessor cards
=20
 Binding AP devices to device drivers
-------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 There are two sysfs files that specify bitmasks marking a subset of the AP=
QN
 range as 'usable by the default AP queue device drivers' or 'not usable by=
 the
 default device drivers' and thus available for use by the alternate device
-driver(s). The sysfs locations of the masks are:
+driver(s). The sysfs locations of the masks are::
=20
    /sys/bus/ap/apmask
    /sys/bus/ap/aqmask
=20
-   The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
-   (APID). Each bit in the mask, from left to right (i.e., from most signi=
ficant
-   to least significant bit in big endian order), corresponds to an APID f=
rom
-   0-255. If a bit is set, the APID is marked as usable only by the defaul=
t AP
-   queue device drivers; otherwise, the APID is usable by the vfio_ap
-   device driver.
+The ``apmask`` is a 256-bit mask that identifies a set of AP adapter IDs
+(APID). Each bit in the mask, from left to right (i.e., from most signific=
ant
+to least significant bit in big endian order), corresponds to an APID from
+0-255. If a bit is set, the APID is marked as usable only by the default A=
P
+queue device drivers; otherwise, the APID is usable by the vfio_ap
+device driver.
=20
-   The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexe=
s
-   (APQI). Each bit in the mask, from left to right (i.e., from most signi=
ficant
-   to least significant bit in big endian order), corresponds to an APQI f=
rom
-   0-255. If a bit is set, the APQI is marked as usable only by the defaul=
t AP
-   queue device drivers; otherwise, the APQI is usable by the vfio_ap devi=
ce
-   driver.
+The ``aqmask`` is a 256-bit mask that identifies a set of AP queue indexes
+(APQI). Each bit in the mask, from left to right (i.e., from most signific=
ant
+to least significant bit in big endian order), corresponds to an APQI from
+0-255. If a bit is set, the APQI is marked as usable only by the default A=
P
+queue device drivers; otherwise, the APQI is usable by the vfio_ap device
+driver.
=20
-   Take, for example, the following mask:
+Take, for example, the following mask::
=20
       0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
=20
-    It indicates:
+It indicates:
=20
       1, 2, 3, 4, 5, and 7-255 belong to the default drivers' pool, and 0 =
and 6
       belong to the vfio_ap device driver's pool.
=20
-   The APQN of each AP queue device assigned to the linux host is checked =
by the
-   AP bus against the set of APQNs derived from the cross product of APIDs
-   and APQIs marked as usable only by the default AP queue device drivers.=
 If a
-   match is detected,  only the default AP queue device drivers will be pr=
obed;
-   otherwise, the vfio_ap device driver will be probed.
+The APQN of each AP queue device assigned to the linux host is checked by =
the
+AP bus against the set of APQNs derived from the cross product of APIDs
+and APQIs marked as usable only by the default AP queue device drivers. If=
 a
+match is detected,  only the default AP queue device drivers will be probe=
d;
+otherwise, the vfio_ap device driver will be probed.
=20
-   By default, the two masks are set to reserve all APQNs for use by the d=
efault
-   AP queue device drivers. There are two ways the default masks can be ch=
anged:
+By default, the two masks are set to reserve all APQNs for use by the defa=
ult
+AP queue device drivers. There are two ways the default masks can be chang=
ed:
=20
-   1. The sysfs mask files can be edited by echoing a string into the
-      respective sysfs mask file in one of two formats:
+ 1. The sysfs mask files can be edited by echoing a string into the
+    respective sysfs mask file in one of two formats:
=20
-      * An absolute hex string starting with 0x - like "0x12345678" - sets
-        the mask. If the given string is shorter than the mask, it is padd=
ed
-        with 0s on the right; for example, specifying a mask value of 0x41=
 is
-        the same as specifying:
+    * An absolute hex string starting with 0x - like "0x12345678" - sets
+      the mask. If the given string is shorter than the mask, it is padded
+      with 0s on the right; for example, specifying a mask value of 0x41 i=
s
+      the same as specifying::
=20
            0x4100000000000000000000000000000000000000000000000000000000000=
000
=20
-        Keep in mind that the mask reads from left to right (i.e., most
-        significant to least significant bit in big endian order), so the =
mask
-        above identifies device numbers 1 and 7 (01000001).
+      Keep in mind that the mask reads from left to right (i.e., most
+      significant to least significant bit in big endian order), so the ma=
sk
+      above identifies device numbers 1 and 7 (``01000001``).
=20
-        If the string is longer than the mask, the operation is terminated=
 with
-        an error (EINVAL).
+      If the string is longer than the mask, the operation is terminated w=
ith
+      an error (EINVAL).
=20
-      * Individual bits in the mask can be switched on and off by specifyi=
ng
-        each bit number to be switched in a comma separated list. Each bit
-        number string must be prepended with a ('+') or minus ('-') to ind=
icate
-        the corresponding bit is to be switched on ('+') or off ('-'). Som=
e
-        valid values are:
+    * Individual bits in the mask can be switched on and off by specifying
+      each bit number to be switched in a comma separated list. Each bit
+      number string must be prepended with a (``+``) or minus (``-``) to i=
ndicate
+      the corresponding bit is to be switched on (``+``) or off (``-``). S=
ome
+      valid values are::
=20
            "+0"    switches bit 0 on
            "-13"   switches bit 13 off
            "+0x41" switches bit 65 on
            "-0xff" switches bit 255 off
=20
-           The following example:
+      The following example::
+
               +0,-6,+0x47,-0xf0
=20
-              Switches bits 0 and 71 (0x47) on
-              Switches bits 6 and 240 (0xf0) off
+      Switches bits 0 and 71 (0x47) on
+      Switches bits 6 and 240 (0xf0) off
=20
-        Note that the bits not specified in the list remain as they were b=
efore
-        the operation.
+      Note that the bits not specified in the list remain as they were bef=
ore
+      the operation.
=20
-   2. The masks can also be changed at boot time via parameters on the ker=
nel
-      command line like this:
+ 2. The masks can also be changed at boot time via parameters on the kerne=
l
+    command line like this::
=20
          ap.apmask=3D0xffff ap.aqmask=3D0x40
=20
-         This would create the following masks:
+    This would create the following masks:
+
+    apmask::
=20
-            apmask:
             0xffff00000000000000000000000000000000000000000000000000000000=
0000
=20
-            aqmask:
+    aqmask::
+
             0x400000000000000000000000000000000000000000000000000000000000=
0000
=20
-         Resulting in these two pools:
+    Resulting in these two pools::
=20
             default drivers pool:    adapter 0-15, domain 1
             alternate drivers pool:  adapter 16-255, domains 0, 2-255
=20
-Configuring an AP matrix for a linux guest.
-------------------------------------------
+Configuring an AP matrix for a linux guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The sysfs interfaces for configuring an AP matrix for a guest are built on=
 the
 VFIO mediated device framework. To configure an AP matrix for a guest, a
-mediated matrix device must first be created for the /sys/devices/vfio_ap/=
matrix
+mediated matrix device must first be created for the ``/sys/devices/vfio_a=
p/matrix``
 device. When the vfio_ap device driver is loaded, it registers with the VF=
IO
 mediated device framework. When the driver registers, the sysfs interfaces=
 for
-creating mediated matrix devices is created:
+creating mediated matrix devices is created::
=20
-/sys/devices
-... [vfio_ap]
-......[matrix]
-......... [mdev_supported_types]
-............ [vfio_ap-passthrough]
-............... create
-............... [devices]
+  /sys/devices
+  ... [vfio_ap]
+  ......[matrix]
+  ......... [mdev_supported_types]
+  ............ [vfio_ap-passthrough]
+  ............... create
+  ............... [devices]
=20
 A mediated AP matrix device is created by writing a UUID to the attribute =
file
-named 'create', for example:
+named ``create``, for example::
=20
    uuidgen > create
=20
-   or
+or
+
+::
=20
    echo $uuid > create
=20
 When a mediated AP matrix device is created, a sysfs directory named after
-the UUID is created in the 'devices' subdirectory:
+the UUID is created in the ``devices`` subdirectory::
=20
-/sys/devices
-... [vfio_ap]
-......[matrix]
-......... [mdev_supported_types]
-............ [vfio_ap-passthrough]
-............... create
-............... [devices]
-.................. [$uuid]
+  /sys/devices
+  ... [vfio_ap]
+  ......[matrix]
+  ......... [mdev_supported_types]
+  ............ [vfio_ap-passthrough]
+  ............... create
+  ............... [devices]
+  .................. [$uuid]
=20
 There will also be three sets of attribute files created in the mediated
 matrix device's sysfs directory to configure an AP matrix for the
-KVM guest:
-
-/sys/devices
-... [vfio_ap]
-......[matrix]
-......... [mdev_supported_types]
-............ [vfio_ap-passthrough]
-............... create
-............... [devices]
-.................. [$uuid]
-..................... assign_adapter
-..................... assign_control_domain
-..................... assign_domain
-..................... matrix
-..................... unassign_adapter
-..................... unassign_control_domain
-..................... unassign_domain
-
-assign_adapter
+KVM guest::
+
+  /sys/devices
+  ... [vfio_ap]
+  ......[matrix]
+  ......... [mdev_supported_types]
+  ............ [vfio_ap-passthrough]
+  ............... create
+  ............... [devices]
+  .................. [$uuid]
+  ..................... assign_adapter
+  ..................... assign_control_domain
+  ..................... assign_domain
+  ..................... matrix
+  ..................... unassign_adapter
+  ..................... unassign_control_domain
+  ..................... unassign_domain
+
+``assign_adapter``
    To assign an AP adapter to the mediated matrix device, its APID is writ=
ten
-   to the 'assign_adapter' file. This may be done multiple times to assign=
 more
+   to the ``assign_adapter`` file. This may be done multiple times to assi=
gn more
    than one adapter. The APID may be specified using conventional semantic=
s
    as a decimal, hexadecimal, or octal number. For example, to assign adap=
ters
    4, 5 and 16 to a mediated matrix device in decimal, hexadecimal and oct=
al
-   respectively:
+   respectively::
=20
        echo 4 > assign_adapter
        echo 0x5 > assign_adapter
@@ -373,22 +401,22 @@ assign_adapter
      APQNs are bound to the driver, the operation will terminate with an
      error (EADDRNOTAVAIL).
=20
-     No APQN that can be derived from the adapter ID and the IDs of the
+   * No APQN that can be derived from the adapter ID and the IDs of the
      previously assigned domains can be assigned to another mediated matri=
x
      device. If an APQN is assigned to another mediated matrix device, the
      operation will terminate with an error (EADDRINUSE).
=20
-unassign_adapter
-   To unassign an AP adapter, its APID is written to the 'unassign_adapter=
'
+``unassign_adapter``
+   To unassign an AP adapter, its APID is written to the ``unassign_adapte=
r``
    file. This may also be done multiple times to unassign more than one ad=
apter.
=20
-assign_domain
+``assign_domain``
    To assign a usage domain, the domain number is written into the
-   'assign_domain' file. This may be done multiple times to assign more th=
an one
+   ``assign_domain`` file. This may be done multiple times to assign more =
than one
    usage domain. The domain number is specified using conventional semanti=
cs as
    a decimal, hexadecimal, or octal number. For example, to assign usage d=
omains
    4, 8, and 71 to a mediated matrix device in decimal, hexadecimal and oc=
tal
-   respectively:
+   respectively::
=20
       echo 4 > assign_domain
       echo 0x8 > assign_domain
@@ -408,23 +436,23 @@ assign_domain
      APQNs are bound to the driver, the operation will terminate with an
      error (EADDRNOTAVAIL).
=20
-     No APQN that can be derived from the domain ID being assigned and the=
 IDs
+   * No APQN that can be derived from the domain ID being assigned and the=
 IDs
      of the previously assigned adapters can be assigned to another mediat=
ed
      matrix device. If an APQN is assigned to another mediated matrix devi=
ce,
      the operation will terminate with an error (EADDRINUSE).
=20
-unassign_domain
+``unassign_domain``
    To unassign a usage domain, the domain number is written into the
-   'unassign_domain' file. This may be done multiple times to unassign mor=
e than
+   ``unassign_domain`` file. This may be done multiple times to unassign m=
ore than
    one usage domain.
=20
-assign_control_domain
+``assign_control_domain``
    To assign a control domain, the domain number is written into the
-   'assign_control_domain' file. This may be done multiple times to
+   ``assign_control_domain`` file. This may be done multiple times to
    assign more than one control domain. The domain number may be specified=
 using
    conventional semantics as a decimal, hexadecimal, or octal number. For
    example, to assign  control domains 4, 8, and 71 to  a mediated matrix =
device
-   in decimal, hexadecimal and octal respectively:
+   in decimal, hexadecimal and octal respectively::
=20
       echo 4 > assign_domain
       echo 0x8 > assign_domain
@@ -435,33 +463,34 @@ assign_control_domain
    allowed by the machine model. If a control domain number higher than th=
e
    maximum is specified, the operation will terminate with an error (ENODE=
V).
=20
-unassign_control_domain
+``unassign_control_domain``
    To unassign a control domain, the domain number is written into the
-   'unassign_domain' file. This may be done multiple times to unassign mor=
e than
+   ``unassign_domain`` file. This may be done multiple times to unassign m=
ore than
    one control domain.
=20
 Notes: No changes to the AP matrix will be allowed while a guest using
 the mediated matrix device is running. Attempts to assign an adapter,
 domain or control domain will be rejected and an error (EBUSY) returned.
=20
-Starting a Linux Guest Configured with an AP Matrix:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+Starting a Linux Guest Configured with an AP Matrix
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 To provide a mediated matrix device for use by a guest, the following opti=
on
-must be specified on the QEMU command line:
+must be specified on the QEMU command line::
=20
    -device vfio_ap,sysfsdev=3D$path-to-mdev
=20
 The sysfsdev parameter specifies the path to the mediated matrix device.
-There are a number of ways to specify this path:
+There are a number of ways to specify this path::
=20
-/sys/devices/vfio_ap/matrix/$uuid
-/sys/bus/mdev/devices/$uuid
-/sys/bus/mdev/drivers/vfio_mdev/$uuid
-/sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devic=
es/$uuid
+  /sys/devices/vfio_ap/matrix/$uuid
+  /sys/bus/mdev/devices/$uuid
+  /sys/bus/mdev/drivers/vfio_mdev/$uuid
+  /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/dev=
ices/$uuid
=20
 When the linux guest is started, the guest will open the mediated
 matrix device's file descriptor to get information about the mediated matr=
ix
-device. The vfio_ap device driver will update the APM, AQM, and ADM fields=
 in
+device. The ``vfio_ap`` device driver will update the APM, AQM, and ADM fi=
elds in
 the guest's CRYCB with the adapter, usage domain and control domains assig=
ned
 via the mediated matrix device's sysfs attribute files. Programs running o=
n the
 linux guest will then:
@@ -486,20 +515,22 @@ facilities:
    The AP facilities feature indicates that AP facilities are installed on=
 the
    guest. This feature will be exposed for use only if the AP facilities
    are installed on the host system. The feature is s390-specific and is
-   represented as a parameter of the -cpu option on the QEMU command line:
+   represented as a parameter of the -cpu option on the QEMU command line:=
:
=20
       qemu-system-s390x -cpu $model,ap=3Don|off
=20
-      Where:
+   Where:
=20
-         $model is the CPU model defined for the guest (defaults to the mo=
del of
-                the host system if not specified).
+      ``$model``
+        is the CPU model defined for the guest (defaults to the model of
+        the host system if not specified).
=20
-         ap=3Don|off indicates whether AP facilities are installed (on) or=
 not
-                   (off). The default for CPU models zEC12 or newer
-                   is ap=3Don. AP facilities must be installed on the gues=
t if a
-                   vfio-ap device (-device vfio-ap,sysfsdev=3D$path) is co=
nfigured
-                   for the guest, or the guest will fail to start.
+      ``ap=3Don|off``
+        indicates whether AP facilities are installed (on) or not
+        (off). The default for CPU models zEC12 or newer
+        is ``ap=3Don``. AP facilities must be installed on the guest if a
+        vfio-ap device (``-device vfio-ap,sysfsdev=3D$path``) is configure=
d
+        for the guest, or the guest will fail to start.
=20
 2. Query Configuration Information (QCI) facility
=20
@@ -507,27 +538,29 @@ facilities:
    configuration of the AP facilities. This facility will be available
    only if the QCI facility is installed on the host system. The feature i=
s
    s390-specific and is represented as a parameter of the -cpu option on t=
he
-   QEMU command line:
+   QEMU command line::
=20
       qemu-system-s390x -cpu $model,apqci=3Don|off
=20
-      Where:
+   Where:
=20
-         $model is the CPU model defined for the guest
+      ``$model``
+        is the CPU model defined for the guest
=20
-         apqci=3Don|off indicates whether the QCI facility is installed (o=
n) or
-                      not (off). The default for CPU models zEC12 or newer
-                      is apqci=3Don; for older models, QCI will not be ins=
talled.
+      ``apqci=3Don|off``
+        indicates whether the QCI facility is installed (on) or
+        not (off). The default for CPU models zEC12 or newer
+        is ``apqci=3Don``; for older models, QCI will not be installed.
=20
-                      If QCI is installed (apqci=3Don) but AP facilities a=
re not
-                      (ap=3Doff), an error message will be logged, but the=
 guest
-                      will be allowed to start. It makes no sense to have =
QCI
-                      installed if the AP facilities are not; this is cons=
idered
-                      an invalid configuration.
+        If QCI is installed (``apqci=3Don``) but AP facilities are not
+        (``ap=3Doff``), an error message will be logged, but the guest
+        will be allowed to start. It makes no sense to have QCI
+        installed if the AP facilities are not; this is considered
+        an invalid configuration.
=20
-                      If the QCI facility is not installed, APQNs with an =
APQI
-                      greater than 15 will not be detected by the AP bus
-                      running on the guest.
+        If the QCI facility is not installed, APQNs with an APQI
+        greater than 15 will not be detected by the AP bus
+        running on the guest.
=20
 3. Adjunct Process Facility Test (APFT) facility
=20
@@ -535,48 +568,51 @@ facilities:
    AP facilities available for a given AP queue. This facility will be ava=
ilable
    only if the APFT facility is installed on the host system. The feature =
is
    s390-specific and is represented as a parameter of the -cpu option on t=
he
-   QEMU command line:
+   QEMU command line::
=20
       qemu-system-s390x -cpu $model,apft=3Don|off
=20
-      Where:
+   Where:
+
+      ``$model``
+        is the CPU model defined for the guest (defaults to the model of
+        the host system if not specified).
=20
-         $model is the CPU model defined for the guest (defaults to the mo=
del of
-                the host system if not specified).
+      ``apft=3Don|off``
+        indicates whether the APFT facility is installed (on) or
+        not (off). The default for CPU models zEC12 and
+        newer is ``apft=3Don`` for older models, APFT will not be
+        installed.
=20
-         apft=3Don|off indicates whether the APFT facility is installed (o=
n) or
-                     not (off). The default for CPU models zEC12 and
-                     newer is apft=3Don for older models, APFT will not be
-                     installed.
+        If APFT is installed (``apft=3Don``) but AP facilities are not
+        (``ap=3Doff``), an error message will be logged, but the guest
+        will be allowed to start. It makes no sense to have APFT
+        installed if the AP facilities are not; this is considered
+        an invalid configuration.
=20
-                     If APFT is installed (apft=3Don) but AP facilities ar=
e not
-                     (ap=3Doff), an error message will be logged, but the =
guest
-                     will be allowed to start. It makes no sense to have A=
PFT
-                     installed if the AP facilities are not; this is consi=
dered
-                     an invalid configuration.
+        It also makes no sense to turn APFT off because the AP bus
+        running on the guest will not detect CEX4 and newer devices
+        without it. Since only CEX4 and newer devices are supported
+        for guest usage, no AP devices can be made accessible to a
+        guest started without APFT installed.
=20
-                     It also makes no sense to turn APFT off because the A=
P bus
-                     running on the guest will not detect CEX4 and newer d=
evices
-                     without it. Since only CEX4 and newer devices are sup=
ported
-                     for guest usage, no AP devices can be made accessible=
 to a
-                     guest started without APFT installed.
+Hot plug a vfio-ap device into a running guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-Hot plug a vfio-ap device into a running guest:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Only one vfio-ap device can be attached to the virtual machine's ap-bus, s=
o a
 vfio-ap device can be hot plugged if and only if no vfio-ap device is atta=
ched
 to the bus already, whether via the QEMU command line or a prior hot plug
 action.
=20
-To hot plug a vfio-ap device, use the QEMU device_add command:
+To hot plug a vfio-ap device, use the QEMU ``device_add`` command::
=20
     (qemu) device_add vfio-ap,sysfsdev=3D"$path-to-mdev"
=20
-    Where the '$path-to-mdev' value specifies the absolute path to a media=
ted
-    device to which AP resources to be used by the guest have been assigne=
d.
+Where the ``$path-to-mdev`` value specifies the absolute path to a mediate=
d
+device to which AP resources to be used by the guest have been assigned.
=20
 Note that on Linux guests, the AP devices will be created in the
-/sys/bus/ap/devices directory when the AP bus subsequently performs its pe=
riodic
+``/sys/bus/ap/devices`` directory when the AP bus subsequently performs it=
s periodic
 scan, so there may be a short delay before the AP devices are accessible o=
n the
 guest.
=20
@@ -587,66 +623,69 @@ The command will fail if:
 * The CPU model features for controlling guest access to AP facilities are=
 not
   enabled (see 'CPU model features' subsection in the previous section).
=20
-Hot unplug a vfio-ap device from a running guest:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Hot unplug a vfio-ap device from a running guest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 A vfio-ap device can be unplugged from a running KVM guest if a vfio-ap de=
vice
 has been attached to the virtual machine's ap-bus via the QEMU command lin=
e
 or a prior hot plug action.
=20
-To hot unplug a vfio-ap device, use the QEMU device_del command:
+To hot unplug a vfio-ap device, use the QEMU ``device_del`` command::
=20
     (qemu) device_del vfio-ap,sysfsdev=3D"$path-to-mdev"
=20
-    Where $path-to-mdev is the same as the path specified when the vfio-ap
-    device was attached to the virtual machine's ap-bus.
+Where ``$path-to-mdev`` is the same as the path specified when the vfio-ap
+device was attached to the virtual machine's ap-bus.
=20
-On a Linux guest, the AP devices will be removed from the /sys/bus/ap/devi=
ces
+On a Linux guest, the AP devices will be removed from the ``/sys/bus/ap/de=
vices``
 directory on the guest when the AP bus subsequently performs its periodic =
scan,
 so there may be a short delay before the AP devices are no longer accessib=
le by
 the guest.
=20
-The command will fail if the $path-to-mdev specified on the device_del com=
mand
+The command will fail if the ``$path-to-mdev`` specified on the ``device_d=
el`` command
 does not match the value specified when the vfio-ap device was attached to
 the virtual machine's ap-bus.
=20
-Example: Configure AP Matrixes for Three Linux Guests:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+Example: Configure AP Matrices for Three Linux Guests
+-----------------------------------------------------
+
 Let's now provide an example to illustrate how KVM guests may be given
 access to AP facilities. For this example, we will show how to configure
 three guests such that executing the lszcrypt command on the guests would
 look like this:
=20
-Guest1
-------
-CARD.DOMAIN TYPE  MODE
-------------------------------
-05          CEX5C CCA-Coproc
-05.0004     CEX5C CCA-Coproc
-05.00ab     CEX5C CCA-Coproc
-06          CEX5A Accelerator
-06.0004     CEX5A Accelerator
-06.00ab     CEX5C CCA-Coproc
-
-Guest2
-------
-CARD.DOMAIN TYPE  MODE
-------------------------------
-05          CEX5A Accelerator
-05.0047     CEX5A Accelerator
-05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
-
-Guest3
-------
-CARD.DOMAIN TYPE  MODE
-------------------------------
-06          CEX5A Accelerator
-06.0047     CEX5A Accelerator
-06.00ff     CEX5A Accelerator
+Guest1::
+
+  CARD.DOMAIN TYPE  MODE
+  ------------------------------
+  05          CEX5C CCA-Coproc
+  05.0004     CEX5C CCA-Coproc
+  05.00ab     CEX5C CCA-Coproc
+  06          CEX5A Accelerator
+  06.0004     CEX5A Accelerator
+  06.00ab     CEX5C CCA-Coproc
+
+Guest2::
+
+  CARD.DOMAIN TYPE  MODE
+  ------------------------------
+  05          CEX5A Accelerator
+  05.0047     CEX5A Accelerator
+  05.00ff     CEX5A Accelerator
+
+Guest3::
+
+  CARD.DOMAIN TYPE  MODE
+  ------------------------------
+  06          CEX5A Accelerator
+  06.0047     CEX5A Accelerator
+  06.00ff     CEX5A Accelerator
=20
 These are the steps:
=20
 1. Install the vfio_ap module on the linux host. The dependency chain for =
the
    vfio_ap module is:
+
    * iommu
    * s390
    * zcrypt
@@ -657,6 +696,7 @@ These are the steps:
=20
    To build the vfio_ap module, the kernel build must be configured with t=
he
    following Kconfig elements selected:
+
    * IOMMU_SUPPORT
    * S390
    * ZCRYPT
@@ -666,21 +706,21 @@ These are the steps:
    * VFIO_MDEV_DEVICE
    * KVM
=20
-   If using make menuconfig select the following to build the vfio_ap modu=
le:
-   -> Device Drivers
-      -> IOMMU Hardware Support
-         select S390 AP IOMMU Support
-      -> VFIO Non-Privileged userspace driver framework
-         -> Mediated device driver framework
-            -> VFIO driver for Mediated devices
-   -> I/O subsystem
-      -> VFIO support for AP devices
+   If using make menuconfig select the following to build the vfio_ap modu=
le::
+     -> Device Drivers
+        -> IOMMU Hardware Support
+           select S390 AP IOMMU Support
+        -> VFIO Non-Privileged userspace driver framework
+           -> Mediated device driver framework
+              -> VFIO driver for Mediated devices
+     -> I/O subsystem
+        -> VFIO support for AP devices
=20
 2. Secure the AP queues to be used by the three guests so that the host ca=
n not
    access them. To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff=
,
    06.0004, 06.0047, 06.00ab, and 06.00ff for use by the vfio_ap device dr=
iver,
    the corresponding APQNs must be removed from the default queue drivers =
pool
-   as follows:
+   as follows::
=20
       echo -5,-6 > /sys/bus/ap/apmask
=20
@@ -689,19 +729,19 @@ These are the steps:
    This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.00=
04,
    06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device drive=
r. The
    sysfs directory for the vfio_ap device driver will now contain symbolic=
 links
-   to the AP queue devices bound to it:
-
-   /sys/bus/ap
-   ... [drivers]
-   ...... [vfio_ap]
-   ......... [05.0004]
-   ......... [05.0047]
-   ......... [05.00ab]
-   ......... [05.00ff]
-   ......... [06.0004]
-   ......... [06.0047]
-   ......... [06.00ab]
-   ......... [06.00ff]
+   to the AP queue devices bound to it::
+
+     /sys/bus/ap
+     ... [drivers]
+     ...... [vfio_ap]
+     ......... [05.0004]
+     ......... [05.0047]
+     ......... [05.00ab]
+     ......... [05.00ff]
+     ......... [06.0004]
+     ......... [06.0047]
+     ......... [06.00ab]
+     ......... [06.00ff]
=20
    Keep in mind that only type 10 and newer adapters (i.e., CEX4 and later=
)
    can be bound to the vfio_ap device driver. The reason for this is to
@@ -712,153 +752,153 @@ These are the steps:
    The administrator, therefore, must take care to secure only AP queues t=
hat
    can be bound to the vfio_ap device driver. The device type for a given =
AP
    queue device can be read from the parent card's sysfs directory. For ex=
ample,
-   to see the hardware type of the queue 05.0004:
+   to see the hardware type of the queue 05.0004::
=20
-   cat /sys/bus/ap/devices/card05/hwtype
+     cat /sys/bus/ap/devices/card05/hwtype
=20
    The hwtype must be 10 or higher (CEX4 or newer) in order to be bound to=
 the
    vfio_ap device driver.
=20
 3. Create the mediated devices needed to configure the AP matrixes for the
    three guests and to provide an interface to the vfio_ap driver for
-   use by the guests:
+   use by the guests::
=20
-   /sys/devices/vfio_ap/matrix/
-   --- [mdev_supported_types]
-   ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
-   --------- create
-   --------- [devices]
+     /sys/devices/vfio_ap/matrix/
+     ... [mdev_supported_types]
+     ...... [vfio_ap-passthrough] (passthrough mediated matrix device type=
)
+     ......... create
+     ......... [devices]
=20
-   To create the mediated devices for the three guests:
+   To create the mediated devices for the three guests::
=20
        uuidgen > create
        uuidgen > create
        uuidgen > create
=20
-        or
+   or
=20
-        echo $uuid1 > create
-        echo $uuid2 > create
-        echo $uuid3 > create
+   ::
+
+       echo $uuid1 > create
+       echo $uuid2 > create
+       echo $uuid3 > create
=20
    This will create three mediated devices in the [devices] subdirectory n=
amed
    after the UUID used to create the mediated device. We'll call them $uui=
d1,
-   $uuid2 and $uuid3 and this is the sysfs directory structure after creat=
ion:
-
-   /sys/devices/vfio_ap/matrix/
-   --- [mdev_supported_types]
-   ------ [vfio_ap-passthrough]
-   --------- [devices]
-   ------------ [$uuid1]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   --------------- unassign_control_domain
-   --------------- unassign_domain
-
-   ------------ [$uuid2]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   ----------------unassign_control_domain
-   ----------------unassign_domain
-
-   ------------ [$uuid3]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   ----------------unassign_control_domain
-   ----------------unassign_domain
+   $uuid2 and $uuid3 and this is the sysfs directory structure after creat=
ion::
+
+     /sys/devices/vfio_ap/matrix/
+     ... [mdev_supported_types]
+     ...... [vfio_ap-passthrough]
+     ......... [devices]
+     ............ [$uuid1]
+     ............... assign_adapter
+     ............... assign_control_domain
+     ............... assign_domain
+     ............... matrix
+     ............... unassign_adapter
+     ............... unassign_control_domain
+     ............... unassign_domain
+
+     ............ [$uuid2]
+     ............... assign_adapter
+     ............... assign_control_domain
+     ............... assign_domain
+     ............... matrix
+     ............... unassign_adapter
+     ............... unassign_control_domain
+     ............... unassign_domain
+
+     ............ [$uuid3]
+     ............... assign_adapter
+     ............... assign_control_domain
+     ............... assign_domain
+     ............... matrix
+     ............... unassign_adapter
+     ............... unassign_control_domain
+     ............... unassign_domain
=20
 4. The administrator now needs to configure the matrixes for the mediated
    devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3=
).
=20
-   This is how the matrix is configured for Guest1:
+   This is how the matrix is configured for Guest1::
=20
       echo 5 > assign_adapter
       echo 6 > assign_adapter
       echo 4 > assign_domain
       echo 0xab > assign_domain
=20
-      Control domains can similarly be assigned using the assign_control_d=
omain
-      sysfs file.
+   Control domains can similarly be assigned using the assign_control_doma=
in
+   sysfs file.
=20
-      If a mistake is made configuring an adapter, domain or control domai=
n,
-      you can use the unassign_xxx interfaces to unassign the adapter, dom=
ain or
-      control domain.
+   If a mistake is made configuring an adapter, domain or control domain,
+   you can use the ``unassign_xxx`` interfaces to unassign the adapter, do=
main or
+   control domain.
=20
-      To display the matrix configuration for Guest1:
+   To display the matrix configuration for Guest1::
=20
          cat matrix
=20
-         The output will display the APQNs in the format xx.yyyy, where xx=
 is
-         the adapter number and yyyy is the domain number. The output for =
Guest1
-         will look like this:
+   The output will display the APQNs in the format ``xx.yyyy``, where xx i=
s
+   the adapter number and yyyy is the domain number. The output for Guest1
+   will look like this::
=20
          05.0004
          05.00ab
          06.0004
          06.00ab
=20
-   This is how the matrix is configured for Guest2:
+   This is how the matrix is configured for Guest2::
=20
       echo 5 > assign_adapter
       echo 0x47 > assign_domain
       echo 0xff > assign_domain
=20
-   This is how the matrix is configured for Guest3:
+   This is how the matrix is configured for Guest3::
=20
       echo 6 > assign_adapter
       echo 0x47 > assign_domain
       echo 0xff > assign_domain
=20
-5. Start Guest1:
+5. Start Guest1::
=20
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don \
-      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid1 ...
+   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don -=
device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid1 ...
=20
-7. Start Guest2:
+7. Start Guest2::
=20
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don \
-      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid2 ...
+   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don -=
device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid2 ...
=20
-7. Start Guest3:
+7. Start Guest3::
=20
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don \
-      -device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid3 ...
+   /usr/bin/qemu-system-s390x ... -cpu host,ap=3Don,apqci=3Don,apft=3Don -=
device vfio-ap,sysfsdev=3D/sys/devices/vfio_ap/matrix/$uuid3 ...
=20
 When the guest is shut down, the mediated matrix devices may be removed.
=20
-Using our example again, to remove the mediated matrix device $uuid1:
+Using our example again, to remove the mediated matrix device $uuid1::
=20
    /sys/devices/vfio_ap/matrix/
-      --- [mdev_supported_types]
-      ------ [vfio_ap-passthrough]
-      --------- [devices]
-      ------------ [$uuid1]
-      --------------- remove
+   ... [mdev_supported_types]
+   ...... [vfio_ap-passthrough]
+   ......... [devices]
+   ............ [$uuid1]
+   ............... remove
=20
=20
    echo 1 > remove
=20
-   This will remove all of the mdev matrix device's sysfs structures inclu=
ding
-   the mdev device itself. To recreate and reconfigure the mdev matrix dev=
ice,
-   all of the steps starting with step 3 will have to be performed again. =
Note
-   that the remove will fail if a guest using the mdev is still running.
+This will remove all of the mdev matrix device's sysfs structures includin=
g
+the mdev device itself. To recreate and reconfigure the mdev matrix device=
,
+all of the steps starting with step 3 will have to be performed again. Not=
e
+that the remove will fail if a guest using the mdev is still running.
=20
-   It is not necessary to remove an mdev matrix device, but one may want t=
o
-   remove it if no guest will use it during the remaining lifetime of the =
linux
-   host. If the mdev matrix device is removed, one may want to also reconf=
igure
-   the pool of adapters and queues reserved for use by the default drivers=
.
+It is not necessary to remove an mdev matrix device, but one may want to
+remove it if no guest will use it during the remaining lifetime of the lin=
ux
+host. If the mdev matrix device is removed, one may want to also reconfigu=
re
+the pool of adapters and queues reserved for use by the default drivers.
=20
 Limitations
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+-----------
+
 * The KVM/kernel interfaces do not provide a way to prevent restoring an A=
PQN
   to the default drivers pool of a queue that is still assigned to a media=
ted
   device in use by a guest. It is incumbent upon the administrator to
@@ -867,10 +907,10 @@ Limitations
   device, such as a private key configured specifically for the guest.
=20
 * Dynamically assigning AP resources to or unassigning AP resources from a
-  mediated matrix device - see 'Configuring an AP matrix for a linux guest=
'
+  mediated matrix device - see `Configuring an AP matrix for a linux guest=
`_
   section above - while a running guest is using it is currently not suppo=
rted.
=20
 * Live guest migration is not supported for guests using AP devices. If a =
guest
   is using AP devices, the vfio-ap device configured for the guest must be
-  unplugged before migrating the guest (see 'Hot unplug a vfio-ap device f=
rom a
-  running guest' section above.
+  unplugged before migrating the guest (see `Hot unplug a vfio-ap device f=
rom a
+  running guest`_ section above.)
--=20
2.21.1


