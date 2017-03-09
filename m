Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cm2Gt-0004VK-LI
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cm2Gq-0004dZ-IP
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:54:39 -0500
Received: from mo3.mail-out.ovh.net ([178.32.228.3]:48149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cm2Gq-0004dA-BP
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:54:36 -0500
Received: from player693.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 86DF4B4078
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 18:54:34 +0100 (CET)
Date: Thu, 9 Mar 2017 18:54:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170309185426.3506a17b@bahia>
In-Reply-To: <1488852768-8935-3-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703061807431.17906@sstabellini-ThinkPad-X260>
	<1488852768-8935-1-git-send-email-sstabellini@kernel.org>
	<1488852768-8935-3-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Ort.bac0tQzNmav1Ziw2DyD";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/8] xen/9pfs: introduce Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/Ort.bac0tQzNmav1Ziw2DyD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  6 Mar 2017 18:12:43 -0800
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Introduce the Xen 9pfs backend: add struct XenDevOps to register as a
> Xen backend and add struct V9fsTransport to register as v9fs transport.
>=20
> All functions are empty stubs for now.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/xen-9p-backend.c | 96 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 hw/9pfs/xen-9p-backend.c
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> new file mode 100644
> index 0000000..924fb64
> --- /dev/null
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -0,0 +1,96 @@
> +/*
> + * Xen 9p backend
> + *
> + * Copyright Aporeto 2017
> + *
> + * Authors:
> + *  Stefano Stabellini <stefano@aporeto.com>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/hw.h"
> +#include "hw/9pfs/9p.h"
> +#include "hw/xen/xen_backend.h"
> +#include "xen_9pfs.h"
> +#include "qemu/config-file.h"
> +#include "fsdev/qemu-fsdev.h"
> +
> +struct Xen9pfsDev {
> +    struct XenDevice xendev;  /* must be first */
> +};

According to HACKING, this should be:

typedef struct Xen9pfsDev {
    struct XenDevice xendev;  /* must be first */
} Xen9pfsDev;

and...

> +
> +static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> +                                     size_t offset,
> +                                     const char *fmt,
> +                                     va_list ap)
> +{
> +    return 0;
> +}
> +
> +static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> +                                       size_t offset,
> +                                       const char *fmt,
> +                                       va_list ap)
> +{
> +    return 0;
> +}
> +
> +static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> +                                           struct iovec **piov,
> +                                           unsigned int *pniov)
> +{
> +}
> +
> +static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> +                                          struct iovec **piov,
> +                                          unsigned int *pniov,
> +                                          size_t size)
> +{
> +}
> +
> +static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> +{
> +}
> +
> +static const struct V9fsTransport xen_9p_transport =3D {
> +    .pdu_vmarshal =3D xen_9pfs_pdu_vmarshal,
> +    .pdu_vunmarshal =3D xen_9pfs_pdu_vunmarshal,
> +    .init_in_iov_from_pdu =3D xen_9pfs_init_in_iov_from_pdu,
> +    .init_out_iov_from_pdu =3D xen_9pfs_init_out_iov_from_pdu,
> +    .push_and_notify =3D xen_9pfs_push_and_notify,
> +};
> +
> +static int xen_9pfs_init(struct XenDevice *xendev)
> +{
> +    return 0;
> +}
> +
> +static int xen_9pfs_free(struct XenDevice *xendev)
> +{
> +    return -1;
> +}
> +
> +static int xen_9pfs_connect(struct XenDevice *xendev)
> +{
> +    return 0;
> +}
> +
> +static void xen_9pfs_alloc(struct XenDevice *xendev)
> +{
> +}
> +
> +static void xen_9pfs_disconnect(struct XenDevice *xendev)
> +{
> +}
> +
> +struct XenDevOps xen_9pfs_ops =3D {
> +    .size       =3D sizeof(struct Xen9pfsDev),

... s/struct //

> +    .flags      =3D DEVOPS_FLAG_NEED_GNTDEV,
> +    .alloc      =3D xen_9pfs_alloc,
> +    .init       =3D xen_9pfs_init,
> +    .initialise    =3D xen_9pfs_connect,
> +    .disconnect =3D xen_9pfs_disconnect,
> +    .free       =3D xen_9pfs_free,
> +};

With the above comments addressed:

Reviewed-by: Greg Kurz <groug@kaod.org>

--Sig_/Ort.bac0tQzNmav1Ziw2DyD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljBltMACgkQAvw66wEB28KxDQCeJGYNO7iVhdXZo3nJODzjKv8Q
Z5UAmwTRlPTAiJzqtn8QBKtfTBgJfTeA
=pB1H
-----END PGP SIGNATURE-----

--Sig_/Ort.bac0tQzNmav1Ziw2DyD--
