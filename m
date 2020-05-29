Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26274C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E743920723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 19:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBzRthNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E743920723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jekSY-0002Lv-3m
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 15:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jekRq-0001w7-H2
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:13:42 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jekRo-0001e0-UJ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 15:13:42 -0400
Received: by mail-il1-x143.google.com with SMTP id j3so3527350ilk.11
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=18PMaFGqx3ZQQaSbzUFmorqZGVmmD38umv1uirOCgAE=;
 b=fBzRthNa2BvKUu6iAfW9BY+ICOzqC8dlooQyAElhYnsJV4V4wbQfAQ+3VGvFuCD5Hd
 +wt+UmwGcJyLu2xHG0UFT2YneoECKirfMc8dy6gSRhqhX2A+63vge3u7MpdmF+nhR3zQ
 rV8W7qXHbL6fRzFZpkY2rPgV2PqBRAoDM1K2Bdrna35Qtr0uNNxrc66EWuDnmuwpnFuj
 I3lG7yzUbcoE5Fs62tju/vGpFxOZ80ihN3gsp1cV82GGadWDKKnlg5ZrYdtpBjk/yHmA
 GVd63uMBasscPFhN4wuxTAatVOTKRR3Mjzov0c0AJtMg4AOKEA7Onk83yRqtArqlc7V2
 MdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=18PMaFGqx3ZQQaSbzUFmorqZGVmmD38umv1uirOCgAE=;
 b=abAbcQmoXJg+FBU4aLdCmICYXrMkHlovVtDRlTRSPs8uOxdTqY3k6raS8ThkXG0RC+
 wBhHznmT9RFCQIhNvlyCf2xCHF83IA8CqNSdVNex80+A+P9AvIr6n5ONXfCDqIRLvF00
 KcwlaxU9r1ykVicAfVODh96liIxZ/ZXpLks1Nm/zP6hX9gHQxvZiod/hXfx7IOotT00o
 scizb5BWtfHu2d8xnH4klhtp0GYsgp9XVh5DY5SpQiMi2EZfCIvOGVNs8RR9tKx+QhMh
 t6q/tYTl8uLMoaZ39Hsss/I/hAMko2Bxw1QYmAVU8CGw6CXhIAb2lcw4XOkKLAoY1BD9
 EXEw==
X-Gm-Message-State: AOAM530gSkmyxARGplB49cEULUfzJ7vUIRuVZm/HkgBBjixb6SgoNJhS
 F9QP1LwYlA5JCSIXDNQrgDcXVNzRXXrSssyrPmo=
X-Google-Smtp-Source: ABdhPJxvLnpELtDZ/pkjQheofdjvo0ZIC0bcY23F5Q7u45WEIPfRVlQyU5WNXuLlijcfLgvpPs5ZqRyHaDLu/vZJG98=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr9148059ili.40.1590779618528;
 Fri, 29 May 2020 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-5-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-5-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 12:04:35 -0700
Message-ID: <CAKmqyKMRn4oaw747JN+kAt69SzwNChKua_ndTjetmSABho=sPw@mail.gmail.com>
Subject: Re: [PATCH v2 04/58] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 7:03 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> We commonly plug devices into their bus right when we create them,
> like this:
>
>     dev = qdev_create(bus, type_name);
>
> Note that @dev is a weak reference.  The reference from @bus to @dev
> is the only strong one.
>
> We realize at some later time, either with
>
>     object_property_set_bool(OBJECT(dev), true, "realized", errp);
>
> or its convenience wrapper
>
>     qdev_init_nofail(dev);
>
> If @dev still has no QOM parent then, realizing makes the
> /machine/unattached/ orphanage its QOM parent.
>
> Note that the device returned by qdev_create() is plugged into a bus,
> but doesn't have a QOM parent, yet.  Until it acquires one,
> unrealizing the bus will hang in bus_unparent():
>
>     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>         DeviceState *dev = kid->child;
>         object_unparent(OBJECT(dev));
>     }
>
> object_unparent() does nothing when its argument has no QOM parent,
> and the loop spins forever.
>
> Device state "no QOM parent, but plugged into bus" is dangerous.
>
> Paolo suggested to delay plugging into the bus until realize.  We need
> to plug into the parent bus before we call the device's realize
> method, in case it uses the parent bus.  So the dangerous state still
> exists, but only within realization, where we can manage it safely.
>
> This commit creates infrastructure to do this:
>
>     dev = qdev_new(type_name);
>     ...
>     qdev_realize_and_unref(dev, bus, errp)
>
> Note that @dev becomes a strong reference here.
> qdev_realize_and_unref() drops it.  There is also plain
> qdev_realize(), which doesn't drop it.
>
> The remainder of this series will convert all users to this new
> interface.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/qdev-core.h | 11 +++++-
>  hw/core/bus.c          | 14 +++++++
>  hw/core/qdev.c         | 90 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b870b27966..fba29308f7 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -57,7 +57,7 @@ typedef void (*BusUnrealize)(BusState *bus);
>   * After successful realization, setting static properties will fail.
>   *
>   * As an interim step, the #DeviceState:realized property can also be
> - * set with qdev_init_nofail().
> + * set with qdev_realize() or qdev_init_nofail().
>   * In the future, devices will propagate this state change to their children
>   * and along busses they expose.
>   * The point in time will be deferred to machine creation, so that values
> @@ -322,7 +322,13 @@ compat_props_add(GPtrArray *arr,
>
>  DeviceState *qdev_create(BusState *bus, const char *name);
>  DeviceState *qdev_try_create(BusState *bus, const char *name);
> +DeviceState *qdev_new(const char *name);
> +DeviceState *qdev_try_new(const char *name);
>  void qdev_init_nofail(DeviceState *dev);
> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
> +void qdev_unrealize(DeviceState *dev);
> +
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
> @@ -411,6 +417,9 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
>                           DeviceState *parent, const char *name);
>  BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
> +bool qbus_realize(BusState *bus, Error **errp);
> +void qbus_unrealize(BusState *bus);
> +
>  /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
>   *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
>   *           0 otherwise. */
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 33a4443217..6f6071f5fa 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -164,6 +164,20 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
>      return bus;
>  }
>
> +bool qbus_realize(BusState *bus, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    object_property_set_bool(OBJECT(bus), true, "realized", &err);
> +    error_propagate(errp, err);
> +    return !err;
> +}
> +
> +void qbus_unrealize(BusState *bus)
> +{
> +    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
> +}
> +
>  static bool bus_get_realized(Object *obj, Error **errp)
>  {
>      BusState *bus = BUS(obj);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index a68ba674db..f2c5cee278 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -176,6 +176,32 @@ DeviceState *qdev_try_create(BusState *bus, const char *type)
>      return dev;
>  }
>
> +/*
> + * Create a device on the heap.
> + * A type @name must exist.
> + * This only initializes the device state structure and allows
> + * properties to be set.  The device still needs to be realized.  See
> + * qdev-core.h.
> + */
> +DeviceState *qdev_new(const char *name)
> +{
> +    return DEVICE(object_new(name));
> +}
> +
> +/*
> + * Try to create a device on the heap.
> + * This is like qdev_new(), except it returns %NULL when type @name
> + * does not exist.
> + */
> +DeviceState *qdev_try_new(const char *name)
> +{
> +    if (!object_class_by_name(name)) {
> +        return NULL;
> +    }
> +
> +    return DEVICE(object_new(name));
> +}
> +
>  static QTAILQ_HEAD(, DeviceListener) device_listeners
>      = QTAILQ_HEAD_INITIALIZER(device_listeners);
>
> @@ -427,6 +453,66 @@ void qdev_init_nofail(DeviceState *dev)
>      object_unref(OBJECT(dev));
>  }
>
> +/*
> + * Realize @dev.
> + * @dev must not be plugged into a bus.
> + * Plug @dev into @bus if non-null, else into the main system bus.
> + * This takes a reference to @dev.
> + * If @dev has no QOM parent, make one up, taking another reference.
> + * On success, return true.
> + * On failure, store an error through @errp and return false.
> + */
> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    assert(!dev->realized && !dev->parent_bus);
> +
> +    if (!bus) {
> +        /*
> +         * Assert that the device really is a SysBusDevice before we
> +         * put it onto the sysbus.  Non-sysbus devices which aren't
> +         * being put onto a bus should be realized with
> +         * object_property_set_bool(OBJECT(dev), true, "realized",
> +         * errp);
> +         */
> +        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
> +        bus = sysbus_get_default();
> +    }
> +
> +    qdev_set_parent_bus(dev, bus);
> +
> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +    }
> +    return !err;
> +}
> +
> +/*
> + * Realize @dev and drop a reference.
> + * This is like qdev_realize(), except the caller must hold a
> + * (private) reference, which is dropped on return regardless of
> + * success or failure.  Intended use:
> + *     dev = qdev_new();
> + *     [...]
> + *     qdev_realize_and_unref(dev, bus, errp);
> + * Now @dev can go away without further ado.
> + */
> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
> +{
> +    bool ret;
> +
> +    ret = qdev_realize(dev, bus, errp);
> +    object_unref(OBJECT(dev));
> +    return ret;
> +}
> +
> +void qdev_unrealize(DeviceState *dev)
> +{
> +    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
> +}
> +
>  static int qdev_assert_realized_properly(Object *obj, void *opaque)
>  {
>      DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
> @@ -1002,6 +1088,10 @@ post_realize_fail:
>  fail:
>      error_propagate(errp, local_err);
>      if (unattached_parent) {
> +        /*
> +         * Beware, this doesn't just revert
> +         * object_property_add_child(), it also runs bus_remove()!
> +         */
>          object_unparent(OBJECT(dev));
>          unattached_count--;
>      }
> --
> 2.21.3
>
>

