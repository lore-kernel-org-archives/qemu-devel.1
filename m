Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE6AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5605E20449
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5605E20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpX16-0004H2-HX
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpX0p-0003n0-3H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpX0n-0006pn-CV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:01:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpX0n-0006jo-6X
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:01:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so34893254wma.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 05:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QxwSqHBA8DRjSa2MMWLacwC6rG8/TBDpIBgzm86NSR4=;
 b=QTRpvjyYNWbC1h6zQpV4AdVSjpfWBvlYO5bvQ/tklE2RUIOVwj7aWMfliWSXx5X2Dh
 k0/f1ChG7cDN8IzyPhrqVMmH6osQOBYPFtWVzJpG+YV4bb4c235rWcqkDFhAGIeKTyiy
 KX8/cDSddqXslmL7oC2LJLoQSLhWNsamh/5mIeGj40jT0NYeKps2s3oy8sjMqHRBDLfO
 M44ch+0LksiD2R1nndbFEGvT38o13KiWa84xns+PyAg2sYNockfSeVf1Fi2ECC4USa5I
 0Db4gePZd7S8mNM3MXPK8bumHOR4bJHv52uYkCl2JR2u5rbaUaWDdzAW8ELRDW1dYM1p
 hv5Q==
X-Gm-Message-State: APjAAAX3QMd82EKbB+iODA4KOAL1T+4Y3d003E2efiS7pbwRP+qL3HHf
 emU7Ifa4wiOsN+v+eGv2xMgXdsKf1as=
X-Google-Smtp-Source: APXvYqwz8dgbLxSh1ahYZWA51owkJ5aygVmQkSbltkuv93r13pwdmprKfisADjOr5uECtqSiobmVuw==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr62254050wmi.77.1563796906857; 
 Mon, 22 Jul 2019 05:01:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id e5sm39541188wro.41.2019.07.22.05.01.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 05:01:46 -0700 (PDT)
To: l00284672 <lizhengui@huawei.com>, kwolf@redhat.com
References: <1563696502-7972-1-git-send-email-lizhengui@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3d900e19-5025-c882-627b-8217a8ba1542@redhat.com>
Date: Mon, 22 Jul 2019 14:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563696502-7972-1-git-send-email-lizhengui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] virtio-scsi: fixed
 virtio_scsi_ctx_check failed when detaching scsi disk
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
Cc: jiangyiwen@huawei.com, wangjie88@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/07/19 10:08, l00284672 wrote:
> commit a6f230c move blockbackend back to main AioContext on unplug. It set the AioContext of
> SCSIDevice to the main AioContex, but s->ctx is still the iothread AioContex（if the scsi controller
> is configure with iothread）. So if there are having in-flight requests during unplug, a failing assertion
> happend. The bt is below:
> (gdb) bt
> #0  0x0000ffff86aacbd0 in raise () from /lib64/libc.so.6
> #1  0x0000ffff86aadf7c in abort () from /lib64/libc.so.6
> #2  0x0000ffff86aa6124 in __assert_fail_base () from /lib64/libc.so.6
> #3  0x0000ffff86aa61a4 in __assert_fail () from /lib64/libc.so.6
> #4  0x0000000000529118 in virtio_scsi_ctx_check (d=<optimized out>, s=<optimized out>, s=<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:246
> #5  0x0000000000529ec4 in virtio_scsi_handle_cmd_req_prepare (s=0x2779ec00, req=0xffff740397d0) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:559
> #6  0x000000000052a228 in virtio_scsi_handle_cmd_vq (s=0x2779ec00, vq=0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:603
> #7  0x000000000052afa8 in virtio_scsi_data_plane_handle_cmd (vdev=<optimized out>, vq=0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplane.c:59
> #8  0x000000000054d94c in virtio_queue_host_notifier_aio_poll (opaque=<optimized out>) at /home/qemu-4.0.0/hw/virtio/virtio.c:2452
> 
> assert(blk_get_aio_context(d->conf.blk) == s->ctx) failed.
> 
> To avoid assertion failed,  moving the "if" after qdev_simple_device_unplug_cb.
> 
> In addition, to avoid another qemu crash below, add aio_disable_external before
> qdev_simple_device_unplug_cb, which disable the further processing of external clients
> when doing qdev_simple_device_unplug_cb.
> (gdb) bt
> #0  scsi_req_unref (req=0xffff6802c6f0) at hw/scsi/scsi-bus.c:1283
> #1  0x00000000005294a4 in virtio_scsi_handle_cmd_req_submit (req=<optimized out>,
>     s=<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:589
> #2  0x000000000052a2a8 in virtio_scsi_handle_cmd_vq (s=s@entry=0x9c90e90,
>     vq=vq@entry=0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:625
> #3  0x000000000052afd8 in virtio_scsi_data_plane_handle_cmd (vdev=<optimized out>,
>     vq=0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplane.c:60
> #4  0x000000000054d97c in virtio_queue_host_notifier_aio_poll (opaque=<optimized out>)
>     at /home/qemu-4.0.0/hw/virtio/virtio.c:2447
> #5  0x00000000009b204c in run_poll_handlers_once (ctx=ctx@entry=0x6efea40,
>     timeout=timeout@entry=0xffff7d7f7308) at util/aio-posix.c:521
> #6  0x00000000009b2b64 in run_poll_handlers (ctx=ctx@entry=0x6efea40,
>     max_ns=max_ns@entry=4000, timeout=timeout@entry=0xffff7d7f7308) at util/aio-posix.c:559
> #7  0x00000000009b2ca0 in try_poll_mode (ctx=ctx@entry=0x6efea40, timeout=0xffff7d7f7308,
>     timeout@entry=0xffff7d7f7348) at util/aio-posix.c:594
> #8  0x00000000009b31b8 in aio_poll (ctx=0x6efea40, blocking=blocking@entry=true)
>     at util/aio-posix.c:636
> #9  0x00000000006973cc in iothread_run (opaque=0x6ebd800) at iothread.c:75
> #10 0x00000000009b592c in qemu_thread_start (args=0x6efef60) at util/qemu-thread-posix.c:502
> #11 0x0000ffff8057f8bc in start_thread () from /lib64/libpthread.so.0
> #12 0x0000ffff804e5f8c in thread_start () from /lib64/libc.so.6
> (gdb) p bus
> $1 = (SCSIBus *) 0x0
> 
> Signed-off-by: Zhengui li <lizhengui@huawei.com>
> ---
>  hw/scsi/virtio-scsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 839f120..79e555f 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -837,13 +837,15 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          virtio_scsi_release(s);
>      }
>  
> +    aio_disable_external(s->ctx);
> +    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
> +    aio_enable_external(s->ctx);
> +
>      if (s->ctx) {
>          virtio_scsi_acquire(s);
>          blk_set_aio_context(sd->conf.blk, qemu_get_aio_context());
>          virtio_scsi_release(s);
>      }
> -
> -    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
>  }
>  
>  static struct SCSIBusInfo virtio_scsi_scsi_info = {
> 

Queued, thanks.

Paolo

