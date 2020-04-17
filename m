Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D38C38A29
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8297D21D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqOrQTVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8297D21D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOf3-0007eR-Ka
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPOeI-0006lx-Gs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPOeG-0007SU-H9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:55:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPOeG-0007R3-Ak
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587120903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ti9I71S/Q6d7hiEq2xAePCcdZneNNmIFl8fap07HnG4=;
 b=VqOrQTVo52SZCj0VSJ3jzxOj9rhEUu5k+Fmdf/q4rBnKDRV2nRAk6xSI0Uxv6PJyZSj58F
 CW6cfmqnRUJyN4z/PiQ2FLKnajppt5QIU3A7mNoCxgwCAFWhO0fz4ep+TQF3Q7Sl+q8AIi
 J12lqiaIns/0/o6jFD6Z1TY/+u9xhzI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-wZrsHUffPn-tPK-WrldOfw-1; Fri, 17 Apr 2020 06:55:00 -0400
X-MC-Unique: wZrsHUffPn-tPK-WrldOfw-1
Received: by mail-ej1-f71.google.com with SMTP id 9so855627ejv.16
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ti9I71S/Q6d7hiEq2xAePCcdZneNNmIFl8fap07HnG4=;
 b=gl3f+D4mMeLv++UzudjVCEqQJhiyySWBUu77Xz05CldZm3peoKxESEYN6yrfNEl5OT
 CLEmvi9AnWip5m8PAsdScWAjAwbZiz/ji6XRXcwXnHhbPGXZBWJFWdaB9RC7MebVYlc7
 sfveX6235++8z4Z3pg4IqsKsEyCwpBanrdm7kAXiWj9Jp79F3P063T6KZRoV4wQJpHfA
 F5XJOxuL3vp3eSq6zMHsMUIOAbdROPJ5O25stb73TpCB74C4SnTO3ZiXAP8LX7Wcjavy
 pzKqRTrktH5j/zoZPM0cYb/RRM57W14Cf+h31CeN+x9PtgjROWmdLFDEcSiq/bEApNMr
 Wh2Q==
X-Gm-Message-State: AGi0PuZp3jTeeFols6ntLiFyl65t1Uhe0s74CEdM10q4/Tt6zcU3U3mY
 1Qw3V55YjGALgUxJMfub/CB8g+M2I2cUHFmFrJeZbN7BZRwnCw/cJTEtXARd0Qjny/ttj3mcs0r
 QwU0CM5v0A+wYRLg=
X-Received: by 2002:a17:906:3296:: with SMTP id
 22mr2431675ejw.195.1587120898797; 
 Fri, 17 Apr 2020 03:54:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypL8sdrU2aZVnAZDlRbdfQUAg6ks90vL0J6QwNbIXhumfSD9wvpWq2A4fJlj3xidk7523VPFhA==
X-Received: by 2002:a17:906:3296:: with SMTP id
 22mr2431649ejw.195.1587120898429; 
 Fri, 17 Apr 2020 03:54:58 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b13sm3006342edv.88.2020.04.17.03.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 03:54:57 -0700 (PDT)
Subject: Re: [PATCH] vhost-user-blk: fix invalid memory access
To: Li Feng <fengli@smartx.com>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20200417101707.14467-1-fengli@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d3d5f4b-aa98-7b99-015a-0a3f541e8367@redhat.com>
Date: Fri, 17 Apr 2020 12:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200417101707.14467-1-fengli@smartx.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: lifeng1519@gmail.com, fanyang@smartx.com, kyle@smartx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 4/17/20 12:17 PM, Li Feng wrote:
> when s->inflight is freed, vhost_dev_free_inflight may try to access
> s->inflight->addr, it will retrigger the following issue.
> 
> ==7309==ERROR: AddressSanitizer: heap-use-after-free on address 0x604001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
> READ of size 8 at 0x604001020d18 thread T0
>      #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7/qemu-test/hw/virtio/vhost.c:1473
>      #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/hw/virtio/virtio.c:1214
>      #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
>      #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
>      #4 0x5555561d572c in property_set_bool qom/object.c:1925
>      #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c:27
>      #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
>      #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-test/qdev-monitor.c:626

Maybe cut <--

>      #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-test/qdev-monitor.c:806
>      #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-test/hmp.c:1951
>      #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qemu-test/monitor.c:3404
>      #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qemu-test/monitor.c:4296
>      #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
>      #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test/monitor.c:4279
>      #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
>      #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x4a968)
>      #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
>      #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
>      #18 0x55555640727c in main_loop_wait util/main-loop.c:497
>      #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl.c:2013
>      #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:4776
>      #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
>      #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmmu/qemu-system-x86_64+0x5e367a)

-->.

> 
> 0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020d10,0x604001020d38)
> freed by thread T0 here:
>      #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde508)
>      #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)
> 
> previously allocated by thread T0 here:
>      #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xdea88)
>      #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)
> 
> SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qemu-test/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
> Shadow bytes around the buggy address:
>    0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
>    0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
>    0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
>    0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
>    0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
> =>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
>    0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
>    0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
>    0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
>    0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
>    0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>    Addressable:           00
>    Partially addressable: 01 02 03 04 05 06 07
>    Heap left redzone:       fa
>    Freed heap region:       fd

cut <--

>    Stack left redzone:      f1
>    Stack mid redzone:       f2
>    Stack right redzone:     f3
>    Stack after return:      f5
>    Stack use after scope:   f8
>    Global redzone:          f9
>    Global init order:       f6
>    Poisoned by user:        f7
>    Container overflow:      fc
>    Array cookie:            ac
>    Intra object redzone:    bb
>    ASan internal:           fe
>    Left alloca redzone:     ca
>    Right alloca redzone:    cb

-->

> ==7309==ABORTING
> 
> Signed-off-by: Li Feng <fengli@smartx.com>

What did you change since your previous version Raphael Norwitz already 
reviewed? The patch looks the same...
https://www.mail-archive.com/qemu-devel@nongnu.org/msg696385.html

> ---
>   hw/block/vhost-user-blk.c | 4 ++++
>   hw/virtio/vhost.c         | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 776b9af3eb..19e79b96e4 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -463,7 +463,9 @@ reconnect:
>   
>   virtio_err:
>       g_free(s->vhost_vqs);
> +    s->vhost_vqs = NULL;
>       g_free(s->inflight);
> +    s->inflight = NULL;
>       for (i = 0; i < s->num_queues; i++) {
>           virtio_delete_queue(s->virtqs[i]);
>       }
> @@ -484,7 +486,9 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
>       vhost_dev_cleanup(&s->dev);
>       vhost_dev_free_inflight(s->inflight);
>       g_free(s->vhost_vqs);
> +    s->vhost_vqs = NULL;
>       g_free(s->inflight);
> +    s->inflight = NULL;
>   
>       for (i = 0; i < s->num_queues; i++) {
>           virtio_delete_queue(s->virtqs[i]);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 01ebe12f28..aff98a0ede 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
>   
>   void vhost_dev_free_inflight(struct vhost_inflight *inflight)
>   {
> -    if (inflight->addr) {
> +    if (inflight && inflight->addr) {
>           qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
>           inflight->addr = NULL;
>           inflight->fd = -1;
> 


