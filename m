Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hzzhan9@gmail.com>) id 1fU0bF-0006Ce-5i
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 22:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hzzhan9@gmail.com>) id 1fU0bB-0000Bf-3o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 22:05:57 -0400
Date: Sat, 16 Jun 2018 10:05:28 +0800
From: Haozhong Zhang <hzzhan9@gmail.com>
Message-ID: <20180616020528.sz7luae4axtlupai@HZ>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bmpmajvu42jt7q4l"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-12-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nvdimm: allow setting the
 label-size to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


--bmpmajvu42jt7q4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06/15/18 16:04, David Hildenbrand wrote:
> It is inititally 0, so setting it to 0 should be allowed, too.

I'm fine with this change and believe nothing is broken in practice,
but what is expected by the user who sets a zero label size?

Look at nvdimm_dsm_device() which enables label DSMs only if the label
size is not smaller than 128 KB. If a user sets a zero label size
explicitly, does he/she expect those label DSMs are available in
guest?  (according to Intel spec, the minimal label size is 128
KBytes)

I think if it's allowed to set a zero label-size, it would be better
to document its difference from other non-zero values in docs/nvdimm.txt.

Thanks,
Haozhong

>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db7d8c3050..df7646488b 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -52,9 +52,9 @@ static void nvdimm_set_label_size(Object *obj, Visitor =
*v, const char *name,
>      if (local_err) {
>          goto out;
>      }
> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
> +    if (value && value < MIN_NAMESPACE_LABEL_SIZE) {
>          error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is requ=
ired"
> -                   " at least 0x%lx", object_get_typename(obj),
> +                   " either 0 or at least 0x%lx", object_get_typename(ob=
j),
>                     name, value, MIN_NAMESPACE_LABEL_SIZE);
>          goto out;
>      }
> --=20
> 2.17.1
>=20
>=20


--bmpmajvu42jt7q4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9A2n0Sq9CPUvBJWWSn3ETy7JRYFAlskcGgACgkQWSn3ETy7
JRaUUA//Y27zY8nI9qsyXEcmJ9uEN6JIwXGPUxHFjk720+43wUJygHFoGPfJPdao
qJmv4w0kwfvbzDcupFvOQ/1vm0lgadoGfHfQSchvrnUyp1+0Xe0OCt6uMFSxJffd
QKy61JxTzMmm64FQM2+k8MY2CP8+QRVrbiZsh8CSJ5M0nZqHTiUIc9+sQxOuzzTA
4tYJCJ6IEbPG1IbNZNhBIPv5bM6wn8XkMPGVggUKamroJjmdQa601S7uReQxwnrb
blb4eOCNysCRn9pPpbzXGOeIhvpVsJJVmFWnUi3C18x97ajGTsbX1r3zUhPeFjkk
jB36OvMFzesTyqju27r8T1RDsuVQHAucWCx21GFL4qYE8Xx4M/xOoTvKCI4iRmCL
I9U64iiajFVADyaDx82Br6aavVe5pPz7vVLM6GaV86e2jI2aI633Dmp3f/KCSi8X
LC7h+SnHO+L61reW42jcJurNiV98QsIUauARCzfMeSz4WUypse2sgPPltGOiVg9D
yAhj6MTAQ8ftfceeYT8SdCHs45emOaaXyHDDYFZD8lS4RupmzS0gPT8DaQu4Cyta
j1qYf2J2FcDi9ewOzkemBrAyC588YS3/OD8tGXyyiwfkcdTKiRaXrSLvBKxsMwCF
JnjHnfMtcT9JG35+QJU/CcDlesD3zOZUebNzZBCoP1lHSe3ktbQ=
=r7ZM
-----END PGP SIGNATURE-----

--bmpmajvu42jt7q4l--
