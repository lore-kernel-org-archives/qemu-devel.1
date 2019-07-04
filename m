Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F1C5B578
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7293C2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qIEwrKc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7293C2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hirAZ-0004Hi-OJ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 22:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hir8Q-0001kW-5J
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hir8O-0004CO-LZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:06:06 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hir8O-0004BL-00; Wed, 03 Jul 2019 22:06:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45fLtD3zcpz9sPB; Thu,  4 Jul 2019 12:05:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562205956;
 bh=X93MPxnQP8n+l6Lbeg7YScDpdXU5IHa7UDwta+LPl7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qIEwrKc/x7Fir/29DVrdRzZnywnl6xVwKnWVHOz6Vtgyamx79BpaS4f4xlWL4YYlk
 JEYZCFvlmrciIPskQ+6KrBTgTyPdhf+vWtJgjG5dmNyp+11A9L0qtZxJOhkx0su32j
 xScoLlptxuplGn6ZJXF+AK5nl5/+BNT/z09FCF54=
Date: Thu, 4 Jul 2019 11:07:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190704010714.GS9442@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
 <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
 <20190703030334.GF9442@umbus.fritz.box>
 <a43707b0-8059-b2bd-a461-9f6de3285d8f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o/5eNASeIIpuMggS"
Content-Disposition: inline
In-Reply-To: <a43707b0-8059-b2bd-a461-9f6de3285d8f@linux.vnet.ibm.com>
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


--o/5eNASeIIpuMggS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 02:58:24PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 03 July 2019 08:33 AM, David Gibson wrote:
> > On Tue, Jul 02, 2019 at 11:54:26AM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
> >>> On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
> >>>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> >>>> the KVM causes guest exit with NMI as exit reason
> >>>> when it encounters a machine check exception on the
> >>>> address belonging to a guest. Without this capability
> >>>> enabled, KVM redirects machine check exceptions to
> >>>> guest's 0x200 vector.
> >>>>
> >>>> This patch also introduces fwnmi-mce capability to
> >>>> deal with the case when a guest with the
> >>>> KVM_CAP_PPC_FWNMI capability enabled is attempted
> >>>> to migrate to a host that does not support this
> >>>> capability.
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr.c         |    1 +
> >>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>>>  include/hw/ppc/spapr.h |    4 +++-
> >>>>  target/ppc/kvm.c       |   19 +++++++++++++++++++
> >>>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >>>>  5 files changed, 61 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 6dd8aaa..2ef86aa 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
> >>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_O=
FF;
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_ON;
> >>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>      smc->irq =3D &spapr_irq_dual;
> >>>>      smc->dr_phb_enabled =3D true;
> >>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>> index 31b4661..2e92eb6 100644
> >>>> --- a/hw/ppc/spapr_caps.c
> >>>> +++ b/hw/ppc/spapr_caps.c
> >>>> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineSt=
ate *spapr, uint8_t val,
> >>>>      }
> >>>>  }
> >>>> =20
> >>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t v=
al,
> >>>> +                                Error **errp)
> >>>> +{
> >>>> +    if (!val) {
> >>>> +        return; /* Disabled by default */
> >>>> +    }
> >>>> +
> >>>> +    if (tcg_enabled()) {
> >>>> +        error_setg(errp,
> >>>> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try c=
ap-fwnmi-mce=3Doff");
> >>>
> >>> Not allowing this for TCG creates an awkward incompatibility between
> >>> KVM and TCG guests.  I can't actually see any reason to ban it for TCG
> >>> - with the current code TCG won't ever generate NMIs, but I don't see
> >>> that anything will actually break.
> >>>
> >>> In fact, we do have an nmi monitor command, currently wired to the
> >>> spapr_nmi() function which resets each cpu, but it probably makes
> >>> sense to wire it up to the fwnmi stuff when present.
> >>
> >> Yes, but that nmi support is not enough to inject a synchronous error
> >> into the guest kernel. For example, we should provide the faulty addre=
ss
> >> along with other information such as the type of error (slb multi-hit,
> >> memory error, TLB multi-hit) and when the error occurred (load/store)
> >> and whether the error was completely recovered or not. Without such
> >> information we cannot build the error log and pass it on to the guest
> >> kernel. Right now nmi monitor command takes cpu number as the only arg=
ument.
> >=20
> > Obviously we can't inject an arbitrary MCE event with that monitor
> > command.  But isn't there some sort of catch-all / unknown type of MCE
> > event which we could inject?
>=20
> We have "unknown" type of error, but we should also pass an address in
> the MCE event log. Strictly speaking this address should be a valid
> address in the current CPU context as MCEs are synchronous errors
> triggered when we touch a bad address.

Well, some of them are.  At least historically both synchronous and
asnchronous MCEs were possible.  Are there really no versions where
you can report an MCE with unknown address?

> We can pass a default address with every nmi, but I am not sure whether
> that will be practically helpful.
>=20
> > It seems very confusing to me to have 2 totally separate "nmi"
> > mechanisms.
> >=20
> >> So I think TCG support should be a separate patch by itself.
> >=20
> > Even if we don't wire up the monitor command, I still don't see
> > anything that this patch breaks - we can support the nmi-register and
> > nmi-interlock calls without ever actually creating MCE events.
>=20
> If we support nmi-register and nmi-interlock calls without the monitor
> command wire-up then we will be falsely claiming the nmi support to the
> guest while it is not actually supported.

How so?  AFAICT, from the point of view of the guest this is not
observably different from supporting the NMI mechanism but NMIs never
occurring.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o/5eNASeIIpuMggS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0dUT8ACgkQbDjKyiDZ
s5IGug/8Cn8ppaHO2DeYg+qZALgvMu82/eMdxkR2sdaBw+Dxu9h4B1OWrphsA/Bw
UiP1xz5dgnm37HA7Qk0FI1AQKNk5s7MdCSVPtCkWqRdHI43mqV5p8uC017lukHua
Oi9xcYk+gb0JR73T9ba39SgYNcO9MkjSHItdG2MKhfFJwF+hoak02NAWOxQXPjNg
1VDvuYaYAB98mxTx7qu7vlZX47iaQ1z/pATp5++pnPZuV7VWJBd12Fg17sP1GPRQ
BEalARG3AVkU4PIw9zhJMa5WgG5y8d2t2+JkYL6kwkcnqxEY3X7r2Io62hdnUPyo
BeOMDInqjSBaPcNviIcGYeshQmri8RboyOrWRAhKajVJfq423Jn3bD+Uo7kcpcx7
BKj4daUNGwHGPLrS9CFmVTphw8fsBf9sThWsXc62T5azP0HsjYIpTQGvboPitlKW
FEoRUvJKcWFXsoDY9y4rNA0EGv4h6KGw2W9uZWvDuqo2idUZ7zlDPXxLVsydVGpx
gzyPCC0T88fvrZr2eMt21wXKwAO58N3hEEbPgg6IWOqHNlpB7nsueDlLVy/Xio8l
XfpZpVW1xSo2hjOGeLi45jArLNEoul+36dnOTnLOC3RCtk9d1GWYsQBUUTpWC13f
9rAQ1BDrNWR7KIzdIQpfBGffYAfQCvsBq9TZvwAL4oN73gsuU/g=
=aYln
-----END PGP SIGNATURE-----

--o/5eNASeIIpuMggS--

