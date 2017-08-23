Received: from eggs.gnu.org ([2001:4830:134:3::10]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLs3-0004aD-OT
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLrz-0001Qo-8b
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:19 -0400
Date: Wed, 23 Aug 2017 12:49:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823024943.GO5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<c4ae0bb4dadb252a29439570a5aef125ebc4503c.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bAr+fMtvBxbbbkvl"
Content-Disposition: inline
In-Reply-To: <c4ae0bb4dadb252a29439570a5aef125ebc4503c.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 14/15] ppc4xx: Add device models found in
 PPC440 core SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--bAr+fMtvBxbbbkvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> These devices are found in newer SoCs based on 440 core e.g. the 460EX
> (http://www.embeddeddeveloper.com/assets/processors/amcc/datasheets/
> PP460EX_DS2063.pdf)

As usual, I can't review in depth, but there's not much obviously
bogus, so I'm inclined to merge, except for one detail:

[snip]
> +#ifdef MAP_L2SRAM
> +static void l2sram_update_mappings(ppc4xx_l2sram_t *l2sram,
> +                                   uint32_t isarc, uint32_t isacntl,
> +                                   uint32_t dsarc, uint32_t dsacntl)
> +{
> +#ifdef DEBUG_L2SRAM
> +    printf("L2SRAM update ISA %08" PRIx32 " %08" PRIx32 " (%08" PRIx32
> +           " %08" PRIx32 ") DSA %08" PRIx32 " %08" PRIx32
> +           " (%08" PRIx32 " %08" PRIx32 ")\n",
> +           isarc, isacntl, dsarc, dsacntl,
> +           l2sram->isarc, l2sram->isacntl, l2sram->dsarc, l2sram->dsacnt=
l);

For new code, trace points are strongly preferred to DPRINTF() macros
or explicit printf()s.  In addition sending this output to stdout
rather than stderr is a pretty bad idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bAr+fMtvBxbbbkvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc7UcACgkQbDjKyiDZ
s5J01g//dQWvOvQ/nER7XjzZTuaC3mjga8FDQ1dsoo05Snf37BQy2DAMqGWbtw/B
VkMmaft7MSnADj0NvGnjY4kqf/3fkxzsqfbhtBeJOFuX6vH7icgiF8Wwb4GmCT+J
9nkf7OKoIlTc/m0IT2ifUHlPWs4M1REnTmQHAMnw0XQKZ9c1H3iCF/ajuJquwem3
ztrDXNWBOWBkARzJvzbuoyueiuoyHfEfI7Z1FjWoBkVEsf/mkJycmjiIgh4jKpJE
rtbm6/SVW/79aIwtLgeb1e42Bo7LNwl4D9mqgUz6TqngkjXYVASGllZLfxmlXMvZ
13Hs1vQF+eXFE7bBf2BZ4hMQSnVRd++tcisMsuZ8CdqJy1J8QoxJwMoC8wpMwLZ9
Zd32UOid9jbVlwfZA+udNMVFusnouVSxeMgWfO4VKpbsPtS0NZ+t6JoMWcBxQeRh
nf9QwJr+c2xtlnjFPBPsKjnIuPlav8YJzJlVDjwLHcyxYLMPbtgYrRP2EczzBi1H
SFOMGApQUsc8YMxSjwBActhiJ1KT+09wyqmXjgSx15C89l1+YfKX8BbAjRUnumBX
CdwgG2Tmus8WxigfY638pXihAbZ4w+XDu8HCFJBFrtDP7eAm7kfmdL7ZSVbLQWy+
8IJYX7bFxiVIfnTkrL21lFBgwHMX/xrrQXl35GYy5xJg3C6EkVU=
=xOYI
-----END PGP SIGNATURE-----

--bAr+fMtvBxbbbkvl--
