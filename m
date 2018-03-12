Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evMTP-0000Ip-2j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evMTN-0002Vw-VH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:22:39 -0400
References: <20180224154033.29559-1-mreitz@redhat.com>
	<1d3b01d0-4cf8-9a3a-e7a6-862599cda2dc@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <448e14c2-98c6-245d-d1af-a84743656bc7@redhat.com>
Date: Mon, 12 Mar 2018 13:22:29 +0100
MIME-Version: 1.0
In-Reply-To: <1d3b01d0-4cf8-9a3a-e7a6-862599cda2dc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S6n229cyNuNOTT4q6cvhrWtpOCusVpOSk"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S6n229cyNuNOTT4q6cvhrWtpOCusVpOSk
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <448e14c2-98c6-245d-d1af-a84743656bc7@redhat.com>
Subject: Re: [PATCH v3 0/7] block: Handle null backing link
References: <20180224154033.29559-1-mreitz@redhat.com>
 <1d3b01d0-4cf8-9a3a-e7a6-862599cda2dc@redhat.com>
In-Reply-To: <1d3b01d0-4cf8-9a3a-e7a6-862599cda2dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-10 23:34, Eric Blake wrote:
> On 02/24/2018 09:40 AM, Max Reitz wrote:
>> Currently, we try to rewrite every occurrence of "backing": null into
>> "backing": "" in qmp_blockdev_add().=C2=A0 However, that breaks using =
the
>> same "backing": null construction in json:{} file names (which do not =
go
>> through qmp_blockdev_add()).=C2=A0 Currently, these then just behave a=
s if
>> the option has not been specified.
>>
>> Since there is actually only one place where we evaluate the @backing
>> option to find out whether not to use a backing file, we can instead
>> just check for null there.=C2=A0 It doesn't matter that this changes t=
he
>> runtime state of the option from "" to null, because nobody really doe=
s
>> anything with that runtime state anyway (except put it into qemu again=
,
>> but qemu doesn't care whether it's "" or null).
>>
>> And in the future, it's much better if we get it to be null in that
>> runtime state sooner than later -- see patch 7.
>>
>>
>> Note that it was Markus (who's away having a good time, I hope) who
>> proposed qobject_to(), so I guess he won't object too much to seeing t=
he
>> concept having landed in his tree once he returns.
>> (Although he hasn't reviewed the previous iteration of this series,
>> =C2=A0 which included it already.)
>>
>=20
> Thanks, applied to my QAPI staging tree (with qobject_to(type, obj)
> reordering - it didn't take me too long after all):
> git://repo.or.cz/qemu/ericb.git qapi
> http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi

Thanks!

Max


--S6n229cyNuNOTT4q6cvhrWtpOCusVpOSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmcQUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHugIALnCzHAKhBwz7Y6LtcQmSKKlKS6QI3T6
3f9Hm+U/5SWIwMUGS/zbUcKL/xloiDS1AyJ/6kjtAj1+mhfx1b6lZ55qGvHaF49t
LUPn5jPuf6fBb3Fv2DP25iw3tAmQHDJ6vpFugxvvZ3P+4p63A3B/Gz8e1/Wg8aEl
2C7EeIQ39oEYCgETFOe9ZS9Tp81OtQJsi6ccfTY6UaL+IpFA4KnecIB9z6ML+sK4
7B9Rf08fQ7fGlOhiwkgryukQVoPxEsvU6vR4xqt1GEFhZsYwrOpOzWBU2hHpBgtu
y6pQzvEvizhcqT3Fg/nkoYEZPtE2ZVh+Ti/pqUYpVKeLxgwpltNF4bg=
=Y8AA
-----END PGP SIGNATURE-----

--S6n229cyNuNOTT4q6cvhrWtpOCusVpOSk--
