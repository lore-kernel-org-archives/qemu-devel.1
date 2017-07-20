Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYADU-0000eq-EE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYADR-0002qv-5U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYADQ-0002pV-St
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:06:01 -0400
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c98eec07-b269-ddb3-6e53-88ad4e34dbc5@redhat.com>
Date: Thu, 20 Jul 2017 07:05:50 -0500
MIME-Version: 1.0
In-Reply-To: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3FlG9OO97g0GuKOkPGM5T4StpsdtAnwjH"
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3FlG9OO97g0GuKOkPGM5T4StpsdtAnwjH
From: Eric Blake <eblake@redhat.com>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <c98eec07-b269-ddb3-6e53-88ad4e34dbc5@redhat.com>
Subject: Re: [PATCH] acpi: Add emulated sleep button
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 04:31 AM, Stefan Fritsch wrote:
> From: Stefan Fritsch <stefan_fritsch@genua.de>
>=20
> Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sleep
> button is a so called "fixed hardware feature", which makes it more
> suitable for putting the system to sleep than a laptop lid, for example=
=2E
>=20
> The sleep button is disabled by default (Bit 5 in the FACP flags
> register set and no button "device" present in SSDT/DSDT). Clearing sai=
d
> bit enables it as a fixed feature device.
>=20
> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> ---

Just an interface review:

> +++ b/qapi-schema.json
> @@ -2314,6 +2314,18 @@
>  { 'command': 'system_reset' }
> =20
>  ##
> +# @system_sleep:
> +#
> +# Requests that a guest perform a ACPI sleep transition by pushing a v=
irtual

s/a /an /

> +# sleep button.
> +#
> +# Notes: A guest may or may not respond to this command.  This command=

> +#        returning does not indicate that a guest has accepted the req=
uest or
> +#        that it has gone to sleep.

Missing a 'Since: 2.11' line.

> +##
> +{ 'command': 'system_sleep' }

Please name this 'system-sleep' (new QMP commands should favor '-' over
'_').  Or at least document in the commit message that you are
intentionally trying to match spelling of older existing system_*
commands.  I wonder if it might be better to have a single system-acpi
command that takes an enum of which action (sleep, powerdown, ...) to
attempt, rather than a proliferation of commands per action..

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3FlG9OO97g0GuKOkPGM5T4StpsdtAnwjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwnJ4ACgkQp6FrSiUn
Q2rRbAf/VKaoRTud4PP6WRYZoU7BLS4z9SlF/mHQr0fyMbZeJZn1LMC6n1kgRZjo
IR+pvjUszK+gU8pxlFDuOaQdiEH75e/ncjN6uL/2N0m5Mw5nR1VLfk+EY8zk5JLz
vYNOJuraiIvtGdNOhTItpr1c363SdCZAze+5z2K/vBmmFDyp65DOkjDXVgnjhCpM
I1UZ2EaUAl1Nhkc8ptMAKQWPzd2NOTum8S/zyDU+8iESd8eTJFSTZTQwDk6WwrLV
LOjps7C2cdnpFuSLoiLxbc+IFG2E4svMQjWjizEi/xbEbGUKqIUySjwCdy0D+eQz
gIEkBiS9iQ2ADh4ham351tz2IGokog==
=JrAf
-----END PGP SIGNATURE-----

--3FlG9OO97g0GuKOkPGM5T4StpsdtAnwjH--
