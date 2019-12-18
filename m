Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB93206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oe4w/6c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB93206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQ51-0005PJ-Fh
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3d-000473-IX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3c-0005R7-6O
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:29 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihQ3b-0005N2-Qq; Tue, 17 Dec 2019 22:31:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47d0sk69ywz9sRv; Wed, 18 Dec 2019 14:31:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576639882;
 bh=vt0fN7mX9qEeZ0/8qi4UwGYqTMbHJRKAmwOxq91Ackg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oe4w/6c7Cwfhd2DRrfbBI0gOUF//JMeps28nF7DvlCbRbaJO4UWnraYo32Z2oFkJW
 G0XfJzyw4TbVJCQ5FUWpHf2keVHvgRxKww5Rw7hPkzqWd7vDoIlULNHAudyEBh+BSQ
 P2qC7BuledSeQ1AcheHR/h67SfsxCp1U+KgsNOSE=
Date: Wed, 18 Dec 2019 14:11:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Handle AIL=0 in ppc_excp_vector_offset
Message-ID: <20191218031145.GP6242@umbus.fritz.box>
References: <20191217142512.574075-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pk/CTwBz1VvfPIDp"
Content-Disposition: inline
In-Reply-To: <20191217142512.574075-1-farosas@linux.ibm.com>
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


--Pk/CTwBz1VvfPIDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 11:25:12AM -0300, Fabiano Rosas wrote:
> The exception vector offset calculation was moved into a function but
> the case when AIL=3D0 was not checked.
>=20
> The reason we got away with this is that the sole caller of
> ppc_excp_vector_offset checks the AIL before calling the function:
>=20
>     /* Handle AIL */
>     if (ail) {
>         ...
>         vector |=3D ppc_excp_vector_offset(cs, ail);
>     }
>=20
> Fixes: 2586a4d7a0 ("target/ppc: Move exception vector offset computation =
into a function")
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/excp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 50b004d00d..5752ed4a4d 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -112,6 +112,8 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, =
int ail)
>      uint64_t offset =3D 0;
> =20
>      switch (ail) {
> +    case AIL_NONE:
> +        break;
>      case AIL_0001_8000:
>          offset =3D 0x18000;
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pk/CTwBz1VvfPIDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl35mOwACgkQbDjKyiDZ
s5IYwRAAoeOo8ZzkwwtYHvqOP1VRTs0gm/q6xpPcaC7Nf5c8X2C5YwPN+uIislKp
C0MM3+5phGrNTADl4O8TxZeHwF4tLbjFwajZl/It/QIYDYS+f4qSEtquFM9itQpp
WE13leZhVKBtiK5meCojBi2GYRy8BrgCQ7kPWXZqzcgsG0TPfLowRty/6sx0nbFd
mFHqL62sxfGodD7lHv5pdXddeqnwdx0z2+BU9u62tLPR1fK5ESMzgWUsA291Z+ju
T8A/CwYsQfqyW8/d8f42QwWoL7eos16NxFhotx4BYytf9vfM05g9XWtTJ+LIMV/M
tmubSbyOnBLGG05g7lqHxixUlre777AwQSaPE7gzSzsywI+DgZEn/91IJF0TZGRk
Xu9JU7XGobi878VR27BBtguLJqqKsiYmvpBhSXIyue329NOrwPNOo/1WDV7aLSpZ
wIPAZ8nyndcYgLTjjTYjEGCDlg6GBcs5RXcKKmCXbfJQrORGghbahFY8C2yeJVbk
MQsv7nNW/ymhv9bBwZvBBlYPC+PrrHKPJ5wmEZ/dwptOGmbzcY57g+lJDvQl/HTW
GUT3zJqRQ0owRQyY7z/vigl73jqd3NHBYuvznzgmTidfY8mHGgDgJWYZAKNeNtYt
0aZ+XRBNKLmFhCL5MT1A5kkJp/mJ6WUkdlCBQxASLlSgg6LfTX8=
=NC9I
-----END PGP SIGNATURE-----

--Pk/CTwBz1VvfPIDp--

