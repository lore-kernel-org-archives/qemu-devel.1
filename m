Received: from eggs.gnu.org ([2001:4830:134:3::10]:54951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDeJl-0004b2-2N
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDeJi-0004wh-0p
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDeJh-0004w9-NA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:59:41 -0400
References: <20170331101947.2046-1-vfeenstr@redhat.com>
	<20170331101947.2046-2-vfeenstr@redhat.com>
	<e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
	<CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
	<149202750217.22939.16193629731178448080@loki>
	<20170524235155.2b1454ef@fiorina>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91c64ddc-991c-9877-23c9-c1783e459416@redhat.com>
Date: Wed, 24 May 2017 16:59:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170524235155.2b1454ef@fiorina>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="flMKgQcCNVUCb66osv1TDiTHkHCsNBlBC"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--flMKgQcCNVUCb66osv1TDiTHkHCsNBlBC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Message-ID: <91c64ddc-991c-9877-23c9-c1783e459416@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
References: <20170331101947.2046-1-vfeenstr@redhat.com>
 <20170331101947.2046-2-vfeenstr@redhat.com>
 <e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
 <CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
 <149202750217.22939.16193629731178448080@loki>
 <20170524235155.2b1454ef@fiorina>
In-Reply-To: <20170524235155.2b1454ef@fiorina>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 04:51 PM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> So what about the following, would that be acceptable?
>=20
>=20
> ##
> # @GuestOSRelease:
> #
> # @content:
> #           POSIX systems the @kernel_version, @kernel_release and
> #           @machine_hardware correspond to the values release, version=
 and
> #           machine returned by uname(2). On Windows, they correspond t=
o the
> #           version number, build number and architecture.

You'll have to actually document each field, not just a catch-all
@content.  You can list per-OS on which field is likely to be present or
absent.

> #
> #           On Linux-based system where os-release info is available ei=
ther
> #           from /etc/os-release or from /usr/lib/os-release, the field=
s @id,
> #           @name, @pretty_name, @version, @version_codename, @variant,=

> #           correspond to the fields of the same name defined in os-rel=
ease(5).
> #           On Windows, the data is generated based on the available
> #           inforamtion.

s/inforamtion/information/

> #
> # Since: 2.10
> ##
> { 'struct': 'GuestOSRelease',
>   'data': {
>       'kernel_release': 'str',

Please name this 'kernel-release'; new interfaces should use '-' rather
than '_'.

>       'kernel_version': 'str',

Etc.

>       'machine_hardware': 'str'
>       'id': '*str',

If a field doesn't make sense for all guests, then it should be marked
optional (for example, a Linux guest that does not have
/etc/os-release).  Marking a field optional is done as '*id':'str' (you
got it backwards).


>       'name': '*str',
>       'pretty_name': '*str',
>       'version': '*str',
>       'version_codename': '*str',
>       'variant': '*str',
>   } }
>=20
>=20

It's probably a reasonable start at the interface, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--flMKgQcCNVUCb66osv1TDiTHkHCsNBlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJgJKAAoJEKeha0olJ0Nq+oAH/RsXU6DVAcA/nHE0rVLSgo1G
t28DWs/sJJuYKUzEXWjlCplIWkQ7bN97yTTrGyS6kkeFRUQ4FjU8xpTzN6mumXyV
e76//nMMCpEWnKUGhOr5fYHTCInd2glBmiVW+ti5XY6aW+y6wXQIGjqJI5uhlsmN
v/Jf4SmZehfwylBwWn5KKVTuJoT+Q4en+Y636TegBlhJgQ0BCzI4hBhzqxuLQmOY
8M1vaROIAvarp0b8cNvQcAQ+pKA2UAhnmbxCEp4dB4H30xzgg931KWMUFljj+Deg
JmLiqdnO6JAZfia1xIsSRH0HZd0FcUHFLzBGh5R2Gquw5yeu8YhjrK0Io45Fl0o=
=53mT
-----END PGP SIGNATURE-----

--flMKgQcCNVUCb66osv1TDiTHkHCsNBlBC--
