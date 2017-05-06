Received: from eggs.gnu.org ([2001:4830:134:3::10]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d73FZ-0001Ev-NG
	for qemu-devel@nongnu.org; Sat, 06 May 2017 13:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d73FY-0008Ij-Nz
	for qemu-devel@nongnu.org; Sat, 06 May 2017 13:12:09 -0400
References: <20170506124314.23354-1-aurelien@aurel32.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10e6a024-f9d1-b33a-9181-3b896dcccd4d@redhat.com>
Date: Sat, 6 May 2017 12:11:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170506124314.23354-1-aurelien@aurel32.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M7VAAFJiE40rlTU5axXnjTVLhu5NATBmE"
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/block: Introduce rotational qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M7VAAFJiE40rlTU5axXnjTVLhu5NATBmE
From: Eric Blake <eblake@redhat.com>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <10e6a024-f9d1-b33a-9181-3b896dcccd4d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/block: Introduce rotational qdev
 property
References: <20170506124314.23354-1-aurelien@aurel32.net>
In-Reply-To: <20170506124314.23354-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2017 07:43 AM, Aurelien Jarno wrote:
> The Linux kernel uses different I/O scheduler depending if the block
> device is a rotational device or not. Also it uses rotational devices
> to add entropy to the random pool.
>=20
> This patch add a rotational qdev property so that the block device can
> be configured as a rotational device or a non-rotational device. Defaul=
t
> to true to not change the default behavior.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  blockdev.c               | 4 ++++
>  include/hw/block/block.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Please remember to send a 0/3 cover letter when sending a series (you
can use 'git config format.coverletter auto' to make it easier).

The NBD server has the ability to expose to a client whether a given
exported volume is rotational or not; so there may be some additional
integration you should perform to make nbd-server properly export this
new property.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--M7VAAFJiE40rlTU5axXnjTVLhu5NATBmE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDgPeAAoJEKeha0olJ0NqiWkH/1y6j4AJalPLSoP9Cdb04IJG
086jHCn1gLw+qZscAbsFzLyP0W5Na4/uJlTkuc3f8IkWIXZOEaWlzUE/7yY2DtSP
6rcvv5AzAJ0zZT3E3otgWnkEWpAAFBosxTnAMditj/emC8mzMBwbBfvWZ6WNKoia
7wkVohF2ILRYOqqKobqUgUXL3mpx9+WT8RD3ePeJPsuoIse6IKIGQ2qjOzionC6Q
GVzleO6OB5Vt0oMc8/YYKw+0+Fk/YE51SwB3QBVkgBRvww+YZH6rL4v8LJwzRifi
fxK5g+lYarYzlAFwto/xVKV62cl/LIXIjYnLyJdvRtYaIGB8hhAFSzd8+TgUgJw=
=tTXc
-----END PGP SIGNATURE-----

--M7VAAFJiE40rlTU5axXnjTVLhu5NATBmE--
