Received: from eggs.gnu.org ([2001:4830:134:3::10]:47645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwLs-0002HU-Pq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPwLo-00051w-GV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:40:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPwLo-00051b-7q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:40:40 -0400
References: <20170611074817.13621-1-sf@sfritsch.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
Date: Tue, 27 Jun 2017 14:40:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170611074817.13621-1-sf@sfritsch.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7srgJPxcMajUf52FdDKTDNcSuUPAf6kUr"
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7srgJPxcMajUf52FdDKTDNcSuUPAf6kUr
From: Eric Blake <eblake@redhat.com>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d95a3198-3ad0-4a75-dda2-a3b7502ede28@redhat.com>
Subject: Re: [PATCH v2] Add chardev-send-break monitor command
References: <20170611074817.13621-1-sf@sfritsch.de>
In-Reply-To: <20170611074817.13621-1-sf@sfritsch.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/11/2017 02:48 AM, Stefan Fritsch wrote:
> Sending a break on a serial console can be useful for debugging the
> guest. But not all chardev backends support sending breaks (only telnet=

> and mux do). The chardev-send-break command allows to send a break even=

> if using other backends.
>=20
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> v2: added tests and Acked-by line
>=20

> +++ b/hmp-commands.hx
> @@ -1745,6 +1745,22 @@ Removes the chardev @var{id}.
>  ETEXI
> =20
>      {
> +        .name       =3D "chardev-send-break",
> +        .args_type  =3D "id:s",
> +        .params     =3D "id",
> +        .help       =3D "send break on chardev",

Compare this wording,...

> +STEXI
> +@item chardev-send-break id
> +@findex chardev-send-break
> +Sends break on the chardev @var{id}.

repeated here,

> +++ b/qapi-schema.json
> @@ -5114,6 +5114,26 @@
>  { 'command': 'chardev-remove', 'data': {'id': 'str'} }
> =20
>  ##
> +# @chardev-send-break:
> +#
> +# Send a break to a character device

=2E..with this wording.  I like 'send a break' better than 'send break',
but even better might be 'send a break sequence' or even 'emulate a
break sequence' (by definition, a break is NOT a character, but on bare
metal character devices it IS a defined electrical sequence distinct
from characters to make the recipient aware that the sender is trying to
get attention).

Otherwise, the patch looks fine to me.  If all that changes is some
word-smithing (and the maintainer may be willing to do that), you can add=
:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7srgJPxcMajUf52FdDKTDNcSuUPAf6kUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUrSyAAoJEKeha0olJ0Nqe60IAK5wPJw2c5Y46cr2vuKhAIqI
Hem5Lr7z6206tAoomtyK5jwHq4pece+ET/0tzQIa2/LNmBwWbeYEGrUe54EmHwCJ
NUpWwPbul9ovXCqUuhHKcvdEsx+nAXwdbcSjNZZEfFCFL96OZ7PEEtVBdV5UAttv
86+ltZeMbhTJQjFaCohVt5NZkqHt+jhvSyl1i/QluwUv0FVbwFx7fs6JB2uenMYq
Tv89mXrOSL9X4jfGRr0k6Pxsvc8gus35La4xe8r0+mxCZbo2JNawQjq1h/NdaNkA
M4B2vrO0Tsuz9p+O8iBKbKq39cxbJpY3e7rDu3HPGl7Ygo6MQ/Xt906yMvWKUSI=
=X1sA
-----END PGP SIGNATURE-----

--7srgJPxcMajUf52FdDKTDNcSuUPAf6kUr--
