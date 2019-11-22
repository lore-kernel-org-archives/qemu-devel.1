Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B703C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB24120706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP/OsA4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB24120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAJ7-0007ig-UZ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iYAHj-00063h-Ul
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iYADe-0006I3-KX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:47:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iYADe-0006Hk-Fc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574434053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfzF814ow3PsutzoSjuxPHowD7iRZi7qKlFhlA3arBo=;
 b=VP/OsA4mfgzO5a6fTvqCT/jjQlpNAXBMmaJlPckKtAilkPPPhkLRm0QT4B3Z6zqEtOrJxY
 A6QnCNeZsBw2Cu1IRZrPAmY1fpkwTaZwEeofNG/yclPaDSCUXkJgoMMAiIUYWc9P2AYmLi
 NZCgHuqgUzmnEkM2hXBFMRNntjSG/yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-671rnpXPOHKpxRgNPVia4g-1; Fri, 22 Nov 2019 09:47:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A17800054;
 Fri, 22 Nov 2019 14:47:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED8D263742;
 Fri, 22 Nov 2019 14:47:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5CBE6220AFF; Fri, 22 Nov 2019 09:47:21 -0500 (EST)
Date: Fri, 22 Nov 2019 09:47:21 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/4] virtiofd: Create a notification queue
Message-ID: <20191122144721.GD8636@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-3-vgoyal@redhat.com>
 <20191122101903.GC464656@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191122101903.GC464656@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 671rnpXPOHKpxRgNPVia4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Fri, Nov 22, 2019 at 10:19:03AM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 15, 2019 at 03:55:41PM -0500, Vivek Goyal wrote:
> >  /* Callback from libvhost-user */
> >  static void fv_set_features(VuDev *dev, uint64_t features)
> >  {
> > +    struct fv_VuDev *vud =3D container_of(dev, struct fv_VuDev, dev);
> > +    struct fuse_session *se =3D vud->se;
> > +
> > +    if ((1 << VIRTIO_FS_F_NOTIFICATION) & features) {
>=20
> For consistency 1ull should be used.  That way the reader does not have
> to check the bit position to verify that the bitmap isn't truncated at
> 32 bits.

Ok, will do.

>=20
> > +        vud->notify_enabled =3D true;
> > +        se->notify_enabled =3D true;
>=20
> Only one copy of this field is needed.  vud has a pointer to se.

I need to access ->notify_enabled in passthrough_ll.c to determine if
notification queue is enabled or not. That determines if async locks are
supported or not.  And based on that either -EOPNOTSUPP is returned or
a response to wait is returned.

I did not see passthrough_ll.c accessing vud. I did see it having access
to session object though. So I created a copy there.

But I am open to suggestions on what's the best way to access this
information in passthrough_ll.c

>=20
> > +    }
> >  }
> > =20
> >  /*
> > @@ -662,6 +671,65 @@ static void fv_queue_worker(gpointer data, gpointe=
r user_data)
> >      free(req);
> >  }
> > =20
> > +static void *fv_queue_notify_thread(void *opaque)
> > +{
> > +    struct fv_QueueInfo *qi =3D opaque;
> > +
> > +    fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __f=
unc__,
> > +             qi->qidx, qi->kick_fd);
> > +
> > +    while (1) {
> > +        struct pollfd pf[2];
> > +
> > +        pf[0].fd =3D qi->kick_fd;
> > +        pf[0].events =3D POLLIN;
> > +        pf[0].revents =3D 0;
> > +        pf[1].fd =3D qi->kill_fd;
> > +        pf[1].events =3D POLLIN;
> > +        pf[1].revents =3D 0;
> > +
> > +        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for Queue %d event\n", _=
_func__,
> > +                 qi->qidx);
> > +        int poll_res =3D ppoll(pf, 2, NULL, NULL);
> > +
> > +        if (poll_res =3D=3D -1) {
> > +            if (errno =3D=3D EINTR) {
> > +                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going =
around\n",
> > +                         __func__);
> > +                continue;
> > +            }
> > +            fuse_log(FUSE_LOG_ERR, "fv_queue_thread ppoll: %m\n");
> > +            break;
> > +        }
> > +        assert(poll_res >=3D 1);
> > +        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> > +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Que=
ue %d\n",
> > +                     __func__, pf[0].revents, qi->qidx);
> > +             break;
> > +        }
> > +        if (pf[1].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> > +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Que=
ue %d"
> > +                     "killfd\n", __func__, pf[1].revents, qi->qidx);
> > +            break;
> > +        }
> > +        if (pf[1].revents) {
> > +            fuse_log(FUSE_LOG_INFO, "%s: kill event on queue %d - quit=
ting\n",
> > +                     __func__, qi->qidx);
> > +            break;
> > +        }
> > +        assert(pf[0].revents & POLLIN);
> > +        fuse_log(FUSE_LOG_DEBUG, "%s: Got queue event on Queue %d\n", =
__func__,
> > +                 qi->qidx);
> > +
> > +        eventfd_t evalue;
> > +        if (eventfd_read(qi->kick_fd, &evalue)) {
> > +            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
> > +            break;
> > +        }
> > +    }
> > +    return NULL;
> > +}
>=20
> It's difficult to review function without any actual functionality using
> the virtqueue.  I'm not sure a thread is even needed since the device
> only needs to get a buffer when it has a notification for the driver.
> I'll have to wait for the following patches to see what happens here...

This might very well be redundant. I am not sure. Can get rid of
this thread if not needed at all. So we don't need to monitor even
kill_fd and take any special action?

>=20
> > @@ -378,12 +382,23 @@ static void vuf_set_status(VirtIODevice *vdev, ui=
nt8_t status)
> >      }
> >  }
> > =20
> > -static uint64_t vuf_get_features(VirtIODevice *vdev,
> > -                                      uint64_t requested_features,
> > -                                      Error **errp)
> > +static uint64_t vuf_get_features(VirtIODevice *vdev, uint64_t features=
,
> > +                                 Error **errp)
> >  {
> > -    /* No feature bits used yet */
> > -    return requested_features;
> > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > +
> > +    virtio_add_feature(&features, VIRTIO_FS_F_NOTIFICATION);
> > +
> > +    return vhost_get_features(&fs->vhost_dev, user_feature_bits, featu=
res);
> > +}
> > +
> > +static void vuf_set_features(VirtIODevice *vdev, uint64_t features)
> > +{
> > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > +
> > +    if (virtio_has_feature(features, VIRTIO_FS_F_NOTIFICATION)) {
> > +        fs->notify_enabled =3D true;
>=20
> This field is unused, please remove it.

vuf_get_config() uses it.

Thanks
Vivek


