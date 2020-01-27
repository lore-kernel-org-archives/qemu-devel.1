Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CC0C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80402071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="F2p/+giD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80402071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0aQ-0003gM-2e
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iw0Zp-00038h-6F
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iw0Zn-0007PS-M3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:21:00 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:43063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iw0Zm-0007Ln-Tw; Mon, 27 Jan 2020 04:20:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 485kkZ15R2z9sRR; Mon, 27 Jan 2020 20:20:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580116854;
 bh=wrO7VlkgeV4ypWjsPlmWLbiZrckiZtBRGDxecI+M+lY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F2p/+giDQiLVHNDNfMY/vlsBb5bnqRbJLXJAq2HH5HyTgTVMq/sBEv/N8HHt/mS5i
 KodAi3wg7zkod6cyGYr5MVJBbaINbOhlI53pxk5iKzNe0d5pRdVQjA4zGxVlWD4n//
 9FK48dt+ehaG3QLzj6jB3MUSkUcDirH+KkKtfYX0=
Date: Mon, 27 Jan 2020 19:18:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3.1 74/80] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
Message-ID: <20200127081846.GA34829@umbus.fritz.box>
References: <1579779525-20065-75-git-send-email-imammedo@redhat.com>
 <1580112408-93354-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <1580112408-93354-1-git-send-email-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: thuth@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 09:06:48AM +0100, Igor Mammedov wrote:
> Since all RAM is backed by hostmem backends, drop
> global -mem-path invariant and simplify code.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>   * fix access to uninitialized pagesize/hpsize
>     (David Gibson <david@gibson.dropbear.id.au>)

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> CC: thuth@redhat.com
> CC: aik@ozlabs.ru
> CC: mdroth@linux.vnet.ibm.com
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> ---
>  exec.c | 49 ++++---------------------------------------------
>  1 file changed, 4 insertions(+), 45 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index 67e520d..9f5421c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1668,59 +1668,18 @@ static int find_max_backend_pagesize(Object *obj,=
 void *opaque)
>  long qemu_minrampagesize(void)
>  {
>      long hpsize =3D LONG_MAX;
> -    long mainrampagesize;
> -    Object *memdev_root;
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
> -
> -    mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> -
> -    /* it's possible we have memory-backend objects with
> -     * hugepage-backed RAM. these may get mapped into system
> -     * address space via -numa parameters or memory hotplug
> -     * hooks. we want to take these into account, but we
> -     * also want to make sure these supported hugepage
> -     * sizes are applicable across the entire range of memory
> -     * we may boot from, so we take the min across all
> -     * backends, and assume normal pages in cases where a
> -     * backend isn't backed by hugepages.
> -     */
> -    memdev_root =3D object_resolve_path("/objects", NULL);
> -    if (memdev_root) {
> -        object_child_foreach(memdev_root, find_min_backend_pagesize, &hp=
size);
> -    }
> -    if (hpsize =3D=3D LONG_MAX) {
> -        /* No additional memory regions found =3D=3D> Report main RAM pa=
ge size */
> -        return mainrampagesize;
> -    }
> -
> -    /* If NUMA is disabled or the NUMA nodes are not backed with a
> -     * memory-backend, then there is at least one node using "normal" RA=
M,
> -     * so if its page size is smaller we have got to report that size in=
stead.
> -     */
> -    if (hpsize > mainrampagesize &&
> -        (ms->numa_state =3D=3D NULL ||
> -         ms->numa_state->num_nodes =3D=3D 0 ||
> -         ms->numa_state->nodes[0].node_memdev =3D=3D NULL)) {
> -        static bool warned;
> -        if (!warned) {
> -            error_report("Huge page support disabled (n/a for main memor=
y).");
> -            warned =3D true;
> -        }
> -        return mainrampagesize;
> -    }
> +    Object *memdev_root =3D object_resolve_path("/objects", NULL);
> =20
> +    object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize=
);
>      return hpsize;
>  }
> =20
>  long qemu_maxrampagesize(void)
>  {
> -    long pagesize =3D qemu_mempath_getpagesize(mem_path);
> +    long pagesize =3D 0;
>      Object *memdev_root =3D object_resolve_path("/objects", NULL);
> =20
> -    if (memdev_root) {
> -        object_child_foreach(memdev_root, find_max_backend_pagesize,
> -                             &pagesize);
> -    }
> +    object_child_foreach(memdev_root, find_max_backend_pagesize, &pagesi=
ze);
>      return pagesize;
>  }
>  #else

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4unOQACgkQbDjKyiDZ
s5JJXg//YCQvsE1JVDU5f8xvKbTsZpaf4WRmDNbJCbQkY3S/Hbzr40IEQVDR+Wyu
Q+JmWYCAKbrBwi+S5VpSC8hVovj5CH6AJ9BROEH25QVBVg+gMUhPxq30fOz0Ospw
25l9cjWVY7rY/Ec1O/6RQ+4Ip41FpK4QJxZY7PoQDuG/5Sb1dFGhGPkHx+2IOosd
IEUVIDhc6UlQN2+c/IetZTV/WgxjwNloeKNwjUaTNyuMjm5RGi5QuUZqhc0Y+OUc
1HoRIDU79U4iaPPoAIik5cpqwVK48Hbb7SWutCbI6mmOrYJ7VSqVazEIGgYaBohp
5in3LgNio3LOyvDjq4jvV8FGcM7AIgqfNZs8DLnp8zaD/2UK0XH6gYTP/m/a4+Mh
pzxGM/8GzkPBep3j8ORoc4KggmcHALgO3FloOodM/l54WrpMZR+NS/Tp6jCRKRwQ
qzJRL9YkfCOEvPFx6/aJeidVBVsb7Vi3GHLqKyhZ5BfdErWzEjGVHfpliKHnThTv
fXv5eU6Fb1w4tI4YU6ZrTwM+3Ka65syLERF7cj+klMERDC37WC/nrC6FWOOPiKly
kUZCuPsbWwZIdbMiKZtdMDokGjyaPuqP3kZTxGEAsYHyQmcE/3gNuFFxiOU7XY/J
4GNY6c2TaxHeQfvjQRDwBB/8iZNdG9rLv9QDl7Mim8QoIET0sxI=
=iQJw
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

