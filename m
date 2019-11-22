Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2773720708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeKwlwz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2773720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY64S-0001YT-Bm
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iY621-000779-Ip
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iY61w-0000AV-AK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:19:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iY61w-0000A7-5o
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574417951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKz6EwtPkz9w4YV8v08pcDeP8Ex1Xk7zSoshChN00M4=;
 b=aeKwlwz5Upfaedr3VxnAMoZi7G/T4NFYlQ38feXjEiUg4gAiDVeU0QJ3OeFxDmi0bOwdgd
 k8X3IACPiIxtclDuB5UGFm2oBVCLXGlJl6qVuA00aErjDv8zBmTKFpfurBFQ89QSti7xGr
 buDje+ft7lPEZzg8kTVzUGhQGvR2Jqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-YsxkKQ6xNC-a5P-ywpfXog-1; Fri, 22 Nov 2019 05:19:09 -0500
X-MC-Unique: YsxkKQ6xNC-a5P-ywpfXog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6CB800054;
 Fri, 22 Nov 2019 10:19:08 +0000 (UTC)
Received: from localhost (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2064D6E717;
 Fri, 22 Nov 2019 10:19:04 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:19:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/4] virtiofd: Create a notification queue
Message-ID: <20191122101903.GC464656@stefanha-x1.localdomain>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205543.1816-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: virtio-fs@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:55:41PM -0500, Vivek Goyal wrote:
>  /* Callback from libvhost-user */
>  static void fv_set_features(VuDev *dev, uint64_t features)
>  {
> +    struct fv_VuDev *vud =3D container_of(dev, struct fv_VuDev, dev);
> +    struct fuse_session *se =3D vud->se;
> +
> +    if ((1 << VIRTIO_FS_F_NOTIFICATION) & features) {

For consistency 1ull should be used.  That way the reader does not have
to check the bit position to verify that the bitmap isn't truncated at
32 bits.

> +        vud->notify_enabled =3D true;
> +        se->notify_enabled =3D true;

Only one copy of this field is needed.  vud has a pointer to se.

> +    }
>  }
> =20
>  /*
> @@ -662,6 +671,65 @@ static void fv_queue_worker(gpointer data, gpointer =
user_data)
>      free(req);
>  }
> =20
> +static void *fv_queue_notify_thread(void *opaque)
> +{
> +    struct fv_QueueInfo *qi =3D opaque;
> +
> +    fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __fun=
c__,
> +             qi->qidx, qi->kick_fd);
> +
> +    while (1) {
> +        struct pollfd pf[2];
> +
> +        pf[0].fd =3D qi->kick_fd;
> +        pf[0].events =3D POLLIN;
> +        pf[0].revents =3D 0;
> +        pf[1].fd =3D qi->kill_fd;
> +        pf[1].events =3D POLLIN;
> +        pf[1].revents =3D 0;
> +
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for Queue %d event\n", __f=
unc__,
> +                 qi->qidx);
> +        int poll_res =3D ppoll(pf, 2, NULL, NULL);
> +
> +        if (poll_res =3D=3D -1) {
> +            if (errno =3D=3D EINTR) {
> +                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going ar=
ound\n",
> +                         __func__);
> +                continue;
> +            }
> +            fuse_log(FUSE_LOG_ERR, "fv_queue_thread ppoll: %m\n");
> +            break;
> +        }
> +        assert(poll_res >=3D 1);
> +        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Queue=
 %d\n",
> +                     __func__, pf[0].revents, qi->qidx);
> +             break;
> +        }
> +        if (pf[1].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Queue=
 %d"
> +                     "killfd\n", __func__, pf[1].revents, qi->qidx);
> +            break;
> +        }
> +        if (pf[1].revents) {
> +            fuse_log(FUSE_LOG_INFO, "%s: kill event on queue %d - quitti=
ng\n",
> +                     __func__, qi->qidx);
> +            break;
> +        }
> +        assert(pf[0].revents & POLLIN);
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Got queue event on Queue %d\n", __=
func__,
> +                 qi->qidx);
> +
> +        eventfd_t evalue;
> +        if (eventfd_read(qi->kick_fd, &evalue)) {
> +            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
> +            break;
> +        }
> +    }
> +    return NULL;
> +}

It's difficult to review function without any actual functionality using
the virtqueue.  I'm not sure a thread is even needed since the device
only needs to get a buffer when it has a notification for the driver.
I'll have to wait for the following patches to see what happens here...

> @@ -378,12 +382,23 @@ static void vuf_set_status(VirtIODevice *vdev, uint=
8_t status)
>      }
>  }
> =20
> -static uint64_t vuf_get_features(VirtIODevice *vdev,
> -                                      uint64_t requested_features,
> -                                      Error **errp)
> +static uint64_t vuf_get_features(VirtIODevice *vdev, uint64_t features,
> +                                 Error **errp)
>  {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> +
> +    virtio_add_feature(&features, VIRTIO_FS_F_NOTIFICATION);
> +
> +    return vhost_get_features(&fs->vhost_dev, user_feature_bits, feature=
s);
> +}
> +
> +static void vuf_set_features(VirtIODevice *vdev, uint64_t features)
> +{
> +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> +
> +    if (virtio_has_feature(features, VIRTIO_FS_F_NOTIFICATION)) {
> +        fs->notify_enabled =3D true;

This field is unused, please remove it.

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3XthcACgkQnKSrs4Gr
c8gs5Qf+LyPnQ5S6B38Cg32zP4Ue8WZjyuFmlqBTKJ46vyg7gWkF6vDxWRDt/qu1
Q1cG3ErePIynsgV1rQyWTRKY0Yx82eahfFeh0QjOJYWwgfWbcRwb+oPUgCUQutXh
slBJu7InNwyhHnVQYNgXJoltwRVHdg7GA/sUqTbf1pEuocyFoFXInGWGppEystT4
R9cpoEEtDUqxUvES0DHGZ4f67qXQyAm8WGxfRC/wPZURActXeBEryqt2aShJ7dl2
FU7OdYj6Fr8XoCSdCLLsEOl5JOEk/ECkYLai3ZBaq+LHARXF68vSlwj8u81M6ffK
vSQaMpxLrn43n16CieagYSw2XTPqEw==
=oibv
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--


