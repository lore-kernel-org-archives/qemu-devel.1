Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D81C04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F809208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JQdVqGaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F809208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39099 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQPN5-0006Q0-BT
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 00:48:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQPLc-0005l7-KX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQPLb-0006tw-BU
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:47:28 -0400
Received: from ozlabs.org ([203.11.71.1]:38485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQPLa-0006ah-Ok; Tue, 14 May 2019 00:47:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4534sv6Vv6z9sBr; Tue, 14 May 2019 14:47:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557809235;
	bh=Qc69U55m7HL536xXt8uBb1jPCGp3GoTSkY8LCYhKdmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQdVqGaWgXHTpuJOhOQ6jw+sGO9nglIGpvifwO2jz5ulXLZgjel1S4H9CB/ZDuVEH
	OHaEoPaNbuhd4TDzqokCo2Rf6VpcYAaFyyNwTpB2Ygz2SWERK8i9QIlFQvZ2LSyRU5
	jgpJfbxEiX3G5RWbHMdSj6Qn8Iv+rhGTUIwuzM6k=
Date: Tue, 14 May 2019 14:40:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190514044005.GH6441@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190513133053.4d900d4a@bahia.lan>
	<20190514000819.GA6441@umbus.fritz.box>
	<9eb7a5a6-a018-d08a-4556-26da0b6cc3ca@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <9eb7a5a6-a018-d08a-4556-26da0b6cc3ca@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 09:56:41AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 14 May 2019 05:38 AM, David Gibson wrote:
> > On Mon, May 13, 2019 at 01:30:53PM +0200, Greg Kurz wrote:
> >> On Mon, 22 Apr 2019 12:33:26 +0530
> >> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >>
> >>> Upon a machine check exception (MCE) in a guest address space,
> >>> KVM causes a guest exit to enable QEMU to build and pass the
> >>> error to the guest in the PAPR defined rtas error log format.
> >>>
> >>> This patch builds the rtas error log, copies it to the rtas_addr
> >>> and then invokes the guest registered machine check handler. The
> >>> handler in the guest takes suitable action(s) depending on the type
> >>> and criticality of the error. For example, if an error is
> >>> unrecoverable memory corruption in an application inside the
> >>> guest, then the guest kernel sends a SIGBUS to the application.
> >>> For recoverable errors, the guest performs recovery actions and
> >>> logs the error.
> >>>
> >>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>> ---
> >>>  hw/ppc/spapr.c         |    4 +
> >>>  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> >>>  include/hw/ppc/spapr.h |    4 +
> >>>  3 files changed, 253 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 2779efe..ffd1715 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>          error_report("Could not get size of LPAR rtas '%s'", filenam=
e);
> >>>          exit(1);
> >>>      }
> >>> +
> >>> +    /* Resize blob to accommodate error log. */
> >>> +    spapr->rtas_size =3D spapr_get_rtas_size(spapr->rtas_size);
> >>> +
> >>
> >> This is the only user for spapr_get_rtas_size(), which is trivial.
> >> I suggest you simply open-code it here.
> >=20
> > I agree.
>=20
> Sure.
>=20
> >=20
> >> But also, spapr->rtas_size is a guest visible thing, "rtas-size" prop =
in the
> >> DT. Since existing machine types don't do that, I guess we should only=
 use
> >> the new size if cap-fwnmi-mce=3Don for the sake of compatibility.
> >=20
> > Yes, that's a good idea.  Changing this is very unlikely to break a
> > guest, but it's easy to be safe here so let's do it.
>=20
> I did it like that because the rtas_blob is allocated based on rtas_size
> in spapr_machine_init(). During spapr_machine_init() it is not know if
> the guest calls "ibm, nmi-register". So if we want to use the new size
> only when cap_fwnmi=3Don, then we have to realloc the blob in "ibm,
> nmi-register".

What?  Just always allocate the necessary space in
spapr_machine_init() if cap_fwnmi=3Don, it'll be wasted if
ibm,nmi-register is never called, but it's not that much space so we
don't really care.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaRqUACgkQbDjKyiDZ
s5KDEhAAt1WUq036Ttx5TyyQ/vsR2rFdAqOWeJHj8x/Lt4wNlw2aVQyEkLMWIvsk
W0pFeOQkuqr6f9WnvQdl0djOi9BmwYr+UHtXUlJKaUiJj3DKvC+7fO1d2poxtPZZ
M6GkFY8tCZZwgbU0P66YbkimA9Hvh+Ta3IkQyTAWy4Th6x5jD/8vicp/1mVRHJZw
CJt4pNSO/y9xPQ6tCHMQo4mhItGVzRs6W8OK9pPQyl2C1YNa+0cuRgsVonEolaxE
xaNbtJQ+fFYDKSs6CdeQ6CQLv0gcM6IEIzY8M0I9kZy5oCljiyqd/8Zcfoz0iSi1
Wx+bqq+dPLEn+PRuKVa0J3Vmh9OgazdfAxboXKfQ4XOBm9AEa5E5/w2UqK15T8qn
b0d5rIbWNoowR8jsEV82aIUrP6aEAmw1jlsSYG6dAoxp3y68FzQ6bbl4E0mH37IO
XSC8rnNaMoIxlWwU80C/nAjDetn/ypjIhM1JaeglqFWbGyMzlZlI7nxsZoEGOeCb
y0ASJ11wTN4BYJe1nygjjyh1wQsMRxsnI5hsVy1sjas8vzywnXJT0qylPXcS9Gt6
8Ieqo8ld/I3h/zA2K24E5VwkPWxfmS5zafOcSxJT2BHXDyu8xFv/76NTxaa4PEnr
zNjvNNLHIxD2USHrCiDQdrmK0jMjyVnGm/b3icfEoRZ1HAuNrgM=
=CCvL
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--

