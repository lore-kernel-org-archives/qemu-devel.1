Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4082C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BC52133F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BC52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oX3-00037D-Kz
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0oVY-0001za-8p
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0oVV-0000K3-Kv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:56:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0oVV-0000Jd-C3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:56:09 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E11A88304
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 14:56:08 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 19so3057765wmk.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tAaBjny2qlFElN4KIiu3ureeZyXRgblYIrzJ3TEilmU=;
 b=UMz2x2xtXeoPPGbtWSNUcLwl6670xh/7bVAyvsi+9bPncRxH+W+DtWztWupobOJ219
 NAWtdU3XlPDRdWhHS0mNG5v2spYsEB0yH+WgM30+mgiIP0FAB9CZmqOerj6H1rOUcW8B
 KytBf4HUi57LymEdOg73kyVi3I9YmJTgKHz0NaPt4UZCmEV0bCxJvQ0/aEODzKve9/PR
 RDMFo4sibuRN91KTvPwfnakCtLbO5D1UfyWVpZqyMy7+2mJ9ac96Y5SIrDy1O8drIxnF
 OGSD7LlcFNyS0Qmn7lA8u56xhU2j0WQ3FfzVzZX7cR+XHjvgoRPPKB6+RfI9Sz46m5WH
 +vCQ==
X-Gm-Message-State: APjAAAVkkucmN0/7Z3jWhA3n+/zFt/oDgBY+ekglfjjmV4VIsVDPrKZ4
 5PB/8F6N6T50IX7ai7YydyluJbAmOkmOrPprMnOu47AO/KUZwRujNg6Kn575sV6ZN2QxlnX+MZi
 0JJ12oezjSwQm1i8=
X-Received: by 2002:adf:90d0:: with SMTP id i74mr29858074wri.218.1566485766945; 
 Thu, 22 Aug 2019 07:56:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPSJoEwjryIgghtjsIBLnTY5Ak9kjBY2s8vlVTv22cm1nZJQX4er2Hp8XEYXWpmANkcXdAtA==
X-Received: by 2002:adf:90d0:: with SMTP id i74mr29858050wri.218.1566485766769; 
 Thu, 22 Aug 2019 07:56:06 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f10sm23113787wrm.31.2019.08.22.07.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 07:56:06 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20190816171503.24761-1-philmd@redhat.com>
 <20190822130121.GF20491@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5f5029a5-0682-4d38-5262-9c3276cec8a8@redhat.com>
Date: Thu, 22 Aug 2019 16:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190822130121.GF20491@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: Cancel the pending BH when the
 dataplane is reset
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Xujun Ma <xuma@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Yihuang Yu <yihyu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 3:01 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 16, 2019 at 07:15:03PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> When 'system_reset' is called, the main loop clear the memory
>> region cache before the BH has a chance to execute. Later when
>> the deferred function is called, some assumptions that were
>> made when scheduling them are no longer true when they actually
>> execute.
>>
>> This is what happens using a virtio-blk device (fresh RHEL7.8 install)=
:
>>
>>  $ (sleep 12.3; echo system_reset; sleep 12.3; echo system_reset; slee=
p 1; echo q) \
>>    | qemu-system-x86_64 -m 4G -smp 8 -boot menu=3Don \
>>      -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1 \
>>      -drive file=3D/var/lib/libvirt/images/rhel78.qcow2,if=3Dnone,id=3D=
drive_image1,format=3Dqcow2,cache=3Dnone \
>>      -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:=
e7:84 \
>>      -netdev tap,id=3Dnet0,script=3D/bin/true,downscript=3D/bin/true,v=
host=3Don \
>>      -monitor stdio -serial null -nographic
>>   (qemu) system_reset
>>   (qemu) system_reset
>>   (qemu) qemu-system-x86_64: hw/virtio/virtio.c:225: vring_get_region_=
caches: Assertion `caches !=3D NULL' failed.
>>   Aborted
>>
>>   (gdb) bt
>>   Thread 1 (Thread 0x7f109c17b680 (LWP 10939)):
>>   #0  0x00005604083296d1 in vring_get_region_caches (vq=3D0x56040a24bd=
d0) at hw/virtio/virtio.c:227
>>   #1  0x000056040832972b in vring_avail_flags (vq=3D0x56040a24bdd0) at=
 hw/virtio/virtio.c:235
>>   #2  0x000056040832d13d in virtio_should_notify (vdev=3D0x56040a24063=
0, vq=3D0x56040a24bdd0) at hw/virtio/virtio.c:1648
>>   #3  0x000056040832d1f8 in virtio_notify_irqfd (vdev=3D0x56040a240630=
, vq=3D0x56040a24bdd0) at hw/virtio/virtio.c:1662
>>   #4  0x00005604082d213d in notify_guest_bh (opaque=3D0x56040a243ec0) =
at hw/block/dataplane/virtio-blk.c:75
>>   #5  0x000056040883dc35 in aio_bh_call (bh=3D0x56040a243f10) at util/=
async.c:90
>>   #6  0x000056040883dccd in aio_bh_poll (ctx=3D0x560409161980) at util=
/async.c:118
>>   #7  0x0000560408842af7 in aio_dispatch (ctx=3D0x560409161980) at uti=
l/aio-posix.c:460
>>   #8  0x000056040883e068 in aio_ctx_dispatch (source=3D0x560409161980,=
 callback=3D0x0, user_data=3D0x0) at util/async.c:261
>>   #9  0x00007f10a8fca06d in g_main_context_dispatch () at /lib64/libgl=
ib-2.0.so.0
>>   #10 0x0000560408841445 in glib_pollfds_poll () at util/main-loop.c:2=
15
>>   #11 0x00005604088414bf in os_host_main_loop_wait (timeout=3D0) at ut=
il/main-loop.c:238
>>   #12 0x00005604088415c4 in main_loop_wait (nonblocking=3D0) at util/m=
ain-loop.c:514
>>   #13 0x0000560408416b1e in main_loop () at vl.c:1923
>>   #14 0x000056040841e0e8 in main (argc=3D20, argv=3D0x7ffc2c3f9c58, en=
vp=3D0x7ffc2c3f9d00) at vl.c:4578
>>
>> Fix this by cancelling the BH when the virtio dataplane is stopped.
>>
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1839428
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>  hw/block/dataplane/virtio-blk.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virt=
io-blk.c
>> index 9299a1a7c2..4030faa21d 100644
>> --- a/hw/block/dataplane/virtio-blk.c
>> +++ b/hw/block/dataplane/virtio-blk.c
>> @@ -301,6 +301,8 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev=
)
>>      /* Clean up guest notifier (irq) */
>>      k->set_guest_notifiers(qbus->parent, nvqs, false);
>> =20
>> +    qemu_bh_cancel(s->bh);
>> +
>>      vblk->dataplane_started =3D false;
>>      s->stopping =3D false;
>>  }
>> --=20
>> 2.20.1
>>
>=20
> Along the lines of what John said:
>=20
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virti=
o-blk.c
> index 9299a1a7c2..4030faa21d 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -301,6 +301,8 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
> +    qemu_bh_cancel(s->bh);
> +    notify_guest_bh(s); /* final chance to notify guest */
> +
>      /* Clean up guest notifier (irq) */
>      k->set_guest_notifiers(qbus->parent, nvqs, false);
> =20
>      vblk->dataplane_started =3D false;
>      s->stopping =3D false;
>  }
>=20
> Let's notify the guest if any batched notifications are waiting.  This
> ensures that no notifications are lost when dataplane is stopped.

OK, works for me, thanks!

