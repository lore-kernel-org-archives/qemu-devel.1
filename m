Received: from eggs.gnu.org ([2001:4830:134:3::10]:53678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eANdK-0008Rp-JJ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eANdJ-0004Ms-EJ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:06:42 -0400
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-17-mreitz@redhat.com>
	<w51shdwwxpn.fsf@maestria.local.igalia.com>
	<b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
Date: Thu, 2 Nov 2017 17:06:28 -0500
MIME-Version: 1.0
In-Reply-To: <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s3uMNrn6isTcp76Gtlrr6nkmB9GgfR3pP"
Subject: Re: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s3uMNrn6isTcp76Gtlrr6nkmB9GgfR3pP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
Subject: Re: [PATCH v6 16/25] block: Add 'base-directory' BDS option
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-17-mreitz@redhat.com>
 <w51shdwwxpn.fsf@maestria.local.igalia.com>
 <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
In-Reply-To: <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2017 11:07 AM, Max Reitz wrote:
> On 2017-11-02 15:40, Alberto Garcia wrote:
>> On Fri 29 Sep 2017 06:53:38 PM CEST, Max Reitz wrote:
>>> Using this option, one can directly override what bdrv_dirname() will=

>>> return. This is useful if one uses e.g. qcow2 on top of quorum (with
>>> only protocol BDSs under the quorum BDS) and wants to be able to use
>>> relative backing filenames.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>
>> Who would be using this option in practice? I understand that manageme=
nt
>> tools should be using always absolute filenames, and this API doesn't
>> seem so convenient for humans.
>=20
> Hmmm.  I seem to recall Eric liked it a couple of years ago when he was=

> still more on the libvirt side of things. :-)

Ideally, libvirt should be using node names rather than filenames
(whether absolute or relative); but I still think it could be something
that turns out to be useful.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s3uMNrn6isTcp76Gtlrr6nkmB9GgfR3pP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7luQACgkQp6FrSiUn
Q2rxzwf/QsNtOMJeoajFn/CyVDVDDLy8x35tyVzF8WR9omlwgWOVGCyuHEXLr866
3uznHpMz6K009sxuDy2uOdsi8lzlWXta6WEfitqUFi90Aj7pV2fdHP27JeOmJdDH
XaDmFtIRkplP4fpbsItII2pOBcclddhf0tAXBerV4ekuMWBQHNT2QFEoaREhGuAQ
ZsRujsjg6ytD167GCy8KNY9pFCCN4amX8j1Pyp2kw+39uxq98GLYIvuVWgs6EmHc
Rr/ztr7FqYsQtwSNHjeP45hssu5h7wZSRCyAXkRyzUoZnLDIWB9CJQiBqXhG0eXo
pW2Wx5tX+XHlj+7C44x9HHzGgiomRg==
=haoF
-----END PGP SIGNATURE-----

--s3uMNrn6isTcp76Gtlrr6nkmB9GgfR3pP--
