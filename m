Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D1CC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAB520728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAB520728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isNfP-0002vS-An
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1isNem-0002Rc-Ui
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1isNel-00022o-Hm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:11:08 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:52893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1isNel-00020s-8e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:11:07 -0500
Received: from player690.ha.ovh.net (unknown [10.108.35.27])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7E6961BFEDC
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:11:04 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 7B668E338763;
 Fri, 17 Jan 2020 09:10:59 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:10:53 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Fail CAS if option vector table cannot be parsed
Message-ID: <20200117101053.3b436140@bahia.lan>
In-Reply-To: <20200117054657.GT54439@umbus>
References: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
 <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
 <20200117054657.GT54439@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jymUMTFDjF=71HTWto4mdlY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 8802285474499631590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/jymUMTFDjF=71HTWto4mdlY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2020 15:46:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jan 16, 2020 at 04:34:06PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Greg,
> >=20
> > On 1/16/20 4:05 PM, Greg Kurz wrote:
> > > Most of the option vector helpers have assertions to check their
> > > arguments aren't null. The guest can provide an arbitrary address
> > > for the CAS structure that would result in such null arguments.
> > > Fail CAS with H_PARAMETER instead of aborting QEMU.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >   hw/ppc/spapr_hcall.c |    9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 84e1612595bb..051869ae20ec 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1701,9 +1701,18 @@ static target_ulong h_client_architecture_supp=
ort(PowerPCCPU *cpu,
> > >       /* For the future use: here @ov_table points to the first optio=
n vector */
> > >       ov_table =3D addr;
> > > +    if (!ov_table) {
> > > +        return H_PARAMETER;
> > > +    }
> >=20
> > This doesn't look right to check ov_table, I'd check addr directly inst=
ead:
> >=20
> > -- >8 --
> > @@ -1679,12 +1679,16 @@ static target_ulong
> > h_client_architecture_support(PowerPCCPU *cpu,
> >=20
> >      cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported,
> > &local_err);
> >      if (local_err) {
> >          error_report_err(local_err);
> >          return H_HARDWARE;
> >      }
> > +    if (!addr) {
> > +        // error_report*()
> > +        return H_PARAMETER;
> > +    }
> >=20
> >      /* Update CPUs */
> >      if (cpu->compat_pvr !=3D cas_pvr) {
> > ---
> >=20
> > Still I'm not sure it makes sense, because the guest can also set other
> > invalid addresses such addr=3D0x69.
>=20
> Neither is correct.  As you point out this filters at most one of many
> bad addresses.  And, in fact it's not even a bad address - there's no
> inherent reason the CAS information couldn't be put at guest address
> 0.
>=20

Yes you're right, the guest can pass 0 as the address of the CAS structure.
But ov_table is the address of the vector table which comes after the PVR
list in the CAS structure, so it _cannot_ be zero. It is calculated in
cas_check_pvr() by incrementing the address passed by the guest while
parsing the PVR list. I was thinking that the guest could pass a value
that could cause addr to wrap and we end up with 0... but this cannot
happen actually since addr is a real address (60 bits) as returned by
ppc64_phys_to_real() and cas_check_pvr() can increment it no more than
512*8. Definitely not enough to wrap.

I'll simply drop this check. If the g_assert() in spapr_ovec_parse_vector()
is hit then it can only be the consequence of a bug in QEMU.

>=20
> >=20
> > >       ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
> > > +    if (!ov1_guest) {
> > > +        return H_PARAMETER;
> > > +    }
> >=20
> > This one is OK (unlikely case where vector 1 isn't present).
> >=20
> > >       ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> > > +    if (!ov5_guest) {
> > > +        return H_PARAMETER;
> > > +    }
> >=20
> > This one is OK too (unlikely case where vector 5 isn't present).
> >=20
> > >       if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
> > >           error_report("guest requested hash and radix MMU, which is =
invalid.");
> > >           exit(EXIT_FAILURE);
> > >=20
> > >=20
> >=20
>=20
> I agree these ones are ok, though.
>=20


--Sig_/jymUMTFDjF=71HTWto4mdlY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4heh0ACgkQcdTV5YIv
c9bhZRAAu4pIqg35cze0w1EUSATdziLwf9VNxXsPN03TrhscVkR3NmLLf9gqpSo1
1TQ/WeVrZ+imGqU82gxwADcZUvFnRUxMMLu107rx4xNKEUlwC4EFupWXSGVqWKWw
dXq+N3SHdqq7PKjBGEc+BTu/UQubk+6GnOgma5s9TonHVva9iPbFyN44ZslpOos2
ruoLDWbDJBvAMIFvEXTnsE8FflL1asBHNt0KwU3H9rLVOXCOVuHwDfx/Tddewr+U
reXHIA3yHIQmxwQfhPPpro0GpuTZVv+lEKHfiW63LJvBi2YAr7lLvPsSjYspBilv
LQKrDnG0fNsq89KkTa68OLffenCyzccq+cud6g5dznQaX0eks5AeJSEilt3ateUl
LfsAZbAHGF5EZzytuWXKLVXKIbq7mVFs3YxSNAfVJNyDwBAEeZB6Jox5c4Hg5496
iUvwypEBG9dzEyLglafAiz6NZMoc0ZNApRxnu5qw5Rpae34nAbMhkoW3wUAmhEUO
p3q6JqXrO3a4Hq+CXolsqoAdJCR2pso1cUhab/H8GMgUYCBLJoIMK0LuiPlGiwg/
vd0W6gOWRO290UghwtVd+VqNQFjbLzA+DEI3siZoXw1A7/UCb0qvdgHLUwjRgf1S
5dNCpDnx3qGu2pT0tSHz6XFh8qRe3MhbyQBDHSPqkm9mnYzpwns=
=vGqy
-----END PGP SIGNATURE-----

--Sig_/jymUMTFDjF=71HTWto4mdlY--

