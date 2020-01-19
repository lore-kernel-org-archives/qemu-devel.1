Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B06C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 06:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8030E20714
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 06:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CqGMg5A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8030E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it4Hg-0005rS-LA
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 01:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1it4H0-0005Jy-6q
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 01:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1it4Gu-0003ea-Kb
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 01:41:24 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:56503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1it4Gt-0003Ws-Cx; Sun, 19 Jan 2020 01:41:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 480lYz0MYWz9sRW; Sun, 19 Jan 2020 17:41:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579416071;
 bh=ALVjebjQXzfumNzirXTkFkXPcOMV793VkV1OL7Scgow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CqGMg5A4oCvb2vmQbBbPnTj+oLkK1Lv68YNNNCUbbOEWGh3Epq5+x1plYgpdcld9e
 wkbB0dtGAownDDvR5/8s3rYmj6bfBm8wtwTvkgrMMXNgDBk1vAxiWozIsjPJcVI9ws
 lJENUSqt8UW6ralKk0VqE3SMUWGKnTFkY0kIRwPg=
Date: Sun, 19 Jan 2020 15:27:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3] spapr: Fail CAS if option vector table cannot be parsed
Message-ID: <20200119052739.GC54439@umbus>
References: <157925255250.397143.10855183619366882459.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+RqgOR8y65RRYhVY"
Content-Disposition: inline
In-Reply-To: <157925255250.397143.10855183619366882459.stgit@bahia.lan>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+RqgOR8y65RRYhVY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 10:15:52AM +0100, Greg Kurz wrote:
> Most of the option vector helpers have assertions to check their
> arguments aren't null. The guest can provide an arbitrary address
> for the CAS structure that would result in such null arguments.
> Fail CAS with H_PARAMETER and print a warning instead of aborting
> QEMU.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Applied to ppc-for-5.0, thanks.

> ---
> v3: - drop ov_table check
> v2: - print warnings
> ---
>  hw/ppc/spapr_hcall.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f1799b1b707d..ffb14641f9d3 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1703,7 +1703,15 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      ov_table =3D addr;
> =20
>      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
> +    if (!ov1_guest) {
> +        warn_report("guest didn't provide option vector 1");
> +        return H_PARAMETER;
> +    }
>      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> +    if (!ov5_guest) {
> +        warn_report("guest didn't provide option vector 5");
> +        return H_PARAMETER;
> +    }
>      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>          error_report("guest requested hash and radix MMU, which is inval=
id.");
>          exit(EXIT_FAILURE);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+RqgOR8y65RRYhVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4j6MgACgkQbDjKyiDZ
s5LQvw/8CGCZlpBJpu/0kkzsR+7jnR7ObnHmr/9UWfDMd+77D2PGIvONSvtwA0kF
l8ajG92AAOxZTcrN6Qvkmc47EDkNP7eRt4fZ+R+BE0jDmUtqrAwTz+K3kKZmgZvE
SLuLmJB22PdQaJG8A14PZY4kjQz/1hTr90wiQ8junnAjSSkw/RDYEvv1db70jrII
ESKVCu1rFGBIPpuFqXcByvA0nojoWXMIqGfHY5twa12GoSWgX+hq6Tft/zVajxno
Yi6g3jtFZI2oIP2l0Rfec+BoFHN3Sq4FJ0sAk5GPSaauvKsR5i5lbAIfhwKn1DVm
dnerkLEqxBfLY90Fw0lWrIK/ZdlANhMo4hfDriVkSU+9Y0xxNvBjKenLvb3F/+4k
VqtcXzq7pqrR/OwZtzzEWlxoM5Ti9pu3cSRXtm1DksRDSKHbcv9KaG9tMLuPXwqO
66ZcRUptaBsPJB9G5AxN1ZLb0HffoM6bAUjOU0uo0cDR64ETUzf4PscIzSqvkEHU
/4WwKJmLRLi/PTMt6ZNo3vfqhU6PhpLQXe6A/xQ/IB2hj5e7mKz7LA3lyWTnZ187
x6UJRhFxdbbHabq5C7+cW4X9r/uVZ3pamswxcK8uRT+M7NaD5JnnZMZnSC9GWXjH
PHFxrEvPLiHBlrFVGGvlFe9wUc3HmIoCdMxUqFKpnwlsbgujGmk=
=lqNl
-----END PGP SIGNATURE-----

--+RqgOR8y65RRYhVY--

