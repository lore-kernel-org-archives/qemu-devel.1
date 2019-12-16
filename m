Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FCC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7893520700
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXD83HhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7893520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguTC-0004Om-Kz
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iguSG-0003Wx-EM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iguSC-00026C-2k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:46:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iguSB-00024U-Tb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576518402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUKsiAeYGC7LpYT/kUsIxrWViEWq3sJgvJ8IBKiyZ74=;
 b=JXD83HhS0lYshl22RTxpQaQKe92vV0KSAQ2kOPb4uy+Auw1X+wk/dXkrO0Frb0NlgGQSZd
 zmAolh1RuuAr7QU7y5J2l+AIi1aJ2tU2N3RfqIlE4dcaKWlHR0/ugC/10dqA9obd2l17Uf
 Hidcq49RW/TueQ4ljn/xSqS8zr73Vwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-5Obgt9poOmmQ7Hppmsm7Ag-1; Mon, 16 Dec 2019 12:46:39 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so50369wma.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 09:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lNOBW/V+pA18dYMQuHFi7+TcZj4/PVgD33YyIXP1krc=;
 b=Vfx3Gd81Yx0Pb6ptiSVlwBDJfUDf684kZxtmF4Nct1f2aTdlm1ZJD+vVNx3CdZAKO2
 h4+7R2dI73ehob9EUvEFzaVFBlp1msMwstw7+7TeZW9f04TbMvSx4nhmIxs22ZKfwQfe
 S4/zbjnkmtpUfqKZWinNqKomOeSSDnPorAi3tb94BJuYdeSdC/qTltoybDM+DEm3t1Yd
 8ktCSSDrM9CW5efcdi7pkIMRbQsYiLfOYj32Ol5Gm+ujNrQlifkir0tsQqIAQaWetYLW
 vDCd8jIIKKZfQ/XR8DfT3d8L4Efmd1h2QoNUbYt2G7YFBHksk1sbUYSngLI8unwe/0dX
 kOhw==
X-Gm-Message-State: APjAAAW0GScQ1vOtmcjj0PLfeM36sdJIohfpfjgFBPumEYlsk8bx7eY4
 8I8g5ZVJPouwhRGdTDyH69CRQnCVJg2gIFoO8CUlxcj0pbw1ZYsoEPZVye5PYcF5jF9wxNr7WiF
 gJUiV9iRdPc8y6vM=
X-Received: by 2002:a5d:5704:: with SMTP id a4mr31479371wrv.198.1576518397297; 
 Mon, 16 Dec 2019 09:46:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiKPdvKiYm6EhqVRDyLIztNkqyHqtiLv90JTrhS5wXSRwngKuPUKKRwQumAALOxLk+dgMAcg==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr31479336wrv.198.1576518396821; 
 Mon, 16 Dec 2019 09:46:36 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n16sm22494542wro.88.2019.12.16.09.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 09:46:36 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
Date: Mon, 16 Dec 2019 18:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
Content-Language: en-US
X-MC-Unique: 5Obgt9poOmmQ7Hppmsm7Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 2:08 PM, Paolo Bonzini wrote:
> On 14/12/19 17:02, Philippe Mathieu-Daud=C3=A9 wrote:
>> If a subregion is mapped out of the parent region range, it
>> will never get accessed. Since this is a bug, abort to help
>> the developer notice the mistake.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   memory.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/memory.c b/memory.c
>> index 06484c2bff..61f355dcd5 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -2390,6 +2390,7 @@ static void memory_region_add_subregion_common(Mem=
oryRegion *mr,
>>   {
>>       assert(!subregion->container);
>>       subregion->container =3D mr;
>> +    assert(offset + memory_region_size(subregion) <=3D memory_region_si=
ze(mr));
>>       subregion->addr =3D offset;
>>       memory_region_update_container_subregions(subregion);
>>   }
>>
>=20
> I think in some cases this could be intentional, for example if you have
> different models with different BAR sizes and you organize this with the
> same tree of MemoryRegion and different sizes for the parent.

But if a child is outside of the parent range, it can't be reached,=20
right? I'm confused, maybe AddressSpace can do that, but MemoryRegion=20
shouldn't?

In the PCI case, you will simply alias a subregion with=20
memory_region_init_alias(..., size), and size has to be <=3D parent size.
But you won't add the PCI region, you'll add the alias, so the assert=20
won't fire.

> I'm not
> saying this happens in the current devices we support, I'm just
> wondering if it should be a reason not to apply the patch.  I suppose
> you did spend some time debugging something where the patch would have
> been useful; what was that something?

I'm updating some devices to use relative base address, instead of=20
absolute one. This is useful when a subdevice is reused in another=20
device but mapped at a different location.

One case is the Raspberry Pi:

$ git grep BCM2835_VC_PERI_BASE
hw/arm/bcm2835_peripherals.c:20:#define BCM2835_VC_PERI_BASE 0x7e000000
hw/arm/bcm2835_peripherals.c:156:=20
memory_region_add_subregion_overlap(&s->gpu_bus_mr, BCM2835_VC_PERI_BASE,

The GPU physical address space is 1GiB, and virtual is 4GiB. Currently=20
the device is mapped in virtual space, not respecting the GPU cache=20
mappings. If we move the chipset base address (and correct the cache=20
mappings) this device ends out of the GPU physical address space.

To have it working I had to correct the physical address to 0x3e000000.

Maybe 'info mtree' is more explicit:

before:

address-space: bcm2835-dma-memory
0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
   0000000000000000-000000003fffffff (prio 0, i/o): alias=20
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
   0000000040000000-000000007fffffff (prio 0, i/o): alias=20
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
   000000007e000000-000000007effffff (prio 1, i/o): alias=20
bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
   0000000080000000-00000000bfffffff (prio 0, i/o): alias=20
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
   00000000c0000000-00000000ffffffff (prio 0, i/o): alias=20
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

after:

address-space: bcm2835-dma-memory
0000000000000000-00000000ffffffff (prio 0, i/o): gpu-bus
   0000000000000000-000000003fffffff (prio 0, i/o): alias l1-l2-cached=20
@videocore 0000000000000000-000000003fffffff
   0000000040000000-000000007fffffff (prio 0, i/o): alias=20
l2-cached-coherent @videocore 0000000000000000-000000003fffffff
   0000000080000000-00000000bfffffff (prio 0, i/o): alias l2-cached=20
@videocore 0000000000000000-000000003fffffff
   00000000c0000000-00000000ffffffff (prio 0, i/o): alias=20
direct-uncached @videocore 0000000000000000-000000003fffffff

memory-region: videocore
0000000000000000-000000003fffffff (prio 0, i/o): videocore
   0000000000000000-000000003fffffff (prio 0, i/o): alias vc-ram @ram=20
0000000000000000-000000003fffffff
   000000003e000000-000000003effffff (prio 1, i/o): alias vc-peripherals=20
@bcm2835-peripherals 0000000000000000-0000000000ffffff

Even clearer, a diff of 'info mtree -f':

  (qemu) info mtree -f
  FlatView #0
   AS "bcm2835-fb-memory", root: gpu-bus
   AS "bcm2835-property-memory", root: gpu-bus
   AS "bcm2835-dma-memory", root: gpu-bus
   Root memory region: gpu-bus
-  0000000000000000-000000003fffffff (prio 0, ram): ram
+  0000000000000000-000000003e002fff (prio 0, ram): ram
+  000000003e003000-000000003e00301f (prio 0, i/o): bcm2835-sys-timer
+  000000003e003020-000000003e006fff (prio 0, ram): ram @000000003e003020
+  000000003e007000-000000003e007fff (prio 0, i/o): bcm2835-dma
+  000000003e008000-000000003e00b1ff (prio 0, ram): ram @000000003e008000
+  000000003e00b200-000000003e00b3ff (prio 0, i/o): bcm2835-ic
+  000000003e00b400-000000003e00b43f (prio -1000, i/o): bcm2835-sp804
+  000000003e00b440-000000003e00b7ff (prio 0, ram): ram @000000003e00b440
+  000000003e00b800-000000003e00bbff (prio 0, i/o): bcm2835-mbox
+  000000003e00bc00-000000003e0fffff (prio 0, ram): ram @000000003e00bc00
+  000000003e100000-000000003e100fff (prio -1000, i/o): bcm2835-cprman
+  000000003e101000-000000003e101fff (prio 0, ram): ram @000000003e101000
+  000000003e102000-000000003e102fff (prio -1000, i/o): bcm2835-a2w
+  000000003e103000-000000003e103fff (prio 0, ram): ram @000000003e103000
+  000000003e104000-000000003e10400f (prio 0, i/o): bcm2835-rng
+  000000003e104010-000000003e1fffff (prio 0, ram): ram @000000003e104010
+  000000003e200000-000000003e200fff (prio 0, i/o): bcm2835_gpio
+  000000003e201000-000000003e201fff (prio 0, i/o): pl011
+  000000003e202000-000000003e202fff (prio 0, i/o): bcm2835-sdhost
+  000000003e203000-000000003e2030ff (prio -1000, i/o): bcm2835-i2s
+  000000003e203100-000000003e203fff (prio 0, ram): ram @000000003e203100
+  000000003e204000-000000003e20401f (prio -1000, i/o): bcm2835-spi0
+  000000003e204020-000000003e204fff (prio 0, ram): ram @000000003e204020
+  000000003e205000-000000003e20501f (prio -1000, i/o): bcm2835-i2c0
+  000000003e205020-000000003e20efff (prio 0, ram): ram @000000003e205020
+  000000003e20f000-000000003e20f07f (prio -1000, i/o): bcm2835-otp
+  000000003e20f080-000000003e211fff (prio 0, ram): ram @000000003e20f080
+  000000003e212000-000000003e212007 (prio 0, i/o): bcm2835-thermal
+  000000003e212008-000000003e213fff (prio 0, ram): ram @000000003e212008
+  000000003e214000-000000003e2140ff (prio -1000, i/o): bcm2835-spis
+  000000003e214100-000000003e214fff (prio 0, ram): ram @000000003e214100
+  000000003e215000-000000003e2150ff (prio 0, i/o): bcm2835-aux
+  000000003e215100-000000003e2fffff (prio 0, ram): ram @000000003e215100
+  000000003e300000-000000003e3000ff (prio 0, i/o): sdhci
+  000000003e300100-000000003e5fffff (prio 0, ram): ram @000000003e300100
+  000000003e600000-000000003e6000ff (prio -1000, i/o): bcm2835-smi
+  000000003e600100-000000003e803fff (prio 0, ram): ram @000000003e600100
+  000000003e804000-000000003e80401f (prio -1000, i/o): bcm2835-i2c1
+  000000003e804020-000000003e804fff (prio 0, ram): ram @000000003e804020
+  000000003e805000-000000003e80501f (prio -1000, i/o): bcm2835-i2c2
+  000000003e805020-000000003e8fffff (prio 0, ram): ram @000000003e805020
+  000000003e900000-000000003e907fff (prio -1000, i/o): bcm2835-dbus
+  000000003e908000-000000003e90ffff (prio 0, ram): ram @000000003e908000
+  000000003e910000-000000003e917fff (prio -1000, i/o): bcm2835-ave0
+  000000003e918000-000000003e97ffff (prio 0, ram): ram @000000003e918000
+  000000003e980000-000000003e980fff (prio -1000, i/o): dwc-usb2
+  000000003e981000-000000003edfffff (prio 0, ram): ram @000000003e981000
+  000000003ee00000-000000003ee000ff (prio -1000, i/o): bcm2835-sdramc
+  000000003ee00100-000000003ee04fff (prio 0, ram): ram @000000003ee00100
+  000000003ee05000-000000003ee050ff (prio 0, i/o): bcm2835-dma-chan15
+  000000003ee05100-000000003fffffff (prio 0, ram): ram @000000003ee05100
    0000000040000000-000000007e002fff (prio 0, ram): ram
    000000007e003000-000000007e00301f (prio 0, i/o): bcm2835-sys-timer
    000000007e003020-000000007e006fff (prio 0, ram): ram @000000003e003020
@@ -56,5 +106,105 @@
    000000007ee00100-000000007ee04fff (prio 0, ram): ram @000000003ee00100
    000000007ee05000-000000007ee050ff (prio 0, i/o): bcm2835-dma-chan15
    000000007ee05100-000000007fffffff (prio 0, ram): ram @000000003ee05100
-  0000000080000000-00000000bfffffff (prio 0, ram): ram
-  00000000c0000000-00000000ffffffff (prio 0, ram): ram
+  0000000080000000-00000000be002fff (prio 0, ram): ram
+  00000000be003000-00000000be00301f (prio 0, i/o): bcm2835-sys-timer
+  00000000be003020-00000000be006fff (prio 0, ram): ram @000000003e003020
+  00000000be007000-00000000be007fff (prio 0, i/o): bcm2835-dma
+  00000000be008000-00000000be00b1ff (prio 0, ram): ram @000000003e008000
+  00000000be00b200-00000000be00b3ff (prio 0, i/o): bcm2835-ic
+  00000000be00b400-00000000be00b43f (prio -1000, i/o): bcm2835-sp804
+  00000000be00b440-00000000be00b7ff (prio 0, ram): ram @000000003e00b440
+  00000000be00b800-00000000be00bbff (prio 0, i/o): bcm2835-mbox
+  00000000be00bc00-00000000be0fffff (prio 0, ram): ram @000000003e00bc00
+  00000000be100000-00000000be100fff (prio -1000, i/o): bcm2835-cprman
+  00000000be101000-00000000be101fff (prio 0, ram): ram @000000003e101000
+  00000000be102000-00000000be102fff (prio -1000, i/o): bcm2835-a2w
+  00000000be103000-00000000be103fff (prio 0, ram): ram @000000003e103000
+  00000000be104000-00000000be10400f (prio 0, i/o): bcm2835-rng
+  00000000be104010-00000000be1fffff (prio 0, ram): ram @000000003e104010
+  00000000be200000-00000000be200fff (prio 0, i/o): bcm2835_gpio
+  00000000be201000-00000000be201fff (prio 0, i/o): pl011
+  00000000be202000-00000000be202fff (prio 0, i/o): bcm2835-sdhost
+  00000000be203000-00000000be2030ff (prio -1000, i/o): bcm2835-i2s
+  00000000be203100-00000000be203fff (prio 0, ram): ram @000000003e203100
+  00000000be204000-00000000be20401f (prio -1000, i/o): bcm2835-spi0
+  00000000be204020-00000000be204fff (prio 0, ram): ram @000000003e204020
+  00000000be205000-00000000be20501f (prio -1000, i/o): bcm2835-i2c0
+  00000000be205020-00000000be20efff (prio 0, ram): ram @000000003e205020
+  00000000be20f000-00000000be20f07f (prio -1000, i/o): bcm2835-otp
+  00000000be20f080-00000000be211fff (prio 0, ram): ram @000000003e20f080
+  00000000be212000-00000000be212007 (prio 0, i/o): bcm2835-thermal
+  00000000be212008-00000000be213fff (prio 0, ram): ram @000000003e212008
+  00000000be214000-00000000be2140ff (prio -1000, i/o): bcm2835-spis
+  00000000be214100-00000000be214fff (prio 0, ram): ram @000000003e214100
+  00000000be215000-00000000be2150ff (prio 0, i/o): bcm2835-aux
+  00000000be215100-00000000be2fffff (prio 0, ram): ram @000000003e215100
+  00000000be300000-00000000be3000ff (prio 0, i/o): sdhci
+  00000000be300100-00000000be5fffff (prio 0, ram): ram @000000003e300100
+  00000000be600000-00000000be6000ff (prio -1000, i/o): bcm2835-smi
+  00000000be600100-00000000be803fff (prio 0, ram): ram @000000003e600100
+  00000000be804000-00000000be80401f (prio -1000, i/o): bcm2835-i2c1
+  00000000be804020-00000000be804fff (prio 0, ram): ram @000000003e804020
+  00000000be805000-00000000be80501f (prio -1000, i/o): bcm2835-i2c2
+  00000000be805020-00000000be8fffff (prio 0, ram): ram @000000003e805020
+  00000000be900000-00000000be907fff (prio -1000, i/o): bcm2835-dbus
+  00000000be908000-00000000be90ffff (prio 0, ram): ram @000000003e908000
+  00000000be910000-00000000be917fff (prio -1000, i/o): bcm2835-ave0
+  00000000be918000-00000000be97ffff (prio 0, ram): ram @000000003e918000
+  00000000be980000-00000000be980fff (prio -1000, i/o): dwc-usb2
+  00000000be981000-00000000bedfffff (prio 0, ram): ram @000000003e981000
+  00000000bee00000-00000000bee000ff (prio -1000, i/o): bcm2835-sdramc
+  00000000bee00100-00000000bee04fff (prio 0, ram): ram @000000003ee00100
+  00000000bee05000-00000000bee050ff (prio 0, i/o): bcm2835-dma-chan15
+  00000000bee05100-00000000bfffffff (prio 0, ram): ram @000000003ee05100
+  00000000c0000000-00000000fe002fff (prio 0, ram): ram
+  00000000fe003000-00000000fe00301f (prio 0, i/o): bcm2835-sys-timer
+  00000000fe003020-00000000fe006fff (prio 0, ram): ram @000000003e003020
+  00000000fe007000-00000000fe007fff (prio 0, i/o): bcm2835-dma
+  00000000fe008000-00000000fe00b1ff (prio 0, ram): ram @000000003e008000
+  00000000fe00b200-00000000fe00b3ff (prio 0, i/o): bcm2835-ic
+  00000000fe00b400-00000000fe00b43f (prio -1000, i/o): bcm2835-sp804
+  00000000fe00b440-00000000fe00b7ff (prio 0, ram): ram @000000003e00b440
+  00000000fe00b800-00000000fe00bbff (prio 0, i/o): bcm2835-mbox
+  00000000fe00bc00-00000000fe0fffff (prio 0, ram): ram @000000003e00bc00
+  00000000fe100000-00000000fe100fff (prio -1000, i/o): bcm2835-cprman
+  00000000fe101000-00000000fe101fff (prio 0, ram): ram @000000003e101000
+  00000000fe102000-00000000fe102fff (prio -1000, i/o): bcm2835-a2w
+  00000000fe103000-00000000fe103fff (prio 0, ram): ram @000000003e103000
+  00000000fe104000-00000000fe10400f (prio 0, i/o): bcm2835-rng
+  00000000fe104010-00000000fe1fffff (prio 0, ram): ram @000000003e104010
+  00000000fe200000-00000000fe200fff (prio 0, i/o): bcm2835_gpio
+  00000000fe201000-00000000fe201fff (prio 0, i/o): pl011
+  00000000fe202000-00000000fe202fff (prio 0, i/o): bcm2835-sdhost
+  00000000fe203000-00000000fe2030ff (prio -1000, i/o): bcm2835-i2s
+  00000000fe203100-00000000fe203fff (prio 0, ram): ram @000000003e203100
+  00000000fe204000-00000000fe20401f (prio -1000, i/o): bcm2835-spi0
+  00000000fe204020-00000000fe204fff (prio 0, ram): ram @000000003e204020
+  00000000fe205000-00000000fe20501f (prio -1000, i/o): bcm2835-i2c0
+  00000000fe205020-00000000fe20efff (prio 0, ram): ram @000000003e205020
+  00000000fe20f000-00000000fe20f07f (prio -1000, i/o): bcm2835-otp
+  00000000fe20f080-00000000fe211fff (prio 0, ram): ram @000000003e20f080
+  00000000fe212000-00000000fe212007 (prio 0, i/o): bcm2835-thermal
+  00000000fe212008-00000000fe213fff (prio 0, ram): ram @000000003e212008
+  00000000fe214000-00000000fe2140ff (prio -1000, i/o): bcm2835-spis
+  00000000fe214100-00000000fe214fff (prio 0, ram): ram @000000003e214100
+  00000000fe215000-00000000fe2150ff (prio 0, i/o): bcm2835-aux
+  00000000fe215100-00000000fe2fffff (prio 0, ram): ram @000000003e215100
+  00000000fe300000-00000000fe3000ff (prio 0, i/o): sdhci
+  00000000fe300100-00000000fe5fffff (prio 0, ram): ram @000000003e300100
+  00000000fe600000-00000000fe6000ff (prio -1000, i/o): bcm2835-smi
+  00000000fe600100-00000000fe803fff (prio 0, ram): ram @000000003e600100
+  00000000fe804000-00000000fe80401f (prio -1000, i/o): bcm2835-i2c1
+  00000000fe804020-00000000fe804fff (prio 0, ram): ram @000000003e804020
+  00000000fe805000-00000000fe80501f (prio -1000, i/o): bcm2835-i2c2
+  00000000fe805020-00000000fe8fffff (prio 0, ram): ram @000000003e805020
+  00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
+  00000000fe908000-00000000fe90ffff (prio 0, ram): ram @000000003e908000
+  00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
+  00000000fe918000-00000000fe97ffff (prio 0, ram): ram @000000003e918000
+  00000000fe980000-00000000fe980fff (prio -1000, i/o): dwc-usb2
+  00000000fe981000-00000000fedfffff (prio 0, ram): ram @000000003e981000
+  00000000fee00000-00000000fee000ff (prio -1000, i/o): bcm2835-sdramc
+  00000000fee00100-00000000fee04fff (prio 0, ram): ram @000000003ee00100
+  00000000fee05000-00000000fee050ff (prio 0, i/o): bcm2835-dma-chan15
+  00000000fee05100-00000000ffffffff (prio 0, ram): ram @000000003ee05100

This is for the raspi2, but there is a mmap schema for the raspi1:
https://www.cnx-software.com/wp-content/uploads/2012/02/BCM2835-Memory-Map-=
Large.png


I found another discrepancy in the Bonito north bridge, which maps in=20
KSEG1 instead of physical:

$ git grep 'sysbus_mmio_map(.*, 0xb'
hw/pci-host/bonito.c:645:    sysbus_mmio_map(sysbus, 3, 0xbfe00200);
hw/pci-host/bonito.c:650:    sysbus_mmio_map(sysbus, 4, 0xbfe00300);


We can put this patch on hold for now, I might came back to this thread=20
later with more use cases.

Regards,

Phil.


