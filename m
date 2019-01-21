Received: from eggs.gnu.org ([209.51.188.92]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=917a3d296=Paul.Durrant@citrix.com>)
	id 1gld6P-0001wk-Od
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=917a3d296=Paul.Durrant@citrix.com>)
	id 1gld5w-0007ue-5A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:10:46 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:23715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=917a3d296=Paul.Durrant@citrix.com>)
	id 1gld5u-0007hu-9w
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:10:42 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 21 Jan 2019 17:10:25 +0000
Message-ID: <24a54a78a49141f48e430df5fdbcadb0@AMSPEX02CL03.citrite.net>
References: <20190121170713.11906-1-anthony.perard@citrix.com>
In-Reply-To: <20190121170713.11906-1-anthony.perard@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] configure: xen: Stop build-testing for
 xc_domain_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 21 January 2019 17:07
> To: qemu-devel@nongnu.org
> Cc: Stefano Stabellini <sstabellini@kernel.org>; Paul Durrant
> <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org; Anthony Perard
> <anthony.perard@citrix.com>
> Subject: [PATCH] configure: xen: Stop build-testing for xc_domain_create
>=20
> Its last uses was removed by: 6d7c06c213ddcfabcafdc178ccef81736f85a7c2
> "Remove broken Xen PV domain builder".
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  configure | 19 -------------------
>  1 file changed, 19 deletions(-)
>=20
> diff --git a/configure b/configure
> index 98b270974d..8684a6e5ef 100755
> --- a/configure
> +++ b/configure
> @@ -2469,7 +2469,6 @@ int main(void) {
>    xenforeignmemory_handle *xfmem;
>    xenevtchn_handle *xe;
>    xengnttab_handle *xg;
> -  xen_domain_handle_t handle;
>    xengnttab_grant_copy_segment_t* seg =3D NULL;
>=20
>    xs_daemon_open();
> @@ -2479,7 +2478,6 @@ int main(void) {
>    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
>    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
>    xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
> -  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
>=20
>    xfmem =3D xenforeignmemory_open(0, 0);
>    xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
> @@ -2521,7 +2519,6 @@ int main(void) {
>    xenforeignmemory_handle *xfmem;
>    xenevtchn_handle *xe;
>    xengnttab_handle *xg;
> -  xen_domain_handle_t handle;
>=20
>    xs_daemon_open();
>=20
> @@ -2530,7 +2527,6 @@ int main(void) {
>    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
>    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
>    xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
> -  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
>=20
>    xfmem =3D xenforeignmemory_open(0, 0);
>    xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
> @@ -2548,21 +2544,6 @@ EOF
>        then
>        xen_ctrl_version=3D40701
>        xen=3Dyes
> -    elif
> -        cat > $TMPC <<EOF &&
> -#include <xenctrl.h>
> -#include <stdint.h>
> -int main(void) {
> -  xc_interface *xc =3D NULL;
> -  xen_domain_handle_t handle;
> -  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
> -  return 0;
> -}
> -EOF
> -        compile_prog "" "$xen_libs"
> -      then
> -      xen_ctrl_version=3D40700
> -      xen=3Dyes
>=20
>      # Xen 4.6
>      elif
> --
> Anthony PERARD
