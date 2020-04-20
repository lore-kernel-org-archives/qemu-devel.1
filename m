Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D6C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DC6206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa5DgDBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DC6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSOC-0004Oo-1M
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSM1-0001cw-GJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSLq-0007w8-2l
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSLp-0007vH-Kl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587373464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2F38n83DNBjv6uKYmWR3tQ3H+OnpTOnwXP+NqocoCE=;
 b=aa5DgDBtJl1qQMVTBdzX9bRwqwL6Vp5RGdhEQ3NE8cBDQRbQXrxC6Q0LTpDDmnBGVJjV97
 NY+yOGIYXnz+X7LGJNBmluo9CgK9NSME4DycLFA9Et5rbUVosJ7Jq8ucO4VzW0ANcjiEAr
 8KaA0fmIM+yOw9GTBMRv23cTeenfrgM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-SbNnLBmkNQGztWy9e5NFNg-1; Mon, 20 Apr 2020 05:04:22 -0400
X-MC-Unique: SbNnLBmkNQGztWy9e5NFNg-1
Received: by mail-ej1-f71.google.com with SMTP id j3so510502ejb.16
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RlsTPrg9QiqpxfgT7qSthf7eni7nDK35G/VVoQb8m0Q=;
 b=lHhWFMGBQPtg0aZFLAcsuAGpwDp3MViVK42mKCru3yIizSUCJUsN53pzqzND3VyzuE
 +1hezXZvDK/ik5fm32bvNDc9BXxXFn9JblQRCRIbb18b5deZIGV+whL7rS6r6OwIYZvT
 Ao/aEPb6MbMP4XIu5R85ltQm1BrmYa33dfnypTdHVhZMPEVYtQSrK3bm41A1wjvW/L3h
 fOcYEaRfPYV+IyG5lU6YjH7flqINTRuCmWM/WNRq9vhsceFctJjSKjCQ8OZvzA7GgZDj
 GD2f9/AdBYcNNXIVpHNzzgH6DdXWe6QWNS6QiFGyG3LsXLndS+3HWs4fIsYIJMxacYZU
 xWLQ==
X-Gm-Message-State: AGi0PuZJ6rflBvLBf65PutBy77kaz/9eFGMYJIgBFMKBZiUf+mFf/gP9
 Vq0xfUczJED9tux7+v/uNsAD0spM1FnMa6HLzBUtixSJve1s+8gjKE4AQjAKaLb3fCQB6dlJ9hX
 Z+fhuntzBoOqri4g=
X-Received: by 2002:a50:f617:: with SMTP id c23mr12911900edn.60.1587373461613; 
 Mon, 20 Apr 2020 02:04:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypLceMAOjqlYJfJWBeU89WiOHiP49tIIOtIEbCLfgbNeZRwFvAppAA06/2yEHufCoWd0R3VNLw==
X-Received: by 2002:a50:f617:: with SMTP id c23mr12911876edn.60.1587373461321; 
 Mon, 20 Apr 2020 02:04:21 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v12sm25209edw.51.2020.04.20.02.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 02:04:20 -0700 (PDT)
Subject: Re: [PATCH 08/11] virtio-net: Fix duplex=... and speed=... error
 handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-9-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71c59655-4d7e-ba77-64eb-ee795adf2fae@redhat.com>
Date: Mon, 20 Apr 2020 11:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420083236.19309-9-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Markus Armbruster wrote:
> virtio_net_device_realize() rejects invalid duplex and speed values.
> The error handling is broken:
>=20
>      $ ../qemu/bld-sani/x86_64-softmmu/qemu-system-x86_64 -S -display non=
e -monitor stdio
>      QEMU 4.2.93 monitor - type 'help' for more information
>      (qemu) device_add virtio-net,duplex=3Dx
>      Error: 'duplex' must be 'half' or 'full'
>      (qemu) c
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      =3D=3D15654=3D=3DERROR: AddressSanitizer: heap-use-after-free on add=
ress 0x62e000014590 at pc 0x560b75c8dc13 bp 0x7fffdf1a6950 sp 0x7fffdf1a694=
0
>      READ of size 8 at 0x62e000014590 thread T0
> =09#0 0x560b75c8dc12 in object_dynamic_cast_assert /work/armbru/qemu/qom/=
object.c:826
> =09#1 0x560b74c38ac0 in virtio_vmstate_change /work/armbru/qemu/hw/virtio=
/virtio.c:3210
> =09#2 0x560b74d9765e in vm_state_notify /work/armbru/qemu/softmmu/vl.c:12=
71
> =09#3 0x560b7494ba72 in vm_prepare_start /work/armbru/qemu/cpus.c:2156
> =09#4 0x560b7494bacd in vm_start /work/armbru/qemu/cpus.c:2162
> =09#5 0x560b75a7d890 in qmp_cont /work/armbru/qemu/monitor/qmp-cmds.c:160
> =09#6 0x560b75a8d70a in hmp_cont /work/armbru/qemu/monitor/hmp-cmds.c:104=
3
> =09#7 0x560b75a799f2 in handle_hmp_command /work/armbru/qemu/monitor/hmp.=
c:1082
>      [...]
>=20
>      0x62e000014590 is located 33168 bytes inside of 42288-byte region [0=
x62e00000c400,0x62e000016930)
>      freed by thread T1 here:
> =09#0 0x7feadd39491f in __interceptor_free (/lib64/libasan.so.5+0x10d91f)
> =09#1 0x7feadcebcd7c in g_free (/lib64/libglib-2.0.so.0+0x55d7c)
> =09#2 0x560b75c8fd40 in object_unref /work/armbru/qemu/qom/object.c:1128
> =09#3 0x560b7498a625 in memory_region_unref /work/armbru/qemu/memory.c:17=
62
> =09#4 0x560b74999fa4 in do_address_space_destroy /work/armbru/qemu/memory=
.c:2788
> =09#5 0x560b762362fc in call_rcu_thread /work/armbru/qemu/util/rcu.c:283
> =09#6 0x560b761c8884 in qemu_thread_start /work/armbru/qemu/util/qemu-thr=
ead-posix.c:519
> =09#7 0x7fead9be34bf in start_thread (/lib64/libpthread.so.0+0x84bf)
>=20
>      previously allocated by thread T0 here:
> =09#0 0x7feadd394d18 in __interceptor_malloc (/lib64/libasan.so.5+0x10dd1=
8)
> =09#1 0x7feadcebcc88 in g_malloc (/lib64/libglib-2.0.so.0+0x55c88)
> =09#2 0x560b75c8cf8a in object_new /work/armbru/qemu/qom/object.c:699
> =09#3 0x560b75010ad9 in qdev_device_add /work/armbru/qemu/qdev-monitor.c:=
654
> =09#4 0x560b750120c2 in qmp_device_add /work/armbru/qemu/qdev-monitor.c:8=
05
> =09#5 0x560b75012c1b in hmp_device_add /work/armbru/qemu/qdev-monitor.c:9=
05
>      [...]
>      =3D=3D15654=3D=3DABORTING
>=20
> Cause: virtio_net_device_realize() neglects to bail out after setting
> the error.  Fix that.
>=20
> Fixes: 9473939ed7addcaaeb8fde5c093918fb7fa0919c
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/net/virtio-net.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a46e3b37a7..b52ff4ab63 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2947,6 +2947,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>               n->net_conf.duplex =3D DUPLEX_FULL;
>           } else {
>               error_setg(errp, "'duplex' must be 'half' or 'full'");
> +            return;
>           }
>           n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>       } else {
> @@ -2955,7 +2956,9 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>  =20
>       if (n->net_conf.speed < SPEED_UNKNOWN) {
>           error_setg(errp, "'speed' must be between 0 and INT_MAX");
> -    } else if (n->net_conf.speed >=3D 0) {
> +        return;
> +    }
> +    if (n->net_conf.speed >=3D 0) {
>           n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


