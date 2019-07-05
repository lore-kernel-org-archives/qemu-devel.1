Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21120C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB490218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 05:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fjv+cF4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB490218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjGiN-0008Mm-S3
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 01:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hjGhF-0007We-TD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hjGhE-0007AR-PR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 01:23:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58719 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hjGhD-00073l-CE; Fri, 05 Jul 2019 01:23:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45g3Ct2mNPz9sNp; Fri,  5 Jul 2019 15:23:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562304218;
 bh=Rladb2u5r1twdla6zW8hxtyP/5iCd/Z1a8RQPSFhopk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fjv+cF4MU1CjEb5YocgDMh4hf3FfkNsNrGAgJv54udh9821ZIJb7z89R+KsD1FYKX
 GGbD6FHHg4NRt5IuWHDBOsCjLbtz8d6FWgU9mF955w2iCu7r6gHmWCxVyrVqoU354N
 4Ps5TG6FR/kElz14302ICr+A1sL2g/FZJAFBihCw=
Date: Fri, 5 Jul 2019 15:18:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190705051842.GC3266@umbus.fritz.box>
References: <20190705032501.106966-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20190705032501.106966-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH qemu] vfio-quirks: Pass the actual
 parent when deleting a memory region
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2019 at 01:25:01PM +1000, Alexey Kardashevskiy wrote:
> The usual way of using a quirk's MR is to add it as a subregion of a BAR
> as this is what quirks are for. However there is less than standard user
> of this - NVLink2-enabled NVIDIA GPU which exposes a GPU RAM and a ATSD
> 64K region outside of PCI MMIO window so these MRs get the system address
> space root as a parent. So when the user unplugs such device, assert
> occurs:
>=20
> qemu-system-ppc64: /home/aik/p/qemu/memory.c:2391: memory_region_del_subr=
egion: Assertion `subregion->container =3D=3D mr' failed.
>=20
> This passes the actual parent MR to memory_region_del_subregion() in
> vfio_bar_quirk_exit.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> This removes an extra sanity check that a quirk has a correct parent;
> I am not sure if it is very useful.
> I could use the "system" MR if quirk->mem[i].container=3D=3Dget_system_me=
mory()
> and quirk->mem[i].container otherwise to keep that assert working.
>=20
> Also this does not help with the actual device removal much because of
> the closed source driver nature - the associated service
> (nvidia-persistenced, responsible for onlining GPU memory) crashes
> the guest system but at least the user can reboot the guest after
> the crash which is not as bad as assert.
>=20
> ---
>  hw/vfio/pci-quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 27dddbc8fa3e..ef2e182c1d36 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1896,7 +1896,8 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int n=
r)
>          }
> =20
>          for (i =3D 0; i < quirk->nr_mem; i++) {
> -            memory_region_del_subregion(bar->region.mem, &quirk->mem[i]);
> +            memory_region_del_subregion(quirk->mem[i].container,
> +                                        &quirk->mem[i]);
>          }
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0e3bAACgkQbDjKyiDZ
s5IbKg/44U9BYLm4RP9wadwbqWJRwtMeSQcJicZOcoPmAnkOonp1TllQUjxNA5K+
Qd1FmtCPBFVnXZfe9hX5O+me7cODWls/G5FbrHGXfYzEkRQVfR63ZGyMlyRdYCpu
g89bWOVEQWN1NtTKVY6FWTsLHXFXBqSVNzIW8LenxAOhzK3AMHUVV/tu6MsExTSy
ntZE14/n4WAj6IVGzVUh8Zl0GH6Jh0kNI6CgwkaQNxp9Dc+mf9cKfZfq8/LpcSHZ
j/R5ub88QXCntDnYbjaLGhMOPatZqrIHJRxf+PENDxlztk7ydYmbYWV0tm7pHDE2
CGQ32WKLas2ozquAre7jE3YLhrf2Ih81X2uw+cW2YSuvmO57+FAYIPK41e0/P50C
S7Ua0nb0MOkYUAYI717LJm0c8fYF9WzXcq2VY4oTdayFcTcezJP+OZDlyRiK2EGf
E7NO1K6FD/V8qsF4nQhOIkAnKPPfqDmuHBCBOHJCApCN/jbf5sxCQo7DgwXsS45u
RcJguw0lgxWWX+u5vNR6h5xnzC1hy0Q/CAHyD5OaLTnq7y2jQzW9hVN2PR0YqKQd
zZWBG0KsGMTu7+AN9I6xA1l9HKnCID0H28XaTKJfeo3CwFdqZ135C2d3oYSxNvzG
n7fuiKuM4WbznZlrjrKXVEnAxCtHKKbbWpXfLUCNfVsP4sOKQQ==
=txQd
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

