Received: from eggs.gnu.org ([2001:4830:134:3::10]:52740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUzDM-0003up-GK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUzDH-0006Gk-G2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dUzDH-0006FV-8d
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:43 -0400
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
Date: Tue, 11 Jul 2017 19:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hCEUtoASNQXuXkoE1MlkmDRa2ukOBV8a9"
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hCEUtoASNQXuXkoE1MlkmDRa2ukOBV8a9
From: Max Reitz <mreitz@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, armbru@redhat.com
Message-ID: <040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
References: <cover.1499774331.git.alistair.francis@xilinx.com>
 <12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 14:07, Alistair Francis wrote:
> As we don't regard error messages as a stable API the let's add a
> 'error: ' prefix to the original error_report() messages.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>=20
>  util/qemu-error.c | 1 +
>  1 file changed, 1 insertion(+)

This breaks quite a few qemu-iotests.

Max


--hCEUtoASNQXuXkoE1MlkmDRa2ukOBV8a9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZQ6GEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGSt
B/9iz1+0KO/cGEJTJ+wAi28Qn5dwTfY5ud+OqL6LuFW0Tt9EGuFx8CZFP+hjql0O
9q2zTYapG1JjTaV0yL7LXeePrj2i48GXES+w6q/X/KfY8Lu2L3y4pmJgCijqaT44
8UVYg+PebOhFtIZgPtjHBWSLsI2o4ju3YVmOGuZk2RdCk2OP9B4djQ+GScIhwpfr
BDWQyGWqizrXBLQF/muPn4fR6bUjuJBhZ+YRM4tpLVkKWhLpskMCcjBl4uldyR3F
hW3WcwJrzsT0a7BwKbZVNu55Jr1qHmc2cjvPMwUCtUKS0GERuzt7GyEkzR2JXTu5
ieDFLH6i7KAPkSYI0zv6Ix10
=x20+
-----END PGP SIGNATURE-----

--hCEUtoASNQXuXkoE1MlkmDRa2ukOBV8a9--
