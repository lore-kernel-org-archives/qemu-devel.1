Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENz7-0005Qq-GL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENz2-0002nt-J5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:13:13 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
Date: Tue, 6 Dec 2016 16:12:48 -0600
MIME-Version: 1.0
In-Reply-To: <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NcNuMU8oL4ecVSXh9mKc8IxtCv8v8D6hi"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NcNuMU8oL4ecVSXh9mKc8IxtCv8v8D6hi
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
In-Reply-To: <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 04:00 PM, Max Reitz wrote:

>> Tested by setting up an NBD server with export 'foo', then invoking:
>> $ ./qemu-io
>> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/foo=


By the way, I'd LOVE to know if there is a way to write a qemu-io
command line that would do this connection automatically (so that I can
batch commands up front and benefit from the shell's history) rather
than having to issue an 'open' after the fact.  I tried various
incantations with --object and --image-opts, but got stumped.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NcNuMU8oL4ecVSXh9mKc8IxtCv8v8D6hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRzfgAAoJEKeha0olJ0NqfX4H/2OJwkAeSaTKtfJ59dIswS6B
DMULGg8/4zMdiv0sQpXdT46kEzJ+5KZNA7PD4vIIDOt6oHdftXh0Ane+4eAvpJgl
rmaTilyD8DXFgVdgB4dIfCWkRqlC6YR0OIBWxFIZ4Cx+5d7MgmJ6lK3qkyqT3vCS
dhKrUsWmuK+LUQd1FNLJNX+rlQ5JQPDXwjoxix4jXol5T+ZseN9Ubi6DvNdnHm+u
/UpI6NWLwlOg2LlPGAamiU+5oc8FGCOh5bYekJyyZJpTE7HjeADWXMRjXfYURJ5l
Xdw3FceN3LbpZ9SdoBoz7eUJjFMAQfSubuNZ6JQ4rZyA51TVcvZEJTqozpcUeoM=
=zqwK
-----END PGP SIGNATURE-----

--NcNuMU8oL4ecVSXh9mKc8IxtCv8v8D6hi--
