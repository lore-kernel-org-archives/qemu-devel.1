Received: from eggs.gnu.org ([2001:4830:134:3::10]:55497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS6HV-0001iI-Ba
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS6HU-00031V-FC
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:41:09 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-2-el13635@mail.ntua.gr>
	<8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b82e5ed-73b1-34d6-9958-dfc45bebedfc@redhat.com>
Date: Mon, 3 Jul 2017 13:40:57 -0500
MIME-Version: 1.0
In-Reply-To: <8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qCHdOoJRPx6mIxNcVWA4wTF1nScXlKSnx"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qCHdOoJRPx6mIxNcVWA4wTF1nScXlKSnx
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1b82e5ed-73b1-34d6-9958-dfc45bebedfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: pass bdrv_* methods to
 bs->file by default
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-2-el13635@mail.ntua.gr>
 <8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
In-Reply-To: <8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 10:56 AM, Eric Blake wrote:
> On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
>> The following functions fail if bs->drv does not implement them:

One other suggestion: most patches in the tree use 'topic: Capital',
while yours used 'topic: lowercase'.  It's probably worth posting a v3
that addresses all of the nits I've pointed out, including tweaking the
commit messages.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qCHdOoJRPx6mIxNcVWA4wTF1nScXlKSnx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWo+5AAoJEKeha0olJ0NqzIkH+gPaWgJAV3O0cL0yvAyRfnrI
VQWiQAIgsrKxD5lnRPfZNN1zsZmOiqybDGhse6UcRzIK+w3/2Qw/uliMOJPSq6qA
Fd9U0keSl9ln4ISBmXirhIqv4KOuEL6iuyJLyTwGjdnoH3kkTBq3NJ1qUCY+H8zJ
5ghB7N3iVWmUUuxPVgSVOt7Akg5Xyx0OJM1RRBfauNKxL200fJI+wVpgZHC9Qplg
on6++UnBoakkp0+6hhCDxdl9ydWY/Mwqpassx695Andw0x5xLNHJBYVUwzMve898
qB9EdmpJNpRXqbBjnApS/jnl8MCgyz7pN+4oTcjynntGpZ3GKj6Z69qNApWpbmY=
=4ssp
-----END PGP SIGNATURE-----

--qCHdOoJRPx6mIxNcVWA4wTF1nScXlKSnx--
