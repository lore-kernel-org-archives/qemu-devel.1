Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E50C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85562227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Cl5h3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85562227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMbu-0004wb-AN
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ifMam-0004Gv-LU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ifMah-0006wL-GE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:25:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ifMah-0006th-85
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576149906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+QDvCekcH//Ke0qvYXdEGTbLEmQodWY2I1WlxQqzvI=;
 b=K3Cl5h3vcFBPsXmhz/0bCKtZYgZBKqMfD1BvqUtJ+DbtOmGOXlIZfHL2LmCFaYh1aUTg0L
 9oiwQql1xFJYeEk8VHVSlXktC9t4Q2VoayazJk9YtynmXfhbVZetdHngnXDv8EyF0+g6Nq
 o2COL2Vqoh1ENqmwjscLLLI0ry45J6o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-wk2vLMsGN2upp3HWaNec2Q-1; Thu, 12 Dec 2019 06:25:01 -0500
Received: by mail-qk1-f199.google.com with SMTP id a6so1173291qkl.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iizwp79AS31udxvOQzqaEq5gPMX1CTMtd/jTalJLAhU=;
 b=ocdbWa30D1da4TbEZC6ceLYRn9rpOhS/nUVQbQ+uYewgRzjCBWamN356vrfUOuxM4u
 Y/TQQ7V6vT6QYd+c54A3fQ0muDSRZNwtuBbEZC2+Owr4N/+BMLGN7cvwi/UvJbuUVxpV
 pKCorqSj9WCuDH5RAtBt9jZJxHwJUzzB7+XMzV9rCv2KBrDrssaivEuSaLIQcaJGEoun
 WBasztiwSv21lcbiClrK7O2YspgciAblOYRHSyiEWFt4SIaaKHuB05YZTIW7vc3rSHRF
 h/noI0jRAx63UnoFDUKL18ATIGcbQrq3WCE3SIjEEFUnMdkSQTCmSxFuoeOgwcoRJGhp
 cpSA==
X-Gm-Message-State: APjAAAX9RJ1EK8/bxdp6vW9mpeQzWnTmakk55uylMwk5uOSmd3i0NVKx
 +yF5ZReqE0Uu4R+LtpqScaQYAPsKDJiHy/4w7JsGXO7IicJJ4WFrFgBCV6iztCRC9dJq92P9mpB
 UwWkOPGpVa+757wE=
X-Received: by 2002:a37:a00b:: with SMTP id j11mr7605829qke.268.1576149901257; 
 Thu, 12 Dec 2019 03:25:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIjoIXrDvOlByXVAKdXyMXtPT8Fh4dab5ZTdv0NRa2M4kL8mL6rDgGYackIVUiTNroCpvELg==
X-Received: by 2002:a37:a00b:: with SMTP id j11mr7605803qke.268.1576149900952; 
 Thu, 12 Dec 2019 03:25:00 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id a24sm1958847qtj.61.2019.12.12.03.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 03:24:59 -0800 (PST)
Date: Thu, 12 Dec 2019 06:24:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event when
 setrunning
Message-ID: <20191212062328-mutt-send-email-mst@kernel.org>
References: <20190809134134.GA8594@stefanha-x1.localdomain>
 <201911281926474453744@zte.com.cn>
 <20191212110525.GA1141992@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191212110525.GA1141992@stefanha-x1.localdomain>
X-MC-Unique: wk2vLMsGN2upp3HWaNec2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ning.bo9@zte.com.cn, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 11:05:25AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 28, 2019 at 07:26:47PM +0800, ning.bo9@zte.com.cn wrote:
> > Let me describe the issue with an example via `nc-vsock`:
> >=20
> > Let's assume the Guest cid is 3.
> > execute 'rmmod vmw_vsock_virtio_transport' in Guest,
> > then execute 'while true; do nc-vsock 3 1234' in Host.
> >=20
> > Host                             Guest
> >                                  # rmmod vmw_vsock_virtio_transport
> >=20
> > # while true; do ./nc-vsock 3 1234; done
> > (after 2 second)
> > connect: Connection timed out
> > (after 2 second)
> > connect: Connection timed out
> > ...
> >=20
> >                                  # modprobe vmw_vsock_virtio_transport
> >=20
> > connect: Connection reset by peer
> > connect: Connection reset by peer
> > connect: Connection reset by peer
> > ...
> >=20
> >                                  # nc-vsock -l 1234
> >                                  Connetion from cid 2 port ***...
> > (stop printing)
> >=20
> >=20
> > The above process simulates the communication process between
> > the `kata-runtime` and `kata-agent` after starting the Guest.
> > In order to connect to `kata-agent` as soon as possible,=20
> > `kata-runtime` will continuously try to connect to `kata-agent` in a lo=
op.
> > see https://github.com/kata-containers/runtime/blob/d054556f60f092335a2=
2a288011fa29539ad4ccc/vendor/github.com/kata-containers/agent/protocols/cli=
ent/client.go#L327
> > But when the vsock device in the Guest is not ready, the connection
> > will block for 2 seconds. This situation actually slows down
> > the entire startup time of `kata-runtime`.
>=20
> This can be done efficiently as follows:
> 1. kata-runtime listens on a vsock port
> 2. kata-agent-port=3DPORT is added to the kernel command-line options
> 3. kata-agent parses the port number and connects to the host
>=20
> This eliminates the reconnection attempts.

Then we'll get the same problem in reverse, won't we?
Agent must now be running before guest can boot ...
Or did I miss anything?

> > > I think that adding a QMP event is working around the issue rather th=
an
> > > fixing the root cause.  This is probably a vhost_vsock.ko problem and
> > > should be fixed there.
> >=20
> > After looking at the source code of vhost_vsock.ko,=20
> > I think it is possible to optimize the logic here too.
> > The simple patch is as follows. Do you think the modification is approp=
riate?
> >=20
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 9f57736f..8fad67be 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -51,6 +51,7 @@ struct vhost_vsock {
> >  =09atomic_t queued_replies;
> >=20
> >  =09u32 guest_cid;
> > +=09u32 state;
> >  };
> >=20
> >  static u32 vhost_transport_get_local_cid(void)
> > @@ -497,6 +541,7 @@ static int vhost_vsock_start(struct vhost_vsock *vs=
ock)
> >=20
> >  =09=09mutex_unlock(&vq->mutex);
> >  =09}
> > +=09vsock->state =3D 1;
> >=20
> >  =09mutex_unlock(&vsock->dev.mutex);
> >  =09return 0;
> > @@ -535,6 +580,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vso=
ck)
> >  =09=09vq->private_data =3D NULL;
> >  =09=09mutex_unlock(&vq->mutex);
> >  =09}
> > +=09vsock->state =3D 0;
> >=20
> >  err:
> >  =09mutex_unlock(&vsock->dev.mutex);
> > @@ -786,6 +832,27 @@ static struct miscdevice vhost_vsock_misc =3D {
> >  =09.fops =3D &vhost_vsock_fops,
> >  };
> >=20
> > +int vhost_transport_connect(struct vsock_sock *vsk) {
> > +=09struct vhost_vsock *vsock;
> > +
> > +=09rcu_read_lock();
> > +
> > +=09/* Find the vhost_vsock according to guest context id  */
> > +=09vsock =3D vhost_vsock_get(vsk->remote_addr.svm_cid);
> > +=09if (!vsock) {
> > +=09=09rcu_read_unlock();
> > +=09=09return -ENODEV;
> > +=09}
> > +
> > +=09rcu_read_unlock();
> > +
> > +=09if (vsock->state =3D=3D 1) {
> > +=09=09return virtio_transport_connect(vsk);
> > +=09} else {
> > +=09=09return -ECONNRESET;
> > +=09}
> > +}
> > +
> >  static struct virtio_transport vhost_transport =3D {
> >  =09.transport =3D {
> >  =09=09.get_local_cid            =3D vhost_transport_get_local_cid,
> > @@ -793,7 +860,7 @@ static struct virtio_transport vhost_transport =3D =
{
> >  =09=09.init                     =3D virtio_transport_do_socket_init,
> >  =09=09.destruct                 =3D virtio_transport_destruct,
> >  =09=09.release                  =3D virtio_transport_release,
> > -=09=09.connect                  =3D virtio_transport_connect,
> > +=09=09.connect                  =3D vhost_transport_connect,
> >  =09=09.shutdown                 =3D virtio_transport_shutdown,
> >  =09=09.cancel_pkt               =3D vhost_transport_cancel_pkt,
>=20
> I'm not keen on adding a special case for vhost_vsock.ko connect.
>=20
> Userspace APIs to avoid the 2 second wait already exist:
>=20
> 1. The SO_VM_SOCKETS_CONNECT_TIMEOUT socket option controls the connect
>    timeout for this socket.
>=20
> 2. Non-blocking connect allows the userspace process to do other things
>    while a connection attempt is being made.
>=20
> But the best solution is the one I mentioned above.
>=20
> Stefan



