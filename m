Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtS2-0004M2-Jt
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtS0-0001jY-IQ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:50:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOtS0-0001jL-9s
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:50:28 -0500
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<4315c23d-0c4b-4341-90aa-54d186eaa251@redhat.com>
	<CAJ+F1C+qoZrmMgsiEC+=xNVVaJFV+fUxk8ZmjSQTxnDXpKb6Dg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a614dd79-959f-705f-7957-e0fc4c9b9a8a@redhat.com>
Date: Wed, 4 Jan 2017 15:50:24 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+qoZrmMgsiEC+=xNVVaJFV+fUxk8ZmjSQTxnDXpKb6Dg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wBQ3ct65baWeCICvkwvweDkomiAoDs3gC"
Subject: Re: [Qemu-devel] [PATCH 00/54] WIP: chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wBQ3ct65baWeCICvkwvweDkomiAoDs3gC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a614dd79-959f-705f-7957-e0fc4c9b9a8a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/54] WIP: chardev: qom-ify
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <4315c23d-0c4b-4341-90aa-54d186eaa251@redhat.com>
 <CAJ+F1C+qoZrmMgsiEC+=xNVVaJFV+fUxk8ZmjSQTxnDXpKb6Dg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+qoZrmMgsiEC+=xNVVaJFV+fUxk8ZmjSQTxnDXpKb6Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 03:20 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jan 2, 2017 at 11:27 AM Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>=20
>>
>>
>> On 12/12/2016 23:42, Marc-Andr=C3=A9 Lureau wrote:
>>>
>>> Note: this series has been tested with Linux and cross-building with
>>> mingw. It mostly breaks on other platforms,
>>
>> What breaks exactly?
>>
>>
> Not much that I know. I was afraid it would break on BSD (in particular=
 the
> move to own file and last patch), so I tested on FreeBSD. The last vers=
ion
> of the series works on win32, linux and freebsd. It can be found on
> https://github.com/elmarco/qemu/commits/chrfe It's slightly over 80 pat=
ches
> now, and needs some win32 fixes I sent earlier (subprocess tests, and
> main-loop busy loop fix)
>=20
> Since Erik started reviewing the series, I suggest to resend the first =
part
> until "qom-ify" patch. Erik, feel free to review the remaining part of =
the
> WIP series, but more changes happened after iirc. What do you think?

It's Eric (but you're not the first, and probably not the last).  The
qom-ify patch is 15/54, right? Okay, I'll complete my review up to that
point, and then you can split the series into two: a v2 through qom-ify
(which should probably be ready to go, or only very little to change),
and the second half which is still the WIP.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wBQ3ct65baWeCICvkwvweDkomiAoDs3gC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbW4gAAoJEKeha0olJ0NqqkEIAJ1KTf3WffIBWXLOQujc0Meg
ksyUQmrluwoNvQXmPsjJk+mu5DhqDrPFHooU73ZRzKNXhzrpBZne7k4dE41x6e1h
+QuVNwlf+i25VrkKumKRtyJZgqwGkPARh+W6mBWdMrNU80ejStA4OPgNuxFc7YLK
/UiF9B7+eOceEcv+tM7ZnRcEbJENP/OQM+WuKqlNGROJpy+6shQTFzFh0lsxLXY1
S0z/k31Kyg8ehFKafE3j2oNhhfefRdjk09cXLrYzVwbJJcCrwyO3EGchqBzQ5lJo
GfdIgepPY762khzN4dzBurLNeayjNjRREHrGx+Y/P947IWM7xkOo3N+/9mRwwLM=
=N4+h
-----END PGP SIGNATURE-----

--wBQ3ct65baWeCICvkwvweDkomiAoDs3gC--
