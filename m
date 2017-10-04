Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZKb-00087R-D3
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZKa-0005pY-Jr
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:22:41 -0400
References: <150708336622.147.16727017734840064391@b58463cdfd5f>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d6f852d-5186-e488-2f32-861ce5f69c79@redhat.com>
Date: Tue, 3 Oct 2017 21:22:26 -0500
MIME-Version: 1.0
In-Reply-To: <150708336622.147.16727017734840064391@b58463cdfd5f>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kt2ndBrAbAs5HRxBr7ccDnPEKq0eKOC21"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] block: Avoid copy-on-read assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kt2ndBrAbAs5HRxBr7ccDnPEKq0eKOC21
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <7d6f852d-5186-e488-2f32-861ce5f69c79@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] block: Avoid copy-on-read assertions
References: <150708336622.147.16727017734840064391@b58463cdfd5f>
In-Reply-To: <150708336622.147.16727017734840064391@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/03/2017 09:16 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

> 195         [not run] not suitable for this image format: raw
> 197         - output mismatch (see 197.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/197.out	2017-10-04 01:52:59.0=
00000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/197.out.bad	2017-10-04 02:1=
5:52.212004491 +0000
> @@ -12,13 +12,18 @@
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 0/0 bytes at offset 0
>  0 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -read 2147483136/2147483136 bytes at offset 1024
> -2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +(process:16284): GLib-ERROR **: gmem.c:100: failed to allocate 2147483=
136 bytes

Okay, a test that requires a nearly-2G read in one operation is fringe,
and I can see it choking 32-bit platforms rather easily.  How do we
modify the test to not be so mean to memory-starved systems?  And why
didn't patchew complain about this on v1, which had the same ~2G read?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Kt2ndBrAbAs5HRxBr7ccDnPEKq0eKOC21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnUReIACgkQp6FrSiUn
Q2p9iQf/Z2IiUz/kqgKePiudO5ScY5K/7H0HJBAV9U/4/NBmnNA+1zYCylzATggm
2R0sk7OCYyc0MHDaJasOslguOHhb54JMEVQlDnx//VRktZU/ADxx32KGchU5Rxwz
sHhb5JcnqRCrTlXFHmK866jax9QO57/JF9xlS1Jv061XcWqAaKIeo+O3nnyb9ClQ
Fmv1lPI3jAD5HRRNa+R91Zl9Yj5AkdWUZ14wLrHPHxRD6pLOGiv+B+hRgaqi0FxA
06vtVzlXLTH1FbZjXySjLenznhxS5Y66wfHZYjS/fTHOXv21fDk+H+LWU19r9vFN
5dVN6mxfPrgLxLXnPfc4pblE13glxQ==
=9E0F
-----END PGP SIGNATURE-----

--Kt2ndBrAbAs5HRxBr7ccDnPEKq0eKOC21--
