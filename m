Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE864C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D94720833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ6Mlu2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D94720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibV17-00019I-Mn
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 14:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibV06-0000cA-Dj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibV05-00077F-6M
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:35:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibV05-00076y-2B
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575228920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJtkVYpb/UYqcLwYq9FG9klZ72YB/4xFOqABpC+v27U=;
 b=DQ6Mlu2JfoKKWnCp0AMQobCa53D7YX6KwakVLiJm0U0Ql6SU1DNxpLN8XhClJ0pwUtb4Oy
 frjoIjbAtBU7j+iPRniuuSibjTVlyLN7XIg0Abrwvv0obxIyLD2Hr4FnbezNdvklAtESEh
 nxe1EC87zsr3ckdyDa5rJdLlp6u0spk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_mEV-xEtPuanG9MnOkEXrw-1; Sun, 01 Dec 2019 14:35:18 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so19254278wrb.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 11:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JWSUDlY28g9m7uprzfHBEWlZFNlsn2gtd3d7Q+1SZN8=;
 b=JYWidP6sGqWk56sx+WqHnG1K72PwateIl/0wuid37RdNEe6mly+jEdt3X2SvydckHG
 bELfKduQCr5txWM18wSela81/JMpGqd1wTS8pLNx+N8hiYA47d7wG3L/1LZrf6b8yb12
 3obM3FXPGPkdjvwXAB30OHMnsgdWR6rTgA1r4HctakVjwbR/UM1QuGlSUX0xN717AveM
 clDg4u2X1m3JPEDAG0zDNe4UghQg0CFgOoz4ctzstH3RkQyvzl2eWX5rPlw8uI5YHiAC
 h9FLcadZ3QKOhmiwUmCzXC9TSg4uDFU2E0sPfXj9ZrDuOhCdH21nncAFt0EfmUQPE5ZM
 awWA==
X-Gm-Message-State: APjAAAVK2k2+NQ05lxPvQXGcne6HKVvG9yUGzgU2jSHQkY5orQ7CdpB4
 EDPEhOaaXu6rDgcM+SiM4bZP6xAAWXna9ocYVWBlDRKEhC1cytWfLuRJ1DphnoJbiCBP9Lav4gD
 +po3LZEso/f6jSyA=
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr24305345wml.65.1575228917426; 
 Sun, 01 Dec 2019 11:35:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRuFO9f0fA1not5QpyedQ7TXVr64tRg5pULD7tr3a8zC+q62HnpKZ5u/nJnij1S4LwGw75gA==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr24305334wml.65.1575228917233; 
 Sun, 01 Dec 2019 11:35:17 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id h17sm11594871wrs.18.2019.12.01.11.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 11:35:16 -0800 (PST)
Subject: Re: [PATCH 04/26] qdev: move helper function to monitor/misc
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
 <20191201111531.1136947-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39a24e69-c443-57af-447c-a4bfb52b1c74@redhat.com>
Date: Sun, 1 Dec 2019 20:35:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191201111531.1136947-5-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: _mEV-xEtPuanG9MnOkEXrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:15 PM, Marc-Andr=C3=A9 Lureau wrote:
> Move the one-user function to the place it is being used.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev.c         | 26 --------------------------
>   include/hw/qdev-core.h |  2 --
>   monitor/misc.c         | 26 ++++++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c1a338bbe4..90eb01bc8e 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -760,32 +760,6 @@ void qdev_alias_all_properties(DeviceState *target, =
Object *source)
>       } while (class !=3D object_class_by_name(TYPE_DEVICE));
>   }
>  =20
> -static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
> -{
> -    GSList **list =3D opaque;
> -    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
> -                                                          TYPE_DEVICE);
> -
> -    if (dev =3D=3D NULL) {
> -        return 0;
> -    }
> -
> -    if (dev->realized && object_property_get_bool(obj, "hotpluggable", N=
ULL)) {
> -        *list =3D g_slist_append(*list, dev);
> -    }
> -
> -    return 0;
> -}
> -
> -GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
> -{
> -    GSList *list =3D NULL;
> -
> -    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list=
);
> -
> -    return list;
> -}
> -
>   static bool device_get_realized(Object *obj, Error **errp)
>   {
>       DeviceState *dev =3D DEVICE(obj);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1518495b1e..6b0e7b265d 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -457,8 +457,6 @@ extern bool qdev_hot_removed;
>  =20
>   char *qdev_get_dev_path(DeviceState *dev);
>  =20
> -GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
> -
>   void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **e=
rrp);
>  =20
>   void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 3baa15f3bf..36c85cecf3 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -1956,6 +1956,32 @@ void object_add_completion(ReadLineState *rs, int =
nb_args, const char *str)
>       g_slist_free(list);
>   }
>  =20
> +static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
> +                                                          TYPE_DEVICE);
> +
> +    if (dev =3D=3D NULL) {
> +        return 0;
> +    }
> +
> +    if (dev->realized && object_property_get_bool(obj, "hotpluggable", N=
ULL)) {
> +        *list =3D g_slist_append(*list, dev);
> +    }
> +
> +    return 0;
> +}
> +
> +static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list=
);
> +
> +    return list;
> +}
> +
>   static void peripheral_device_del_completion(ReadLineState *rs,
>                                                const char *str, size_t le=
n)
>   {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


