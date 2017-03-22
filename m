Received: from eggs.gnu.org ([2001:4830:134:3::10]:34766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqih7-0002Mc-Us
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqih2-0006YN-2h
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:06 -0400
References: <20170322154649.6947-1-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d8dfe28-5366-fe25-ff27-d79cdc0bf1f7@redhat.com>
Date: Wed, 22 Mar 2017 11:00:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170322154649.6947-1-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DfRVoo1hsm4bjR43AquKAIOWcwMvPH4Lv"
Subject: Re: [Qemu-devel] [PATCH] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DfRVoo1hsm4bjR43AquKAIOWcwMvPH4Lv
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
Message-ID: <6d8dfe28-5366-fe25-ff27-d79cdc0bf1f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: Add `guest-get-timezone` command
References: <20170322154649.6947-1-vfeenstr@redhat.com>
In-Reply-To: <20170322154649.6947-1-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 10:46 AM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>

This is not a trivial patch (it is adding a new feature), so including
qemu-trivial is not necessary, and it should be merged through the qga
maintainer.

>=20
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>  qga/commands.c       | 19 +++++++++++++++++++
>  qga/qapi-schema.json | 25 +++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>=20

> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,28 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in minutes
> +#

Is it worth clarifying that negative numbers imply west of UTC? (There
are some places that get offsets backwards from the usual POSIX
notation, so it never hurts to be specific which direction is intended).


> +##
> +# @guest-get-timezone:
> +#
> +# Retrieves the timezone information from the guest.
> +#
> +# Returns: The guest timezone GuestTimezone information on success.

Sounds rather repetitive; and a struct return is implicitly only
possible on success.  Perhaps it could be shortened to:

# Retrieves timezone information from the guest.
#
# Returns: A GuestTimezone dictionary.

> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-timezone',
> +  'returns': 'GuestTimezone' }
>=20

But the overall idea makes sense to me, so whether or not you wordsmith
the documentation in the .json file,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DfRVoo1hsm4bjR43AquKAIOWcwMvPH4Lv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0p+3AAoJEKeha0olJ0NqkwsH/RoUKDaK/1XRSMHF0MtRf5+D
UpHF025PYE8KmZ25dznp2DRdoNy713fbvtoaSmBsjpB6pibo7Kh+lDSUDAdpktHj
JHYvQLw9UWOG4USK5bHSOvMGHax3iuyMNED617FhdBNTo5tpS+SjwxYO9U47GEs3
CZcPNlCsjMBe4RSEtPevYBfC6EkQ62UIDQFGrlW4wBVva/NTf1Sus/YpJ2pMVY1z
FSkCbmMmkNkEr1vLrK6T/R5aZxksv11X9q6lu2SkULZCrZHtWkq0XM2VAqv8lHs7
kHeS3ruNXTLSWZdGE0177PjWxvPQsrhJBAA06ZS1KVFO3Nw96PDqoq1AWXbf7uQ=
=eUwk
-----END PGP SIGNATURE-----

--DfRVoo1hsm4bjR43AquKAIOWcwMvPH4Lv--
