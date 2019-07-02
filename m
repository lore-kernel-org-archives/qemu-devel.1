Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC3C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA46216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nk2ZSCTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA46216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiC5S-0001zk-4n
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBye-0004iY-3h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByc-0002oD-FY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35621 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByb-0002kK-Rm; Tue, 02 Jul 2019 02:09:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg0kXwz9sLt; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=EXWWJ27XRbv47YC0aDMEUuAkmoRUNlFet6onbAw9VCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nk2ZSCTuq9y+nmXkDjDOREb2j0/xNEjwLzbVW2xkBtrT3Idu0hf/8dIc2823C+kEN
 G1TKjsN7Ix/hnrnRPXU1xrh+rL60YmutVFM+7GDgXz7f2XoVUd7GH/JMv/bW+W5iwJ
 2BpvzwnAlalHPdfhKpiG9y1oI4ISLIHIATCUOg4k=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:10 +1000
Message-Id: <20190702060857.3926-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 02/49] docs: updates on the POWER9 XIVE
 interrupt controller documentation
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This includes various small updates and a better description of the
chosen interrupt mode resulting from the combination of the 'ic-mode'
machine option, the 'kernel_irqchip' option, guest support and KVM
support.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190612160425.27670-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/ppc-spapr-xive.rst | 112 ++++++++++++++++++++++++++++++++--
 docs/specs/ppc-xive.rst       |   9 +--
 2 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rs=
t
index 539ce7ca4e..7a64c9d049 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -34,19 +34,118 @@ CAS Negotiation
 ---------------
=20
 QEMU advertises the supported interrupt modes in the device tree
-property "ibm,arch-vec-5-platform-support" in byte 23 and the OS
-Selection for XIVE is indicated in the "ibm,architecture-vec-5"
+property ``ibm,arch-vec-5-platform-support`` in byte 23 and the OS
+Selection for XIVE is indicated in the ``ibm,architecture-vec-5``
 property byte 23.
=20
 The interrupt modes supported by the machine depend on the CPU type
 (POWER9 is required for XIVE) but also on the machine property
 ``ic-mode`` which can be set on the command line. It can take the
-following values: ``xics``, ``xive``, ``dual`` and currently ``xics``
-is the default but it may change in the future.
+following values: ``xics``, ``xive``, and ``dual`` which is the
+default mode. ``dual`` means that both modes XICS **and** XIVE are
+supported and if the guest OS supports XIVE, this mode will be
+selected.
=20
 The choosen interrupt mode is activated after a reconfiguration done
 in a machine reset.
=20
+KVM negotiation
+---------------
+
+When the guest starts under KVM, the capabilities of the host kernel
+and QEMU are also negotiated. Depending on the version of the host
+kernel, KVM will advertise the XIVE capability to QEMU or not.
+
+Nevertheless, the available interrupt modes in the machine should not
+depend on the XIVE KVM capability of the host. On older kernels
+without XIVE KVM support, QEMU will use the emulated XIVE device as a
+fallback and on newer kernels (>=3D5.2), the KVM XIVE device.
+
+As a final refinement, the user can also switch the use of the KVM
+device with the machine option ``kernel_irqchip``.
+
+
+XIVE support in KVM
+~~~~~~~~~~~~~~~~~~~
+
+For guest OSes supporting XIVE, the resulting interrupt modes on host
+kernels with XIVE KVM support are the following:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ic-mode                            kernel_irqchip
+--------------  ----------------------------------------------
+/               allowed        off            on
+                (default)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+dual (default)  XIVE KVM       XIVE emul.     XIVE KVM
+xive            XIVE KVM       XIVE emul.     XIVE KVM
+xics            XICS KVM       XICS emul.     XICS KVM
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+For legacy guest OSes without XIVE support, the resulting interrupt
+modes are the following:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ic-mode                            kernel_irqchip
+--------------  ----------------------------------------------
+/               allowed        off            on
+                (default)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+dual (default)  XICS KVM       XICS emul.     XICS KVM
+xive            QEMU error(3)  QEMU error(3)  QEMU error(3)
+xics            XICS KVM       XICS emul.     XICS KVM
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+(3) QEMU fails at CAS with ``Guest requested unavailable interrupt
+    mode (XICS), either don't set the ic-mode machine property or try
+    ic-mode=3Dxics or ic-mode=3Ddual``
+
+
+No XIVE support in KVM
+~~~~~~~~~~~~~~~~~~~~~~
+
+For guest OSes supporting XIVE, the resulting interrupt modes on host
+kernels without XIVE KVM support are the following:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ic-mode                            kernel_irqchip
+--------------  ----------------------------------------------
+/               allowed        off            on
+                (default)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+dual (default)  XIVE emul.(1)  XIVE emul.     QEMU error (2)
+xive            XIVE emul.(1)  XIVE emul.     QEMU error (2)
+xics            XICS KVM       XICS emul.     XICS KVM
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+(1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
+    IRQ_XIVE capability must be present for KVM``
+(2) QEMU fails with ``kernel_irqchip requested but unavailable:
+    IRQ_XIVE capability must be present for KVM``
+
+
+For legacy guest OSes without XIVE support, the resulting interrupt
+modes are the following:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ic-mode                            kernel_irqchip
+--------------  ----------------------------------------------
+/               allowed        off            on
+                (default)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+dual (default)  QEMU error(4)  XICS emul.     QEMU error(4)
+xive            QEMU error(3)  QEMU error(3)  QEMU error(3)
+xics            XICS KVM       XICS emul.     XICS KVM
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+(3) QEMU fails at CAS with ``Guest requested unavailable interrupt
+    mode (XICS), either don't set the ic-mode machine property or try
+    ic-mode=3Dxics or ic-mode=3Ddual``
+(4) QEMU/KVM incompatibility due to device destruction in reset. This
+    needs to be addressed more cleanly with an error.
+
+
 XIVE Device tree properties
 ---------------------------
=20
@@ -92,10 +191,11 @@ for both interrupt mode. The different ranges are de=
fined as follow :
 - ``0x0000 .. 0x0FFF`` 4K CPU IPIs (only used under XIVE)
 - ``0x1000 .. 0x1000`` 1 EPOW
 - ``0x1001 .. 0x1001`` 1 HOTPLUG
+- ``0x1002 .. 0x10FF`` unused
 - ``0x1100 .. 0x11FF`` 256 VIO devices
-- ``0x1200 .. 0x127F`` 32 PHBs devices
+- ``0x1200 .. 0x127F`` 32x4 LSIs for PHB devices
 - ``0x1280 .. 0x12FF`` unused
-- ``0x1300 .. 0x1FFF`` PHB MSIs
+- ``0x1300 .. 0x1FFF`` PHB MSIs (dynamically allocated)
=20
 Monitoring XIVE
 ---------------
diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
index b997dc0629..148d57eb6a 100644
--- a/docs/specs/ppc-xive.rst
+++ b/docs/specs/ppc-xive.rst
@@ -20,10 +20,11 @@ The XIVE IC is composed of three sub-engines, each ta=
king care of a
 processing layer of external interrupts:
=20
 - Interrupt Virtualization Source Engine (IVSE), or Source Controller
-  (SC). These are found in PCI PHBs, in the PSI host bridge
-  controller, but also inside the main controller for the core IPIs
-  and other sub-chips (NX, CAP, NPU) of the chip/processor. They are
-  configured to feed the IVRE with events.
+  (SC). These are found in PCI PHBs, in the Processor Service
+  Interface (PSI) host bridge Controller, but also inside the main
+  controller for the core IPIs and other sub-chips (NX, CAP, NPU) of
+  the chip/processor. They are configured to feed the IVRE with
+  events.
 - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
   Controller (VC). It handles event coalescing and perform interrupt
   routing by matching an event source number with an Event
--=20
2.21.0


