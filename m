Received: from eggs.gnu.org ([2001:4830:134:3::10]:59360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGgV-00039u-Lh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGgR-00005R-Mj
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:46:19 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:48565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGgR-0008VA-Gt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:46:15 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 11DED103506
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:46:14 +0200 (CEST)
Date: Tue, 6 Jun 2017 17:46:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170606174607.36654ac1@bahia.ttt.fr.ibm.com>
In-Reply-To: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uOA1oXhD.o7fmyFjUhWer9o";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] target/ppc: pass const
 pointer to kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/uOA1oXhD.o7fmyFjUhWer9o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Jun 2017 17:22:48 +0200
Greg Kurz <groug@kaod.org> wrote:

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/kvm.c     |    4 ++--
>  target/ppc/kvm_ppc.h |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51249ce79e55..88817620766c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -478,7 +478,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
>  }
> =20
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      Object *mem_obj =3D object_resolve_path(obj_path, NULL);
>      char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL);
> @@ -499,7 +499,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *c=
pu)
>  {
>  }
> =20
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      return true;
>  }
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f48243d13ffc..fd72d6b05a98 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -64,7 +64,7 @@ int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> =20
> -bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
> +bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> =20
>  #else
>=20

Dumb me forgot to patch the inline stub... Will send a v2 for this patch on=
ly.

--Sig_/uOA1oXhD.o7fmyFjUhWer9o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk2zj8ACgkQAvw66wEB28L9ZgCeN5cCXZL3ynUDA9TDx2kkDoTl
dKwAn2Qxm2UVV62AHqibvYpr2Et4HRbv
=/aM4
-----END PGP SIGNATURE-----

--Sig_/uOA1oXhD.o7fmyFjUhWer9o--
