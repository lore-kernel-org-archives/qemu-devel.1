Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B0C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 04:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C417921670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 04:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZHfbhh16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C417921670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjFvu-0004pr-4R
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 00:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hjFv9-0004Pj-VY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 00:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hjFv8-0000FD-EP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 00:34:03 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hjFv7-0008BX-Al; Fri, 05 Jul 2019 00:34:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45g26F6w0Wz9sPG; Fri,  5 Jul 2019 14:33:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562301221;
 bh=MjedqUUuszvrnMR1xbsiiUljgUjSMLpkVQOAHxis+og=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZHfbhh16LiKF/rSRyDVOYB/jMQfGRnj+9hfjIO4C/6ZJyPMaX9tBA4w5GUvJi+1Lv
 RGHfr21Gp6BV/YuA7T1aBp0Izssl63Ei9kmeV8Tbx+lpJbrRC6jBZi6o04i50LgSYT
 MHZsn5mDAR+tKfux12V5rnkag00SLQ5K6gSPyS48=
Date: Fri, 5 Jul 2019 11:07:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190705010755.GA3266@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
 <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
 <20190703030334.GF9442@umbus.fritz.box>
 <a43707b0-8059-b2bd-a461-9f6de3285d8f@linux.vnet.ibm.com>
 <20190704010714.GS9442@umbus.fritz.box>
 <d5c75742-4f45-2f26-3837-098e8710ccd9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <d5c75742-4f45-2f26-3837-098e8710ccd9@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v10 2/6] ppc: spapr: Introduce FWNMI
 capability
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 10:33:11AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 04 July 2019 06:37 AM, David Gibson wrote:
> > On Wed, Jul 03, 2019 at 02:58:24PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Wednesday 03 July 2019 08:33 AM, David Gibson wrote:
> >>> On Tue, Jul 02, 2019 at 11:54:26AM +0530, Aravinda Prasad wrote:
> >>>>
> >>>>
> >>>> On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
> >>>>> On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
> >>>>>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> >>>>>> the KVM causes guest exit with NMI as exit reason
> >>>>>> when it encounters a machine check exception on the
> >>>>>> address belonging to a guest. Without this capability
> >>>>>> enabled, KVM redirects machine check exceptions to
> >>>>>> guest's 0x200 vector.
> >>>>>>
> >>>>>> This patch also introduces fwnmi-mce capability to
> >>>>>> deal with the case when a guest with the
> >>>>>> KVM_CAP_PPC_FWNMI capability enabled is attempted
> >>>>>> to migrate to a host that does not support this
> >>>>>> capability.
> >>>>>>
> >>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>>>> ---
> >>>>>>  hw/ppc/spapr.c         |    1 +
> >>>>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>>>>>  include/hw/ppc/spapr.h |    4 +++-
> >>>>>>  target/ppc/kvm.c       |   19 +++++++++++++++++++
> >>>>>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >>>>>>  5 files changed, 61 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>>> index 6dd8aaa..2ef86aa 100644
> >>>>>> --- a/hw/ppc/spapr.c
> >>>>>> +++ b/hw/ppc/spapr.c
> >>>>>> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectC=
lass *oc, void *data)
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP=
_OFF;
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR=
_CAP_ON;
> >>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OF=
F;
> >>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>>>      smc->irq =3D &spapr_irq_dual;
> >>>>>>      smc->dr_phb_enabled =3D true;
> >>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>>>> index 31b4661..2e92eb6 100644
> >>>>>> --- a/hw/ppc/spapr_caps.c
> >>>>>> +++ b/hw/ppc/spapr_caps.c
> >>>>>> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachine=
State *spapr, uint8_t val,
> >>>>>>      }
> >>>>>>  }
> >>>>>> =20
> >>>>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t=
 val,
> >>>>>> +                                Error **errp)
> >>>>>> +{
> >>>>>> +    if (!val) {
> >>>>>> +        return; /* Disabled by default */
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (tcg_enabled()) {
> >>>>>> +        error_setg(errp,
> >>>>>> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try=
 cap-fwnmi-mce=3Doff");
> >>>>>
> >>>>> Not allowing this for TCG creates an awkward incompatibility between
> >>>>> KVM and TCG guests.  I can't actually see any reason to ban it for =
TCG
> >>>>> - with the current code TCG won't ever generate NMIs, but I don't s=
ee
> >>>>> that anything will actually break.
> >>>>>
> >>>>> In fact, we do have an nmi monitor command, currently wired to the
> >>>>> spapr_nmi() function which resets each cpu, but it probably makes
> >>>>> sense to wire it up to the fwnmi stuff when present.
> >>>>
> >>>> Yes, but that nmi support is not enough to inject a synchronous error
> >>>> into the guest kernel. For example, we should provide the faulty add=
ress
> >>>> along with other information such as the type of error (slb multi-hi=
t,
> >>>> memory error, TLB multi-hit) and when the error occurred (load/store)
> >>>> and whether the error was completely recovered or not. Without such
> >>>> information we cannot build the error log and pass it on to the guest
> >>>> kernel. Right now nmi monitor command takes cpu number as the only a=
rgument.
> >>>
> >>> Obviously we can't inject an arbitrary MCE event with that monitor
> >>> command.  But isn't there some sort of catch-all / unknown type of MCE
> >>> event which we could inject?
> >>
> >> We have "unknown" type of error, but we should also pass an address in
> >> the MCE event log. Strictly speaking this address should be a valid
> >> address in the current CPU context as MCEs are synchronous errors
> >> triggered when we touch a bad address.
> >=20
> > Well, some of them are.  At least historically both synchronous and
> > asnchronous MCEs were possible.  Are there really no versions where
> > you can report an MCE with unknown address?
>=20
> I am not aware of any such versions. Will cross check.
>=20
> >=20
> >> We can pass a default address with every nmi, but I am not sure whether
> >> that will be practically helpful.
> >>
> >>> It seems very confusing to me to have 2 totally separate "nmi"
> >>> mechanisms.
> >>>
> >>>> So I think TCG support should be a separate patch by itself.
> >>>
> >>> Even if we don't wire up the monitor command, I still don't see
> >>> anything that this patch breaks - we can support the nmi-register and
> >>> nmi-interlock calls without ever actually creating MCE events.
> >>
> >> If we support nmi-register and nmi-interlock calls without the monitor
> >> command wire-up then we will be falsely claiming the nmi support to the
> >> guest while it is not actually supported.
> >=20
> > How so?  AFAICT, from the point of view of the guest this is not
> > observably different from supporting the NMI mechanism but NMIs never
> > occurring.
>=20
> A guest inserting a duplicate SLB will expect the machine check
> exception delivered to the handler registered via nmi,register.
> But we actually don't do that in TCG.

Ah, true, I was thinking of external hardware fault triggered MCEs
rather than software error ones like duplicate SLB.

That said, I strongly suspect TCG is buggy enough at present that
exact behaviour in rare error conditions like duplicate SLB is not
really a big problem in the scheme of things.

I really don't think we can enable this by default until we allow it
for TCG - we don't want starting a TCG guest to involve manually
switching other options.

We could consider allowing it for TCG but just printing a warning that
the behaviour may not be correct in some conditions - we do something
similar for some of the Spectre workarounds already.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0eoukACgkQbDjKyiDZ
s5JkpxAA1ObTlUn9Po1xUde6cGgFT0N75DH28Dvua34jW6O0jBgfFG0GTVfOLdza
/gPdNQW3T7z2038RPcEv5ewz98ps1rxmFpqcpA9AyNTRoQQLumMwmpT2nlGjE+ZV
syHiNfyWUlWIjRKNdK6yjB295NwN3tqgfjZKkALdEsJlFwlVvZzTcstefx2/aAsG
fwtMWRb4OoiqEJ3lxuEUoEv/Xw8Cfdlt7/ONC3npHZAypguUOAz+ZtYUFgA6gKjv
u9ugLVGRjcS6e8dIya8sdxVQRM3db5fVoCasRP/yi57clmIsnO7/gVJuDmBJM6nP
X8PVtTV7ItwoyCC2IieKWL+7tkMvj/+pWcqlKHFLGsZN8ja1SpnuF/If5ztcvdZo
wzhb/j33wIo2Lonk7+KroTvYbkEKc7O5gKHff0/Ty+ytPCNpojLZZtj++GtuKThN
lqcba1wvyGkZ9Pi/G3sBn71AkeUKdFAwVHNJWITYoSbxMOLzsuMUPmkQ7AJnMzXE
l2dM2p/Q0+uMN3iijnWjhZn1ZzgJ1/Y+5IgrXBRakRA49Hj5VhQm4x2g+k3HfNmt
OlXpabIYk8c5GWOTisSC15LmScNlHKOemgZJENrmQ3JPvmVwqK/RezaEpwH4Qa+X
HkFq34s3I9yQYwycgWJ1yI/3M94jKyM+bQ44TTyY6b4Fq2WHR2c=
=tj8u
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

