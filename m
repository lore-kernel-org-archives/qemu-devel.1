Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44168C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F9D24656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHLOwl0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F9D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Teq-0001Ra-6f
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j4Tbx-0005M4-5n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j4Tbw-0000xB-1t
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j4Tbv-0000wi-U2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582135091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q8sIlNeIhXs2O4OtetmVJXEzSdHi6yxtkJxTJPiqVb4=;
 b=MHLOwl0QlkO/0AJYSOY6bM6dtzCXfG95xNxvw5EZ9DPEjmMBk+J1uFj/yTqO220ffbF89t
 jsIGeWCmJ/xdO1edXO/b67OukI+67YJLTZx1xfOZmO8Ce8s69NgP/ZNjaAa1RRpCtqxrWk
 k5Sby1i3jRJbR+5Y5B13qa+/k5oDU/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-YlyDOv2wM8WJMwUDFJuBag-1; Wed, 19 Feb 2020 12:58:08 -0500
X-MC-Unique: YlyDOv2wM8WJMwUDFJuBag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E51DBB7;
 Wed, 19 Feb 2020 17:58:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1657A48;
 Wed, 19 Feb 2020 17:58:06 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:33:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 1/5] extend libvhost to support IOThread and coroutine
Message-ID: <20200219163353.GC1085125@stefanha-x1.localdomain>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200218050711.8133-2-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200218050711.8133-2-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 01:07:07PM +0800, Coiby Xu wrote:
> +static bool vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
> +{
> +    vu_read_msg_cb read_msg;
> +    if (dev->co_iface) {
> +        read_msg =3D dev->co_iface->read_msg;
> +    } else {
> +        read_msg =3D vu_message_read_;
> +    }
> +    return read_msg(dev, conn_fd, vmsg);
> +}

libvhost-user is already partially asynchronous (->set/remove_watch()
are used for eventfds).

Can you make the vhost-user socket I/O asynchronous too?

> +
>  static bool
>  vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>  {
> @@ -1075,9 +1084,14 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *v=
msg)
>      }
> =20
>      if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
> +        if (dev->set_watch_packed_data) {
> +            dev->set_watch_packed_data(dev, dev->vq[index].kick_fd, VU_W=
ATCH_IN,
> +                                       dev->co_iface->kick_callback,
> +                                       (void *)(long)index);
> +        } else {
>          dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
>                         vu_kick_cb, (void *)(long)index);

Why is it necessary to replace vu_kick_cb()?

The user can set a custom vq->handler() function with
vu_set_queue_handler().

Coroutines aren't needed for this part since eventfd_read() always
returns right away.

> @@ -1627,6 +1647,12 @@ vu_deinit(VuDev *dev)
>          }
> =20
>          if (vq->kick_fd !=3D -1) {
> +            /* remove watch for kick_fd
> +             * When client process is running in gdb and
> +             * quit command is run in gdb, QEMU will still dispatch the =
event
> +             * which will cause segment fault in the callback function
> +             */

Code and comments in libvhost-user should not refer to QEMU specifics.
Removing the watch is a good idea regardless of the application or event
loop implementation.  No comment is needed here.

> +            dev->remove_watch(dev, vq->kick_fd);
>              close(vq->kick_fd);
>              vq->kick_fd =3D -1;
>          }
> @@ -1682,7 +1708,7 @@ vu_init(VuDev *dev,
> =20
>      assert(max_queues > 0);
>      assert(socket >=3D 0);
> -    assert(set_watch);
> +    /* assert(set_watch); */

?

> @@ -372,7 +389,8 @@ struct VuDev {
>      /* @set_watch: add or update the given fd to the watch set,
>       * call cb when condition is met */
>      vu_set_watch_cb set_watch;
> -
> +    /* AIO dispatch will only one data pointer to callback function */

I don't understand what this comment is saying.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5NY3AACgkQnKSrs4Gr
c8grmgf/XG0pSn/B8QqaT7uycrsWiH9FA/dGsGiNnKg7d8txvyPNJgpvpdidr0yp
ijUodJpVgwPA8liGRpkNrnVVARe/jZzzEtForVBJS6dWJTB0RvE58PLafTmfRuj5
6TjT/Lvu5aM7BNcLYfoqTpKnQZT4zoqFA3NKS8ORH6CqlV2Wh67KmPJtHY5eGQdZ
BaOoPxB+8N1kIUyADxXEwBNXmav25HcRnUeEmBHdR/OBf6K11vxqVJXAdsS4IRB7
kaRDs0x5Qgy8H9xoDEnmTCbJHt4VYCM1Aq8QS5RhwA4imEGsJVwynrJwJQY079mv
KiYN64v/ELvJ/gItRR0RT3bVxX6GNQ==
=1huJ
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--


