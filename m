Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4853220B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VK98Q+ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4853220B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNth0-0002fQ-FV
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:35:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0000o5-4B
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0002hd-Bq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVj-0002e8-Cq; Tue, 07 May 2019 02:23:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL250nTz9sD4; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=B8s0wa7uKzCF07V2NRa7udjsSMZldDSr/gFPsf+z1XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VK98Q+ZE9EQ7iZfvHzovvVc7a/GL/TGi5K/B0BlZxIYzEF380k79Yl9VVI98ys0fj
	rCGKuxWCVIeg14pmX6uEASxVmb81XQWhCbxkW7Kgrar+oJjkxJA7gxbtxkKGPp0OKB
	rSgsYESOv3eun2zd23CjZ1e5zkwNyQLXU83sdxkU=
Date: Tue, 7 May 2019 15:23:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507052358.GI7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-6-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-6-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 6/9] target/ppc: Fix vslv and vsrv
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:08AM +1000, Anton Blanchard wrote:
> vslv and vsrv are broken on little endian, we append 00 to the
> high byte not the low byte. Fix it by using the VsrB() accessor.
>=20
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Applied, thanks.

> ---
>  target/ppc/int_helper.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index f6a088ac08..fd715b4076 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1800,10 +1800,10 @@ void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)
> =20
>      size =3D ARRAY_SIZE(r->u8);
>      for (i =3D 0; i < size; i++) {
> -        shift =3D b->u8[i] & 0x7;             /* extract shift value */
> -        bytes =3D (a->u8[i] << 8) +             /* extract adjacent byte=
s */
> -            (((i + 1) < size) ? a->u8[i + 1] : 0);
> -        r->u8[i] =3D (bytes << shift) >> 8;   /* shift and store result =
*/
> +        shift =3D b->VsrB(i) & 0x7;             /* extract shift value */
> +        bytes =3D (a->VsrB(i) << 8) +           /* extract adjacent byte=
s */
> +            (((i + 1) < size) ? a->VsrB(i + 1) : 0);
> +        r->VsrB(i) =3D (bytes << shift) >> 8;   /* shift and store resul=
t */
>      }
>  }
> =20
> @@ -1818,10 +1818,10 @@ void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)
>       * order will guarantee that computed result is not fed back.
>       */
>      for (i =3D ARRAY_SIZE(r->u8) - 1; i >=3D 0; i--) {
> -        shift =3D b->u8[i] & 0x7;                 /* extract shift value=
 */
> -        bytes =3D ((i ? a->u8[i - 1] : 0) << 8) + a->u8[i];
> +        shift =3D b->VsrB(i) & 0x7;               /* extract shift value=
 */
> +        bytes =3D ((i ? a->VsrB(i - 1) : 0) << 8) + a->VsrB(i);
>                                                  /* extract adjacent byte=
s */
> -        r->u8[i] =3D (bytes >> shift) & 0xFF;     /* shift and store res=
ult */
> +        r->VsrB(i) =3D (bytes >> shift) & 0xFF;   /* shift and store res=
ult */
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFm4ACgkQbDjKyiDZ
s5K8og/+MFb/VpFCFSfbsSfLq78BQEjwcoVKyGvvS/Vw6Q2ET++Efv7G1MXY2O86
mrqYYozjkK1foW3QTcqhxfy0UfjT3HuYuqexWHQPysJusy42pnQmYcd6WcSRMa7l
JGTVdl/MWcxi5aL7U3lxIlYS7viLrMNqNpJdBMnh5w8hsophjdgP1WTrNyHiaZa4
fcElvxvT09EC3R5anXahEFhCYAdp1zkD45MOVBEi6Pm+nS8mpM6GW+bcQjKtaOql
zOnVfNDL0tpL4G6EX+wBbB8QjwsIRjXJsblXjl2Dvh3MGinibaX1JkmVIAODUpSu
T1bbaGQY6qbSn+toh7AHmivxFLHxBfKpX4zp6fW0jVI/TIoXMkJkhRH2zIe7CsnA
r+Cct5p/gBJnHyrrOtUorUbaGMhe64H2140tfPz89dV5TugV0M2f17gGlVMJOonr
A8yLP9P7LcVN4RtOZF4BhFUlqLA186Ic26BuHOeBHMppIZHPDvh1+mCYMCzBPFla
S3mn4z5SnR6VcIY9R1p+aN3FD9M6ZDXbxImzBvIs3l0tHqpxvZ95JSsPLmVfRFB/
21x7A0hhRDKLF3mtVj2et4KR4Ow7e9GxxoXc1hJFTmEU6SEHZwYwZxcuB5hUD561
iR2uNBSbIBPLOd3sPIVSarP8T9V5sk+NmzaXOgfDncscZ0Kf03M=
=UUpM
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--

