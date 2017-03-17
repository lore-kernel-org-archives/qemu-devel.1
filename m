Received: from eggs.gnu.org ([2001:4830:134:3::10]:46087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1copsA-0005PJ-BX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cops7-0003r6-MO
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:16:42 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:37527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cops7-0003qW-FF
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:16:39 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3D8911BAEB
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 12:16:38 +0100 (CET)
Date: Fri, 17 Mar 2017 12:16:30 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317121630.503719ec@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489694518-16978-3-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
	<1489694518-16978-3-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//m_V3EkTwWpOrSsbmFvHM30";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/9] 9p: introduce a type for the 9p
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, jgross@suse.com, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_//m_V3EkTwWpOrSsbmFvHM30
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Mar 2017 13:01:52 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Use the new type in virtio-9p-device.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.h               | 6 ++++++
>  hw/9pfs/virtio-9p-device.c | 6 +-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index b7e8362..5312d8a 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -119,6 +119,12 @@ static inline char *rpath(FsContext *ctx, const char=
 *path)
>  typedef struct V9fsPDU V9fsPDU;
>  struct V9fsState;
> =20
> +typedef struct {
> +    uint32_t size_le;
> +    uint8_t id;
> +    uint16_t tag_le;
> +} QEMU_PACKED P9MsgHeader;
> +
>  struct V9fsPDU
>  {
>      uint32_t size;
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 27a4a32..3782f43 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -46,11 +46,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQ=
ueue *vq)
>      VirtQueueElement *elem;
> =20
>      while ((pdu =3D pdu_alloc(s))) {
> -        struct {
> -            uint32_t size_le;
> -            uint8_t id;
> -            uint16_t tag_le;
> -        } QEMU_PACKED out;
> +        P9MsgHeader out;
> =20
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
>          if (!elem) {


--Sig_//m_V3EkTwWpOrSsbmFvHM30
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljLxY4ACgkQAvw66wEB28KyPgCdHpLkKdwftqamgtzuP7g+N0RZ
n30AoKE9+Xev+r4X8sMqEpVeJsZYg21e
=6QYN
-----END PGP SIGNATURE-----

--Sig_//m_V3EkTwWpOrSsbmFvHM30--
