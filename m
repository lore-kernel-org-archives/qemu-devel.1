Received: from eggs.gnu.org ([2001:4830:134:3::10]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVI7g-00083O-VO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVI7g-0000eu-32
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:13 -0400
References: <20170609152017.7286-1-eblake@redhat.com>
	<1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15dc487a-c340-e407-a7b0-b7159a5a49a2@redhat.com>
Date: Wed, 12 Jul 2017 08:56:05 -0500
MIME-Version: 1.0
In-Reply-To: <1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="04bNNjAeuEo5TLUJvU8fircCO5HfmaEVM"
Subject: Re: [Qemu-devel] [PATCH 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--04bNNjAeuEo5TLUJvU8fircCO5HfmaEVM
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com, armbru@redhat.com
Message-ID: <15dc487a-c340-e407-a7b0-b7159a5a49a2@redhat.com>
Subject: Re: [PATCH 0/2] qobject coccinelle followups
References: <20170609152017.7286-1-eblake@redhat.com>
 <1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
In-Reply-To: <1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 08:35 AM, Michael Tokarev wrote:
> 09.06.2017 18:20, Eric Blake wrote:
>> Inspired by https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg0=
2505.html
>>
>> Surprisingly, the updated script didn't find any existing longhand
>> use as candidates for QDECREF() (our last such use was cleaned up
>> as a side effect, in commit b72fe9e), but it DID find another straggle=
r
>> missed in commit 579cf1d1.
>>
>> Eric Blake (2):
>>   qobject: Update coccinelle script to catch Q{INC,DEC}REF
>>   qobject: Catch another straggler for use of qdict_put_str()
>=20
> Applied to -trivial, thanks!

Markus has taken v2 of these patches through his qapi-next tree:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05589.html

so you can drop this v1 from -trivial

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--04bNNjAeuEo5TLUJvU8fircCO5HfmaEVM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZip1AAoJEKeha0olJ0Nq8poH/RFOTX5SVP0jvziqSIgO9GK6
SoLpxNhiPKCZxkHJQmYKEijURIrCLtmv4evX1aw+tM+5ur6FuaGpO9nSHWiftQir
60jai8Lnclae4BGFRkM0thw872GThRYraZuDgwzfRSlM1ZKIlFJxVhK/VDGu3705
xAshIE35ykVLMcBbI3f/ZnY54LUjvIx9m6YjtfKz6C5Q8+9ZD4lUqTBTUgo2XeE9
SEQBJbGe8KCUJl456F9jhR0EMCL/vPQDcUhU5RTUWy/ZIfiH9Ef5KmxpVNhfKui+
XohePHZFgfvY/yIXPQyPnhY+ijY0XPWrmBZj9x5hQa1zVtDHt7yS2xyzubXegKc=
=3ct3
-----END PGP SIGNATURE-----

--04bNNjAeuEo5TLUJvU8fircCO5HfmaEVM--
