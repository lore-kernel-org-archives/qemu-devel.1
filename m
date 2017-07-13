Received: from eggs.gnu.org ([2001:4830:134:3::10]:44780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfz6-0004mH-H8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfz2-0001ki-Cw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVfz2-0001kN-3d
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:24:52 -0400
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
	<20170712181652-mutt-send-email-mst@kernel.org>
	<20170712201550.GN6020@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4393c710-fb1e-892c-3c24-cdd6284c3a80@redhat.com>
Date: Thu, 13 Jul 2017 10:24:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170712201550.GN6020@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="blQn0OEN4VXtJMjcWUtNwGq5xslw2mCue"
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blQn0OEN4VXtJMjcWUtNwGq5xslw2mCue
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <4393c710-fb1e-892c-3c24-cdd6284c3a80@redhat.com>
Subject: Re: [PATCH v3] hw/i386: Deprecate the machines pc-0.10 to pc-1.2
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
 <20170712145121.GF6020@localhost.localdomain>
 <20170712181652-mutt-send-email-mst@kernel.org>
 <20170712201550.GN6020@localhost.localdomain>
In-Reply-To: <20170712201550.GN6020@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 03:15 PM, Eduardo Habkost wrote:

>=20
> If we use strverscmp(), it will be sorted in a more reasonable
> way.  We could copy the gnulib version on systems without glibc.
> Life is too short for writing configure checks by hand, though; I
> will add this to the end of my wish-todo list.  If somebody wants
> to volunteer, be my guest.
>=20
> I'm CCing Eric in case he has suggestions that would help import
> the gnulib module in an easy way.

We don't use autoconf, so we can't directly use gnulib. Copying the
files and making sure we provide the configure tests those files depend
on (or tweaking the files to simplify to our build system, where we
don't have to be quite as portable as gnulib tries to be) is going to be
a manual process. But at least the license is compatible (LGPLv2+), and
I'll willingly review patches attempted along those lines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--blQn0OEN4VXtJMjcWUtNwGq5xslw2mCue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ5CmAAoJEKeha0olJ0NqeF8H/A3/1HsiPec29yy2ItEKFetp
cSjF1DhfPH766M/14mH0cKHn7yU89w1NqDrhNMdld6b8He/b6U8RsoSRozm5xGJo
NJHd9omP/JMGgtS6HBg5qU9QeehALjFu3uC4FAoxepuEs2fhsRqZDumXY5vBD7Ht
AKRFAzFlIm//HkjDnZDhiuAq8Qx7ntODezlns1PEvd3Xp6UQ4Ko1my43xtwRGBpf
G/coOp6wiJrvcFOyeMoB1ZtvRlmlQi+us9qXuDEy0oSmWLuURCnCmuSOcRUr6kMr
Kb6M/MxZEEtaPaWeVV/O/Lh8LTI7QIZu7Qz3LKfOmo5mX5tR3ZnLxa9Lel6j0ho=
=+FfD
-----END PGP SIGNATURE-----

--blQn0OEN4VXtJMjcWUtNwGq5xslw2mCue--
