Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lXR-0004vp-5Q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lXO-0001K5-2b
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7lXN-0001K1-P4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:29:29 -0400
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
	<CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
Date: Mon, 8 May 2017 11:29:25 -0500
MIME-Version: 1.0
In-Reply-To: <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kLkVGlus2U1uVDXQM5EeukMDgxgBoDboO"
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>, John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kLkVGlus2U1uVDXQM5EeukMDgxgBoDboO
From: Eric Blake <eblake@redhat.com>
To: Carl Karsten <carl@personnelware.com>, John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
Subject: Re: [Qemu-devel] format=raw,readonly errors
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
 <87wp9r689l.fsf@dusky.pond.sub.org>
 <CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
 <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
 <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
In-Reply-To: <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 10:56 AM, Carl Karsten wrote:

>>>>> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -dri=
ve
>>>>> file=3Ddisk.cow -drive file=3Dboot.img
>>>>> WARNING: Image format was not specified for 'boot.img' and probing
>>>> guessed
>>>>> raw.
>>>>>          Automatically detecting the format is dangerous for raw
>> images,
>>>>> write operations on block 0 will be restricted.
>>>>>          Specify the 'raw' format explicitly to remove the
>> restrictions.

>  "write operations on block 0 will be restricted."
>=20
> Is there a way to explicitly enable that?

Yes. Pass format=3Draw at the right place (in other words, instead of
getting the 'raw' format driver by default, explicitly mentioning that
you KNOW you want the 'raw' format driver is enough to shut up the warnin=
g).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kLkVGlus2U1uVDXQM5EeukMDgxgBoDboO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEJzlAAoJEKeha0olJ0NqQQ4IAKVjx4BTI/SWob9pUNaKYNH8
eWkVE2EGqlNuu1lU+59IDsu7JAARnMGDhP7BEwJYjIqI3Rhw9It41rJrPLDcPCds
IrIipmflzzjrtFEtOmZtkAeZTTTE/hF4fkMrcTS3qZjBv7aIQZH4tmzgJ4jB4Rww
YQ8Ci+bSf51tW8JHiUkXj6rsZ6dyVHk6FdjeBGn9oXaP3GZXmhODd7yVFlFwlY4S
Sl2yyMMfIQpOCMYvlk/+jCDqBNu1p55luYhB8b1bVll0ufdqQvjdTRIG0nGOm0VY
ohBRAmMFfdPRDvXHzpHeJ9I39eoXZq/28+v8l6EMXYf+AfJYkWEFdQ5REJwpiZM=
=pvTW
-----END PGP SIGNATURE-----

--kLkVGlus2U1uVDXQM5EeukMDgxgBoDboO--
