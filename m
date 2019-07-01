Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A968C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57737208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kyUB2rfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57737208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoSR-0003fH-7e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhoRK-00037K-Jq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhoRJ-0003pn-5N
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:01:18 -0400
Received: from ozlabs.org ([203.11.71.1]:33779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhoRH-0003Wc-OB; Mon, 01 Jul 2019 01:01:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cZvY3HJrz9sPB; Mon,  1 Jul 2019 15:00:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561957257;
 bh=9/iKxDWJaVl8YI5Buf3vy1F8pCkAQy72zreiVxW0QWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kyUB2rfYjUqsu3tXzjmlAS9b2CHkXUVwPHArFd2tIte64teN1T+f64hQuiAClvfcm
 pdTTYpl7uLoF36g80FeePzEMv6pUDQhQFrOiyu4EJYpPw63ZL7b/bkHZiW+0BBNn/Q
 muQFVAYmwCmtgA4ETcigeL1GoKyyuh1wo6qmHcZ0=
Date: Mon, 1 Jul 2019 14:42:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190701044201.GH2138@umbus.fritz.box>
References: <20190624055812.3906-1-sjitindarsingh@gmail.com>
 <20190628092952.GB29462@umbus.fritz.box>
 <1561955001.10832.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <1561955001.10832.2.camel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] ppc/spapr: Add
 implementation of hcall H_PURR
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 02:23:21PM +1000, Suraj Jitindar Singh wrote:
> On Fri, 2019-06-28 at 19:29 +1000, David Gibson wrote:
> > On Mon, Jun 24, 2019 at 03:58:11PM +1000, Suraj Jitindar Singh wrote:
> > > The hcall H_PURR is used by a guest to read the PURR (processor
> > > utilisation of resources register). A guest expects that this
> > > register
> > > will count at a rate of timebase scaled by the number of guest
> > > vcpus
> > > present in the vcore. That is the per vcpu purr will count at a
> > > rate of
> > > timebase / # vcpus per vcore.
> > >=20
> > > Implement a handler for the H_PURR hcall and return the purr value
> > > divided by smp_threads so that the sum of the purr deltas across
> > > the
> > > vcpus of a vcore equals the timebase delta
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > Does this need something new advertised in the hypertas DT entry?
>=20
> Hi David,
>=20
> There doesn't seem to be a concensus on what the return value from the
> H_PURR hcall should be, whether it just returns the hardware value or
> does some adjusting of the value based on guest smt mode as I've
> implemented in the patch below.

*eyeroll*.  Lack of forethought in PAPR strikes again.

> As such please drop this patch series.

Ok, will do.

>=20
> The guest can just read the purr register directly anyway and then
> interpret the values as it pleases.
>=20
> Kind Regards,
> Suraj
>=20
> >=20
> > > ---
> > >  hw/ppc/spapr_hcall.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index aae9fd2b3e..88b3343f04 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1819,6 +1819,27 @@ static target_ulong h_update_dt(PowerPCCPU
> > > *cpu, SpaprMachineState *spapr,
> > >      return H_SUCCESS;
> > >  }
> > > =20
> > > +static target_ulong h_purr(PowerPCCPU *cpu, SpaprMachineState
> > > *spapr,
> > > +                           target_ulong opcode, target_ulong
> > > *args)
> > > +{
> > > +    CPUPPCState *env =3D &cpu->env;
> > > +    target_ulong purr;
> > > +
> > > +    if (kvm_enabled()) {
> > > +        cpu_synchronize_state(CPU(cpu));
> > > +        /*
> > > +         * Divide by smp_threads so that the sum of the purr
> > > deltas across the
> > > +         * vcpus of a vcore equal the timebase delta.
> > > +         */
> > > +        purr =3D env->spr[SPR_PURR] / smp_threads;
> > > +    } else {
> > > +        purr =3D cpu_ppc_load_purr(env);
> > > +    }
> > > +    args[0] =3D purr;
> > > +
> > > +    return H_SUCCESS;
> > > +}
> > > +
> > >  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4)
> > > + 1];
> > >  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX -
> > > KVMPPC_HCALL_BASE + 1];
> > > =20
> > > @@ -1915,6 +1936,9 @@ static void hypercall_register_types(void)
> > >      spapr_register_hypercall(H_LOGICAL_DCBF, h_logical_dcbf);
> > >      spapr_register_hypercall(KVMPPC_H_LOGICAL_MEMOP,
> > > h_logical_memop);
> > > =20
> > > +    /* hcall-purr */
> > > +    spapr_register_hypercall(H_PURR, h_purr);
> > > +
> > >      /* qemu/KVM-PPC specific hcalls */
> > >      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> > > =20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZjxkACgkQbDjKyiDZ
s5J1/w//e+vXYgFYB+TJLt+8Hif5PUypXYZ4BlbEwhjOvbNGUhY7jme+QkxqGapD
7yYvIUNhUHoD3/x4NSEvbyzJbThFRz/oQl8RaQtFKtqjduAl0COLGw624CWkzFsx
ytFWtJHb3kkGuQrc97bFn7m8ZGOZLCqgii1rItqWTrT7PXvGTW9NNhEN+5e04nMi
qTCC8j6blc2/Ti+rkj7oNWWOBzheeb4OVLaXtdGxpIHuiDdpPtYGS192/pwPYgPr
Xui9L/hMHC3cp9tlPlRg8iBZAt8yjdlkYj1BFtQyKEG+KaP3WclAvjXscL3AoJ2i
osjyXeY2hdLdKhoA/m/Pum/VnMaTXBn1XGup7ku3dpa9cy/wBaTX0s3AHnusrNgv
1WQmXVJgEcn5ry5urlVSJbNwxOOJ2CBcComrnMDNCiEBdAJaPME3kv8SigNFqIEk
kaW8cgVvg3vuOHqbn7kiz2f1Hdl6cn7YBA9qLfZ6Cg4cKQOXxutf5guIH1b1DRfb
VH38AwzhHwww1AqMta97rCD54lfNCeXW66sAsT/YzCYLW/I8V4/x7wKQYxLfJNQg
fIQ2QRkWIHbWQCxjbSUpfwKuYZqPiXiu3yXWfkoty/zZSZuG0P+hz9+qixRTkzRN
1F3VGdyWvns2ex7F5ugmLPTlKmCIhnz9195aZLK/8mXMkM0WB0c=
=SIDp
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--

