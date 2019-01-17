Received: from eggs.gnu.org ([209.51.188.92]:46917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjyFW-0007Xq-3a
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjyFT-0000aN-Gz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:21:46 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-19-eblake@redhat.com>
	<0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
Date: Wed, 16 Jan 2019 21:21:32 -0600
MIME-Version: 1.0
In-Reply-To: <0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KLOYR5q1JqxF81lcd57LqytlBUnmxhSK1"
Subject: Re: [Qemu-devel] [PATCH v3 18/19] nbd/client: Work around 3.0 bug
 for listing meta contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KLOYR5q1JqxF81lcd57LqytlBUnmxhSK1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
Subject: Re: [PATCH v3 18/19] nbd/client: Work around 3.0 bug for listing meta
 contexts
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-19-eblake@redhat.com>
 <0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
In-Reply-To: <0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 9:43 AM, Vladimir Sementsov-Ogievskiy wrote:

>> @@ -839,9 +842,25 @@ static int nbd_list_meta_contexts(QIOChannel *ioc=
,
>>
>>           ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_META_=
CONTEXT,
>>                                              &context, NULL, errp);
>> +        if (ret =3D=3D 0 && seen_any && !seen_qemu) {
>> +            /*
>> +             * Work around qemu 3.0 bug: the server forgot to send
>> +             * "qemu:" replies to 0 queries. If we saw at least one
>> +             * reply (probably base:allocation), but none of them wer=
e
>=20
> if we are saying about 3.0, it is base:allocation for sure, isn't it?
>=20
>> +             * qemu:, then run a more specific query to make sure.

If the server is qemu 3.0, then yes, it is base:allocation. But it could
be some other server that has its own custom return without implementing
base:allocation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KLOYR5q1JqxF81lcd57LqytlBUnmxhSK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/9LwACgkQp6FrSiUn
Q2rmfgf9EBPn+h19cw1+FD8qOYWjEhtz+ufsUmugn4O0pxSOpE6xjg9bmEGealjC
mITRLEnTecJGV47y7O5kIU0scRef41AedvAPKtesJrsxqOwlIrW/hJajdj+k7Chq
Qkz8LlBXf1BBk5eboJaHYlLCgh/2bqu/TzDy4ogGqHJciHHLWD913mjl02IjF/5y
6+MtBj56ds15wFr5KgKBTnZx3UH2K3mpqeUx27qfK7h9WMii7KjC6UfDHcCd+dmZ
8lV3ySPp/SEuatZvu8NUNB5WyPQe0Z1Ct4EHGTWjbcFLxM8yCvauPH1VdDuDtG9u
rhzpFMr+asjH25YboCGu4Ojuks8HQg==
=cXR8
-----END PGP SIGNATURE-----

--KLOYR5q1JqxF81lcd57LqytlBUnmxhSK1--
