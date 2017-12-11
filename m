Received: from eggs.gnu.org ([2001:4830:134:3::10]:36373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOVgo-0002e5-Qo
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOVgj-0000MS-MJ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:32:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOVgj-0000JR-Dh
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:32:37 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
	<CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
	<b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
Date: Mon, 11 Dec 2017 22:32:13 +0100
MIME-Version: 1.0
In-Reply-To: <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dWEGiTWx5NDPSdpB6dc4fD5J1ujVTSL9t"
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dWEGiTWx5NDPSdpB6dc4fD5J1ujVTSL9t
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota"
 <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
 <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
 <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
In-Reply-To: <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/12/2017 15:11, Eric Blake wrote:
> I don't know if there is a way to make gcc insert stack-unwind
> directives that are honored across longjmp (I know C++ does it for
> exceptions; so there may be a way, and I just don't know it).

Probably -fexceptions.

Paolo

> Conversely, I do know that pthread_cleanup_push/pop, which does
> something similar, is permitted by POSIX to NOT work across longjmp:
>=20
>        Calling longjmp(3) (siglongjmp(3)) produces undefined  results
> if  any
>        call  has  been made to pthread_cleanup_push() or
> pthread_cleanup_pop()
>        without the matching call of the pair since the jump buffer was
> filled
>        by   setjmp(3)  (sigsetjmp(3)).   Likewise,  calling  longjmp(3)=

> (sig=E2=80=90
>        longjmp(3)) from inside a clean-up handler produces  undefined
> results
>        unless  the  jump  buffer  was  also filled by setjmp(3)
> (sigsetjmp(3))
>        inside the handler.



--dWEGiTWx5NDPSdpB6dc4fD5J1ujVTSL9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlou+WMACgkQv/vSX3jH
roOVLwf+LB58K9hpDmBU6r58r/2s+aqlOC8PT+YaUFCUkZL2ZSalc7BYkXY1Q1oA
jSDmaBSp+HfUfDtka7p+k3D91XaOiD9Y646sL9rpIFPifZ225C/1gMTIf44l3/k/
nk7k7InXJ11VASmEcTcaIv/gCwzft54gf/2VQX7u5TaOhHm5jug+K7r55Cwx+GLe
gNhFkrUUp+cuESPZ1vVVQPgDAqs1udWBtcu4BSA6wVqP9snXRUVgHkOZAb9YcXqV
OvvW3qcG6Ow0ncAfuNDqrK+Lo88lq7G2lXrVyzoIXOhS2AJYJkQsKetCs3YfuM2Q
YDtjf0kwwoJuy0++1PJbg4gBJaNSTA==
=REIL
-----END PGP SIGNATURE-----

--dWEGiTWx5NDPSdpB6dc4fD5J1ujVTSL9t--
