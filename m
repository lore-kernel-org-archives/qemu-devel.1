Received: from eggs.gnu.org ([2001:4830:134:3::10]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esddA-0005pP-Q5
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esdd9-0002Yc-DH
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:05:28 -0500
Date: Mon, 5 Mar 2018 10:51:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180304235152.GA2650@umbus.fritz.box>
References: <20180303130226.26906-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20180303130226.26906-1-nia.alarie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] PPC: e500: Add check for NULL return value
 from qemu_find_file.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, agraf@suse.de, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 01:02:26PM +0000, Nia Alarie wrote:
> This prints a message and exits if the e500 BIOS firmware can't
> be found, to avoid dereferencing a null pointer.
>=20
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/e500.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index a40d3ec3e3..6ce03d6ff4 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1005,6 +1005,10 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>          }
>      }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!filename) {
> +        error_report("Could not find firmware '%s'", bios_name);
> +        exit(1);
> +    }
> =20
>      bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadaddr,=
 NULL,
>                           1, PPC_ELF_MACHINE, 0, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqchpYACgkQbDjKyiDZ
s5L88A//WiiWK3kgKK8AHQwTtLJWzhCp+pH6NsXhGsKAWUkiTQ2q05qACZVdVxoj
zcu6VkZupzyBIbKmj9aEoyaUNp+Nk7n9D08d8oXY/VCBeZjLvWr4a9ULK4/k/nIn
avBDcO4/XALdu0IUmbeifBUi9LB9cLe08rXef6U9CXNlbl53uvoQHyOYaoxI1OCu
9kWymJR/ejn9o/Xgn7PUvJYnuUioRUIy0yUt7bui2npTuDAZQzbKQoYePxY/c0j8
dz0/7X1LdqUsvdWu7RN3dpg19p9TA2jHh1HAoYFFW7ti4aaONI/H3BlxnVTJ2v0J
640B3AZ3XJEqBSQe0q3W3Vwe3b8VIR+w+wq+ONawIcz3xwzOKeaGQzJKyxS8wrXm
N+0d25A7tuyG3iKqCjsLt6NJs+hm9dLn/YV0FXJVe3/pY8UnxyymPUj/YeMisMjp
zYt3pwCfRdhxbfxoHzUGb0UR8AFbn7bWX2WlBFN1qY1U773xxuNHjdvOxFAonFOJ
upuRYdQLy7ienzoysD9NzlXamNu5+YOm+PLfDutmt/JyTMY25DIZ0bkqCRz/cWjC
MfYqibCkKPqiVOkkWaaEagR0lJV5qJnQWlAdCNFrTz3R5nuicSOU+1wT2q1Ij+SR
/9hxL1KGHkQ/s/O910075a80eLS18rl5iNzS1zU1zWGZwdwy/q0=
=qIpx
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
