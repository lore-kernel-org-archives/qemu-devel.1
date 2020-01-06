Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB00C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C27C2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C27C2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioSfd-0006Bm-JF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioSf3-0005lk-78
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioSf1-0007mj-Db
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:43:12 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:38182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioSf1-0007m0-70
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:43:11 -0500
Received: from player761.ha.ovh.net (unknown [10.108.35.211])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7770C1B744C
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 14:43:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id CBE6DDE5691D;
 Mon,  6 Jan 2020 13:43:01 +0000 (UTC)
Date: Mon, 6 Jan 2020 14:42:54 +0100
From: Greg Kurz <groug@kaod.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Message-ID: <20200106144254.79920ae7@bahia.lan>
In-Reply-To: <20191219004251.23763-1-sstabellini@kernel.org>
References: <20191219004251.23763-1-sstabellini@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 4137119211111094705
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 16:42:51 -0800
Stefano Stabellini <sstabellini@kernel.org> wrote:

> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
>=20
> init_in_iov_from_pdu might not be able to allocate the full buffer size
> requested, which comes from the client and could be larger than the
> transport has available at the time of the request. Specifically, this
> can happen with read operations, with the client requesting a read up to
> the max allowed, which might be more than the transport has available at
> the time.
>=20
> Today the implementation of init_in_iov_from_pdu throws an error, both
> Xen and Virtio.
>=20
> Instead, change the V9fsTransport interface so that the size becomes a
> pointer and can be limited by the implementation of
> init_in_iov_from_pdu.
>=20
> Change both the Xen and Virtio implementations to set the size to the
> size of the buffer they managed to allocate, instead of throwing an
> error.
>=20
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> CC: groug@kaod.org
> CC: anthony.perard@citrix.com
> ---
>  hw/9pfs/9p.c               | 22 +++++++++++++++-------
>  hw/9pfs/9p.h               |  2 +-
>  hw/9pfs/virtio-9p-device.c | 10 +++-------
>  hw/9pfs/xen-9p-backend.c   | 12 ++++--------
>  4 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index bdf7919abf..d6c89ce608 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1682,22 +1682,30 @@ out_nofid:
>   * with qemu_iovec_destroy().
>   */
>  static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
> -                                    size_t skip, size_t size,
> +                                    size_t skip, size_t *size,
>                                      bool is_write)
>  {
>      QEMUIOVector elem;
>      struct iovec *iov;
>      unsigned int niov;
> +    size_t alloc_size =3D *size + skip;
> =20
>      if (is_write) {
> -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size =
+ skip);
> +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, alloc=
_size);
>      } else {
> -        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size +=
 skip);
> +        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, &alloc=
_size);
> +    }
> +
> +    if (alloc_size < skip)
> +    {
> +        *size =3D 0;
> +    } else {
> +        *size =3D alloc_size - skip;
>      }
>      qemu_iovec_init_external(&elem, iov, niov);
>      qemu_iovec_init(qiov, niov);
> -    qemu_iovec_concat(qiov, &elem, skip, size);
> +    qemu_iovec_concat(qiov, &elem, skip, *size);
>  }
> =20
>  static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fid=
p,
> @@ -1722,7 +1730,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *p=
du, V9fsFidState *fidp,
>      }
>      offset +=3D err;
> =20
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);


>      err =3D v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
>                      ((char *)fidp->fs.xattr.value) + off,
>                      read_count);
> @@ -1852,7 +1860,7 @@ static void coroutine_fn v9fs_read(void *opaque)
>          QEMUIOVector qiov;
>          int32_t len;
> =20
> -        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count, =
false);
> +        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &max_count,=
 false);

This doesn't build:

hw/9pfs/9p.c: In function =E2=80=98v9fs_read=E2=80=99:
hw/9pfs/9p.c:2271:62: error: passing argument 4 of =E2=80=98v9fs_init_qiov_=
from_pdu=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-po=
inter-types]
 2271 |         v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &max_c=
ount, false);
      |                                                              ^~~~~~=
~~~~
      |                                                              |
      |                                                              uint32=
_t * {aka unsigned int *}
hw/9pfs/9p.c:2093:58: note: expected =E2=80=98size_t *=E2=80=99 {aka =E2=80=
=98long unsigned int *=E2=80=99} but argument is of type =E2=80=98uint32_t =
*=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99}
 2093 |                                     size_t skip, size_t *size,
      |                                                  ~~~~~~~~^~~~

>          qemu_iovec_init(&qiov, qiov_full.niov);
>          do {
>              qemu_iovec_reset(&qiov);
> @@ -2085,7 +2093,7 @@ static void coroutine_fn v9fs_write(void *opaque)
>          return;
>      }
>      offset +=3D err;
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &count, true);

Same here.

hw/9pfs/9p.c: In function =E2=80=98v9fs_write=E2=80=99:
hw/9pfs/9p.c:2527:54: error: passing argument 4 of =E2=80=98v9fs_init_qiov_=
from_pdu=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-po=
inter-types]
 2527 |     v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &count, true);
      |                                                      ^~~~~~
      |                                                      |
      |                                                      uint32_t * {ak=
a unsigned int *}
hw/9pfs/9p.c:2093:58: note: expected =E2=80=98size_t *=E2=80=99 {aka =E2=80=
=98long unsigned int *=E2=80=99} but argument is of type =E2=80=98uint32_t =
*=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99}
 2093 |                                     size_t skip, size_t *size,
      |                                                  ~~~~~~~~^~~~

>      trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
> =20
>      fidp =3D get_fid(pdu, fid);
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 8883761b2c..50f7e21da6 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -365,7 +365,7 @@ struct V9fsTransport {
>      ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const cha=
r *fmt,
>                                    va_list ap);
>      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pio=
v,
> -                                        unsigned int *pniov, size_t size=
);
> +                                        unsigned int *pniov, size_t *siz=
e);
>      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pi=
ov,
>                                           unsigned int *pniov, size_t siz=
e);
>      void        (*push_and_notify)(V9fsPDU *pdu);
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 775e8ff766..68873c3f5f 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, =
size_t offset,
>  }
> =20
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **pio=
v,
> -                                        unsigned int *pniov, size_t size)
> +                                        unsigned int *pniov, size_t *siz=
e)
>  {
>      V9fsState *s =3D pdu->s;
>      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem =3D v->elems[pdu->idx];
>      size_t buf_size =3D iov_size(elem->in_sg, elem->in_num);
> =20
> -    if (buf_size < size) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has %=
zu",
> -                     pdu->id + 1, size, buf_size);
> +    if (buf_size < *size) {
> +        *size =3D buf_size;
>      }

As suggested by Christian in some other mail, it could still make sense to
raise the error if there isn't even enough space to pack a 9p message heade=
r.

> =20
> =20
>      *piov =3D elem->in_sg;
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 3f54a21c76..3994a356d4 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -187,7 +187,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *p=
du,
>  static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>                                            struct iovec **piov,
>                                            unsigned int *pniov,
> -                                          size_t size)
> +                                          size_t *size)
>  {
>      Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
> @@ -197,15 +197,11 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *=
pdu,
>      g_free(ring->sg);
> =20
>      ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
> -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> =20

This chunk doesn't apply on master:

<<<<<<<
    ring->sg =3D g_new0(struct iovec, 2);
    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
=3D=3D=3D=3D=3D=3D=3D
    ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
>>>>>>>


>      buf_size =3D iov_size(ring->sg, num);
> -    if (buf_size  < size) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> -                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
> -                buf_size);
> -        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> +    if (buf_size  < *size) {
> +        *size =3D buf_size;
>      }
> =20
>      *piov =3D ring->sg;


