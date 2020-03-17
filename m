Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EFC20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LSpXH4Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EFC20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELFL-0006ow-LS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jELEO-0005xM-6X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jELEM-0006Ty-Ll
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:02:40 -0400
Received: from ozlabs.org ([203.11.71.1]:49729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jELEL-0006FE-Lg; Tue, 17 Mar 2020 19:02:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hpbZ33xJz9sPF; Wed, 18 Mar 2020 10:02:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584486154;
 bh=daCyllCiIz+DXKhtmK1bLfgw6C6uWyHJ40VuQNfGUH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LSpXH4Oruo9qniV52tpk08WMPgtMV0FVm3HbZNbQo66gyEqFN+raJYmJifb0I24oX
 6yBPN4e82MvERPDU5PTuWse+JY7GaVlSSDb+zoBXkAu30XFWMTORCV/5/byu8ny71v
 cufOQaGIUItgEu8QY2MEdW75QUiAbEefGkX1sEFI=
Date: Wed, 18 Mar 2020 09:33:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/45] ppc-for-5.0 queue 20200317
Message-ID: <20200317223305.GN20264@umbus.fritz.box>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
 <bc2dc429-0c54-2a36-b901-97b14d4c9ce7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <bc2dc429-0c54-2a36-b901-97b14d4c9ce7@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 aik@ozlabs.ru, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 11:30:31AM +0100, Paolo Bonzini wrote:
> On 17/03/20 11:03, David Gibson wrote:
> >       pseries: Update SLOF firmware image
> >       ppc/spapr: Move GPRs setup to one place
> >       pseries: Update SLOF firmware image
> >       spapr/rtas: Reserve space for RTAS blob and log
> >       pseries: Update SLOF firmware image
>=20
> Oh, no fake-OF patches?

Apart from some prelims that make sense on their own, no.

Not quite ready to go ahead with that, I'm afraid.

>=20
> Paolo
>=20
> > C=E9dric Le Goater (1):
> >       spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges exposed to the=
 guest
> >=20
> > David Gibson (19):
> >       ppc: Remove stub support for 32-bit hypervisor mode
> >       ppc: Remove stub of PPC970 HID4 implementation
> >       target/ppc: Correct handling of real mode accesses with vhyp on h=
ash MMU
> >       target/ppc: Introduce ppc_hash64_use_vrma() helper
> >       spapr, ppc: Remove VPM0/RMLS hacks for POWER9
> >       target/ppc: Remove RMOR register from POWER9 & POWER10
> >       target/ppc: Use class fields to simplify LPCR masking
> >       target/ppc: Streamline calculation of RMA limit from LPCR[RMLS]
> >       target/ppc: Correct RMLS table
> >       target/ppc: Only calculate RMLS derived RMA limit on demand
> >       target/ppc: Don't store VRMA SLBE persistently
> >       spapr: Don't use weird units for MIN_RMA_SLOF
> >       spapr,ppc: Simplify signature of kvmppc_rma_size()
> >       spapr: Don't attempt to clamp RMA to VRMA constraint
> >       spapr: Don't clamp RMA to 16GiB on new machine types
> >       spapr: Clean up RMA size calculation
> >       spapr: Move creation of ibm,dynamic-reconfiguration-memory dt node
> >       spapr: Move creation of ibm,architecture-vec-5 property
> >       spapr: Rename DT functions to newer naming convention
> >=20
> > Greg Kurz (2):
> >       spapr: Handle pending hot plug/unplug requests at CAS
> >       ppc: Officially deprecate the CPU "compat" property
> >=20
> > Nicholas Piggin (8):
> >       ppc/spapr: Fix FWNMI machine check failure handling
> >       ppc/spapr: Change FWNMI names
> >       ppc/spapr: Add FWNMI System Reset state
> >       ppc/spapr: Fix FWNMI machine check interrupt delivery
> >       ppc/spapr: Allow FWNMI on TCG
> >       target/ppc: allow ppc_cpu_do_system_reset to take an alternate ve=
ctor
> >       ppc/spapr: Implement FWNMI System Reset delivery
> >       ppc/spapr: Ignore common "ibm,nmi-interlock" Linux bug
> >=20
> > Philippe Mathieu-Daud=E9 (8):
> >       hw/ppc/pnv: Fix typo in comment
> >       hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
> >       hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexibl=
e array
> >       hw/scsi/spapr_vscsi: Simplify a bit
> >       hw/scsi/spapr_vscsi: Introduce req_iu() helper
> >       hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
> >       hw/scsi/spapr_vscsi: Prevent buffer overflow
> >       hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event
> >=20
> > Shivaprasad G Bhat (1):
> >       spapr: Fix Coverity warning while validating nvdimm options
> >=20
> > Vitaly Chikunov (1):
> >       target/ppc: Fix rlwinm on ppc64
> >=20
> >  docs/system/deprecated.rst        |   7 +
> >  hw/intc/spapr_xive.c              |   4 +-
> >  hw/ppc/pnv_lpc.c                  |   2 +-
> >  hw/ppc/spapr.c                    | 980 ++++++++++++++++++++----------=
--------
> >  hw/ppc/spapr_caps.c               |  19 +-
> >  hw/ppc/spapr_cpu_core.c           |  16 +-
> >  hw/ppc/spapr_events.c             |  51 +-
> >  hw/ppc/spapr_hcall.c              |  15 +-
> >  hw/ppc/spapr_nvdimm.c             |   7 +-
> >  hw/ppc/spapr_ovec.c               |   4 +-
> >  hw/ppc/spapr_rtas.c               |  45 +-
> >  hw/scsi/spapr_vscsi.c             |  72 +--
> >  hw/scsi/trace-events              |   1 +
> >  hw/scsi/viosrp.h                  |   3 +-
> >  include/hw/ppc/spapr.h            |  34 +-
> >  include/hw/ppc/spapr_cpu_core.h   |   4 +-
> >  include/hw/ppc/spapr_ovec.h       |   4 +-
> >  pc-bios/README                    |   2 +-
> >  pc-bios/slof.bin                  | Bin 931032 -> 965008 bytes
> >  roms/SLOF                         |   2 +-
> >  target/ppc/cpu-qom.h              |   1 +
> >  target/ppc/cpu.h                  |  28 +-
> >  target/ppc/excp_helper.c          |  79 ++-
> >  target/ppc/kvm.c                  |   5 +-
> >  target/ppc/kvm_ppc.h              |   7 +-
> >  target/ppc/mmu-hash64.c           | 319 +++++--------
> >  target/ppc/translate.c            |  20 +-
> >  target/ppc/translate_init.inc.c   | 116 ++---
> >  tests/qtest/libqos/libqos-spapr.h |   3 +-
> >  29 files changed, 930 insertions(+), 920 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5xUCEACgkQbDjKyiDZ
s5LzXg/+I+RbL/bm1Gjtrq9VSjVcTbZNPnDbCXgqbVe6YxaGHe7OQnE0xmAce9fl
tcFhNVPhbog/Uh+Vfb0TYhdtGEyLI7UZwy0JDfLTKKeFEpKx7OjfN7SuqVBH6UaI
gjgXDbpyP2oqRjaXQxjb7q4ukLYjGw89DHzhoCvpW+PbPobGcYDqGBtdDkxnmdDZ
3MAvq6ehaUkPedrlnUC0WRF0zz2ufNbQ3klt6k/LP0L6voeTOkFqJM6nWhi7P6xY
0vFszmOkYKqQOOm3/wZ2PuDjecgOaQDJ7kZSycBVaKRP8tYUqOi8yjjnmuVqZy7E
n5kAb37bBxw3ejkVmgbibL5CGkYF1pTiyniYDtcewWMsouqT06RTfvtWiqAghLaB
oAHmadMjUL1MX1i5mHnBkLmLipz+R0GoBOSHdnWsN95C64yc8jUAyhDeZpR1qxoz
0qb/o51yb3aBEO3RxGN1R7Kxq8iCRMT4LCdI2B7WWTc4nGtG0A5Vw31y/sms/ZGw
NuMgeNZFkaEDqT4O74NSSfYY77ed+0nYkfTDa1f4OOXfh4Cv0gF8zKo2KfYuU35U
82REIxR0hVRmKOEMJOQOq1PGZbwFYac6iBVjxnmOBbwzGuXUeaAUzX6ITFtHxWdV
527imy2KA56jhcW/8O8M1BQEdNcyHnAbVXfsnaStqIujVS5aAQ8=
=yhP4
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--

