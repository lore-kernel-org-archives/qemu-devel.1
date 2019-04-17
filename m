Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EAC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339AB21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pPITIcDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339AB21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGavg-00008A-BM
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:08:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasx-0006Z1-Hl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGasu-0001s3-2g
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:05:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60055 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGasr-0001og-SL; Tue, 16 Apr 2019 23:05:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kRtZ6yTWz9sCF; Wed, 17 Apr 2019 13:05:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555470310;
	bh=StwlbckTahjyZfY4brwkNss0ye010QVIePBnCbxOtxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPITIcDvqw3EGbLAtS+O1SelG2A1c1lxhdNp2Ga9QnOs/pJI5knlENT4UP4LPXcq1
	76u6EDgOaZ/BEAJqcGDWuR/+ERLyFBOHDztyYJMa+Td2rXq9bS1uIikUOylgEwz2Fw
	uwPblvfRKUonIdMtYl6IqvMSsRmon5YwMenV6Xp8=
Date: Wed, 17 Apr 2019 12:09:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190417020928.GJ32705@umbus.fritz.box>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323645659.18748.12592305605497011547.stgit@aravinda>
	<20190325063205.GQ29295@umbus>
	<9da8a51d-106c-410e-fa88-d37dceb0c9e1@linux.vnet.ibm.com>
	<20190325233319.GD9393@umbus.fritz.box>
	<93ee6877-b487-1733-a368-3887f105f5a3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <93ee6877-b487-1733-a368-3887f105f5a3@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 5/6] ppc: spapr: Enable FWNMI
 capability
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
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417020928.cV11FKXBQ1-CCkoZYDKuveYWjdOrD7JcNIV4s0AcVfk@z>


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 03:42:46PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 26 March 2019 05:03 AM, David Gibson wrote:
> > On Mon, Mar 25, 2019 at 02:27:45PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Monday 25 March 2019 12:02 PM, David Gibson wrote:
> >>> On Fri, Mar 22, 2019 at 12:04:16PM +0530, Aravinda Prasad wrote:
> >>>> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> >>>> the KVM causes guest exit with NMI as exit reason
> >>>> when it encounters a machine check exception on the
> >>>> address belonging to a guest. Without this capability
> >>>> enabled, KVM redirects machine check exceptions to
> >>>> guest's 0x200 vector.
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr_rtas.c  |   15 +++++++++++++++
> >>>>  target/ppc/kvm.c     |   14 ++++++++++++++
> >>>>  target/ppc/kvm_ppc.h |    6 ++++++
> >>>>  3 files changed, 35 insertions(+)
> >>>>
> >>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >>>> index fb594a4..939f428 100644
> >>>> --- a/hw/ppc/spapr_rtas.c
> >>>> +++ b/hw/ppc/spapr_rtas.c
> >>>> @@ -49,6 +49,7 @@
> >>>>  #include "hw/ppc/fdt.h"
> >>>>  #include "target/ppc/mmu-hash64.h"
> >>>>  #include "target/ppc/mmu-book3s-v3.h"
> >>>> +#include "kvm_ppc.h"
> >>>> =20
> >>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineSta=
te *spapr,
> >>>>                                     uint32_t token, uint32_t nargs,
> >>>> @@ -354,6 +355,20 @@ static void rtas_ibm_nmi_register(PowerPCCPU *c=
pu,
> >>>>                                    target_ulong args,
> >>>>                                    uint32_t nret, target_ulong rets)
> >>>>  {
> >>>> +    int ret;
> >>>> +
> >>>> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >>>> +
> >>>> +    if (ret =3D=3D 1) {
> >>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >>>
> >>> Urgh, we're here making a guest visible different to the environment
> >>> depending on a host (KVM) capability.  What happens if you start a
> >>> guest and it registers fwnmi support, then migrate it to a host that
> >>> lacks the necessary KVM support?
> >>
> >> I just checked how such scenarios are handled for other KVM
> >> capabilities. Should I need to add an Spapr cap for this?
> >=20
> > Yes, I think that's what we'll need to do.
>=20
> I was looking into SPAPR Cap, and I am not sure that the following code
> will help in handling the migration. I need some help here.
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index edc5ed0..ef96192 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -473,6 +473,15 @@ static void cap_ccf_assist_apply(SpaprMachineState
> *spapr, uint8_t val,
>      }
>  }
>=20
> +static void cap_machine_check_apply(SpaprMachineState *spapr, uint8_t va=
l,
> +                                    Error **errp)
> +{
> +    if (kvm_enabled()) {
> +        if (kvmppc_fwnmi_enable(cpu)) {
> +            error_setg(errp, "Unable to enable fwnmi capability");
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -571,6 +580,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_ccf_assist_apply,
>      },
> +    [SPAPR_CAP_MACHINE_CHECK] =3D {
> +        .name =3D "machine-check",
> +        .description =3D "Handle machine check exceptions",
> +        .index =3D SPAPR_CAP_MACHINE_CHECK,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_machine_check_apply,
> +    },
>  };
>=20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -706,6 +724,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(mce, SPAPR_CAP_MACHINE_CHECK);
>=20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
>=20
>=20
> Or is it that just adding SPAPR_CAP_MIG_STATE(mce,
> SPAPR_CAP_MACHINE_CHECK); is enough as it is checking or cap values?

No, the change you have above looks mostly good.  You'll also need to
set default values for the cap in spapr_machine_class_init(), and
probably compat values in some of the earlier machine type variants.

I also don't like the cap name: there's at least some kind of handling
of machine checks before this, this is more specifically about the
fwnmi scheme, AIUI.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2itgACgkQbDjKyiDZ
s5JyXw/+If92XPZya1XYTydETgMQBbskeQQ84Da3zbeaVb0HEq5AfnLNhzNgT9dd
jKfyrhfPLwuz+xvUGJMt9tI7dSiE6E1xUrxD/NqAwDmMucaS2BFbEfhqG1p6qAkm
lU8+KcXrc9OcxdgfJwo1N13nGElfjlSPKzgc0stWVLbuC2GOX3gHRGwUUn/a2tMZ
dmUbFONGxYOWqUJ78C9AIUfjI/ATiefBhO9PyCjEuGHisjzBH0LBRipdVj3n6Pcd
LPbglIFQbIe+WCZI688sb924GdF+id4HTRlDuTHvQ0qebSxpXQPIY2POYAHg1sLS
IbURDwUhpVWPaKndzX6cjUaHxLmD3IrhQlBX8djvgiBitBHnZ52vVBIDbpyOkk/j
QWz8g+IxHjfUBOrzmjJ8lYVFr0pRVaEDMGGLdgYK8TqRjmjVQsUlrgztWLZU88fW
ZaUDsCW3k1pzb6La9kWlDx0ayUtylSkQQqNmiYh7X4J+TNVeWd4GjQltKAQTP42s
RkF+uxPhuZU4uSk1lInUrU3BM915SPRIoj8o8KB9sN8F5TVkuG9cywqHvXSxNxK1
fEsXFbPSa/l/c7akKN1U5euOKnX08vGjQyuj++JYDsW+joqhgKz1G3uFMXT98IOS
8s4IqAZkzjkbXV8hfHxAIdfA44ymH9+o54MHiybTB5gMXHx+ZS4=
=V7CN
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--

