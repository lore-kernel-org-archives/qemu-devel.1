Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA2C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733012072A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="c02G4tpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733012072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOBO2-0004Eb-IK
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 22:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMO-0001nT-H4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBMN-0003PI-Cd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:31:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43929 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jOBMH-0003Ld-SC; Mon, 13 Apr 2020 22:31:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 491Twy4ztKz9sV1; Tue, 14 Apr 2020 12:25:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586831426;
 bh=/kHCQs6uMq+5u4/mtGXY7lBRycSbLGC1KTKNOnBA2Y4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c02G4tpwBKtSX4Cy8dl3mWquRLc7WiCQh5osqLeugliTuijy/MqJw6vfNgSiAPsAB
 H0YZVfk8CA0NZX5GT9p219pJeA47NIauIGJIowvaA560ShRZvHfBEXyj1poiCf1JRv
 eqv3brG/NrRLimiYlJ5uPxblFDSFWPQwtvkelr1A=
Date: Tue, 14 Apr 2020 12:06:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 1/3] target: Remove unnecessary CPU() cast
Message-ID: <20200414020634.GE48061@umbus.fritz.box>
References: <20200412210954.32313-1-f4bug@amsat.org>
 <20200412210954.32313-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <20200412210954.32313-2-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2020 at 11:09:52PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The CPU() macro is defined as:
>=20
>   #define CPU(obj) ((CPUState *)(obj))
>=20
> Remove an unnecessary CPU() cast.
>=20
> Patch created mechanically using spatch with this script:
>=20
>   @@
>   typedef CPUState;
>   CPUState *s;
>   @@
>   -   CPU(s)
>   +   s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 86c667b094..8972714775 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1820,7 +1820,7 @@ static inline void do_invalidate_BAT(CPUPPCState *e=
nv, target_ulong BATu,
>      if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
>          /* Flushing 1024 4K pages is slower than a complete flush */
>          LOG_BATS("Flush all BATs\n");
> -        tlb_flush(CPU(cs));
> +        tlb_flush(cs);
>          LOG_BATS("Flush done\n");
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6VGqoACgkQbDjKyiDZ
s5KKyg/9FKEqC9D+alWv+8iNCU4sWOQEsmLKphUN1iQEQx1mOEnwEWoegLrG9pUK
mwn+RgxzzFhb2w5xatd+CDz2NzGNYfNNjOiraIrEWWKaPwK9Lz3xLw2J9ChxWcTs
BCb9Tpjl2dwIMYFW4GaLevqosEDRE0Z0IoVKGpyrlVnDLmRWX3ajL1g6KeFILh0c
TBWZlu0/WoHUIk8YZQHWtWQinxOoutnQzshdD4vxpX6qQ6ujrIhbyUFObWNJICse
A2pwFIA41B3rTESPKkxMeFoNXiWcEyd0Jk4qZvJRP0EI5TgLwkFFYogCGFYNS+Z7
UgPPvjgfGd/XbKXuf8sXjUcZgxg6M2lu8nbZ/fsRTTZV33Cjf9scAISZpLkH9bJ1
e4Ln3ge1xIUjhnQvsJ86nzHQLUPE9B1c9XHLYPI8xvDRy3Iup1DvZFi2zqZeMxP6
w0BO5X9OXBJLfo9d3O5UhsOe7fPfojFhHSp1PMovJzhRovcs40eWrJbbl6eJ0pA4
AIJeFYhPxdG/FYCdHPaDS6yIuAgrDHI0v/LXv9aQrfs4qa+ImpUosZwIY8CplZDa
HrM1GoVtuK9RcT/hANmrzlOg+dBFmQJ7IgimXNnVxBgMFQywio61NLYFrhJgfMTq
4mgomt1X+/UMWLjTmnBfgGap+QMG9ORP+H5M7RpHrwcnIjJ6vnI=
=dPwq
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--

