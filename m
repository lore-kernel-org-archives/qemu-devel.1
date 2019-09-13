Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329172089F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329172089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8gJO-0001dV-46
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 03:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8gHx-0000fo-B4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8gHu-0004pE-PJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i8gHu-0004od-Gn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:46:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D46F22CD7E5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:46:36 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t16so13451845wro.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 00:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=C0xycAsyxvlN29+xVCXkmMUGTTG5fOSZSqqTAQU7dE8=;
 b=DeYCFe+RiDF5+RCegFHXH9Hu2xAJg6aqtv/Vchu4PCGYljEw0FiCM3eYr/vUaA7oZI
 E26LQ9oNq8riFUy2mewo/KQum5oLM9dv6zGgmgS/ktvBhPFFbZWuzpQ7edWu0o8f29NT
 A/wfLnrC9zdpKr/QOelY35Zp0NwCNYOuNZiwaUrOGJMjEFsFCD0qbgO7cBMIO/kNLVDc
 g4ryWN+D7+1GXUTB2PCV08Ircr8n//sFeVM8E9iQbauTTBl7h38LOjAU6NPwDzz47Pr+
 lSq6X4btBE4qnscmHsce3e2WZG4UeZb9ufgbNM8dYjNZYACRCOq8Z/RZwtXdM0/1dbGt
 UhGw==
X-Gm-Message-State: APjAAAUHzlfra8ZF3SDm2tN9je2igPcG9gqwQtQ4dZSWaWUZuDqSi1Ww
 UO/1CdqQBTcMwL7Xtwep25rixsn6qjAre2hOqHkrmJDqb6EO5vxvrkAebEFyGiQgaTG/ny8m+kP
 b6SsVvXSyQDEJ8Ps=
X-Received: by 2002:adf:ee50:: with SMTP id w16mr2801497wro.93.1568360795554; 
 Fri, 13 Sep 2019 00:46:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTv6nIgg/KPUvc8r4KLGRh8QWdSgs8WArxZffEOrIT9+gwNPijBOdfQqVNwc06zCqmgoIpTA==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr2801479wro.93.1568360795338; 
 Fri, 13 Sep 2019 00:46:35 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id q25sm1937073wmq.27.2019.09.13.00.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 00:46:34 -0700 (PDT)
References: <20190912181924.48539-1-slp@redhat.com>
 <20190912155023-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190912155023-mutt-send-email-mst@kernel.org>
Date: Fri, 13 Sep 2019 09:46:23 +0200
Message-ID: <87y2yswsds.fsf@redhat.com>
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
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Sep 12, 2019 at 08:19:25PM +0200, Sergio Lopez wrote:
>> Another AioContext-related issue, and this is a tricky one.
>>=20
>> Executing a QMP block_resize request for a virtio-blk device running
>> on an iothread may cause a deadlock involving the following mutexes:
>>=20
>>  - main thead
>>   * Has acquired: qemu_mutex_global.
>>   * Is trying the acquire: iothread AioContext lock via
>>     AIO_WAIT_WHILE (after aio_poll).
>>=20
>>  - iothread
>>   * Has acquired: AioContext lock.
>>   * Is trying to acquire: qemu_mutex_global (via
>>     virtio_notify_config->prepare_mmio_access).
>
> Hmm is this really the only case iothread takes qemu mutex?

Not the only one that takes the mutex, but the only one so far we found
doing so upon request from a job running on the main thread (should be
quite noticeable, due to the deadlock).

> If any such access can deadlock, don't we need a generic
> solution? Maybe main thread can drop qemu mutex
> before taking io thread AioContext lock?

The mutex is acquired very early at os_host_main_loop_wait(), so I
assume there may be many assumptions in multiple code paths that it has
been acquired.

>> With this change, virtio_blk_resize checks if it's being called from a
>> coroutine context running on a non-main thread, and if that's the
>> case, creates a new coroutine and schedules it to be run on the main
>> thread.
>>=20
>> This works, but means the actual operation is done
>> asynchronously, perhaps opening a window in which a "device_del"
>> operation may fit and remove the VirtIODevice before
>> virtio_notify_config() is executed.
>>=20
>> I *think* it shouldn't be possible, as BHs will be processed before
>> any new QMP/monitor command, but I'm open to a different approach.
>>=20
>> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1744955
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 18851601cb..c763d071f6 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -16,6 +16,7 @@
>>  #include "qemu/iov.h"
>>  #include "qemu/module.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/main-loop.h"
>>  #include "trace.h"
>>  #include "hw/block/block.h"
>>  #include "hw/qdev-properties.h"
>> @@ -1086,11 +1087,33 @@ static int virtio_blk_load_device(VirtIODevice *=
vdev, QEMUFile *f,
>>      return 0;
>>  }
>>=20=20
>> +static void coroutine_fn virtio_resize_co_entry(void *opaque)
>> +{
>> +    VirtIODevice *vdev =3D opaque;
>> +
>> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context()=
);
>> +    virtio_notify_config(vdev);
>> +    aio_wait_kick();
>> +}
>> +
>>  static void virtio_blk_resize(void *opaque)
>>  {
>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
>> +    Coroutine *co;
>>=20=20
>> -    virtio_notify_config(vdev);
>> +    if (qemu_in_coroutine() &&
>> +        qemu_get_current_aio_context() !=3D qemu_get_aio_context()) {
>> +        /*
>> +         * virtio_notify_config() needs to acquire the global mutex,
>> +         * so calling it from a coroutine running on a non-main context
>> +         * may cause a deadlock. Instead, create a new coroutine and
>> +         * schedule it to be run on the main thread.
>> +         */
>> +        co =3D qemu_coroutine_create(virtio_resize_co_entry, vdev);
>> +        aio_co_schedule(qemu_get_aio_context(), co);
>> +    } else {
>> +        virtio_notify_config(vdev);
>> +    }
>>  }
>>=20=20
>>  static const BlockDevOps virtio_block_ops =3D {
>> --=20
>> 2.21.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl17SU8ACgkQ9GknjS8M
AjXabBAAuajIGNbaG/8jXpDENnVEQxHCbSYCcUNCnc61VH2rYgt/B9gzEVW7EJGK
dgGhEIshJkvRAeXLEZtUtzK1uJ8KSPq35xjPuow6yD3Vd9q/WHmREEcOYhs/9ko9
FxjHof1jRAsKr8bfMELujNjBFF9LIjqPfTY1UoTojSs7/75V/eyC/7Zw/xP9RkMG
WtUyh6ccQfvUNQbH9M+Cq6No9MFCabok7dxGkUH/8IrMc64ZXPMCg55YF8q/yIp4
AUUKNNpDrxjNP0VRU/Ncl+48d9+5wOoPdUZCwJ7Nm8iXIPsStWWw1ZLco8JV1Wo7
44/qU1xE8pa3j06wZazqTshTziH9o2QBQojIaIZD33n6JPrn7iPTxsdTE4KOwyqc
4wn8dtItmWLQTwONhY/bmYnQaWrge6KFpDko4SDhFwbRV2E9c+7j5bwvcr5/u4+v
L8IZMyaYHTIM+dP887wWsVHT6QtmOoaia13UnEx1Yljy7U5MIG5wfm5ZvKu9cC7W
LbKwAMnHA7X8E5S3Lbio45yfN4w/je//Nd1cfBfjp6nkRIdPzRZt3oacMc5LyqNo
8SXzhl35olragk3gl6GP+58TzJoDvL32owcPd99Dnk8OMnibLO/GBORwZyfgkOSS
T9O2ieMucb2jlziwejhrvAR83nIOPGeKcNz0jvwrZXH4jkGVzP4=
=6FWW
-----END PGP SIGNATURE-----
--=-=-=--

