Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE16206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoABQ59J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE16206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJydx-0007Uc-0j
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJyd8-0006zQ-9o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJyd6-0003jY-K2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:07:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJyd6-0003jB-Et
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585829247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GH9ZctDlOJVXlePIEy/7t69vRL4BBSn3UAVlOi0YVIE=;
 b=YoABQ59JlJvIm4FEj0QxKcwMqFJE7dPfxWM3MFSqjERuuaFulJbq4pFM/TTFboUmVrRjPF
 KoiEOtuhEkXMmwDnU1RFdywZqAuskzMDe8OQdsJ8VYFddNjGMvg2K/ArSgqdfhhdPPfOLI
 elkx1io+8rhSe48zKPZCHSu6UXl/6sU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-kHzTbpFeNFCl7g_IgH5BZw-1; Thu, 02 Apr 2020 08:07:26 -0400
X-MC-Unique: kHzTbpFeNFCl7g_IgH5BZw-1
Received: by mail-ed1-f72.google.com with SMTP id bm25so2519605edb.18
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 05:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IvvY/ezh+A+md7a0w8aybV+mbPJAV/52y9KvRJMvL7U=;
 b=REwD6g0WaIRr/du44E3K3961tKNB8aP7uij48R47Mh8N4qEUF5+FFAB3io665iXPwW
 wqNU1Me5wspn1ppcdOS2dbvSmbHT69w5PqoUIm8Knr2HBke4Ia0Mp07kq6xpkzN0MJGk
 UEYiui6QqWna5ywPZ9gB/a1C74qgJ2OX+lLD5Xtu/TyGDsxdYCSpCF3s6/pISkgsExKp
 uaSy3rT+LYKuPWisonxeED6LuzMEbdpi37b5EbI5Q14ppX5GdRyYBHZdmhW4loOEGJfl
 VHve6Fg0wUO6WQzyTB9lw49ptyCXZLzkLVosJ9h7OkSrJF10ip9BvBC+hx2l25Rr1/wz
 2eGA==
X-Gm-Message-State: AGi0PuaVYoq2IaKbn28D4o9SpHEoupifrU1XDnyeHhNVEj22PgrLOWUZ
 usqu34YjHXFUpg3iqOrpsUarOJOmRHpQ0jEwQUO1PVZ6FW98xyVV/c6Nkqww2yR9Qm8XKEsc6Dn
 r3JdbhzUPATvskZI=
X-Received: by 2002:a17:906:5003:: with SMTP id
 s3mr2829100ejj.266.1585829244900; 
 Thu, 02 Apr 2020 05:07:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLDm9ZnfHA6wKQOZciX7wwCPmBDqT1nlQfHJMQNrxnzwDeBgppafryQKmrd2XqzYIdc24Wsg==
X-Received: by 2002:a17:906:5003:: with SMTP id
 s3mr2829072ejj.266.1585829244579; 
 Thu, 02 Apr 2020 05:07:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id e14sm906098edy.84.2020.04.02.05.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 05:07:23 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 06/25] xen: create xenstore areas for
 XenDevice-s
To: paul@xen.org, 'Anthony PERARD' <anthony.perard@citrix.com>,
 qemu-devel@nongnu.org
References: <20190114135154.16826-1-anthony.perard@citrix.com>
 <20190114135154.16826-7-anthony.perard@citrix.com>
 <772fab5a-59ab-050f-9fef-f3b050cfc5cd@redhat.com>
 <001001d608d4$0e7b9f40$2b72ddc0$@xen.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5f7e6e45-bf73-8a64-81a6-a41cc7b9d747@redhat.com>
Date: Thu, 2 Apr 2020 14:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <001001d608d4$0e7b9f40$2b72ddc0$@xen.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: xen-devel@lists.xenproject.org, 'Markus Armbruster' <armbru@redhat.com>,
 'Peter Maydell' <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 11:49 AM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Sent: 01 April 2020 17:14
>> To: Anthony PERARD <anthony.perard@citrix.com>; qemu-devel@nongnu.org
>> Cc: xen-devel@lists.xenproject.org; Peter Maydell <peter.maydell@linaro.=
org>; Paul Durrant
>> <paul@xen.org>; Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [Qemu-devel] [PULL 06/25] xen: create xenstore areas for Xe=
nDevice-s
>>
>> Hi Anthony, Paul.
>>
>> Cc'ing Markus too.
>>
>> On 1/14/19 2:51 PM, Anthony PERARD wrote:
>>> From: Paul Durrant <paul.durrant@citrix.com>
>>>
>>> This patch adds a new source module, xen-bus-helper.c, which builds on
>>> basic libxenstore primitives to provide functions to create (setting
>>> permissions appropriately) and destroy xenstore areas, and functions to
>>> 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
>>> these primitives [1] to initialize and destroy the frontend and backend
>>> areas for a XenDevice during realize and unrealize respectively.
>>>
>>> The 'xen-block' implementation is extended with a 'get_name' method tha=
t
>>> returns the VBD number. This number is required to 'name' the xenstore
>>> areas.
>>>
>>> NOTE: An exit handler is also added to make sure the xenstore areas are
>>>         cleaned up if QEMU terminates without devices being unrealized.
>>>
>>> [1] The 'scanf' functions are actually not yet needed, but they will be
>>>       needed by code delivered in subsequent patches.
>>>
>>> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>>> Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
>>> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>>> ---
>>>    hw/block/xen-block.c            |   9 +
>>>    hw/xen/Makefile.objs            |   2 +-
>>>    hw/xen/trace-events             |  12 +-
>>>    hw/xen/xen-bus-helper.c         | 150 +++++++++++++++
>>>    hw/xen/xen-bus.c                | 321 ++++++++++++++++++++++++++++++=
+-
>>>    include/hw/xen/xen-bus-helper.h |  39 ++++
>>>    include/hw/xen/xen-bus.h        |  12 ++
>>>    7 files changed, 540 insertions(+), 5 deletions(-)
>>>    create mode 100644 hw/xen/xen-bus-helper.c
>>>    create mode 100644 include/hw/xen/xen-bus-helper.h
>>>
>> [...]
>>> +static void xen_device_exit(Notifier *n, void *data)
>>> +{
>>> +    XenDevice *xendev =3D container_of(n, XenDevice, exit);
>>> +
>>> +    xen_device_unrealize(DEVICE(xendev), &error_abort);
>>>    }
>>>
>>>    static void xen_device_realize(DeviceState *dev, Error **errp)
>>>    {
>>>        XenDevice *xendev =3D XEN_DEVICE(dev);
>>>        XenDeviceClass *xendev_class =3D XEN_DEVICE_GET_CLASS(xendev);
>>> +    XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>>>        const char *type =3D object_get_typename(OBJECT(xendev));
>>>        Error *local_err =3D NULL;
>>>
>>> -    trace_xen_device_realize(type);
>>> +    if (xendev->frontend_id =3D=3D DOMID_INVALID) {
>>> +        xendev->frontend_id =3D xen_domid;
>>> +    }
>>> +
>>> +    if (xendev->frontend_id >=3D DOMID_FIRST_RESERVED) {
>>> +        error_setg(errp, "invalid frontend-id");
>>> +        goto unrealize;
>>> +    }
>>> +
>>> +    if (!xendev_class->get_name) {
>>> +        error_setg(errp, "get_name method not implemented");
>>> +        goto unrealize;
>>> +    }
>>> +
>>> +    xendev->name =3D xendev_class->get_name(xendev, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate_prepend(errp, local_err,
>>> +                                "failed to get device name: ");
>>> +        goto unrealize;
>>> +    }
>>> +
>>> +    trace_xen_device_realize(type, xendev->name);
>>> +
>>> +    xen_device_backend_create(xendev, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        goto unrealize;
>>> +    }
>>> +
>>> +    xen_device_frontend_create(xendev, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        goto unrealize;
>>> +    }
>>>
>>>        if (xendev_class->realize) {
>>>            xendev_class->realize(xendev, &local_err);
>>> @@ -72,18 +364,43 @@ static void xen_device_realize(DeviceState *dev, E=
rror **errp)
>>>            }
>>>        }
>>>
>>> +    xen_device_backend_printf(xendev, "frontend", "%s",
>>> +                              xendev->frontend_path);
>>> +    xen_device_backend_printf(xendev, "frontend-id", "%u",
>>> +                              xendev->frontend_id);
>>> +    xen_device_backend_printf(xendev, "online", "%u", 1);
>>> +    xen_device_backend_printf(xendev, "hotplug-status", "connected");
>>> +
>>> +    xen_device_backend_set_state(xendev, XenbusStateInitWait);
>>> +
>>> +    xen_device_frontend_printf(xendev, "backend", "%s",
>>> +                               xendev->backend_path);
>>> +    xen_device_frontend_printf(xendev, "backend-id", "%u",
>>> +                               xenbus->backend_id);
>>> +
>>> +    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
>>> +
>>> +    xendev->exit.notify =3D xen_device_exit;
>>> +    qemu_add_exit_notifier(&xendev->exit);
>>>        return;
>>>
>>>    unrealize:
>>>        xen_device_unrealize(dev, &error_abort);
>>
>> It seems if unrealize() fails, the error stored in &local_err is never
>> reported. Not sure if this can be improved although.
>=20
> In this case that's essentially a "don't care". We want to know why the r=
ealize failed but if the unrealize fails something is probably pretty serio=
usly screwed (hence the error_abort).

OK. I was surprised by the singular pattern (which confuses Coccinelle=20
semantic transformations), but it works.

Thanks for the quick feedback Paul!

Regards,

Phil.

>=20
>    Paul
>=20


