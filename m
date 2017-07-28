Received: from eggs.gnu.org ([2001:4830:134:3::10]:50806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9yy-0006Rb-Fo
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9yu-0002oq-Hn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:27:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9yu-0002oG-85
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:27:24 -0400
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbad51b9-55b6-44c8-87ca-b3fd052d8805@redhat.com>
Date: Fri, 28 Jul 2017 13:27:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wIeFvvnpsuXE6Tr95WEBIcjqEoQVlKATu"
Subject: Re: [Qemu-devel] [PATCH v5 3/3] hmp: introduce 'info
 memory-size-summary' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIeFvvnpsuXE6Tr95WEBIcjqEoQVlKATu
From: Eric Blake <eblake@redhat.com>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>,
 Mohammed Gamal <mohammed.gamal@profitbricks.com>,
 Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <bbad51b9-55b6-44c8-87ca-b3fd052d8805@redhat.com>
Subject: Re: [PATCH v5 3/3] hmp: introduce 'info memory-size-summary' command
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
 <20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:10 AM, Vadim Galitsyn wrote:
> This command is an equivalent of QMP command query-memory-size-summary.=

> It provides the following memory information in bytes:
>=20
>   * base-memory - size of "base" memory specified with command line opt=
ion -m.
>=20
>   * hotunpluggable-memory - amount of memory that was hot-plugged.
>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>     value is reported.

Most of our HMP commands use underscores between words; for consistency,
you might want to name it 'info memory_size_summary'.  Also, between the
new QMP and HMP parameters, do you have any testsuite coverage?  I know
we don't have many existing QMP tests to copy from, but where possible,
we want to avoid adding new QMP features that don't have some sort of
coverage.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wIeFvvnpsuXE6Tr95WEBIcjqEoQVlKATu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7ggQACgkQp6FrSiUn
Q2pY1QgArHrcvjBVtgpiTLnm4H+HFDqnJWgoT4DwvLNuwyndRrMMfowR8HDE0lYk
p9VumL7M+sReHbgA1GlUNrENVZ4SDjg0LJR+AvVSMH7wQjvu5zoXNNqxTPUcji8q
ioTmxuYH3duAR3zWHcSP0W+keq8LxVawRgS0zy2MJqAOp5cesUoKVlMKT3ZbxR0m
tTLbC9b3evZcDvpzCl9Cv0Llt0ZXpFuAexdFfTYkdQUMjwRlfEAUB5vfn6vJn64b
TlD36pSfQVlJFnjZKmh7vjAgUmUXPgkRANk7rmsM8s1IRT2B0fCWpDymjC97TqC/
PSk1fta1qZ6KYsc/LTfEropLN9gHUA==
=dZer
-----END PGP SIGNATURE-----

--wIeFvvnpsuXE6Tr95WEBIcjqEoQVlKATu--
