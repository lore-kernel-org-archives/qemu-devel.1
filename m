Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C54321D71
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54321D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdR8-0004bl-8T
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 09:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRdQH-0003k2-3i
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRdQF-0002JI-L0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRdQF-0002Iv-CF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:33:35 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F418181E1A
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 14:33:33 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v6so1194486wrm.18
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 06:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pqd2a+23lsIGqYc0RuIYbYmHJtC1x0ID8yTRwiJDGGw=;
 b=oWi6TntmMAhc4FrFXy0cJ4S710V8BxfQlX5cg0zyO5DhMXb1ebVVqQJDjspvn7TDbW
 wwqky2lpdIsd90VEfu7KdYivrtKGuW9/CmvjMgm7BYfVlyYjjLrUyVbx5guRrRyo20Um
 OJmRROm5Ade/bl2H2Uyn/3z1ESWnE9vfAe3j7J4X31TUcU+2dmA8DRHMH1wVlyc/I/Ez
 CqJzNscozALotpQAMzqxp3LIRzGxqZyFdsxjByOSUPU2kxqDblciPG85SvHuQsxJmaLq
 lIVXmFRpjahAhTkPt1VHu/mVYO6nhAuqUsrRL9STAS8WMXtTU39jKpdcXggJ9qSA4TuS
 O1jQ==
X-Gm-Message-State: APjAAAXEdX0fpCYSsOz0mJwnbskgc9k9H+VcDEDiZl2pCwhuntz5LplA
 T63ysEJIyVGfckAk61r5EJDWB4KkeCMw7lzA76FtjHrIMbmkd5TtH1U14ZlzVc6nfe6mr0UTXIw
 GDgbLrXpVijte+OI=
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr22997242wrv.347.1572878012692; 
 Mon, 04 Nov 2019 06:33:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBPWBUqfxnJQhRYY+WxzsZ8NcP9uWsZMSHy4k8o+OHZ1lfzHkaBjkVngh2uxwXMHiBMoTrrw==
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr22997221wrv.347.1572878012466; 
 Mon, 04 Nov 2019 06:33:32 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id y19sm20817315wmd.29.2019.11.04.06.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 06:33:31 -0800 (PST)
Subject: Re: [PATCH v5 02/13] hw/core/qdev: add trace events to help with
 resettable transition
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-3-damien.hedde@greensocs.com>
 <f5d78215-ee4d-ae1a-74dc-52b3c179d88c@redhat.com>
 <984a87d7-0430-d777-0fe9-ce5cfea712a1@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e008dc9a-4a04-8183-3610-bbb3361a877c@redhat.com>
Date: Mon, 4 Nov 2019 15:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <984a87d7-0430-d777-0fe9-ce5cfea712a1@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 1:16 PM, Damien Hedde wrote:
> On 11/1/19 12:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/18/19 5:06 PM, Damien Hedde wrote:
>>> Adds trace events to reset procedure and when updating the parent
>>> bus of a device.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>>  =C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++=
+++++++++++++++++++---
>>>  =C2=A0 hw/core/trace-events |=C2=A0 9 +++++++++
>>>  =C2=A0 2 files changed, 33 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 60be2f2fef..f230063189 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -38,6 +38,7 @@
>>>  =C2=A0 #include "hw/boards.h"
>>>  =C2=A0 #include "hw/sysbus.h"
>>>  =C2=A0 #include "migration/vmstate.h"
>>> +#include "trace.h"
>>>  =C2=A0 =C2=A0 bool qdev_hotplug =3D false;
>>>  =C2=A0 static bool qdev_hot_added =3D false;
>>> @@ -98,7 +99,9 @@ void qdev_set_parent_bus(DeviceState *dev, BusState
>>> *bus)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool replugging =3D dev->parent_bus !=
=3D NULL;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (replugging) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Keep a reference to th=
e device while it's not plugged into
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_qdev_update_parent_=
bus(dev, dev->parent_bus, bus);
>>
>> Nitpicking, if you respin, can you add object_get_typename(OBJECT(dev)=
))
>> and object_get_typename(OBJECT(bus)))?
>=20
> sure. I was wondering if having some kind of qom object support to trac=
e
> would be feasible. Because it's a bit tedious to add this each time. An=
d
> IMO it would be more useful to have the path, but we can't reasonably
> compute it as a trace_..() arguments.

Meanwhile you can use:

   if (trace_event_get_state_backends(TRACE_QDEV_UPDATE_PARENT_BUS)) {
       ...

>>
>> With/without it:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Keep a reference =
to the device while it's not plugged into
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * any b=
us, to avoid it potentially evaporating when it is
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * deref=
fed in bus_remove_child().
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> @@ -272,6 +275,18 @@ HotplugHandler
>>> *qdev_get_hotplug_handler(DeviceState *dev)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return hotplug_ctrl;
>>>  =C2=A0 }
>>>  =C2=A0 +static int qdev_prereset(DeviceState *dev, void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 trace_qdev_reset_tree(dev, object_get_typename(OB=
JECT(dev)));
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int qbus_prereset(BusState *bus, void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset_tree(bus, object_get_typename(OB=
JECT(bus)));
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>>  =C2=A0 static int qdev_reset_one(DeviceState *dev, void *opaque)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_legacy_reset(dev);
>>> @@ -282,6 +297,7 @@ static int qdev_reset_one(DeviceState *dev, void
>>> *opaque)
>>>  =C2=A0 static int qbus_reset_one(BusState *bus, void *opaque)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BusClass *bc =3D BUS_GET_CLASS(bus);
>>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset(bus, object_get_typename(OBJECT(=
bus)));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bc->reset) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc->reset(bus=
);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -290,7 +306,9 @@ static int qbus_reset_one(BusState *bus, void
>>> *opaque)
>>>  =C2=A0 =C2=A0 void qdev_reset_all(DeviceState *dev)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 qdev_walk_children(dev, NULL, NULL, qdev_reset_on=
e,
>>> qbus_reset_one, NULL);
>>> +=C2=A0=C2=A0=C2=A0 trace_qdev_reset_all(dev, object_get_typename(OBJ=
ECT(dev)));
>>> +=C2=A0=C2=A0=C2=A0 qdev_walk_children(dev, qdev_prereset, qbus_prere=
set,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_rese=
t_one, qbus_reset_one, NULL);
>>>  =C2=A0 }
>>>  =C2=A0 =C2=A0 void qdev_reset_all_fn(void *opaque)
>>> @@ -300,7 +318,9 @@ void qdev_reset_all_fn(void *opaque)
>>>  =C2=A0 =C2=A0 void qbus_reset_all(BusState *bus)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 qbus_walk_children(bus, NULL, NULL, qdev_reset_on=
e,
>>> qbus_reset_one, NULL);
>>> +=C2=A0=C2=A0=C2=A0 trace_qbus_reset_all(bus, object_get_typename(OBJ=
ECT(bus)));
>>> +=C2=A0=C2=A0=C2=A0 qbus_walk_children(bus, qdev_prereset, qbus_prere=
set,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_rese=
t_one, qbus_reset_one, NULL);
>>>  =C2=A0 }
>>>  =C2=A0 =C2=A0 void qbus_reset_all_fn(void *opaque)
>>> @@ -1108,6 +1128,7 @@ void device_legacy_reset(DeviceState *dev)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *klass =3D DEVICE_GET_CLA=
SS(dev);
>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 trace_qdev_reset(dev, object_get_typename=
(OBJECT(dev)));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (klass->reset) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 klass->reset(=
dev);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>>> index fe47a9c8cb..1a669be0ea 100644
>>> --- a/hw/core/trace-events
>>> +++ b/hw/core/trace-events
>>> @@ -1,2 +1,11 @@
>>>  =C2=A0 # loader.c
>>>  =C2=A0 loader_write_rom(const char *name, uint64_t gpa, uint64_t siz=
e, bool
>>> isrom) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
>>> +
>>> +# qdev.c
>>> +qdev_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qdev_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qdev_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>>> +qdev_update_parent_bus(void *obj, void *oldp, void *newp) "obj=3D%p
>>> old_parent=3D%p new_parent=3D%p"
>>>

