Received: from eggs.gnu.org ([2001:4830:134:3::10]:38299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnAFv-00083Q-3Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnAFr-0000ZM-TY
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnAFr-0000Ym-Kg
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB5AFC04B938
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 21:10:30 +0000 (UTC)
References: <20170830113319.6749-1-quintela@redhat.com>
	<20170830113319.6749-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2086297c-f647-e993-3fe8-339380c7f5d5@redhat.com>
Date: Wed, 30 Aug 2017 16:10:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170830113319.6749-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IaEmC0sSac7D52xgaJw2edfwKWB8q9LGR"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IaEmC0sSac7D52xgaJw2edfwKWB8q9LGR
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Message-ID: <2086297c-f647-e993-3fe8-339380c7f5d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests: Use real size for iov tests
References: <20170830113319.6749-1-quintela@redhat.com>
 <20170830113319.6749-2-quintela@redhat.com>
In-Reply-To: <20170830113319.6749-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 06:33 AM, Juan Quintela wrote:
> We were using -1 instead of the real size because the functions check
> what is bigger, size in bytes or the size of the iov.  Recent gcc's
> barf at this.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Remove comments about this feature.
> Fix missing -1.
> ---
>  include/qemu/iov.h |  6 ------
>  tests/test-iov.c   | 10 +++++-----
>  2 files changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index bd9fd55b0a..72d4c559b4 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -31,11 +31,6 @@ size_t iov_size(const struct iovec *iov, const unsig=
ned int iov_cnt);
>   * Number of bytes actually copied will be returned, which is
>   *  min(bytes, iov_size(iov)-offset)
>   * `Offset' must point to the inside of iovec.
> - * It is okay to use very large value for `bytes' since we're
> - * limited by the size of the iovec anyway, provided that the
> - * buffer pointed to by buf has enough space.

Is this part of the comment still okay?

>  One possible
> - * such "large" value is -1 (sinice size_t is unsigned),

Nice that we're losing the typo in the process :)

> - * so specifying `-1' as `bytes' means 'up to the end of iovec'.

I agree with dropping this though.  As mentioned elsewhere, we had
crossed mails between v1 reviews and v2 submission, so we'll probably
need a v3 anyways.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IaEmC0sSac7D52xgaJw2edfwKWB8q9LGR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnKcIACgkQp6FrSiUn
Q2rXKwf8CLePR4w/IB0ZhWO/iKr1rH8dBeyap7tpUod8htACVdchf8BU9/qAC7x2
ewoNuEVt2bQs0IXfl7ApVMwYmDa1u/foLvITx5IIXzRUaSklgrWE2jmeEnIqG1qq
PvTOGNB+PyuREmuLOd6oFLTvAZS2W+8vDUYJhxZHxo2cut3zu6tPaiOb+J+n+8b3
ZEFbVq06avSubvI+zKgvv4LaiBJ2tU+AEg7a64aoHB6jo2B4CkY6/ffx2VS8Xy/V
I3dLw3J17mAcCI2Kuk/KhDIwupF77gs9Fa0GhapkvM7h0JZVz4j0+l5/xsHg58Wt
wWCFe8o3gmifk7lTO2CpQinnR1GVnw==
=Wctt
-----END PGP SIGNATURE-----

--IaEmC0sSac7D52xgaJw2edfwKWB8q9LGR--
