Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C343206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtMPmwrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C343206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05uN-00035U-OM
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k05tn-0002ck-Ps
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:22:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k05tl-0002z6-Tx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:22:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id a15so15491815wrh.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Cbq8j1Cg0CNd45GdIyHF+L+geEdQFHWN6A6F/pE7SIw=;
 b=BtMPmwrKpjSB+JJkyCrKdUzsnTTPsAxFNtudqzakZKGkOTb70pPOAYYAZtKhzRelBx
 L5DwCZ0ei7NViI8CM8BHJYWhjJyhr22/y3WvaN1f21xyiEUJ8G+US6jby2BQJ+R//D5E
 /ZzLFgppc8vfop9gAGsupLkoOLA51v8czmOBy8LJ5111PbTOOnGB/m98/fxzIqjKwRaz
 NxnGCRZ5RZnBIAe7cfhDA9EXr3TQrX79Zi8sedvDH7MudI7aPbUA8Ms/T2eIJHoSjKJB
 quM8vxZHl3wDdfqUgtnnNpwqmGff27jWjH8ahrf6tWI+8eIK+OxIXFJVS/i/mYkIVl74
 +5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Cbq8j1Cg0CNd45GdIyHF+L+geEdQFHWN6A6F/pE7SIw=;
 b=ZXBxFLAVjXiKXBUYARuiwSVzg8zLpX2ZHsWG0JThULG380+kVwXB04hSeNV2n9evZO
 BOVk8Yt6+wuKHt4/pcunqGWSbu4DePTPGXyhgYjuJHeAEckeubXPaLaWZ3seLw/BV6/a
 YbMHtx7eJHXkyN9Y8acDNHxPH6mXURqK19/OPouCFSqlPKgh3ovirZd8lFrn/APnqr9j
 1icQq34RW6NwtZ7CWR3kpFxwf4SSd4/FHVlUNo9ekjBkNrSNYEahhnERRryOwdebgO35
 DGiUw59hSRsHHloAsauz+Kx2bDMrAy8DpHlme4PVuMYhk+oMKsrzQiBGGuoCEI9x0rGU
 YBrA==
X-Gm-Message-State: AOAM530vyi46eKLJRZgp5RxjQDtKI/vX5mbKfeqoEUhfYEfdw00J75wB
 YjBKOiqKFxOhUXKI4CGqUwiV9w==
X-Google-Smtp-Source: ABdhPJwB3QH3D1at/nsk20zS1v39Y3GmKmEC+hjKmhzupS9W8oyMQfHUrLz3xU5Y+m7OkUeEBQEQQg==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr20602881wrt.159.1595866964019; 
 Mon, 27 Jul 2020 09:22:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h11sm14076954wrb.68.2020.07.27.09.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 09:22:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB94A1FF7E;
 Mon, 27 Jul 2020 17:22:41 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-6-alex.bennee@linaro.org>
 <20200727093107-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH  v1 05/13] hw/virtio/pci: include vdev name in
 registered PCI sections
In-reply-to: <20200727093107-mutt-send-email-mst@kernel.org>
Date: Mon, 27 Jul 2020 17:22:41 +0100
Message-ID: <87zh7l2ai6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Jul 09, 2020 at 03:13:19PM +0100, Alex Benn=C3=83=C2=A9e wrote:
>> When viewing/debugging memory regions it is sometimes hard to figure
>> out which PCI device something belongs to. Make the names unique by
>> including the vdev name in the name string.
>>=20
>> Signed-off-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> So I don't know what's the plan here. I think ideally core would
> just do it for us automatically. Why not?
> If it can't my ack stands, anyway, pls
> merge with rest of the patches if that is deemed appropriate.

Yeah currently it's sitting in my plugins/next queue which isn't
targeting 5.1. As the hwprofile plugin is the only one I know using it I
figured I'd keep it with those.

>
>> ---
>> v2
>>   - swap ()'s for an extra -
>> ---
>>  hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 8554cf2a038e..215e680c71f4 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1406,7 +1406,8 @@ static void virtio_pci_device_write(void *opaque, =
hwaddr addr,
>>      }
>>  }
>>=20=20
>> -static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
>> +static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
>> +                                           const char *vdev_name)
>>  {
>>      static const MemoryRegionOps common_ops =3D {
>>          .read =3D virtio_pci_common_read,
>> @@ -1453,36 +1454,41 @@ static void virtio_pci_modern_regions_init(VirtI=
OPCIProxy *proxy)
>>          },
>>          .endianness =3D DEVICE_LITTLE_ENDIAN,
>>      };
>> +    g_autoptr(GString) name =3D g_string_new(NULL);
>>=20=20
>> -
>> +    g_string_printf(name, "virtio-pci-common-%s", vdev_name);
>>      memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
>>                            &common_ops,
>>                            proxy,
>> -                          "virtio-pci-common",
>> +                          name->str,
>>                            proxy->common.size);
>>=20=20
>> +    g_string_printf(name, "virtio-pci-isr-%s", vdev_name);
>>      memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
>>                            &isr_ops,
>>                            proxy,
>> -                          "virtio-pci-isr",
>> +                          name->str,
>>                            proxy->isr.size);
>>=20=20
>> +    g_string_printf(name, "virtio-pci-device-%s", vdev_name);
>>      memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
>>                            &device_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-device",
>> +                          name->str,
>>                            proxy->device.size);
>>=20=20
>> +    g_string_printf(name, "virtio-pci-notify-%s", vdev_name);
>>      memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
>>                            &notify_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-notify",
>> +                          name->str,
>>                            proxy->notify.size);
>>=20=20
>> +    g_string_printf(name, "virtio-pci-notify-pio-%s", vdev_name);
>>      memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
>>                            &notify_pio_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-notify-pio",
>> +                          name->str,
>>                            proxy->notify_pio.size);
>>  }
>>=20=20
>> @@ -1623,7 +1629,7 @@ static void virtio_pci_device_plugged(DeviceState =
*d, Error **errp)
>>=20=20
>>          struct virtio_pci_cfg_cap *cfg_mask;
>>=20=20
>> -        virtio_pci_modern_regions_init(proxy);
>> +        virtio_pci_modern_regions_init(proxy, vdev->name);
>>=20=20
>>          virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
>>          virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
>> --=20
>> 2.20.1


--=20
Alex Benn=C3=A9e

