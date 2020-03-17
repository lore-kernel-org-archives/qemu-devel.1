Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45FC0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 01:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0496520663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 01:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oBPMC5qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0496520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0n9-0006p0-8G
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 21:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE0ma-0006Or-ER
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 21:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE0mY-00079o-CI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 21:12:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE0mX-0006zg-W9; Mon, 16 Mar 2020 21:12:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hFWn4w6lz9sRR; Tue, 17 Mar 2020 12:12:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584407541;
 bh=q1l9ZK2qKNSHXdpT4bihTZo5sAP8fL19YgGX1lJntMg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oBPMC5qZTPM2EVC//TWetnRCdgwFSqmUvap6MgvuS19CV+szh6CKgDP5gov38DATn
 3v9k1uG04Cz/OVgcHrFIiI4IWRQ96DxZZDxAYT6DOJqcbD0pARsTUwTI0EbMCZ2bgT
 8tOPxWQTw6oIGnj9SbcSQvGDDWmLIy2qtWqsGawg=
Date: Tue, 17 Mar 2020 12:11:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20200317011150.GL20264@umbus.fritz.box>
References: <20200316233306.50043-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <20200316233306.50043-1-aik@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 10:33:06AM +1100, Alexey Kardashevskiy wrote:
> The following changes since commit 33dead675695e596b7f32c72e6f6a20390e86d=
8a:
>=20
>   pseries: Update SLOF firmware image (2020-03-13 17:50:44 +1100)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20200317
>=20
> for you to fetch changes up to b7cf539920376542f03df8337602c3b8974bd1a1:
>=20
>   pseries: Update SLOF firmware image (2020-03-17 10:27:34 +1100)
>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 968848 -> 965008 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
>=20
> *** Note: this is not for master, this is for pseries
>=20
> The only change here is moving the decision about rtas-size
> to QEMU.

Merged to ppc-for-5.0, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wI9MACgkQbDjKyiDZ
s5KC9g//RDoPK2IJ9lQfPjLKx4KV0DIqZCRZ0oLNecouAAvtN7Os6qA3GAeY6Pci
YJwABIsrt32F2ROkJ8VLg7lJtgm6h+q36Z8ahIbdVDomdAnHYrnVvWB3voXFiLgM
Y1qn+IZEkA00TX1FeHTiRzvCZFhx15SyGzOFwYrbu+0r/7bSJftmQg+SD8Qn5Wxs
scyPs5aeMGRm7G/w1cwnwSk1F0MDQ/9nqMIKKxtWQABiJXyKeyx21db9qATq+tyQ
i312XKAmvd4R7enneqlNDkdm+XlnObkyUl6geKud4ppTRkRaBM+km1gbxK/2+Wyl
B4SjvxDKQefMJa5atH9wodPQg3iBf/WDpvWx1jkY+sY9wpwVBob7koWJf3g+BC1M
7rMkmiVw/UdGsbSlVmGtJ5nIve4BsqZgz9YQEmhLfknMIvykdEYaXRkLD2WdPC2N
0gYouCtp6WZPbrriVS+tLvdm3nHzS7LBsp9a/8LrHe35p46UET2XTobd+lYNf7fb
gYjHQ00VtOebXE3+SNv2cLeGjxcqrlU7Xd4Pa040KNXDbDENrVXFFtn1gUTyH1zC
t0vwt6Ss4IkSmeUL+REx/KsMUfOCYLQU6+m5fdApuHVDRqWAOfYlF01jlT0olvdz
zeduWEcP8kbumCOF86BpNN0h9Gnmvlm5GXDd1zUAJ3fnjNEd970=
=XQ6X
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--

