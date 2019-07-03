Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDFCC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370F221880
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VKKHZQ0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370F221880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYXY-0005Ga-Fb
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYW0-0003YG-19
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVy-0006B2-JR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43017 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiYVu-0005wa-Mj; Wed, 03 Jul 2019 02:13:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45drPZ4hqsz9s4Y; Wed,  3 Jul 2019 16:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562134370;
 bh=5gdfxwhe7B5HsT92/KHwqYPWnrj1gUoE/XOIsBMZLDY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VKKHZQ0dc9yZXlX/6rEzm/6MImQBjlgGMc0b8Q0BqYMsmPWjk+Qyhv6Dopu9KBQWj
 CLvO4roZ9/rTCe17YWmJqWJwnUsPOeVu3r4fZr7a8CqLSQanMDAXaMAZVhFiGvtwWf
 hDm9I2D2zLauLbcM/RY/CcbWoSv0m9kU7Dcfl2aQ=
Date: Wed, 3 Jul 2019 13:03:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190703030334.GF9442@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
 <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
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


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2019 at 11:54:26AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
> > On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
> >> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> >> the KVM causes guest exit with NMI as exit reason
> >> when it encounters a machine check exception on the
> >> address belonging to a guest. Without this capability
> >> enabled, KVM redirects machine check exceptions to
> >> guest's 0x200 vector.
> >>
> >> This patch also introduces fwnmi-mce capability to
> >> deal with the case when a guest with the
> >> KVM_CAP_PPC_FWNMI capability enabled is attempted
> >> to migrate to a host that does not support this
> >> capability.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |    1 +
> >>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |    4 +++-
> >>  target/ppc/kvm.c       |   19 +++++++++++++++++++
> >>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >>  5 files changed, 61 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 6dd8aaa..2ef86aa 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>      spapr_caps_add_properties(smc, &error_abort);
> >>      smc->irq =3D &spapr_irq_dual;
> >>      smc->dr_phb_enabled =3D true;
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index 31b4661..2e92eb6 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineStat=
e *spapr, uint8_t val,
> >>      }
> >>  }
> >> =20
> >> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> >> +                                Error **errp)
> >> +{
> >> +    if (!val) {
> >> +        return; /* Disabled by default */
> >> +    }
> >> +
> >> +    if (tcg_enabled()) {
> >> +        error_setg(errp,
> >> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try cap=
-fwnmi-mce=3Doff");
> >=20
> > Not allowing this for TCG creates an awkward incompatibility between
> > KVM and TCG guests.  I can't actually see any reason to ban it for TCG
> > - with the current code TCG won't ever generate NMIs, but I don't see
> > that anything will actually break.
> >=20
> > In fact, we do have an nmi monitor command, currently wired to the
> > spapr_nmi() function which resets each cpu, but it probably makes
> > sense to wire it up to the fwnmi stuff when present.
>=20
> Yes, but that nmi support is not enough to inject a synchronous error
> into the guest kernel. For example, we should provide the faulty address
> along with other information such as the type of error (slb multi-hit,
> memory error, TLB multi-hit) and when the error occurred (load/store)
> and whether the error was completely recovered or not. Without such
> information we cannot build the error log and pass it on to the guest
> kernel. Right now nmi monitor command takes cpu number as the only argume=
nt.

Obviously we can't inject an arbitrary MCE event with that monitor
command.  But isn't there some sort of catch-all / unknown type of MCE
event which we could inject?

It seems very confusing to me to have 2 totally separate "nmi"
mechanisms.

> So I think TCG support should be a separate patch by itself.

Even if we don't wire up the monitor command, I still don't see
anything that this patch breaks - we can support the nmi-register and
nmi-interlock calls without ever actually creating MCE events.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cGwQACgkQbDjKyiDZ
s5KTjA/9HLz749EM2iv2zhCnpnT5aFKqBnsCG3eNYh7B7SP7Ou5ekPz4GKlkmdSt
M+Vu4xreFDVrPcBSGgP54zoCx8gkeGVBinJH067usn+qBCS3FF7Y7so38DLtcSLK
tUjQ/CCMIkGP2XVUouFAok2mhEJZ0iHJxItW1fiyN0AH54xhu65M5NJ6Y9j3lyDf
TGy4fXNk7YnqrDznPB/wWxrPMYhWl6I7vjQa82TmvWI7PTy95vZREVdr+dNImwnQ
SCnogyriKwTxhHCujWmFdz4cMtp+ZuYed49JcDIkHGjfzgBCqgfEkmRdERPHn/eA
4X5G/x3ijhmk+9v6+y8wozhiWjawehcwMEBjnX5G9Oph+4FJdHyHivLDSsP9XVQq
6vjcIFGQHOfRGX+bqo2KE58qUmyw/lQdpbUebO/7jTOfJcwlexqz+8hCNOoJ0ve2
2eIpT3vEAkHS3YMJr2f1WEEzG0lFnYYGR3Q59dWPYL3JimonVE15NZvvQd0ei/7j
ENJ3AZufmZUaNFMa6w9vrk/m1uMTcqlziotRR3uOAr/O81yk6CwlowOd96JTTlW5
RLUZAJdXppkCZfK59WR3Nwn8gcGU4OQ6Uy77SS/Z9+/HhbYGqO8QGA30UppjrfI7
rvxQLy+M+zw3c/Y+BAo8c2zrXHJ6o/Ag5yOJDFK7P/u3IyQFKTE=
=Xl8X
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

