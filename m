Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D508CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64D620715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaUFsAns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64D620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDbT-0001BE-IN
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iYCkM-0006ss-De
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iYCkJ-0005Yt-1q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:29:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iYCkI-0005Uv-T1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574443761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMFDnr5CTIh4pisDnNHkjdUOMMz9FO2v5cerHK044kU=;
 b=WaUFsAnscmtnrYd7UO00rhhDCD1mY7oJPD2kds18wpH1E9UsQx6Y+iLhz4Xc6g4qgs2T/F
 e9PTbvgEJmfmvbdhduoTMN22DzazYMaAbVn79N0uhhI9Tr3vAqwMMRUJIor9o4qMiQb66d
 xNrvKnsLa97evp1c5phV0b3+8F2LcKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-N9D6g5pmNHqhod5uwtkN_A-1; Fri, 22 Nov 2019 12:29:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE0731005502;
 Fri, 22 Nov 2019 17:29:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 509C2F6DE;
 Fri, 22 Nov 2019 17:29:12 +0000 (UTC)
Date: Fri, 22 Nov 2019 17:29:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/4] virtiofd: Create a notification queue
Message-ID: <20191122172909.GK2785@work-vm>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-3-vgoyal@redhat.com>
 <20191122101903.GC464656@stefanha-x1.localdomain>
 <20191122144721.GD8636@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122144721.GD8636@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: N9D6g5pmNHqhod5uwtkN_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, miklos@szeredi.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Fri, Nov 22, 2019 at 10:19:03AM +0000, Stefan Hajnoczi wrote:
> > On Fri, Nov 15, 2019 at 03:55:41PM -0500, Vivek Goyal wrote:
> > >  /* Callback from libvhost-user */
> > >  static void fv_set_features(VuDev *dev, uint64_t features)
> > >  {
> > > +    struct fv_VuDev *vud =3D container_of(dev, struct fv_VuDev, dev)=
;
> > > +    struct fuse_session *se =3D vud->se;
> > > +
> > > +    if ((1 << VIRTIO_FS_F_NOTIFICATION) & features) {
> >=20
> > For consistency 1ull should be used.  That way the reader does not have
> > to check the bit position to verify that the bitmap isn't truncated at
> > 32 bits.
>=20
> Ok, will do.
>=20
> >=20
> > > +        vud->notify_enabled =3D true;
> > > +        se->notify_enabled =3D true;
> >=20
> > Only one copy of this field is needed.  vud has a pointer to se.
>=20
> I need to access ->notify_enabled in passthrough_ll.c to determine if
> notification queue is enabled or not. That determines if async locks are
> supported or not.  And based on that either -EOPNOTSUPP is returned or
> a response to wait is returned.
>=20
> I did not see passthrough_ll.c accessing vud. I did see it having access
> to session object though. So I created a copy there.
>=20
> But I am open to suggestions on what's the best way to access this
> information in passthrough_ll.c
>=20
> >=20
> > > +    }
> > >  }
> > > =20
> > >  /*
> > > @@ -662,6 +671,65 @@ static void fv_queue_worker(gpointer data, gpoin=
ter user_data)
> > >      free(req);
> > >  }
> > > =20
> > > +static void *fv_queue_notify_thread(void *opaque)
> > > +{
> > > +    struct fv_QueueInfo *qi =3D opaque;
> > > +
> > > +    fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", _=
_func__,
> > > +             qi->qidx, qi->kick_fd);
> > > +
> > > +    while (1) {
> > > +        struct pollfd pf[2];
> > > +
> > > +        pf[0].fd =3D qi->kick_fd;
> > > +        pf[0].events =3D POLLIN;
> > > +        pf[0].revents =3D 0;
> > > +        pf[1].fd =3D qi->kill_fd;
> > > +        pf[1].events =3D POLLIN;
> > > +        pf[1].revents =3D 0;
> > > +
> > > +        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for Queue %d event\n",=
 __func__,
> > > +                 qi->qidx);
> > > +        int poll_res =3D ppoll(pf, 2, NULL, NULL);
> > > +
> > > +        if (poll_res =3D=3D -1) {
> > > +            if (errno =3D=3D EINTR) {
> > > +                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, goin=
g around\n",
> > > +                         __func__);
> > > +                continue;
> > > +            }
> > > +            fuse_log(FUSE_LOG_ERR, "fv_queue_thread ppoll: %m\n");
> > > +            break;
> > > +        }
> > > +        assert(poll_res >=3D 1);
> > > +        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> > > +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Q=
ueue %d\n",
> > > +                     __func__, pf[0].revents, qi->qidx);
> > > +             break;
> > > +        }
> > > +        if (pf[1].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> > > +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Q=
ueue %d"
> > > +                     "killfd\n", __func__, pf[1].revents, qi->qidx);
> > > +            break;
> > > +        }
> > > +        if (pf[1].revents) {
> > > +            fuse_log(FUSE_LOG_INFO, "%s: kill event on queue %d - qu=
itting\n",
> > > +                     __func__, qi->qidx);
> > > +            break;
> > > +        }
> > > +        assert(pf[0].revents & POLLIN);
> > > +        fuse_log(FUSE_LOG_DEBUG, "%s: Got queue event on Queue %d\n"=
, __func__,
> > > +                 qi->qidx);
> > > +
> > > +        eventfd_t evalue;
> > > +        if (eventfd_read(qi->kick_fd, &evalue)) {
> > > +            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
> > > +            break;
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> >=20
> > It's difficult to review function without any actual functionality usin=
g
> > the virtqueue.  I'm not sure a thread is even needed since the device
> > only needs to get a buffer when it has a notification for the driver.
> > I'll have to wait for the following patches to see what happens here...
>=20
> This might very well be redundant. I am not sure. Can get rid of
> this thread if not needed at all. So we don't need to monitor even
> kill_fd and take any special action?

The kill_fd is internal to virtiofsd; it's only used as a way for the
main thread to cause the queue thread to exit;  if you've not got the
thread, you don't need the kill_fd.

Dave

> >=20
> > > @@ -378,12 +382,23 @@ static void vuf_set_status(VirtIODevice *vdev, =
uint8_t status)
> > >      }
> > >  }
> > > =20
> > > -static uint64_t vuf_get_features(VirtIODevice *vdev,
> > > -                                      uint64_t requested_features,
> > > -                                      Error **errp)
> > > +static uint64_t vuf_get_features(VirtIODevice *vdev, uint64_t featur=
es,
> > > +                                 Error **errp)
> > >  {
> > > -    /* No feature bits used yet */
> > > -    return requested_features;
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +
> > > +    virtio_add_feature(&features, VIRTIO_FS_F_NOTIFICATION);
> > > +
> > > +    return vhost_get_features(&fs->vhost_dev, user_feature_bits, fea=
tures);
> > > +}
> > > +
> > > +static void vuf_set_features(VirtIODevice *vdev, uint64_t features)
> > > +{
> > > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > > +
> > > +    if (virtio_has_feature(features, VIRTIO_FS_F_NOTIFICATION)) {
> > > +        fs->notify_enabled =3D true;
> >=20
> > This field is unused, please remove it.
>=20
> vuf_get_config() uses it.
>=20
> Thanks
> Vivek
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


