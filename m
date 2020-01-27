Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D91C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019CF20720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S/itAhYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019CF20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivvHS-0002yV-5D
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 22:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ivvGF-0001ck-89
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 22:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ivvGD-0005MX-FU
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 22:40:26 -0500
Received: from ozlabs.org ([203.11.71.1]:48373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ivvGC-0005Jw-H0; Sun, 26 Jan 2020 22:40:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 485b9Y11KKz9sQp; Mon, 27 Jan 2020 14:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580096417;
 bh=E87zWcf71xRFxHGIFXbkHC31+bkbVstrk2xYZ9EjBgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S/itAhYkzQlf7v/H8SjDgsUa5nBudtvhUPAUQyVbJa58+8x6gaUyrXZ3FD6fJOwwR
 DJIurM2nIwvRQptYnB8KDKj7w9aY/4k/N9Jp2XBauqO6WofH6ZersZbvjcjH9a/a/h
 x7FSsQSy2OaEW2EPcdDK3lqNjZ2XUQbv6e1qPFvM=
Date: Mon, 27 Jan 2020 14:31:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 74/80] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
Message-ID: <20200127033119.GB1818@umbus.fritz.box>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-75-git-send-email-imammedo@redhat.com>
 <20200124112511.7618c3a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20200124112511.7618c3a1@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: thuth@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2020 at 11:25:11AM +0100, Igor Mammedov wrote:
> On Thu, 23 Jan 2020 12:38:39 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > Since all RAM is backed by hostmem backends, drop
> > global -mem-path invariant and simplify code.
>=20
> Looks like origin of removed here code is PPC,
> could PPC folk review this please?

Oh, sure.  I don't think I was CCed initially - I generally don't have
the bandwidth to scan qemu-devel.

I haven't looked at this series as a whole, only the bits which were
CCed to me (presumably because they touched ppc code).  But assuming
the statement above is correct, that everything is now backed by
hostmem backends, then the idea of this change should be fine.

But...

>=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: pbonzini@redhat.com
> > CC: rth@twiddle.net
> > ---
> >  exec.c | 51 +++++----------------------------------------------
> >  1 file changed, 5 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/exec.c b/exec.c
> > index 67e520d..809987c 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1667,60 +1667,19 @@ static int find_max_backend_pagesize(Object *ob=
j, void *opaque)
> >   */
> >  long qemu_minrampagesize(void)
> >  {
> > -    long hpsize =3D LONG_MAX;
> > -    long mainrampagesize;
> > -    Object *memdev_root;
> > -    MachineState *ms =3D MACHINE(qdev_get_machine());
> > -
> > -    mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> > -
> > -    /* it's possible we have memory-backend objects with
> > -     * hugepage-backed RAM. these may get mapped into system
> > -     * address space via -numa parameters or memory hotplug
> > -     * hooks. we want to take these into account, but we
> > -     * also want to make sure these supported hugepage
> > -     * sizes are applicable across the entire range of memory
> > -     * we may boot from, so we take the min across all
> > -     * backends, and assume normal pages in cases where a
> > -     * backend isn't backed by hugepages.
> > -     */
> > -    memdev_root =3D object_resolve_path("/objects", NULL);
> > -    if (memdev_root) {
> > -        object_child_foreach(memdev_root, find_min_backend_pagesize, &=
hpsize);
> > -    }
> > -    if (hpsize =3D=3D LONG_MAX) {
> > -        /* No additional memory regions found =3D=3D> Report main RAM =
page size */
> > -        return mainrampagesize;
> > -    }
> > -
> > -    /* If NUMA is disabled or the NUMA nodes are not backed with a
> > -     * memory-backend, then there is at least one node using "normal" =
RAM,
> > -     * so if its page size is smaller we have got to report that size =
instead.
> > -     */
> > -    if (hpsize > mainrampagesize &&
> > -        (ms->numa_state =3D=3D NULL ||
> > -         ms->numa_state->num_nodes =3D=3D 0 ||
> > -         ms->numa_state->nodes[0].node_memdev =3D=3D NULL)) {
> > -        static bool warned;
> > -        if (!warned) {
> > -            error_report("Huge page support disabled (n/a for main mem=
ory).");
> > -            warned =3D true;
> > -        }
> > -        return mainrampagesize;
> > -    }
> > +    long hpsize;

hpsize absolutely has to be initialized.  find_min_backend_pagesize()
reads it as well as writing it, so if it's uninitialized you'll have
UB.

> > +    Object *memdev_root =3D object_resolve_path("/objects", NULL);
> > =20
> > +    object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsi=
ze);
> >      return hpsize;
> >  }
> > =20
> >  long qemu_maxrampagesize(void)
> >  {
> > -    long pagesize =3D qemu_mempath_getpagesize(mem_path);
> > +    long pagesize;

Same here.

> >      Object *memdev_root =3D object_resolve_path("/objects", NULL);
> > =20
> > -    if (memdev_root) {
> > -        object_child_foreach(memdev_root, find_max_backend_pagesize,
> > -                             &pagesize);
> > -    }
> > +    object_child_foreach(memdev_root, find_max_backend_pagesize, &page=
size);
> >      return pagesize;
> >  }
> >  #else
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4uWYcACgkQbDjKyiDZ
s5JMlBAAuPBhKOocBILG+ZUZP6074NnrME86wrWTxEv8nVZYaDLWFnA0P+8gYcfh
c6SE1rvGDidnPGLYqaGC8V++oYrvFBY828GSC28cJsvRX21x5MFZFiNWvSa3vqhn
tEgRsUhYQKkFW64hUo2WwJlzlNIh+F30txbq6R3Qa/GcaqbMjzogCXsI42BKGM14
5uiJANly/79BFnNOtJSzQLZ+EzvOV4VV2bsRLHsm0wypVR7q2+vRUkdvkL0OZnQC
gyXrB8GNffifZz7GvYEjkZYqD+WB3tIhPZJhIK5BvIdaSjDbXroL7Zw5UvmiWbQH
dW7KJmoEEGBslQK7Po2dVhLVAbIk+P85KVTZzwm0pqK5/veFp4ThxO25tETgn2bM
TWMEUHIO9kEQhs39zOSzBCOKmCIbRkYIZvFpmwNw2CYhThmDZZ/yJAgyzjMmv5sE
uei+Ng+3iWNWO0TFn1LlSg5qTLASul4o5zlpyZF9gRuInvaq2P5tB9YNvZ7s0Mxx
upZoGJ4RoXW7BoPrxwdcCqId5zmxkWjKl5P2Qj4zoxg/FVLDLOrGKxeyoPJnYG04
/vsUDF6KI9kKhwlhh+HtWo8mD08fAgmnAULUneekET0ekyZ/O5JMlDPLLGYmeTdM
NYzXYbnCtjVkPioBVF5siW0Oj3kqVoA997VLLOIgO97itWQxB+Q=
=fuSl
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

