Received: from eggs.gnu.org ([2001:4830:134:3::10]:57194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Ega-0007Ms-Mk
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4EgZ-0007EU-OT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:48:24 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-5-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc62148f-33b4-eeec-61d6-7eb68c1712de@redhat.com>
Date: Fri, 28 Apr 2017 17:48:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170428021317.24711-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8ee0HB2rNJXNr9tCcxlM8mG3RAKAMxMRl"
Subject: Re: [Qemu-devel] [PATCH v5 4/4] RFC: shutdown: Expose full
 ShutdownCause across QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, alistair.francis@xilinx.com, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ee0HB2rNJXNr9tCcxlM8mG3RAKAMxMRl
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 alistair.francis@xilinx.com, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <cc62148f-33b4-eeec-61d6-7eb68c1712de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/4] RFC: shutdown: Expose full
 ShutdownCause across QMP
References: <20170428021317.24711-1-eblake@redhat.com>
 <20170428021317.24711-5-eblake@redhat.com>
In-Reply-To: <20170428021317.24711-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Dan in cc]

On 04/27/2017 09:13 PM, Eric Blake wrote:
> Since all reset/shutdown requests have been associated with a
> reason, we can expose the full reason rather than a simple bool
> to the guest. Document that any future additions to the enum
> type will still use a 'host-' or 'guest-' prefix.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

This is RFC because I really want to know whether libvirt and upper
layer management apps will care about the various causes, or if exposing
just a boolean is okay.  We can maintain backwards compatibility if we
release with just a boolean and later decide we want to expose the enum,
but it's easier to start with a design that meets everyone's needs that
it is to have to add stuff later or wish that we hadn't exposed quite so
many enum values.


> +++ b/qapi/event.json
> @@ -10,9 +10,7 @@
>  # Emitted when the virtual machine has shut down, indicating that qemu=
 is
>  # about to exit.
>  #
> -# @guest: If true, the shutdown was triggered by a guest request (such=
 as
> -# a guest-initiated ACPI shutdown request or other hardware-specific a=
ction)
> -# rather than a host request (such as sending qemu a SIGINT). (since 2=
=2E10)
> +# @reason: What triggered the reset. (since 2.10)
>  #
>  # Note: If the command-line option "-no-shutdown" has been specified, =
qemu will
>  # not exit, and a STOP event will eventually follow the SHUTDOWN event=

> @@ -21,11 +19,11 @@
>  #
>  # Example:
>  #
> -# <- { "event": "SHUTDOWN", "data": { "guest": true },
> +# <- { "event": "SHUTDOWN", "data": { "reason": "guest-shutdown" },
>  #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } =
}
>  #
>  ##
> -{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
> +{ 'event': 'SHUTDOWN', 'data': { 'reason': 'ShutdownCause' } }
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8ee0HB2rNJXNr9tCcxlM8mG3RAKAMxMRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA8asAAoJEKeha0olJ0NqzUcH+gNbnofq7puS3gq4y4+xobx9
9+Lz5XglTU1nZx7knRXSbauNatZSH9Bu3H1VqLr00WJwMp2XNqXOZeMCp6e0DLvA
WeH7B96lOzmShSP979HUsOfQmWnf1L8502+BMz7SAyZK3lJSwlNNbUSSCvAtoVL9
vPlQJlEFB2tfU7FehiGqxbIP25qVYcx4B5Ut6ZL9OK/J1rSFlSQz4mMjkP68Nchp
5c9mHZZ1dJ/ClDGqAjYzXKYKGxOO88kCbuiv+XVn3IvqIYO4ggz9aJI9pCCryMAb
tr8TECV3VYxmZSIav7s9UcMdPYvHyQ1cQoiMWSzba6oEYB7ZHJwCQEzOofWHKLU=
=iah4
-----END PGP SIGNATURE-----

--8ee0HB2rNJXNr9tCcxlM8mG3RAKAMxMRl--
