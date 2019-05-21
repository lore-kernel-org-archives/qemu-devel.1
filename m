Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BA4C04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 01:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205682173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 01:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oBXi2yKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205682173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hStzQ-0007ps-V3
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 21:54:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hStya-0007Sh-Oh
	for qemu-devel@nongnu.org; Mon, 20 May 2019 21:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hStyZ-0002Hu-FI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 21:54:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56915 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hStyX-0002Fv-T3; Mon, 20 May 2019 21:53:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457JhY2T65z9s9T; Tue, 21 May 2019 11:53:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558403629;
	bh=ZS/VbJ9JG+dpuQ48duEzTX3RkyPqOox53cCOffzkefQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBXi2yKhgvupBDSzrBpwaktpT2M0VxfnH7/Xv4pBmmv3qA8gaso0Nt+pkKXqH1X0G
	bWpLSYTy5A/7A0PQQgvOe1juaSfCnwLO8vR1Eaw8tXCRQdmOlw8Ctn8Z4aE2Cvs4Ih
	btC41B1ti7G3Zy3GOhnZeF31aWXHpdKsM/iPOlp0=
Date: Tue, 21 May 2019 11:53:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190521015342.GC30423@umbus.fritz.box>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 00/14] spapr: add KVM support to the
 XIVE interrupt mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 10:42:31AM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> This is the v4 of the QEMU/KVM patchset.
>=20
> The first patches introduce the XIVE KVM device, state synchronization
> and migration support under KVM. The second part of the patchset
> modifies the XICS and XIVE interrupt models to add KVM support to the
> 'dual' IRQ backend.

Ok, I've applied this to my tree, and I'm prepping for a pull request
right now.

>=20
> GitHub trees available here :
> =20
> QEMU sPAPR:
>=20
>   https://github.com/legoater/qemu/commits/xive-next
>  =20
> Linux/KVM:
>=20
>   https://github.com/legoater/linux/commits/xive-5.1
>=20
> Thanks,
>=20
> C.
>=20
> Changes since v3:
>=20
>  - updates of the kvm headers are synced with commit 0caecf5b0019
>    (kvm-ppc-next-5.2-1) in branch kvm-ppc-next. will conflict with
>    kvm-arm.  =20
>  - added usage of xive_end_qaddr() helper
>  - removed KVM_DESTROY_DEVICE control. KVM device is destroyed when
>    the fd is closed.
>  - update in kvmppc_xive_source_reset_one()
>  - introduced a 'init' boolean under ICSState
>  - removed extra spapr_irq_init_device() in spapr_irq_init_xive()=20
>  - reworked slightly the code sequence in xics_kvm_init() creating the
>    presenters and connecting them to the KVM XICS device.
>=20
> Changes since v2:
>=20
>  - update linux headers to 5.1-rc1
>  - rebased on new naming scheme
>  - rebased on new configuration system
>  - replaced error_report_err() by warn_report_err()
>  - added an assert() in spapr_xive_end_to_target()
>  - moved xive_end_is_valid() check out of kvmppc_xive_set_queue_config()
>  - dealt with MASKED EAS
>  - reworked ESB memory operations
>  - improved KVM_XIVE_EQ_ALWAYS_NOTIFY handling
>  - removed the capture of the OS CAM line value from KVM
>  - merged in the handling of pending interrupts while the VM is stopped.
>  - did an update in ics_set_kvm_state_one()
>  - removed spapr_ics_create()=20
>  - introduced a spapr_irq_init_device() helper
>  - reworked test on single initialization of the emulated IRQ device
>=20
> Changes since v1:
>=20
>  - Reworked most of the KVM interface
>  - Reworked *All* hcalls which are now handled at the QEMU level,
>    possibly extended with a KVM device ioctl when required.
>  - TIMA and ESB special mapping done on the KVM device fd.
>  - Tested on nested
>  - Implemented the device fallback mode when a kernel_irqchip is not
>    available and not required. Useful on nested to use XIVE.=20
>  - Fix device hotplug when VM is stopped (Is this necessary ?)
>=20
>=20
> C=E9dric Le Goater (14):
>   linux-headers: update linux headers to kvm-ppc-next-5.2-1
>   spapr/xive: add KVM support
>   spapr/xive: add hcall support when under KVM
>   spapr/xive: add state synchronization with KVM
>   spapr/xive: introduce a VM state change handler
>   spapr/xive: add migration support for KVM
>   spapr/xive: activate KVM support
>   sysbus: add a sysbus_mmio_unmap() helper
>   spapr: introduce routines to delete the KVM IRQ device
>   spapr: check for the activation of the KVM IRQ device
>   spapr/irq: introduce a spapr_irq_init_device() helper
>   spapr/irq: initialize the IRQ device only once
>   ppc/xics: fix irq priority in ics_set_irq_type()
>   spapr/irq: add KVM support to the 'dual' machine
>=20
>  include/hw/ppc/spapr_irq.h      |   2 +
>  include/hw/ppc/spapr_xive.h     |  39 ++
>  include/hw/ppc/xics.h           |   1 +
>  include/hw/ppc/xics_spapr.h     |   1 +
>  include/hw/ppc/xive.h           |  14 +
>  include/hw/sysbus.h             |   1 +
>  linux-headers/asm-powerpc/kvm.h |  46 ++
>  linux-headers/linux/kvm.h       |   3 +
>  target/ppc/kvm_ppc.h            |   6 +
>  hw/core/sysbus.c                |  10 +
>  hw/intc/spapr_xive.c            | 172 ++++++-
>  hw/intc/spapr_xive_kvm.c        | 827 ++++++++++++++++++++++++++++++++
>  hw/intc/xics.c                  |  10 +-
>  hw/intc/xics_kvm.c              | 113 ++++-
>  hw/intc/xics_spapr.c            |   7 +
>  hw/intc/xive.c                  |  44 +-
>  hw/ppc/spapr_irq.c              | 140 ++++--
>  target/ppc/kvm.c                |   7 +
>  hw/intc/Makefile.objs           |   1 +
>  hw/ppc/Kconfig                  |   5 +
>  20 files changed, 1384 insertions(+), 65 deletions(-)
>  create mode 100644 hw/intc/spapr_xive_kvm.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzjWiMACgkQbDjKyiDZ
s5JVKg/+IKCdVGDZsFwTD0BEpxuD10QY6T6d/KvDJVE2hZnionxb/6SBm5VUboS4
tOv54JQywAAAcWM/CVHvwL/0B/6wMM8y0gqx7FxmDrbPbzKZHBYeyX1aRojvO9z/
IKtp7dMhy71be0fJ2S31xQ0jmrWdZjBBVwckQGm01YmNpJs+CopMIrIoyvMteQ/F
9WRy2ZZgobqPryF//oVEbWCYhDFLlidgGNeDYXA5xfDQ79zgj5VBgtKrsT70LWGS
Es5MS0QLfjQ+2CN6gIq52PxZ2eUpo/djDLbWwyhxKcp1+ZXRPmacbyUt2cEuT533
Xhgr6hkT/ny9qEbE619tyBNxvmZ15SqaeSi5lKAHlU8LvsDcNo8GGVlwVh/5Z6/a
51hFMUX+iDeBSZB2cGC4nbrdo35fZClw/o97ztOjHZRIrWRwNpjlvdv914tfQIN1
zuOq6PutOkOoAjo+6ocQ3lK8NDxXx2j3K9eD5pR3LsK7AH+4PqtUAWZT40Nlj6+v
pCKcn1GybmxkoCLzfF7g2IWwSOlP5gEf+S6HBhqwlO3+G3pfMx2wRtSnjWpHoZBn
/iEJWG1wMWomF0x7yjIjhBiS6DpBb0JDpGGQ5UASKwIaC/GdwMjlX/ozf7cVFnRY
mFARdfl2cVtpm5FkPGL3ZXnt0Zzcq1/gZdZ5xJCdVa11Si4g4cI=
=Hg+j
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

