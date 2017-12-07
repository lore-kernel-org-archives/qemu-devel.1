Received: from eggs.gnu.org ([2001:4830:134:3::10]:56562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4Bl-0001Lw-Ko
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4Bh-0007ai-35
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:58:41 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-10-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80a991ec-26ad-c65f-bd15-6a5fc82c6e57@redhat.com>
Date: Thu, 7 Dec 2017 15:58:21 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-10-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rdXfQhBpT68JnS4oEHtb9vugkADuGUOWi"
Subject: Re: [Qemu-devel] [PATCH v2 9/9] qemu-iotests: add 202 external
 snapshots IOThread test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rdXfQhBpT68JnS4oEHtb9vugkADuGUOWi
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <80a991ec-26ad-c65f-bd15-6a5fc82c6e57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] qemu-iotests: add 202 external
 snapshots IOThread test
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-10-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-10-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> QMP 'transaction' blockdev-snapshot-sync with multiple disks in an
> IOThread is an untested code path.  Several bugs have been found in
> connection with this command.  This patch adds a test case to prevent
> future regressions.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/202     | 95 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/202.out | 11 ++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100755 tests/qemu-iotests/202
>  create mode 100644 tests/qemu-iotests/202.out
>=20

> +# Creator/Owner: Stefan Hajnoczi <stefanha@redhat.com>

There's another cleanup series posted that drops these sorts of lines in
favor of git history.

> +++ b/tests/qemu-iotests/202.out
> @@ -0,0 +1,11 @@
> +Launching VM...
> +Adding IOThread...
> +{u'return': {}}
> +Adding blockdevs...
> +{u'return': {}}
> +{u'return': {}}
> +Setting iothread...
> +{u'return': {}}
> +{u'return': {}}
> +Creating external snapshots...
> +{u'return': {}}

Yay - a python test with sane output - if I had to, I could actually
debug this test without too much effort!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rdXfQhBpT68JnS4oEHtb9vugkADuGUOWi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopuX0ACgkQp6FrSiUn
Q2rZyQgAlz9vqucbuR0ndYZ9b+AUkaKsl2VZfXCriUwy3AK2T1o/LOhf1n2jTB5t
ObhOj9SovHXYxpulOqxzAAJw6kWTBcKA8XrCKiWX9Z0/Q5GCL3r7yonIdCxxyat0
7VsPFR98KZJNSKvGeKB8nic1ey2RdJK9RknOn2Bpio6usrBEGd1dFNxtqnU/37JY
HJjV49U+5Wbs/sWL4Lo3UKWm5CS0LplmuePSSQplvh56sNSGw1SndVozBHl7k43E
TLtHzDNMtyITPXx509UOoXCrT8giaRCe+Z3A0QQFzPJiyOV0lD8a9I2rjeqRCpIw
gRv0oObHtl49BkhNPJHrdH3m1h/XcQ==
=41bd
-----END PGP SIGNATURE-----

--rdXfQhBpT68JnS4oEHtb9vugkADuGUOWi--
