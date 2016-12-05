Received: from eggs.gnu.org ([2001:4830:134:3::10]:40490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw6r-0006G3-2u
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw6m-0007y1-Fw
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:27:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cDw6m-0007xX-6V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:27:16 -0500
References: <20161202210152.6880-1-lersek@redhat.com>
	<20161204192953-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2306b67d-b41b-30a7-a5ba-fe00d1639e16@redhat.com>
Date: Mon, 5 Dec 2016 10:27:11 -0600
MIME-Version: 1.0
In-Reply-To: <20161204192953-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JhdjXSb8twTx605buhHBe1SMxGqqBuK2u"
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JhdjXSb8twTx605buhHBe1SMxGqqBuK2u
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <2306b67d-b41b-30a7-a5ba-fe00d1639e16@redhat.com>
Subject: Re: [PATCH v2] scripts: add "git.orderfile" for ordering diff hunks
 by pathname patterns
References: <20161202210152.6880-1-lersek@redhat.com>
 <20161204192953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161204192953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/04/2016 11:33 AM, Michael S. Tsirkin wrote:

>> +++ b/scripts/git.orderfile
>> @@ -0,0 +1,20 @@
>> +# Apply this diff order to your git configuration with the command
>> +#
>> +#   git config diff.orderFile scripts/git.orderfile
>> +
>> +docs/*
>=20
> do we need this now? .txt is just below.
>=20
>> +*.txt

I still think we want docs/* first, at which point this *.txt line
currently only adds changes to qdict-test-data.txt (should that file be
moved to live under tests/ ?)

>> +configure
>> +GNUmakefile
>> +makefile
>> +Makefile*
>> +*.mak
>=20
> do these rules apply in each directory?

My understanding is that git applies similar logic to these lines as it
does to .gitignore files: if not anchored, the pattern applies to any
file in any directory; or you can start with leading / to force the
match to be anchored to a specific directory.

> I think they do but then I don't think we should list directories
> below.
>=20
>> +qapi-schema*.json
>> +qapi/*.json
>> +include/qapi/visitor.h
>> +include/qapi/visitor-impl.h
>> +scripts/qapi.py
>> +scripts/*.py
>> +*.h
>> +qapi/qapi-visit-core.c
>=20
> is the exact order or qapi files that important?
> I'd rather we stuck to simple wildcards without
> special casing visitors etc.

On the v1 thread, I had pointed out that I had special-cased visitor
code in some of my patches, as an example, but I'm not sure that it is
special enough to be needed for everyone.  I'm fine doing one-off tweaks
for patch series where a particular file should come first, without
making the official file have to track all those one-off tweaks.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JhdjXSb8twTx605buhHBe1SMxGqqBuK2u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRZVfAAoJEKeha0olJ0NqHTQH/A6knX4g3iIDmKjIYi3Ek4k0
8VqXiKY5ysNQaawZexbFiLD2tzxmw/1bgnCJ5HXd0Mujg1LoAVXFEHJREECVBUE0
wKD1NUjpc7045BFSndUbVPGU98wYrVphBeuO3PYp7sUg+/o0pzTU3pomCLCGlxG/
ObFzAmmLgxbTE/GqOCYtHm8ihR1YYlfb5uQcH8701qZYW0TR0d9bluNf4eCw9ykJ
Cgq0Di43tdUknqqtapNvDea1kizUOdcA/mGesMM9ngaKqsvgZfAIU7EPoalzBipb
lsi0ng/IQTHWwPzcFe0JKWqwFapwdm93H1RLkaZuL8WmMuZa5CzeYSIEzV1n1Ug=
=LvKr
-----END PGP SIGNATURE-----

--JhdjXSb8twTx605buhHBe1SMxGqqBuK2u--
