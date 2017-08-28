Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMCm-00036z-Eo
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMCi-0008Ou-I4
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:44:00 -0400
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
	<20170827230506.12683-2-samuel.thibault@ens-lyon.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c95c64ee-f9c7-7e58-a4fd-aff76b78a82c@redhat.com>
Date: Mon, 28 Aug 2017 10:43:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170827230506.12683-2-samuel.thibault@ens-lyon.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gJ1MPer5sTOFQU6aNfKwxh5JCfhIt29Jq"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gJ1MPer5sTOFQU6aNfKwxh5JCfhIt29Jq
From: Eric Blake <eblake@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <c95c64ee-f9c7-7e58-a4fd-aff76b78a82c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix clearing ifq_so from pending
 packets
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
 <20170827230506.12683-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170827230506.12683-2-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2017 06:05 PM, Samuel Thibault wrote:
> The if_fastq and if_batchq contain not only packets, but queues of pack=
ets
> for the same socket. When sofree frees a socket, it thus has to clear i=
fq_so
> from all the packets from the queues, not only the first.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  slirp/socket.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)

This is a pull request, but missed 2.10-rc4, which makes it really hard
to justify for inclusion in 2.10 proper.  Is it okay that this doesn't
go in until 2.11? I've added qemu-stable, so it can also be queued for
2.10.1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gJ1MPer5sTOFQU6aNfKwxh5JCfhIt29Jq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmkOjQACgkQp6FrSiUn
Q2qktwf/WJj2ERP+0HY/gkEJk62SeCYySfBFdSJ6iIV7CnqvlNKkT17a37fF9A+7
JNNUFH5G1zmnsz2SZXvUt676xyPOG2Xdo6mmqylhTnoKUZQ8wldnUCc6ZGB05YsH
KuiqbspWjk07QCQOd789x9xYtnOuO3/aftTC7ToMJmaV+XjUgrpALchJzyKrngTF
LFXh1h81FwKqSEWglQZpwX/Bgwdo6LtxUGD2Bbi4MBxmK9YGyrLx3O1hsFD+9a8j
XwjrBp0mbYRPR36/x2bYJY3V+MyxYLQtQMv7/lBdssKu+JaXABAdfoY048TmtD6B
AtZ1hf+4g2kixJepk7leHxofXIRN7g==
=o8D0
-----END PGP SIGNATURE-----

--gJ1MPer5sTOFQU6aNfKwxh5JCfhIt29Jq--
