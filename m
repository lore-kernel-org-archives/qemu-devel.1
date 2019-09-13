Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BFC208C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BFC208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8htn-0008KZ-Np
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8ht1-0007qP-Pc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8ht0-0001Lz-Cd
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8hsz-0001Kb-Qf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:29:02 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C51B9882EA
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 09:29:00 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k67so1105409wmf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 02:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=pmag4xjDfZW8TGiq3Hez660u4TzDc1NR91aZIM391f8=;
 b=UX/DIzkDOEoytQzJM552Ys/PgNJviZOhsIN7qjkgq//RIZClZgzT6trYpipHbBuOpi
 jCLURuPDSCHCNC0IZ1kawR/g4RXpvbIphK8kjZsqpQOzlgSghfHZ70ZhrQvlxsDT4C68
 REQ8Efz9HqzvpKuX5bsiNL6gYouVGxez1JBTFln2ZXYRZqdyg8Kcyx6lngT+xEQATUUg
 cdDavXnrXIqu5vzn1TBq5ohHk0FEk+/bPWY/NIMNSrYZi2O2DPrVX9QFcSBr/JlSumHS
 pv3dW43CB9KTCidoEQ+Ogp4xbRquIEU0V/+v/ompWnj+dd9unjqQc63flJLNFYKrIP1L
 8xPg==
X-Gm-Message-State: APjAAAUNDARH8uEgJifXwxmYzU3e5ki93T1Mh3bvqS4LNjLv0tFKAZTF
 8ck8qb0YaMtZ9G/5zE3d5MDCpOv2L2cTK6CO+raH/O8To46QHpW8VZyrablYqS4fxFBgvxUQbgT
 XIf5YWQeGF1KKjiM=
X-Received: by 2002:a05:6000:1101:: with SMTP id
 z1mr34350498wrw.332.1568366939417; 
 Fri, 13 Sep 2019 02:28:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyVKzIDLHegAjR3CoOQZM2gzehm7DOznMLb5FbUZf2hI2m7YpXE3d3s1qMR6sNFb+Al14nvEg==
X-Received: by 2002:a05:6000:1101:: with SMTP id
 z1mr34350479wrw.332.1568366939190; 
 Fri, 13 Sep 2019 02:28:59 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id y14sm43845390wrd.84.2019.09.13.02.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 02:28:58 -0700 (PDT)
References: <20190912181924.48539-1-slp@redhat.com>
 <20190912155023-mutt-send-email-mst@kernel.org>
 <20190913090457.GA8312@dhcp-200-226.str.redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190913090457.GA8312@dhcp-200-226.str.redhat.com>
Date: Fri, 13 Sep 2019 11:28:56 +0200
Message-ID: <87woecwnmv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] virtio-blk: schedule
 virtio_notify_config to run on main context
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
Cc: mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.09.2019 um 21:51 hat Michael S. Tsirkin geschrieben:
>> On Thu, Sep 12, 2019 at 08:19:25PM +0200, Sergio Lopez wrote:
>> > Another AioContext-related issue, and this is a tricky one.
>> >=20
>> > Executing a QMP block_resize request for a virtio-blk device running
>> > on an iothread may cause a deadlock involving the following mutexes:
>> >=20
>> >  - main thead
>> >   * Has acquired: qemu_mutex_global.
>> >   * Is trying the acquire: iothread AioContext lock via
>> >     AIO_WAIT_WHILE (after aio_poll).
>> >=20
>> >  - iothread
>> >   * Has acquired: AioContext lock.
>> >   * Is trying to acquire: qemu_mutex_global (via
>> >     virtio_notify_config->prepare_mmio_access).
>>=20
>> Hmm is this really the only case iothread takes qemu mutex?
>> If any such access can deadlock, don't we need a generic
>> solution? Maybe main thread can drop qemu mutex
>> before taking io thread AioContext lock?
>
> The rule is that iothreads must not take the qemu mutex. If they do
> (like in this case), it's a bug.
>
> Maybe we could actually assert this in qemu_mutex_lock_iothread()?
>
>> > With this change, virtio_blk_resize checks if it's being called from a
>> > coroutine context running on a non-main thread, and if that's the
>> > case, creates a new coroutine and schedules it to be run on the main
>> > thread.
>> >=20
>> > This works, but means the actual operation is done
>> > asynchronously, perhaps opening a window in which a "device_del"
>> > operation may fit and remove the VirtIODevice before
>> > virtio_notify_config() is executed.
>> >=20
>> > I *think* it shouldn't be possible, as BHs will be processed before
>> > any new QMP/monitor command, but I'm open to a different approach.
>> >=20
>> > RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1744955
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > ---
>> >  hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
>> >  1 file changed, 24 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> > index 18851601cb..c763d071f6 100644
>> > --- a/hw/block/virtio-blk.c
>> > +++ b/hw/block/virtio-blk.c
>> > @@ -16,6 +16,7 @@
>> >  #include "qemu/iov.h"
>> >  #include "qemu/module.h"
>> >  #include "qemu/error-report.h"
>> > +#include "qemu/main-loop.h"
>> >  #include "trace.h"
>> >  #include "hw/block/block.h"
>> >  #include "hw/qdev-properties.h"
>> > @@ -1086,11 +1087,33 @@ static int virtio_blk_load_device(VirtIODevice=
 *vdev, QEMUFile *f,
>> >      return 0;
>> >  }
>> >=20=20
>> > +static void coroutine_fn virtio_resize_co_entry(void *opaque)
>> > +{
>> > +    VirtIODevice *vdev =3D opaque;
>> > +
>> > +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context=
());
>> > +    virtio_notify_config(vdev);
>> > +    aio_wait_kick();
>> > +}
>> > +
>> >  static void virtio_blk_resize(void *opaque)
>> >  {
>> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
>> > +    Coroutine *co;
>> >=20=20
>> > -    virtio_notify_config(vdev);
>> > +    if (qemu_in_coroutine() &&
>> > +        qemu_get_current_aio_context() !=3D qemu_get_aio_context()) {
>> > +        /*
>> > +         * virtio_notify_config() needs to acquire the global mutex,
>> > +         * so calling it from a coroutine running on a non-main conte=
xt
>> > +         * may cause a deadlock. Instead, create a new coroutine and
>> > +         * schedule it to be run on the main thread.
>> > +         */
>> > +        co =3D qemu_coroutine_create(virtio_resize_co_entry, vdev);
>> > +        aio_co_schedule(qemu_get_aio_context(), co);
>> > +    } else {
>> > +        virtio_notify_config(vdev);
>> > +    }
>> >  }
>
> Wouldn't a simple BH suffice (aio_bh_schedule_oneshot)? I don't see why
> you need a coroutine when you never yield.

You're right, that's actually simpler, haven't thought of it.

Do you see any drawbacks or should I send a non-RFC fixed version of
this patch?

> The reason why it deadlocks also has nothing to do with whether we are
> called from a coroutine or not. The important part is that we're running
> in an iothread.
>
> Kevin


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl17YVgACgkQ9GknjS8M
AjXSahAAulJxdFYS4YFjf6WUKjl29tB8/mLQ3+a7gjtkEFLRIUlG0gUz3bosuehZ
tvsRrIR81ciL5ajnzPGr6EyrfkjkVMNlBksviF65R8rBBR9CgHXvsrV9FTHjGjxr
ya5zM/0uveO7/ExpzHCnlCJkwgtnViJ3h6jywTOMargyD4loCK8r5b+AaBj3fZok
iA6GFK5d9ZztDSCYbtZmsOUfx45yUmp/hBPqnHEKk4Us8kYx9ZJsVF5sHWRZjaPX
ZHu5XTQW+eIqs3UF5OQEy7nJXSLp110k1v5hQeAmkttEZG73RBlwyXVHWAZR14lg
hgZrJPs1Y7koXeIC88DIGofiu50MpSs7+5oeDwfULpNAZn39jkB/2d4f1uy428ai
RrM0glT/hzSaeE5S1jWnHE/SAWCoiZCPSmlj0czM/rpnxBvj0P2QwJM2lGLhV2c0
gIsHhHmQTlWMh2eUVds1kUgVFFMqKdICP/Oh1uYpRSZJupfQlWhdfYinSrvYUmyJ
74dRoW95WbKfaFHp3hd+mQ+ki1+cjelLzmncVMXt1/n+bavxHDJv1zWv/N4UyrVD
EETtpfYioRDovmfaNyMKVTrCw4h1YLZA0GE0DwmK/dqFR4LFKLnkxyJAZQAHoJRR
2Df5kBpCVaL2h1fpzCLRJ3CuzCzBw2iVYx7Cm81M/Cjn4+ATZnI=
=Se3t
-----END PGP SIGNATURE-----
--=-=-=--

