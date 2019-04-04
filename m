Return-Path: <SRS0=qZCI=SG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFADC4360F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A1C206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gp92LOpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A1C206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCBgn-0001cK-9C
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 19:22:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hCBft-00017p-Fc
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hCBfs-0007av-7m
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:21:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hCBfp-0007NP-Ei; Thu, 04 Apr 2019 19:21:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44ZzTr291xz9sPf; Fri,  5 Apr 2019 10:21:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554420080;
	bh=1LUdTjZNCxia9kDNpcmBtGAZyJ7mdwFtn4/rEgc8cF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gp92LOpfZ/HW5PsrmYBHJjmAGDK9MnAyVvZ/2QMa1lUBx6S9zWmx76Dg9HuKcEEdf
	qqLuvyQ57EJl2xgLhTpM3tC8hXhli/QBKvB0mWyM/8FLgTxDpVMCCo3hY1VeVf4Qes
	6+9HHhl1AaN6ir5f6rzshlJ4qE2YHZApSqMQOnxw=
Date: Fri, 5 Apr 2019 10:17:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190404231707.GB25513@umbus.fritz.box>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v7 3/6] target/ppc: Handle NMI guest exit
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190404231707.as7Bn8Bs3rNx37emxlJEkf-AfG8TRXBp5jl5EGNX42k@z>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 02:40:45PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Monday 25 March 2019 11:52 AM, David Gibson wrote:
> > On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> the guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases. This patch handles
> >> KVM_EXIT_NMI exit.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>     (e20bbd3d and related commits)
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |    1 +
> >>  target/ppc/kvm.c       |   16 ++++++++++++++++
> >>  target/ppc/kvm_ppc.h   |    2 ++
> >>  4 files changed, 41 insertions(+)
> >>
>=20
> [...]
>=20
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 2427c8e..a593448 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct k=
vm_run *run)
> >>          ret =3D 0;
> >>          break;
> >> =20
> >> +    case KVM_EXIT_NMI:
> >> +        DPRINTF("handle NMI exception\n");
> >=20
> > tracepoints are generally preferred to new DPRINTFs.
>=20
> I see DPRINTFs used in all other exit reasons in this function. Do you
> want me to change this particular exit case to tracepoints? I think it
> is better to keep this DPRINTF as of now and change all the DPRINTFs to
> tracepoints in a separate patch set.

Ah, good point.  Tracepoints are generally preferred, but since
DPRINTFs are in use here, stick with that (at some point it would be
good to change the whole file, but that's out of scope here).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlymkHMACgkQbDjKyiDZ
s5Kk1Q//fxTYGx9HX1OpXOG5hQC3Hi4wXlXe7XBTCi/xh7OdK2qUPJXbHxNn4Qqh
KE+VaDmf3BEnfkkthZ7WTjrADVugx/DCll8LyCWEG9NBz/JFxS4vfCDcr5SbtEBe
EVhd/eUSvIYnME4Lf/bVRvI7L75N54pSc6Bl9TtBWNtNEmZQOiQFak/rmaSy4MXk
vcUGZhSFe44dM2YaSZkI7PjLk5zvcHrQwfkkUamYAV50uEePCUqvvul6RdwbQcXS
HYAcFQv2b+hLHefAm8ooLXChqcODYS+NHKbKfWcyuWGsU5PoGOPbJNSmBkbRp5Hp
Ynxb0cBcrWNahiNadT4fmnphlNVKthdTc2FpJDH9c25JBi1XCxTAiY0AlZUBHcj4
lzTZEd2qJqEzCCUMQGtLi75HYAhVAdAqJMKUM2BRIMuRSAQhbuGfrEk6GPLcdCFZ
kn6ayqeGmVYDbeZHGZUjnlzXah/gKkVA1yalQ3x4wXeec4KFw3EnNqJImvuRMjKw
MpHrY7ANAUcIV9aAlLcWb/iNgG56vmidHC39zrfS7iAdO6NSNuovLRwougg8CWi3
VKw1L0NsbOPprPv8KYPTgnabiZtYg6v2JOxHQ2Ax8KY4Mt/L06XnAIJD+VwUJ+1d
baaksapuaVFYdPvDLLuBG4iYTu6Krf5/aIiIludQFNKCIx/PiHQ=
=4cJ7
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

