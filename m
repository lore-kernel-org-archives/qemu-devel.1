Received: from eggs.gnu.org ([2001:4830:134:3::10]:48430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1drWUi-0008HC-4c
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1drWUd-0007i5-LK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:52 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:39021)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1drWUd-0007dQ-Dy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:47 -0400
Date: Mon, 11 Sep 2017 22:43:43 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170911214343.GC17077@jhogan-linux.le.imgtec.org>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
	<e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v4 6/8] target/mips: Convert VM clock
 update prints to warn_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 12:52:59PM -0700, Alistair Francis wrote:
> Convert the fprintf() messages in kvm_mips_update_state() to use
> warn_report() as they aren't errors, but are just warnings.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: James Hogan <james.hogan@imgtec.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>=20
>  target/mips/kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index a23aa438d2..3b7b1d962a 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -526,7 +526,7 @@ static void kvm_mips_update_state(void *opaque, int r=
unning, RunState state)
>          if (!cs->vcpu_dirty) {
>              ret =3D kvm_mips_save_count(cs);
>              if (ret < 0) {
> -                fprintf(stderr, "Failed saving count\n");
> +                warn_report("Failed saving count");
>              }
>          }
>      } else {
> @@ -535,14 +535,14 @@ static void kvm_mips_update_state(void *opaque, int=
 running, RunState state)
>          ret =3D kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_RESUME,
>                                        &count_resume);
>          if (ret < 0) {
> -            fprintf(stderr, "Failed setting COUNT_RESUME\n");
> +            warn_report("Failed setting COUNT_RESUME");
>              return;
>          }
> =20
>          if (!cs->vcpu_dirty) {
>              ret =3D kvm_mips_restore_count(cs);
>              if (ret < 0) {
> -                fprintf(stderr, "Failed restoring count\n");
> +                warn_report("Failed restoring count");
>              }
>          }
>      }
> --=20
> 2.11.0
>=20

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlm3A4gACgkQbAtpk944
dnoHKRAAnzS2tky9R7fJFJwETDenimEHu4W0O5wYwnekH8Rg+le1iS/19g53tMbo
B2e+WzUsRKcQDxcQqPwJdJsT80mX/0of057q4cIMKnJfF4vQdsacQzgui5KSEH7Z
SGGCicMv2OX6NJw3K+Jr9JhIfsk2zbHnLt86e5NAQ3yxFkHZpd5oy619Kmeucnkp
Au+FV5NjTnIlqI8Upm/1QMNMjRYa1s24awRdGN6cQPTEORqEudoBZBKMOFgKKtGV
dCj8XHlih2cNgpMEhmoqBmhqkb1pfYmn0u6jToiUJ1bJZwKpVoiVm8y0LyVBPlfU
4BFxkLWhqhC2FCprSZSRK/MF/oz4QRRYuqm/5t4tDfoDugYk8P3NiD6ZbXGXdekl
sakQxzLQ/cnjCZ0S6a9k9c9HoUJC01j5f4xayOh/sdbB81cJWxM6mqmQDuv6SZhN
ixXbtnVokZ8f56MJLreIJ+RdKleaX4dPXMZDBb0wU9qNfQyqmN9XO9rhep8Z3AzW
5hl5QqtJFeCcZOyCHdhV/D6t9r/TPF/wzzl+4Xrjiy5kVIzGWZokdOd8HkhpGzHL
fxwahW2smF0wY+6p99UJ3LW03OxwBmhFbvrbAJhdjd5n4D72i82NcsRNYMgGBSwC
DJKBrhlHMWlLIl46Rdg/QV1Oo2ZA4kTzy8Y0Lztx2ZJyiY0fj7g=
=ttNe
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
