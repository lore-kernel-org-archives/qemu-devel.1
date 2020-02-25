Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F1DC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ED52072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epj2lbs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ED52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dEJ-0006C0-P8
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6dCz-0004hv-LW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6dCt-00045d-E4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:37:21 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6dCt-00045C-30; Tue, 25 Feb 2020 11:37:15 -0500
Received: by mail-lj1-x243.google.com with SMTP id q8so14725329ljj.11;
 Tue, 25 Feb 2020 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6P39t6OwqgO7s3hoSwBxyI2ANpbI/mNX4eAo2Bc6UAk=;
 b=epj2lbs3rZNqiYBPU9FhNAzZi9ZpvsNPy9hZbUwVA+OwUFh8lx0Vzgu5NIxhVywDR2
 slnY5wnT7997U1fM4rK7rKiDzi5dWCRD5inEOPmsmYAjOV57Iy2STQ6cIDeXgnNJF004
 6WfeN6PVbATT0htJkAtMDlCHyUMA8e0cKMX/vMpOnFfgdTYyGSQTgVafMgbEUAYHNOyk
 AavbJAJMYQltw7S2wNOE11o/D7L11MqJbIQsKRsczpglVVc4Mb0RrSEs5+LUphIAG3Ky
 0ISPHfKbctqh/pgbvnDoUrubBBsCmksC69bagRwSf8+uB9Sj6H+ZmSGUw90LJ3J9MdYf
 maeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6P39t6OwqgO7s3hoSwBxyI2ANpbI/mNX4eAo2Bc6UAk=;
 b=gAeA1qLPLz6xVoM14oDHhdo9hKAceeiCl8JDzhP/SddIjwKPVDqPxmr43cAWKsMcZz
 i+T+GuimKN126It2wzHCcKw5p90keenVJaK6pshjWMlIP8tATMZA2D9KVen6bHdMBjOL
 jCwJW2tyeRpCl/D5syMQCd4RvhOAM0cQwxyjUc/kcEJux27yM8g6wJC7jcgSh+etjAZ9
 wmKSwvbDn/VcC9JcYhqtySP+hPNqJDGgsIBNkFdrohDt9t37bCoJobCpGvtdX64dl1V7
 pfbHrpaPBKe93SCTRF/govYkLPlZEVO6yVZEWAQU9dhng+lExkcZM5XipBsswK8l2kwu
 0f6w==
X-Gm-Message-State: APjAAAVP+xXirKkbXWyJXOVC5jVyajgo/TSiQ9jsaFMBQXQsFAzSfuee
 Tjef6nGCuq6prFOFL+anaSQ1mgiwTx7mh3xeyxw=
X-Google-Smtp-Source: APXvYqzXb+pjhlVwp/34C597zeP8yzsIPP2riESMsudTNVTnsilrihObGLa9K6SBAac/vYN9jczxn8RjYz31nWQkLSI=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr32029770ljm.285.1582648633799; 
 Tue, 25 Feb 2020 08:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-4-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-4-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Feb 2020 08:36:47 -0800
Message-ID: <CAKmqyKM9neBsjLFeamWU16zzSCse7nzTmmyPwx6EJ1rnR85PRg@mail.gmail.com>
Subject: Re: [PATCH v8 3/9] qdev: add clock input&output support to devices.
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 6:01 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add functions to easily handle clocks with devices.
> Clock inputs and outputs should be used to handle clock propagation
> between devices.
> The API is very similar the GPIO API.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> v8:
> + remove another useless assert (Alistair)
> + typos, comments (Alistair)
>
> v7:
> + update ClockIn/Out types
> + qdev_connect_clock_out function removed / qdev_connect_clock_in added
>   instead
> + qdev_pass_clock renamed to qdev_alias_clock
> + various small fixes (typos, comment, asserts) (Peter)
> + move device's instance_finalize code related to clock in qdev-clock.c
> ---
>  include/hw/qdev-clock.h | 104 +++++++++++++++++++++++++
>  include/hw/qdev-core.h  |  12 +++
>  hw/core/qdev-clock.c    | 168 ++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c          |  12 +++
>  hw/core/Makefile.objs   |   2 +-
>  tests/Makefile.include  |   1 +
>  6 files changed, 298 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/qdev-clock.h
>  create mode 100644 hw/core/qdev-clock.c
>
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> new file mode 100644
> index 0000000000..b3b3a3e021
> --- /dev/null
> +++ b/include/hw/qdev-clock.h
> @@ -0,0 +1,104 @@
> +/*
> + * Device's clock input and output
> + *
> + * Copyright GreenSocs 2016-2020
> + *
> + * Authors:
> + *  Frederic Konrad
> + *  Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QDEV_CLOCK_H
> +#define QDEV_CLOCK_H
> +
> +#include "hw/clock.h"
> +
> +/**
> + * qdev_init_clock_in:
> + * @dev: the device to add an input clock to
> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @opaque: argument for the callback
> + * @returns: a pointer to the newly added clock
> + *
> + * Add an input clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + * The callback will be called with @opaque as opaque parameter.
> + */
> +Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                          ClockCallback *callback, void *opaque);
> +
> +/**
> + * qdev_init_clock_out:
> + * @dev: the device to add an output clock to
> + * @name: the name of the clock (can't be NULL).
> + * @returns: a pointer to the newly added clock
> + *
> + * Add an output clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + */
> +Clock *qdev_init_clock_out(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_get_clock_in:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @returns: a pointer to the clock
> + *
> + * Get the input clock @name from @dev or NULL if does not exist.
> + */
> +Clock *qdev_get_clock_in(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_get_clock_out:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @returns: a pointer to the clock
> + *
> + * Get the output clock @name from @dev or NULL if does not exist.
> + */
> +Clock *qdev_get_clock_out(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_connect_clock_in:
> + * @dev: a device
> + * @name: the name of an input clock in @dev
> + * @source: the source clock (an output clock of another device for example)
> + *
> + * Set the source clock of input clock @name of device @dev to @source.
> + * @source period update will be propagated to @name clock.
> + */
> +static inline void qdev_connect_clock_in(DeviceState *dev, const char *name,
> +                                         Clock *source)
> +{
> +    clock_set_source(qdev_get_clock_in(dev, name), source);
> +}
> +
> +/**
> + * qdev_alias_clock:
> + * @dev: the device which has the clock
> + * @name: the name of the clock in @dev (can't be NULL)
> + * @alias_dev: the device to add the clock
> + * @alias_name: the name of the clock in @container
> + * @returns: a pointer to the clock
> + *
> + * Add a clock @alias_name in @alias_dev which is an alias of the clock @name
> + * in @dev. The direction _in_ or _out_ will the same as the original.
> + * An alias clock must not be modified or used by @alias_dev and should
> + * typically be only only for device composition purpose.
> + */
> +Clock *qdev_alias_clock(DeviceState *dev, const char *name,
> +                        DeviceState *alias_dev, const char *alias_name);
> +
> +/**
> + * qdev_finalize_clocklist:
> + * @dev: the device being finalized
> + *
> + * Clear the clocklist from @dev. Only used internally in qdev.
> + */
> +void qdev_finalize_clocklist(DeviceState *dev);
> +
> +#endif /* QDEV_CLOCK_H */
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1405b8a990..d87d989e72 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -149,6 +149,17 @@ struct NamedGPIOList {
>      QLIST_ENTRY(NamedGPIOList) node;
>  };
>
> +typedef struct Clock Clock;
> +typedef struct NamedClockList NamedClockList;
> +
> +struct NamedClockList {
> +    char *name;
> +    Clock *clock;
> +    bool output;
> +    bool alias;
> +    QLIST_ENTRY(NamedClockList) node;
> +};
> +
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> @@ -171,6 +182,7 @@ struct DeviceState {
>      bool allow_unplug_during_migration;
>      BusState *parent_bus;
>      QLIST_HEAD(, NamedGPIOList) gpios;
> +    QLIST_HEAD(, NamedClockList) clocks;
>      QLIST_HEAD(, BusState) child_bus;
>      int num_child_bus;
>      int instance_id_alias;
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> new file mode 100644
> index 0000000000..62035aef83
> --- /dev/null
> +++ b/hw/core/qdev-clock.c
> @@ -0,0 +1,168 @@
> +/*
> + * Device's clock input and output
> + *
> + * Copyright GreenSocs 2016-2020
> + *
> + * Authors:
> + *  Frederic Konrad
> + *  Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-core.h"
> +#include "qapi/error.h"
> +
> +/*
> + * qdev_init_clocklist:
> + * Add a new clock in a device
> + */
> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
> +                                           bool output, Clock *clk)
> +{
> +    NamedClockList *ncl;
> +
> +    /*
> +     * Clock must be added before realize() so that we can compute the
> +     * clock's canonical path during device_realize().
> +     */
> +    assert(!dev->realized);
> +
> +    /*
> +     * The ncl structure is freed by qdev_finalize_clocklist() which will
> +     * be called during @dev's device_finalize().
> +     */
> +    ncl = g_new0(NamedClockList, 1);
> +    ncl->name = g_strdup(name);
> +    ncl->output = output;
> +    ncl->alias = (clk != NULL);
> +
> +    /*
> +     * Trying to create a clock whose name clashes with some other
> +     * clock or property is a bug in the caller and we will abort().
> +     */
> +    if (clk == NULL) {
> +        clk = CLOCK(object_new(TYPE_CLOCK));
> +        object_property_add_child(OBJECT(dev), name, OBJECT(clk), &error_abort);
> +        if (output) {
> +            /*
> +             * Remove object_new()'s initial reference.
> +             * Note that for inputs, the reference created by object_new()
> +             * will be deleted in qdev_finalize_clocklist().
> +             */
> +            object_unref(OBJECT(clk));
> +        }
> +    } else {
> +        object_property_add_link(OBJECT(dev), name,
> +                                 object_get_typename(OBJECT(clk)),
> +                                 (Object **) &ncl->clock,
> +                                 NULL, OBJ_PROP_LINK_STRONG, &error_abort);
> +    }
> +
> +    ncl->clock = clk;
> +
> +    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> +    return ncl;
> +}
> +
> +void qdev_finalize_clocklist(DeviceState *dev)
> +{
> +    /* called by @dev's device_finalize() */
> +    NamedClockList *ncl, *ncl_next;
> +
> +    QLIST_FOREACH_SAFE(ncl, &dev->clocks, node, ncl_next) {
> +        QLIST_REMOVE(ncl, node);
> +        if (!ncl->output && !ncl->alias) {
> +            /*
> +             * We kept a reference on the input clock to ensure it lives up to
> +             * this point so we can safely remove the callback.
> +             * It avoids having a callback to a deleted object if ncl->clock
> +             * is still referenced somewhere else (eg: by a clock output).
> +             */
> +            clock_clear_callback(ncl->clock);
> +            object_unref(OBJECT(ncl->clock));
> +        }
> +        g_free(ncl->name);
> +        g_free(ncl);
> +    }
> +}
> +
> +Clock *qdev_init_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(name);
> +
> +    ncl = qdev_init_clocklist(dev, name, true, NULL);
> +
> +    return ncl->clock;
> +}
> +
> +Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                            ClockCallback *callback, void *opaque)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(name);
> +
> +    ncl = qdev_init_clocklist(dev, name, false, NULL);
> +
> +    if (callback) {
> +        clock_set_callback(ncl->clock, callback, opaque);
> +    }
> +    return ncl->clock;
> +}
> +
> +static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    QLIST_FOREACH(ncl, &dev->clocks, node) {
> +        if (strcmp(name, ncl->name) == 0) {
> +            return ncl;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +    assert(!ncl->output);
> +
> +    return ncl->clock;
> +}
> +
> +Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +    assert(ncl->output);
> +
> +    return ncl->clock;
> +}
> +
> +Clock *qdev_alias_clock(DeviceState *dev, const char *name,
> +                        DeviceState *alias_dev, const char *alias_name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(name && alias_name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +
> +    qdev_init_clocklist(alias_dev, alias_name, ncl->output, ncl->clock);
> +
> +    return ncl->clock;
> +}
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 3937d1eb1a..f390697348 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -37,6 +37,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-clock.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
>
> @@ -855,6 +856,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>      HotplugHandler *hotplug_ctrl;
>      BusState *bus;
> +    NamedClockList *ncl;
>      Error *local_err = NULL;
>      bool unattached_parent = false;
>      static int unattached_count;
> @@ -902,6 +904,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>           */
>          g_free(dev->canonical_path);
>          dev->canonical_path = object_get_canonical_path(OBJECT(dev));
> +        QLIST_FOREACH(ncl, &dev->clocks, node) {
> +            if (ncl->alias) {
> +                continue;
> +            } else {
> +                clock_setup_canonical_path(ncl->clock);
> +            }
> +        }
>
>          if (qdev_get_vmsd(dev)) {
>              if (vmstate_register_with_alias_id(VMSTATE_IF(dev),
> @@ -1025,6 +1034,7 @@ static void device_initfn(Object *obj)
>      dev->allow_unplug_during_migration = false;
>
>      QLIST_INIT(&dev->gpios);
> +    QLIST_INIT(&dev->clocks);
>  }
>
>  static void device_post_init(Object *obj)
> @@ -1054,6 +1064,8 @@ static void device_finalize(Object *obj)
>           */
>      }
>
> +    qdev_finalize_clocklist(dev);
> +
>      /* Only send event if the device had been completely realized */
>      if (dev->pending_deleted_event) {
>          g_assert(dev->canonical_path);
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 115df55087..1d540ed6e7 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,7 +7,7 @@ common-obj-y += hotplug.o
>  common-obj-y += vmstate-if.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y += irq.o
> -common-obj-y += clock.o
> +common-obj-y += clock.o qdev-clock.o
>
>  common-obj-$(CONFIG_SOFTMMU) += reset.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index edcbd475aa..5a4511a86f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -436,6 +436,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
>         hw/core/fw-path-provider.o \
>         hw/core/reset.o \
>         hw/core/vmstate-if.o \
> +       hw/core/clock.o hw/core/qdev-clock.o \
>         $(test-qapi-obj-y)
>  tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
>         migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
> --
> 2.25.1
>
>

