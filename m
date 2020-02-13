Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135BA21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqD8ui9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135BA21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HP1-0006IM-ML
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j2HNI-0004vE-O3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j2HNG-0005PV-I5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:30:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j2HNG-0005Mm-Dc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581611396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsis8wgiiih+KrgeudxlGMyRAMTOnU1MjKloy6DBesI=;
 b=KqD8ui9H2hwux/+h75HYE11PGDNljXypdS5iXaHHIl2mhhe7uFVsOSS/AfI9gt9I17YL0d
 XbgyfgYQp1ohtFsqmqb2A0KIWNBjkzDETfiC2yNN1yqI3mIhgiAa+OiwihpWiKv1UfosJU
 3OcevUq18E5KwDlo6oPi0XHxnxH+54o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-91hwd5G3NkS1jRqW_OtZ1A-1; Thu, 13 Feb 2020 11:29:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8044B800D48;
 Thu, 13 Feb 2020 16:29:50 +0000 (UTC)
Received: from localhost (ovpn-117-100.ams2.redhat.com [10.36.117.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDFB910027A4;
 Thu, 13 Feb 2020 16:29:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v2 1/2] docs: rstfy s390 dasd ipl documentation
Date: Thu, 13 Feb 2020 17:29:41 +0100
Message-Id: <20200213162942.14177-2-cohuck@redhat.com>
In-Reply-To: <20200213162942.14177-1-cohuck@redhat.com>
References: <20200213162942.14177-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 91hwd5G3NkS1jRqW_OtZ1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

While at it, also fix the numbering in 'What QEMU does'.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                                   |   2 +-
 docs/devel/index.rst                          |   1 +
 .../{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst}  | 119 +++++++++---------
 3 files changed, 64 insertions(+), 58 deletions(-)
 rename docs/devel/{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst} (51%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7717df720a2..34b766f89d32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1243,7 +1243,7 @@ S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
-F: docs/devel/s390-dasd-ipl.txt
+F: docs/devel/s390-dasd-ipl.rst
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 4dc2ca8d715e..b734ba465577 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -25,3 +25,4 @@ Contents:
    tcg-plugins
    bitops
    reset
+   s390-dasd-ipl
diff --git a/docs/devel/s390-dasd-ipl.txt b/docs/devel/s390-dasd-ipl.rst
similarity index 51%
rename from docs/devel/s390-dasd-ipl.txt
rename to docs/devel/s390-dasd-ipl.rst
index 9107e048e4e6..2529eb5f54b3 100644
--- a/docs/devel/s390-dasd-ipl.txt
+++ b/docs/devel/s390-dasd-ipl.rst
@@ -1,49 +1,55 @@
-*****************************
-***** s390 hardware IPL *****
-*****************************
+Booting from real channel-attached devices on s390x
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+s390 hardware IPL
+-----------------
=20
 The s390 hardware IPL process consists of the following steps.
=20
-1. A READ IPL ccw is constructed in memory location 0x0.
-    This ccw, by definition, reads the IPL1 record which is located on the=
 disk
-    at cylinder 0 track 0 record 1. Note that the chain flag is on in this=
 ccw
-    so when it is complete another ccw will be fetched and executed from m=
emory
-    location 0x08.
-
-2. Execute the Read IPL ccw at 0x00, thereby reading IPL1 data into 0x00.
-    IPL1 data is 24 bytes in length and consists of the following pieces o=
f
-    information: [psw][read ccw][tic ccw]. When the machine executes the R=
ead
-    IPL ccw it read the 24-bytes of IPL1 to be read into memory starting a=
t
-    location 0x0. Then the ccw program at 0x08 which consists of a read
-    ccw and a tic ccw is automatically executed because of the chain flag =
from
-    the original READ IPL ccw. The read ccw will read the IPL2 data into m=
emory
-    and the TIC (Transfer In Channel) will transfer control to the channel
-    program contained in the IPL2 data. The TIC channel command is the
-    equivalent of a branch/jump/goto instruction for channel programs.
-    NOTE: The ccws in IPL1 are defined by the architecture to be format 0.
+1. A READ IPL ccw is constructed in memory location ``0x0``.
+   This ccw, by definition, reads the IPL1 record which is located on the =
disk
+   at cylinder 0 track 0 record 1. Note that the chain flag is on in this =
ccw
+   so when it is complete another ccw will be fetched and executed from me=
mory
+   location ``0x08``.
+
+2. Execute the Read IPL ccw at ``0x00``, thereby reading IPL1 data into ``=
0x00``.
+   IPL1 data is 24 bytes in length and consists of the following pieces of
+   information: ``[psw][read ccw][tic ccw]``. When the machine executes th=
e Read
+   IPL ccw it read the 24-bytes of IPL1 to be read into memory starting at
+   location ``0x0``. Then the ccw program at ``0x08`` which consists of a =
read
+   ccw and a tic ccw is automatically executed because of the chain flag f=
rom
+   the original READ IPL ccw. The read ccw will read the IPL2 data into me=
mory
+   and the TIC (Transfer In Channel) will transfer control to the channel
+   program contained in the IPL2 data. The TIC channel command is the
+   equivalent of a branch/jump/goto instruction for channel programs.
+
+   NOTE: The ccws in IPL1 are defined by the architecture to be format 0.
=20
 3. Execute IPL2.
-    The TIC ccw instruction at the end of the IPL1 channel program will be=
gin
-    the execution of the IPL2 channel program. IPL2 is stage-2 of the boot
-    process and will contain a larger channel program than IPL1. The point=
 of
-    IPL2 is to find and load either the operating system or a small progra=
m that
-    loads the operating system from disk. At the end of this step all or s=
ome of
-    the real operating system is loaded into memory and we are ready to ha=
nd
-    control over to the guest operating system. At this point the guest
-    operating system is entirely responsible for loading any more data it =
might
-    need to function. NOTE: The IPL2 channel program might read data into =
memory
-    location 0 thereby overwriting the IPL1 psw and channel program. This =
is ok
-    as long as the data placed in location 0 contains a psw whose instruct=
ion
-    address points to the guest operating system code to execute at the en=
d of
-    the IPL/boot process.
-    NOTE: The ccws in IPL2 are defined by the architecture to be format 0.
+   The TIC ccw instruction at the end of the IPL1 channel program will beg=
in
+   the execution of the IPL2 channel program. IPL2 is stage-2 of the boot
+   process and will contain a larger channel program than IPL1. The point =
of
+   IPL2 is to find and load either the operating system or a small program=
 that
+   loads the operating system from disk. At the end of this step all or so=
me of
+   the real operating system is loaded into memory and we are ready to han=
d
+   control over to the guest operating system. At this point the guest
+   operating system is entirely responsible for loading any more data it m=
ight
+   need to function.
+
+   NOTE: The IPL2 channel program might read data into memory
+   location ``0x0`` thereby overwriting the IPL1 psw and channel program. =
This is ok
+   as long as the data placed in location ``0x0`` contains a psw whose ins=
truction
+   address points to the guest operating system code to execute at the end=
 of
+   the IPL/boot process.
+
+   NOTE: The ccws in IPL2 are defined by the architecture to be format 0.
=20
 4. Start executing the guest operating system.
-    The psw that was loaded into memory location 0 as part of the ipl proc=
ess
-    should contain the needed flags for the operating system we have loade=
d. The
-    psw's instruction address will point to the location in memory where w=
e want
-    to start executing the operating system. This psw is loaded (via LPSW
-    instruction) causing control to be passed to the operating system code=
.
+   The psw that was loaded into memory location ``0x0`` as part of the ipl=
 process
+   should contain the needed flags for the operating system we have loaded=
. The
+   psw's instruction address will point to the location in memory where we=
 want
+   to start executing the operating system. This psw is loaded (via LPSW
+   instruction) causing control to be passed to the operating system code.
=20
 In a non-virtualized environment this process, handled entirely by the har=
dware,
 is kicked off by the user initiating a "Load" procedure from the hardware
@@ -54,18 +60,17 @@ written immediately after the special "Read IPL" ccw, t=
he IPL1 channel program
 will be executed immediately (the special read ccw has the chaining bit tu=
rned
 on). The TIC at the end of the IPL1 channel program will cause the IPL2 ch=
annel
 program to be executed automatically. After this sequence completes the "L=
oad"
-procedure then loads the psw from 0x0.
+procedure then loads the psw from ``0x0``.
=20
-**********************************************************
-***** How this all pertains to QEMU (and the kernel) *****
-**********************************************************
+How this all pertains to QEMU (and the kernel)
+----------------------------------------------
=20
 In theory we should merely have to do the following to IPL/boot a guest
 operating system from a DASD device:
=20
-1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
-2. Execute channel program at 0x0.
-3. LPSW 0x0.
+1. Place a "Read IPL" ccw into memory location ``0x0`` with chaining bit o=
n.
+2. Execute channel program at ``0x0``.
+3. LPSW ``0x0``.
=20
 However, our emulation of the machine's channel program logic within the k=
ernel
 is missing one key feature that is required for this process to work:
@@ -89,32 +94,31 @@ Lastly, in some cases (the zipl bootloader for example)=
 the IPL2 program also
 transfers control to another channel program segment immediately after rea=
ding
 it from the disk. So we need to be able to handle this case.
=20
-**************************
-***** What QEMU does *****
-**************************
+What QEMU does
+--------------
=20
 Since we are forced to live with prefetch we cannot use the very simple IP=
L
 procedure we defined in the preceding section. So we compensate by doing t=
he
 following.
=20
-1. Place "Read IPL" ccw into memory location 0x0, but turn off chaining bi=
t.
-2. Execute "Read IPL" at 0x0.
+1. Place "Read IPL" ccw into memory location ``0x0``, but turn off chainin=
g bit.
+2. Execute "Read IPL" at ``0x0``.
=20
-   So now IPL1's psw is at 0x0 and IPL1's channel program is at 0x08.
+   So now IPL1's psw is at ``0x0`` and IPL1's channel program is at ``0x08=
``.
=20
-4. Write a custom channel program that will seek to the IPL2 record and th=
en
+3. Write a custom channel program that will seek to the IPL2 record and th=
en
    execute the READ and TIC ccws from IPL1.  Normally the seek is not requ=
ired
    because after reading the IPL1 record the disk is automatically positio=
ned
    to read the very next record which will be IPL2. But since we are not r=
eading
    both IPL1 and IPL2 as part of the same channel program we must manually=
 set
    the position.
=20
-5. Grab the target address of the TIC instruction from the IPL1 channel pr=
ogram.
+4. Grab the target address of the TIC instruction from the IPL1 channel pr=
ogram.
    This address is where the IPL2 channel program starts.
=20
    Now IPL2 is loaded into memory somewhere, and we know the address.
=20
-6. Execute the IPL2 channel program at the address obtained in step #5.
+5. Execute the IPL2 channel program at the address obtained in step #4.
=20
    Because this channel program can be dynamic, we must use a special algo=
rithm
    that detects a READ immediately followed by a TIC and breaks the ccw ch=
ain
@@ -126,8 +130,9 @@ following.
    channel program from executing properly.
=20
    Now the operating system code is loaded somewhere in guest memory and t=
he psw
-   in memory location 0x0 will point to entry code for the guest operating
+   in memory location ``0x0`` will point to entry code for the guest opera=
ting
    system.
=20
-7. LPSW 0x0.
+6. LPSW ``0x0``
+
    LPSW transfers control to the guest operating system and we're done.
--=20
2.21.1


