Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C44B206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e47SDF7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C44B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPAB-0004Iz-Bt
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjP4i-0000tw-4v
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:25:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjP4e-0006Kf-Oj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591889099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbUQwYQfxNKQCbkVrBbB3nMAj6VL4y5Tr8/PECNnBTw=;
 b=e47SDF7mm/iDc/G0JQAZ7BB1hFvxQj08I0AQgNOs49QLrTAcvd3/qMO8g2Fp4DvrJ+taD7
 o1x3BWVMiakWITDfKx4rJ/A1Tp5PVjjwmHjevkl3B4g+r+8SnyoPIfr3j1jmu31uRZAmmA
 0733eiI5Q1gtOObXoShAc5DuRM3n89E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-G1L15-s_NV6C-qlwm_DVqw-1; Thu, 11 Jun 2020 11:24:55 -0400
X-MC-Unique: G1L15-s_NV6C-qlwm_DVqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 477F11005513;
 Thu, 11 Jun 2020 15:24:54 +0000 (UTC)
Received: from localhost (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF0C982032;
 Thu, 11 Jun 2020 15:24:53 +0000 (UTC)
Date: Thu, 11 Jun 2020 16:24:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v8 3/4] vhost-user block device backend server
Message-ID: <20200611152452.GC77457@stefanha-x1.localdomain>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-4-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200604233538.256325-4-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 07:35:37AM +0800, Coiby Xu wrote:
> +static void coroutine_fn vu_block_virtio_process_req(void *opaque)
> +{
> +    struct req_data *data = opaque;
> +    VuServer *server = data->server;
> +    VuVirtq *vq = data->vq;
> +    VuVirtqElement *elem = data->elem;
> +    uint32_t type;
> +    VuBlockReq *req;
> +
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(server);
> +    BlockBackend *backend = vdev_blk->backend;
> +
> +    struct iovec *in_iov = elem->in_sg;
> +    struct iovec *out_iov = elem->out_sg;
> +    unsigned in_num = elem->in_num;
> +    unsigned out_num = elem->out_num;
> +    /* refer to hw/block/virtio_blk.c */
> +    if (elem->out_num < 1 || elem->in_num < 1) {
> +        error_report("virtio-blk request missing headers");
> +        free(elem);
> +        return;
> +    }
> +
> +    req = g_new0(VuBlockReq, 1);

elem was allocated with enough space for VuBlockReq. Can this allocation
be eliminated?

  typedef struct VuBlockReq {
-     VuVirtqElement *elem;
+     VuVirtqElement elem;
      int64_t sector_num;
      size_t size;
      struct virtio_blk_inhdr *in;
      struct virtio_blk_outhdr out;
      VuServer *server;
      struct VuVirtq *vq;
  } VuBlockReq;

  req = vu_queue_pop(vu_dev, vq, sizeof(*req));

> +    req->server = server;
> +    req->vq = vq;
> +    req->elem = elem;
> +
> +    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
> +                            sizeof(req->out)) != sizeof(req->out))) {
> +        error_report("virtio-blk request outhdr too short");
> +        goto err;
> +    }
> +
> +    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
> +
> +    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> +        error_report("virtio-blk request inhdr too short");
> +        goto err;
> +    }
> +
> +    /* We always touch the last byte, so just see how big in_iov is.  */
> +    req->in = (void *)in_iov[in_num - 1].iov_base
> +              + in_iov[in_num - 1].iov_len
> +              - sizeof(struct virtio_blk_inhdr);
> +    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> +
> +
> +    type = le32toh(req->out.type);

This implementation assumes the request is always little-endian. This is
true for VIRTIO 1.0+ but not for older versions. Please check that
VIRTIO_F_VERSION_1 has been set.

In QEMU code the le32_to_cpu(), le64_to_cpu(), etc are common used
instead of le32toh(), etc.

> +    switch (type & ~VIRTIO_BLK_T_BARRIER) {
> +    case VIRTIO_BLK_T_IN:
> +    case VIRTIO_BLK_T_OUT: {
> +        ssize_t ret = 0;
> +        bool is_write = type & VIRTIO_BLK_T_OUT;
> +        req->sector_num = le64toh(req->out.sector);
> +
> +        int64_t offset = req->sector_num * vdev_blk->blk_size;
> +        QEMUIOVector *qiov = g_new0(QEMUIOVector, 1);

This can be allocated on the stack:

  QEMUIOVector qiov;

> +static void vhost_user_blk_server_free(VuBlockDev *vu_block_device)
> +{

I'm unsure why this is a separate from vu_block_free(). Neither of these
functions actually free VuBlockDev, so the name could be changed to
vhost_user_blk_server_stop().

> +    if (!vu_block_device) {
> +        return;
> +    }
> +    vhost_user_server_stop(&vu_block_device->vu_server);
> +    vu_block_free(vu_block_device);
> +
> +}
> +
> +/*
> + * A exported drive can serve multiple multiple clients simutateously,
> + * thus no need to export the same drive twice.

This comment is outdated. Only one client is served at a time.

> +static void vhost_user_blk_server_start(VuBlockDev *vu_block_device,
> +                                        Error **errp)
> +{
> +
> +    const char *name = vu_block_device->node_name;
> +    SocketAddress *addr = vu_block_device->addr;
> +    char *unix_socket = vu_block_device->addr->u.q_unix.path;
> +
> +    if (vu_block_dev_find(name)) {
> +        error_setg(errp, "Vhost-user-blk server with node-name '%s' "
> +                   "has already been started",
> +                   name);
> +        return;
> +    }

I think blk_new() permissions should prevent multiple writers. Having
multiple readers would be okay. Therefore this check can be removed.

> +
> +    if (vu_block_dev_find_by_unix_socket(unix_socket)) {
> +        error_setg(errp, "Vhost-user-blk server with with socket_path '%s' "
> +                   "has already been started", unix_socket);
> +        return;
> +    }

Is it a problem if the same path is reused? I don't see an issue if the
user creates a vhost-user-blk server, connects a client, unlinks the
UNIX domain socket, and creates a new vhost-user-blk server with the
same path. It might be a little confusing but if the user wants to do
it, I don't see a reason to stop them.

> +
> +    if (!vu_block_init(vu_block_device, errp)) {
> +        return;
> +    }
> +
> +
> +    AioContext *ctx = bdrv_get_aio_context(blk_bs(vu_block_device->backend));
> +
> +    if (!vhost_user_server_start(VHOST_USER_BLK_MAX_QUEUES, addr, ctx,
> +                                 &vu_block_device->vu_server,
> +                                 NULL, &vu_block_iface,
> +                                 errp)) {

In the previous patch I mentioned that calling g_free(server) is
probably unexpected and here is an example of why that can be a problem.
vu_server is a struct field, not an independent heap-allocated object,
so calling g_free(server) will result in undefined behavior (freeing an
object that was not allocated with g_new()).

> +        goto error;
> +    }
> +
> +    QTAILQ_INSERT_TAIL(&vu_block_devs, vu_block_device, next);
> +    blk_add_aio_context_notifier(vu_block_device->backend, blk_aio_attached,
> +                                 blk_aio_detach, vu_block_device);
> +    return;
> +
> + error:
> +    vu_block_free(vu_block_device);
> +}
> +
> +static void vu_set_node_name(Object *obj, const char *value, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    if (vus->node_name) {
> +        error_setg(errp, "evdev property already set");
> +        return;
> +    }

Setting it twice is okay, we just need to g_free(vus->node_name).

> +
> +    vus->node_name = g_strdup(value);
> +}
> +
> +static char *vu_get_node_name(Object *obj, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +    return g_strdup(vus->node_name);
> +}
> +
> +
> +static void vu_set_unix_socket(Object *obj, const char *value,
> +                               Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    if (vus->addr) {
> +        error_setg(errp, "unix_socket property already set");
> +        return;
> +    }

Setting it twice is okay, we just need to
g_free(vus->addr->u.q_unix.path) and g_free(vus->addr).

> +static void vu_set_blk_size(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    VuBlockDev *vus = VHOST_USER_BLK_SERVER(obj);
> +
> +    Error *local_err = NULL;
> +    uint32_t value;
> +
> +    visit_type_uint32(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    if (value != BDRV_SECTOR_SIZE && value != 4096) {
> +        error_setg(&local_err,
> +                   "Property '%s.%s' can only take value 512 or 4096",
> +                   object_get_typename(obj), name);
> +        goto out;
> +    }

Please see hw/core/qdev-properties.c:set_blocksize() for input
validation checks (min=512, max=32768, must be a power of 2). This code
can be moved into a common utility function so that both
hw/core/qdev-properties.c and vhost-user-blk-server.c can use it.

> +
> +    vus->blk_size = value;
> +
> +out:
> +    error_propagate(errp, local_err);
> +    vus->blk_size = value;
> +}
> +
> +
> +static void vhost_user_blk_server_instance_finalize(Object *obj)
> +{
> +    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> +
> +    vhost_user_blk_server_free(vub);
> +}
> +
> +static void vhost_user_blk_server_complete(UserCreatable *obj, Error **errp)
> +{
> +    Error *local_error = NULL;
> +    VuBlockDev *vub = VHOST_USER_BLK_SERVER(obj);
> +
> +    vhost_user_blk_server_start(vub, &local_error);

After this call succeeds the properties should become read-only
("writable", "node-name", "unix-socket", etc) to prevent modification at
runtime.

I think the easiest way to do that is by keeping a bool field in
VuBlockDev that the property setter functions can check.

> +
> +    if (local_error) {
> +        error_propagate(errp, local_error);
> +        return;
> +    }
> +}
> +
> +static void vhost_user_blk_server_class_init(ObjectClass *klass,
> +                                             void *class_data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
> +    ucc->complete = vhost_user_blk_server_complete;
> +
> +    object_class_property_add_bool(klass, "writable",
> +                                   vu_get_block_writable,
> +                                   vu_set_block_writable);
> +
> +    object_class_property_add_str(klass, "node-name",
> +                                  vu_get_node_name,
> +                                  vu_set_node_name);
> +
> +    object_class_property_add_str(klass, "unix-socket",
> +                                  vu_get_unix_socket,
> +                                  vu_set_unix_socket);
> +
> +    object_class_property_add(klass, "blk-size", "uint32",
> +                              vu_get_blk_size, vu_set_blk_size,
> +                              NULL, NULL);

include/hw/block/block.h:DEFINE_BLOCK_PROPERTIES_BASE calls this
property "logical_block_size". Please use the same name for consistency.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7iTMQACgkQnKSrs4Gr
c8hZDgf/coVV03SODvtkyJ0rW27i16pCAVqD+X/T1uAPDZSTXMpJGkdoA+3VP21c
qthjxsvIHIMkAWI6GA6WFX9ylRF3AD8GvOSKc1Ui2IDycuul/bx82q2/lOHaDrnr
7aspO4Yj6Dm+A2847kv0PVtn1okJ2ZJgERDts40QQ8JZyFfEuCp37OeR4jxjyrJ4
4SNyUnyx24EvJRGLe48EXYoAD20wPlHRW0G7tNWWeOqe3eow+oKyfaEevMK5BNj6
XUsLwcakIP/1ESuI3DkAx6icWxxk2iGXMLFm9swyFPYjwL1+To8gBIqIMQD/m3VS
9s9Ld5BHsK2euO+V86rnQIAv754Ndw==
=5VNZ
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--


