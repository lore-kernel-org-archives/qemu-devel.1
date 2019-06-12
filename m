Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE7C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B742064A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B742064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5ov-0000Cn-6j
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hb5k6-0004JX-Ok
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hb5k3-0001EF-HK
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:04:54 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:58149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hb5k1-00018l-Ki
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:04:51 -0400
Received: from player799.ha.ovh.net (unknown [10.109.143.3])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9B1C417E6BF
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 18:04:43 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 6CCE96BF3B42;
 Wed, 12 Jun 2019 16:04:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jun 2019 18:04:25 +0200
Message-Id: <20190612160425.27670-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2493586819962735590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehjedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.26
Subject: [Qemu-devel] [PATCH] docs: updates on the POWER9 XIVE interrupt
 controller documentation
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes various small updates and a better description of the
chosen interrupt mode resulting from the combination of the 'ic-mode'
machine option, the 'kernel_irqchip' option, guest support and KVM
support.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 David, please check the tables below. Thanks

 docs/specs/ppc-spapr-xive.rst | 112 ++++++++++++++++++++++++++++++++--
 docs/specs/ppc-xive.rst       |   9 +--
 2 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rs=
t
index 539ce7ca4e90..7a64c9d04951 100644
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
index b997dc062910..148d57eb6ab2 100644
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


