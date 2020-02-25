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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED02C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297CB20732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXBzamBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297CB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NoX-0004gv-9p
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6Nnl-00043z-75
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6Nnj-0007cP-8O
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:10:17 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6Nni-0007bl-RJ; Mon, 24 Feb 2020 19:10:15 -0500
Received: by mail-lj1-x241.google.com with SMTP id q8so12045543ljj.11;
 Mon, 24 Feb 2020 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2CU5awjyWBi7wI0IEPR/D7QgQQ8EIg4J7okTZYOGlIg=;
 b=vXBzamBoABysVly6Fjb1iybYA5cyMfgOGHz5BNKgjq6pniLMnT91XG+YAwCLKich8n
 hV6o6gwKN9NdKkBfuf4oBRbgAQDK/PGQOzMAgP+4nmy5WvP5Dgc6YMYk0Bcm/zcm20Cp
 H4ld5n7mqw5odwqQnOhxO890hC6q/ILdOY0dz9wQEED6LWBv4dZhA983pwSqz9rLb1Uo
 IcXyc8PtlGXP9svMvKd4wKIstQE7/hewM+6iQsOKLXEHf0y4xMO3iMI7ktRNwaGNllZz
 17fmhBSrSiOTMNBoxim3I0ImwzH1Q1Fua6ZtfAG6+xgvqvzeTvpax/GmqpWGM5GiyXph
 ku9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2CU5awjyWBi7wI0IEPR/D7QgQQ8EIg4J7okTZYOGlIg=;
 b=XDB2SHZHfSjYdEbON3g1/gCbSBnovT7qM1KNIYc7/WGhAWy2AkoK5o0QBPDwmoHsbP
 aPNgfSN6dEq5+3zCjeWq3aPNNpkL1dhum08PmacnIoOsW/Sg8DRLjs1VNsqY8uivRN2Y
 bCdXPIK9dJpEzZz6gRenGYyip+MhSWxsP6y5UkG1/X/KlC9XdzLQLPX5gaLYSsyNGtJA
 +PnPNck3oMBtd7U372QvmGky404wfgZGgK3NR5+88vKybKbqK+E8FNbPh7/gq27a0rZS
 A+mBI8CjiUlt40A/LUpjNOjK35WtBYqVHvLMd+Zk0CncLxSF8rurg0Q4LhY+J/d+JWYw
 I+Jg==
X-Gm-Message-State: APjAAAVQc2/fmA03NkD/nUoXBiEdh5yBFa9dS7O9tB4YaEowt9lxOYEb
 OHUIzBXQhKKxRN8FERQdYvq+DDfGXqSoEU9nJqk=
X-Google-Smtp-Source: APXvYqw2eIPhuI3fG0BPMlRQI9hqHsZcfrWDMyHbo/HwnI3w5d65Kthu+u50Uh+FewBw5JykheeMILfiJ597rEiYBj0=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr29876885ljm.285.1582589413132; 
 Mon, 24 Feb 2020 16:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20200224170301.246623-1-damien.hedde@greensocs.com>
 <20200224170301.246623-2-damien.hedde@greensocs.com>
In-Reply-To: <20200224170301.246623-2-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2020 16:02:38 -0800
Message-ID: <CAKmqyKP1LR3e5TmUvNWKub21sA7q6u2fK=saEH93i64furcpTQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] hw/core/clock: introduce clock object
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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

On Mon, Feb 24, 2020 at 9:05 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This object may be used to represent a clock inside a clock tree.
>
> A clock may be connected to another clock so that it receives update,
> through a callback, whenever the source/parent clock is updated.
>
> Although only the root clock of a clock tree controls the values
> (represented as periods) of all clocks in tree, each clock holds
> a local state containing the current value so that it can be fetched
> independently. It will allows us to fullfill migration requirements
> by migrating each clock independently of others.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> --
>
> v7:
> + merge ClockIn & ClockOut into a single type Clock
> + switch clock state to a period with 2^-32ns unit
> + add some Hz and ns helpers
> + propagate clock period when setting the source so that
>   clocks with fixed period are easy to handle.
> ---
>  include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/clock.c       | 131 +++++++++++++++++++++++++
>  hw/core/Makefile.objs |   2 +
>  hw/core/trace-events  |   7 ++
>  4 files changed, 356 insertions(+)
>  create mode 100644 include/hw/clock.h
>  create mode 100644 hw/core/clock.c
>
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> new file mode 100644
> index 0000000000..30ac9a9946
> --- /dev/null
> +++ b/include/hw/clock.h
> @@ -0,0 +1,216 @@
> +/*
> + * Hardware Clocks
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
> +#ifndef QEMU_HW_CLOCK_H
> +#define QEMU_HW_CLOCK_H
> +
> +#include "qom/object.h"
> +#include "qemu/queue.h"
> +
> +#define TYPE_CLOCK "clock"
> +#define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
> +
> +typedef void ClockCallback(void *opaque);
> +
> +/*
> + * clock store a value representing the clock's period in 2^-32ns unit.
> + * It can represent:
> + *  + periods from 2^-32ns up to 4seconds
> + *  + frequency from ~0.25Hz 2e10Ghz
> + * Resolution of frequency representation decreases with frequency:
> + * + at 100MHz, resolution is ~2mHz
> + * + at 1Ghz,   resolution is ~0.2Hz
> + * + at 10Ghz,  resolution is ~20Hz
> + */
> +#define CLOCK_SECOND (1000000000llu << 32)
> +
> +/*
> + * macro helpers to convert to hertz / nanosecond
> + */
> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 0u)
> +#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) : 0u)
> +
> +/**
> + * Clock:
> + * @parent_obj: parent class
> + * @period: unsigned integer representing the period of the clock
> + * @canonical_path: clock path string cache (used for trace purpose)
> + * @callback: called when clock changes
> + * @callback_opaque: argument for @callback
> + * @source: source (or parent in clock tree) of the clock
> + * @children: list of clocks connected to this one (it is their source)
> + * @sibling: structure used to form a clock list
> + */
> +
> +typedef struct Clock Clock;
> +
> +struct Clock {
> +    /*< private >*/
> +    Object parent_obj;
> +
> +    /* all fields are private and should not be modified directly */
> +
> +    /* fields */
> +    uint64_t period;
> +    char *canonical_path;
> +    ClockCallback *callback;
> +    void *callback_opaque;
> +
> +    /* Clocks are organized in a clock tree */
> +    Clock *source;
> +    QLIST_HEAD(, Clock) children;
> +    QLIST_ENTRY(Clock) sibling;
> +};
> +
> +/**
> + * clock_setup_canonical_path:
> + * @clk: clock
> + *
> + * compute the canonical path of the clock (used by log messages)
> + */
> +void clock_setup_canonical_path(Clock *clk);
> +
> +/**
> + * clock_add_callback:

s/clock_add_callback/clock_set_callback/g

> + * @clk: the clock to register the callback into
> + * @cb: the callback function
> + * @opaque: the argument to the callback
> + *
> + * Register a callback called on every clock update.
> + */
> +void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque);
> +
> +/**
> + * clock_clear_callback:
> + * @clk: the clock to delete the callback from
> + *
> + * Unregister the callback registered with clock_set_callback.
> + */
> +void clock_clear_callback(Clock *clk);
> +
> +/**
> + * clock_set_source:
> + * @clk: the clock.
> + * @src: the source clock
> + *
> + * Setup @src as the clock source of @clk. The current @src period
> + * value is also copied to @clk and its subtree but not callback is

s/not/no/g

> + * called.
> + * Further @src update will be propagated to @clk and its subtree.
> + */
> +void clock_set_source(Clock *clk, Clock *src);
> +
> +/**
> + * clock_set:
> + * @clk: the clock to initialize.
> + * @value: the clock's value, 0 means unclocked
> + *
> + * Set the local cached period value of @clk to @value.
> + */
> +void clock_set(Clock *clk, uint64_t value);
> +
> +static inline void clock_set_hz(Clock *clk, unsigned hz)
> +{
> +    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
> +}
> +
> +static inline void clock_set_ns(Clock *clk, unsigned ns)
> +{
> +    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
> +}
> +
> +/**
> + * clock_propagate:
> + * @clk: the clock
> + *
> + * Propagate the clock period that has been previsouly configured using

s/previsouly/previously/g

> + * @clock_set(). This will update recursively all connected clocks.
> + * It is an error to call this function on a clock which has a source.
> + * Note: this function must not be called during device inititialization
> + * or migration.
> + */
> +void clock_propagate(Clock *clk);
> +
> +/**
> + * clock_update:
> + * @clk: the clock to update.
> + * @value: the new clock's value, 0 means unclocked
> + *
> + * Update the @clk to the new @value. All connected clocks will be informed
> + * of this update. This is equivalent to call @clock_set() then
> + * @clock_propagate().
> + */
> +static inline void clock_update(Clock *clk, uint64_t value)
> +{
> +    clock_set(clk, value);
> +    clock_propagate(clk);
> +}
> +
> +static inline void clock_update_hz(Clock *clk, unsigned hz)
> +{
> +    clock_update(clk, CLOCK_PERIOD_FROM_HZ(hz));
> +}
> +
> +static inline void clock_update_ns(Clock *clk, unsigned ns)
> +{
> +    clock_update(clk, CLOCK_PERIOD_FROM_NS(ns));
> +}
> +
> +/**
> + * clock_get:
> + * @clk: the clk to fetch the clock
> + *
> + * @return: the current period.
> + */
> +static inline uint64_t clock_get(const Clock *clk)
> +{
> +    return clk->period;
> +}
> +
> +static inline unsigned clock_get_hz(Clock *clk)
> +{
> +    return CLOCK_PERIOD_TO_HZ(clock_get(clk));
> +}
> +
> +static inline unsigned clock_get_ns(Clock *clk)
> +{
> +    return CLOCK_PERIOD_TO_NS(clock_get(clk));
> +}
> +
> +/**
> + * clock_is_enabled:
> + * @clk: a clock
> + *
> + * @return: true if the clock is running.
> + */
> +static inline bool clock_is_enabled(const Clock *clk)
> +{
> +    return clock_get(clk) != 0;
> +}
> +
> +static inline void clock_init(Clock *clk, uint64_t value)
> +{
> +    clock_set(clk, value);
> +}
> +static inline void clock_init_hz(Clock *clk, uint64_t value)
> +{
> +    clock_set_hz(clk, value);
> +}
> +static inline void clock_init_ns(Clock *clk, uint64_t value)
> +{
> +    clock_set_ns(clk, value);
> +}
> +
> +#endif /* QEMU_HW_CLOCK_H */
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> new file mode 100644
> index 0000000000..4ba5765b05
> --- /dev/null
> +++ b/hw/core/clock.c
> @@ -0,0 +1,131 @@
> +/*
> + * Hardware Clocks
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
> +#include "hw/clock.h"
> +#include "trace.h"
> +
> +#define CLOCK_PATH(_clk) (_clk->canonical_path)
> +
> +void clock_setup_canonical_path(Clock *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path = object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
> +{
> +    clk->callback = cb;
> +    clk->callback_opaque = opaque;
> +}
> +
> +void clock_clear_callback(Clock *clk)
> +{
> +    clock_set_callback(clk, NULL, NULL);
> +}
> +
> +void clock_set(Clock *clk, uint64_t period)
> +{
> +    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
> +                    CLOCK_PERIOD_TO_NS(period));
> +    clk->period = period;
> +}
> +
> +static void clock_propagate_period(Clock *clk, bool call_callbacks)
> +{
> +    Clock *child;
> +
> +    QLIST_FOREACH(child, &clk->children, sibling) {
> +        if (child->period != clk->period) {
> +            child->period = clk->period;
> +            trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
> +                               CLOCK_PERIOD_TO_NS(clk->period),
> +                               call_callbacks);
> +            if (call_callbacks && child->callback) {
> +                child->callback(child->callback_opaque);
> +            }
> +            clock_propagate_period(child, call_callbacks);
> +        }
> +    }
> +}
> +
> +void clock_propagate(Clock *clk)
> +{
> +    assert(clk->source == NULL);
> +    trace_clock_propagate(CLOCK_PATH(clk));
> +    clock_propagate_period(clk, true);
> +}
> +
> +void clock_set_source(Clock *clk, Clock *src)
> +{
> +    /* changing clock source is not supported */
> +    assert(!clk->source);
> +
> +    trace_clock_set_source(CLOCK_PATH(clk), CLOCK_PATH(src));
> +
> +    clk->period = src->period;
> +    QLIST_INSERT_HEAD(&src->children, clk, sibling);
> +    clk->source = src;
> +    clock_propagate_period(clk, false);
> +}
> +
> +static void clock_disconnect(Clock *clk)
> +{
> +    if (clk->source == NULL) {
> +        return;
> +    }
> +
> +    trace_clock_disconnect(CLOCK_PATH(clk));
> +
> +    clk->source = NULL;
> +    QLIST_REMOVE(clk, sibling);
> +}
> +
> +static void clock_initfn(Object *obj)
> +{
> +    Clock *clk = CLOCK(obj);
> +
> +    QLIST_INIT(&clk->children);
> +}
> +
> +static void clock_finalizefn(Object *obj)
> +{
> +    Clock *clk = CLOCK(obj);
> +    Clock *child, *next;
> +
> +    /* clear our list of children */
> +    QLIST_FOREACH_SAFE(child, &clk->children, sibling, next) {
> +        clock_disconnect(child);
> +    }
> +
> +    /* remove us from source's chidlren list */

s/chidlren/children/g

> +    clock_disconnect(clk);
> +
> +    g_free(clk->canonical_path);
> +    clk->canonical_path = NULL;

You shouldn't need to set this to NULL.

> +}
> +
> +static const TypeInfo clock_info = {
> +    .name              = TYPE_CLOCK,
> +    .parent            = TYPE_OBJECT,
> +    .instance_size     = sizeof(Clock),
> +    .instance_init     = clock_initfn,
> +    .instance_finalize = clock_finalizefn,
> +};
> +
> +static void clock_register_types(void)
> +{
> +    type_register_static(&clock_info);
> +}
> +
> +type_init(clock_register_types)
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 6215e7c208..d7080edf89 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,10 +7,12 @@ common-obj-y += hotplug.o
>  common-obj-y += vmstate-if.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y += irq.o
> +common-obj-y += clock.o
>
>  common-obj-$(CONFIG_SOFTMMU) += reset.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
> +common-obj-$(CONFIG_SOFTMMU) += hotplug.o

I don't think this should be here.

Alistair

>  common-obj-$(CONFIG_SOFTMMU) += nmi.o
>  common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index aecd8e160e..39301621ce 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -27,3 +27,10 @@ resettable_phase_exit_begin(void *obj, const char *objtype, unsigned count, int
>  resettable_phase_exit_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
>  resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
>  resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
> +
> +# clock.c
> +clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
> +clock_disconnect(const char *clk) "'%s'"
> +clock_set(const char *clk, unsigned long long old, unsigned long long new) "'%s', ns=%llu->%llu"
> +clock_propagate(const char *clk) "'%s'"
> +clock_update(const char *clk, const char *src, unsigned long long val, int cb) "'%s', src='%s', ns=%llu, cb=%d"
> --
> 2.24.1
>
>

