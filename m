Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7445BC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC022082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="loeibe0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC022082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84H7-0007hG-4S
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i842e-0005AR-NU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i842b-0002B5-Mh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:56:20 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:56370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i842b-000298-56
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:56:17 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0D84C96F52;
 Wed, 11 Sep 2019 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568213774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoBOiOe19Tq5o+bte54mau/yr3Ll2VbkbOE7mCswY+o=;
 b=loeibe0Uujkju8kavqkuDIcYq11TaqSIfAgTT3O+zkN1cY4X9f3VhG6cjckSvjN8sJFiJv
 Yqz16nr1AeFTyPrVLo+kZt6/lOjiuhtV32lcoGUCoeIUEFxKfxfvDSCfCdrdylKss1kHbi
 UtkzFioiBWYekNyey3LfzYTAdR1fwKA=
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <20190911080642.GC13785@umbus.fritz.box>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
Date: Wed, 11 Sep 2019 16:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911080642.GC13785@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568213774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoBOiOe19Tq5o+bte54mau/yr3Ll2VbkbOE7mCswY+o=;
 b=yulvM2C0uACrT+U6U44qAo4bF70CHaK9zejIiqRH+5Q8Zfiaa4L1/Uf0sbnKRFXmNaYIAF
 0AC9PsB9pUBEa/gWqDuMPUInmOAZHg65X73Qsv/sFBMQhbveB+U8LXthIdMYpsvD4t0Hb6
 DDR7qQKfaG17RlF0CWGMVEqfqpefzV8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568213774; a=rsa-sha256; cv=none;
 b=pKHPHGUi/NGCjcOaZXaxtejaxhA6X4hUz+SDNCj/bmu5mvvtg5ZQEC0UD7/KwWO9jSfwwf
 2GzDY64pkbOuxz+J51wMFVwczt+8D7PnZmvT2vGb3ZUjcyA8c7wzHu0y/CxWXizmrA/cyi
 I4fOfUkgdFB3J2GPit2XW0rpzeiBMK4=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v4 02/10] hw/core: create Resettable QOM
 interface
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, mark.burton@greensocs.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/11/19 10:06 AM, David Gibson wrote:
> On Wed, Aug 21, 2019 at 06:33:33PM +0200, Damien Hedde wrote:
>> This commit defines an interface allowing multi-phase reset. This aims
>> to solve a problem of the actual single-phase reset (built in
>> DeviceClass and BusClass): reset behavior is dependent on the order
>> in which reset handlers are called. In particular doing external
>> side-effect (like setting an qemu_irq) is problematic because receiving
>> object may not be reset yet.
>>
>> The Resettable interface divides the reset in 3 well defined phases.
>> To reset an object tree, all 1st phases are executed then all 2nd then
>> all 3rd. See the comments in include/hw/resettable.h for a more complete
>> description. There is 3 phases to allow a device to be held in reset
>> state; the ability to control this state will be added in a following
>> commits.
>>
>> The qdev/qbus reset in DeviceClass and BusClass will be modified in
>> following commits to use this interface.
>> No change of behavior is expected because the init phase execution order
>> follows the children-then-parent order inside a tree. Since this is the
>> actual order of qdev/qbus reset, we will be able to map current reset
>> handlers on init phase for example.
>>
>> In this patch only cold reset is introduced, which is pretty much the
>> actual semantics of the current reset handlers. The interface can be
>> extended to support more reset types.
>>
>> Documentation will be added in a following commit.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>
>> I kept the non-recursive count approach (a given object counts reset
>> initiated on it as well as reset initiated on its parents in reset
>> hierarchy). I implemented the other approach, it is possible but is more
>> complex (an object has to know its direct parent(s) and we need to scan
>> the reset hierarchy to know if we are in reset) so I prefer not
>> to introduce it here.
>> Moreover I think it has drawbacks if we want to handle complex reset
>> use cases with more reset type.
>> Anyway, as long as we don't migrate the reset-related state, there is
>> no problem to switch between approaches.
>> ---
> 
> So, I certainly prefer the more general "reset type" approach taken in
> this version.  That said, I find it pretty hard to imagine what types
> of reset other than cold will exist that have well enough defined
> semantics to be meaningfully used from an external subsystem.

Maybe I should completely remove the type then ?

> 
>>  Makefile.objs           |   1 +
>>  hw/core/Makefile.objs   |   1 +
>>  hw/core/resettable.c    | 186 ++++++++++++++++++++++++++++++++++++++++
>>  hw/core/trace-events    |  36 ++++++++
>>  include/hw/resettable.h | 159 ++++++++++++++++++++++++++++++++++
>>  5 files changed, 383 insertions(+)
>>  create mode 100644 hw/core/resettable.c
>>  create mode 100644 hw/core/trace-events
>>  create mode 100644 include/hw/resettable.h
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 6a143dcd57..a723a47e14 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -191,6 +191,7 @@ trace-events-subdirs += migration
>>  trace-events-subdirs += net
>>  trace-events-subdirs += ui
>>  endif
>> +trace-events-subdirs += hw/core
>>  trace-events-subdirs += hw/display
>>  trace-events-subdirs += qapi
>>  trace-events-subdirs += qom
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index b49f880a0c..69b408ad1c 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -1,6 +1,7 @@
>>  # core qdev-related obj files, also used by *-user:
>>  common-obj-y += qdev.o qdev-properties.o
>>  common-obj-y += bus.o reset.o
>> +common-obj-y += resettable.o
>>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
>>  # irq.o needed for qdev GPIO handling:
>> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
>> new file mode 100644
>> index 0000000000..b534c2c7a4
>> --- /dev/null
>> +++ b/hw/core/resettable.c
>> @@ -0,0 +1,186 @@
>> +/*
>> + * Resettable interface.
>> + *
>> + * Copyright (c) 2019 GreenSocs SAS
>> + *
>> + * Authors:
>> + *   Damien Hedde
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/module.h"
>> +#include "hw/resettable.h"
>> +#include "trace.h"
>> +
>> +#define RESETTABLE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE_INTERFACE)
>> +
>> +static void resettable_foreach_child(ResettableClass *rc,
>> +                                     Object *obj,
>> +                                     void (*func)(Object *, ResetType type),
>> +                                     ResetType type)
>> +{
>> +    if (rc->foreach_child) {
>> +        rc->foreach_child(obj, func, type);
>> +    }
>> +}
>> +
>> +static void resettable_init_reset(Object *obj, ResetType type)
> 
> I wonder if "enter reset" would be better terminology so this doesn't
> get confused with the initial, well, initialization of the device.

Do you mean for the function here or in general for the name of the phase ?

> 
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    ResetState *s = rc->get_state(obj);
>> +    bool action_needed = false;
>> +
>> +    /* Only take action if we really enter reset for the 1st time. */
>> +    /*
>> +     * TODO: if adding more ResetType support, some additional checks
>> +     * are probably needed here.
>> +     */
>> +    if (s->count == 0) {
>> +        action_needed = true;
>> +    }
>> +    s->count += 1;
>> +    /*
>> +     * We limit the count to an arbitrary "big" value. The value is big
>> +     * enough not to be triggered nominally.
>> +     * The assert will stop an infinite loop if there is a cycle in the
>> +     * reset tree. The loop goes through resettable_foreach_child below
>> +     * which at some point will call us again.
>> +     */
>> +    assert(s->count <= 50);
>> +    trace_resettable_phase_init(obj, object_get_typename(obj), type,
>> +                                s->count, action_needed);
>> +
>> +    /*
>> +     * handle the children even if action_needed is at false so that
>> +     * children counts are incremented too
>> +     */
>> +    resettable_foreach_child(rc, obj, resettable_init_reset, type);
>> +
>> +    /* exec init phase */
>> +    if (action_needed) {
>> +        s->hold_phase_needed = true;
>> +        if (rc->phases.init) {
>> +            rc->phases.init(obj, type);
>> +        }
>> +    }
>> +    trace_resettable_phase_init_end(obj);
>> +}
>> +
>> +static void resettable_hold_reset_child(Object *obj, ResetType type)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    ResetState *s = rc->get_state(obj);
>> +
>> +    trace_resettable_phase_hold(obj, object_get_typename(obj));
>> +
>> +    /* handle children first */
>> +    resettable_foreach_child(rc, obj, resettable_hold_reset_child, 0);
>> +
>> +    /* exec hold phase */
>> +    if (s->hold_phase_needed) {
>> +        s->hold_phase_needed = false;
>> +        if (rc->phases.hold) {
>> +            rc->phases.hold(obj);
> 
> I was about to ask what purpose the hold phase has since it's always
> executed right after the init phase, before realizing that it's
> because it can happen after parent devices have completed their init
> phase.
> 
> Point that out in a comment here might help to avoid confusion.

noted.

> 
>> +        }
>> +    }
>> +    trace_resettable_phase_hold_end(obj, s->hold_phase_needed);
>> +}
>> +
>> +static void resettable_hold_reset(Object *obj)
>> +{
>> +    /* we don't care of 2nd argument here */
>> +    resettable_hold_reset_child(obj, 0);
>> +}
>> +
>> +static void resettable_exit_reset_child(Object *obj, ResetType type)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    ResetState *s = rc->get_state(obj);
>> +
>> +    trace_resettable_phase_exit(obj, object_get_typename(obj));
>> +
>> +    resettable_foreach_child(rc, obj, resettable_exit_reset_child, 0);
>> +
>> +    /*
>> +     * we could assert that count > 0 but there are some corner cases
>> +     * where we prefer to let it go as it is probably harmless.
>> +     * For example: if there is reset support addition between
>> +     * hosts when doing a migration. We may do such things as
>> +     * deassert a non-existing reset.
>> +     */
>> +    if (s->count > 0) {
>> +        s->count -= 1;
>> +    } else {
>> +        trace_resettable_count_underflow(obj);
> 
> Should this be an assert(), IIUC this could only come about from an
> error within the qemu code, right?

Initially I was thinking that so I put an assert.

But while testing I found out that it is triggered by the raspi machine
during its reset because the qbus tree is modified during it.

So it depends if we consider this kind of action to be faulty. With no
migration support, the only way to trigger it is to modify the qdev
hierarchy during reset.

But it made me think about the migration cases (with "staying in reset
state"). There are some cases where migration between 2 different
versions can lead to problem with the counter (typically if you migrate
to a new version that have a new device on a bus held in reset).

> 
>> +    }
>> +    if (s->count == 0) {
>> +        if (rc->phases.exit) {
>> +            rc->phases.exit(obj);
> 
> Hm.  It's not really clear to me whether child resets should go before
> or after the parent.  It seems odd that it would be the same for both
> entering and exiting reset, though.

Since the whole point of the phases is to make the reset independent of
the order in which it is "scheduled", I think we could consider it as
"unspecified". If we find out that we need some hierarchical order for a
yet unknown reason, we can change it.

I've used the order children then parent because it is the actual qdev
reset order and we do not want to modify the actual order now.

> 
>> +        }
>> +    }
>> +    trace_resettable_phase_exit_end(obj, s->count);
>> +}
>> +
>> +static void resettable_exit_reset(Object *obj)
>> +{
>> +    /* we don't care of 2nd argument here */
>> +    resettable_exit_reset_child(obj, 0);
>> +}
>> +
>> +void resettable_reset(Object *obj, ResetType type)
>> +{
>> +    /* TODO: change that when adding support for other reset types */
>> +    assert(type == RESET_TYPE_COLD);
>> +    trace_resettable_reset(obj, type);
>> +    resettable_init_reset(obj, type);
>> +    resettable_hold_reset(obj);
>> +    resettable_exit_reset(obj);
>> +}
>> +
>> +void resettable_cold_reset_fn(void *opaque)
>> +{
>> +    resettable_reset((Object *) opaque, RESET_TYPE_COLD);
>> +}
>> +
>> +bool resettable_is_resetting(Object *obj)
>> +{
>> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
>> +    ResetState *s = rc->get_state(obj);
>> +
>> +    return (s->count > 0);
>> +}
>> +
>> +void resettable_class_set_parent_phases(ResettableClass *rc,
>> +                                        ResettableInitPhase init,
>> +                                        ResettableHoldPhase hold,
>> +                                        ResettableExitPhase exit,
>> +                                        ResettablePhases *parent_phases)
>> +{
>> +    *parent_phases = rc->phases;
>> +    if (init) {
>> +        rc->phases.init = init;
>> +    }
>> +    if (hold) {
>> +        rc->phases.hold = hold;
>> +    }
>> +    if (exit) {
>> +        rc->phases.exit = exit;
>> +    }
>> +}
>> +
>> +static const TypeInfo resettable_interface_info = {
>> +    .name       = TYPE_RESETTABLE_INTERFACE,
>> +    .parent     = TYPE_INTERFACE,
>> +    .class_size = sizeof(ResettableClass),
>> +};
>> +
>> +static void reset_register_types(void)
>> +{
>> +    type_register_static(&resettable_interface_info);
>> +}
>> +
>> +type_init(reset_register_types)
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> new file mode 100644
>> index 0000000000..ecf966c314
>> --- /dev/null
>> +++ b/hw/core/trace-events
>> @@ -0,0 +1,36 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>> +#
>> +# This file is processed by the tracetool script during the build.
>> +#
>> +# To add a new trace event:
>> +#
>> +# 1. Choose a name for the trace event.  Declare its arguments and format
>> +#    string.
>> +#
>> +# 2. Call the trace event from code using trace_##name, e.g. multiwrite_cb() ->
>> +#    trace_multiwrite_cb().  The source file must #include "trace.h".
>> +#
>> +# Format of a trace event:
>> +#
>> +# [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-string>"
>> +#
>> +# Example: g_malloc(size_t size) "size %zu"
>> +#
>> +# The "disable" keyword will build without the trace event.
>> +#
>> +# The <name> must be a valid as a C function name.
>> +#
>> +# Types should be standard C types.  Use void * for pointers because the trace
>> +# system may not have the necessary headers included.
>> +#
>> +# The <format-string> should be a sprintf()-compatible format string.
>> +
>> +# resettable.c
>> +resettable_reset(void *obj, int cold) "obj=%p cold=%d"
>> +resettable_phase_init(void *obj, const char *type, int cold, uint32_t count, int needed) "obj=%p(%s) cold=%d count=%" PRIu32 " needed=%d"
>> +resettable_phase_init_end(void *obj) "obj=%p"
>> +resettable_phase_hold(void *obj, const char *type) "obj=%p(%s)"
>> +resettable_phase_hold_end(void *obj, int needed) "obj=%p needed=%d"
>> +resettable_phase_exit(void *obj, const char *type) "obj=%p(%s)"
>> +resettable_phase_exit_end(void *obj, uint32_t count) "obj=%p count=%" PRIu32
>> +resettable_count_underflow(void *obj) "obj=%p"
>> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
>> new file mode 100644
>> index 0000000000..5808c3c187
>> --- /dev/null
>> +++ b/include/hw/resettable.h
>> @@ -0,0 +1,159 @@
>> +#ifndef HW_RESETTABLE_H
>> +#define HW_RESETTABLE_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RESETTABLE_INTERFACE "resettable"
>> +
>> +#define RESETTABLE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE_INTERFACE)
>> +
>> +typedef struct ResetState ResetState;
>> +
>> +/**
>> + * ResetType:
>> + * Types of reset.
>> + *
>> + * + Cold: reset resulting from a power cycle of the object.
>> + *
>> + * TODO: Support has to be added to handle more types. In particular,
>> + * ResetState structure needs to be expanded.
>> + */
>> +typedef enum ResetType {
>> +    RESET_TYPE_COLD,
>> +} ResetType;
>> +
>> +/*
>> + * ResettableClass:
>> + * Interface for resettable objects.
>> + *
>> + * See docs/devel/reset.rst for more detailed information about
>> + * how QEMU models reset.
>> + *
>> + * All objects which can be reset must implement this interface;
>> + * it is usually provided by a base class such as DeviceClass or BusClass.
>> + * Every Resettable object must maintain some state tracking the
>> + * progress of a reset operation by providing a ResetState structure.
>> + * The functions defined in this module take care of updating the
>> + * state of the reset.
>> + * The base class implementation of the interface provides this
>> + * state and implements the associated method: get_state.
>> + *
>> + * Concrete object implementations (typically specific devices
>> + * such as a UART model) should provide the functions
>> + * for the phases.init, phases.hold and phases.exit methods, which
>> + * they can set in their class init function, either directly or
>> + * by calling resettable_class_set_parent_phases().
>> + * The phase methods are guaranteed to only only ever be called once
>> + * for any reset event, in the order 'init', 'hold', 'exit'.
>> + * An object will always move quickly from 'init' to 'hold'
>> + * but might remain in 'hold' for an arbitrary period of time
>> + * before eventually reset is deasserted and the 'exit' phase is called.
>> + * Object implementations should be prepared for functions handling
>> + * inbound connections from other devices (such as qemu_irq handler
>> + * functions) to be called at any point during reset after their
>> + * 'init' method has been called.
>> + *
>> + * Users of a resettable object should not call these methods
>> + * directly, but instead use the function resettable_reset().
>> + *
>> + * @phases.init: This phase is called when the object enters reset. It
>> + * should reset local state of the object, but it must not do anything that
>> + * has a side-effect on other objects, such as raising or lowering a qemu_irq
>> + * line or reading or writing guest memory. It takes the reset's type as
>> + * argument.
>> + *
>> + * @phases.hold: This phase is called for entry into reset, once every object
>> + * in the system which is being reset has had its @phases.init method called.
>> + * At this point devices can do actions that affect other objects.
>> + *
>> + * @phases.exit: This phase is called when the object leaves the reset state.
>> + * Actions affecting other objects are permitted.
>> + *
>> + * @get_state: Mandatory method which must return a pointer to a ResetState.
>> + *
>> + * @foreach_child: Executes a given function on every Resettable child. Child
>> + * in this context means a child in the qbus tree, so the children of a qbus
>> + * are the devices on it, and the children of a device are all the buses it
>> + * owns. This is not the same as the QOM object hierarchy. The function takes
>> + * an additional ResetType argument which is passed to foreach_child.
>> + */
>> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
>> +typedef void (*ResettableHoldPhase)(Object *obj);
>> +typedef void (*ResettableExitPhase)(Object *obj);
>> +typedef ResetState * (*ResettableGetState)(Object *obj);
>> +typedef void (*ResettableForeachChild)(Object *obj,
>> +                                       void (*func)(Object *, ResetType type),
>> +                                       ResetType type);
>> +typedef struct ResettableClass {
>> +    InterfaceClass parent_class;
>> +
>> +    struct ResettablePhases {
>> +        ResettableInitPhase init;
>> +        ResettableHoldPhase hold;
>> +        ResettableExitPhase exit;
>> +    } phases;
>> +
>> +    ResettableGetState get_state;
>> +    ResettableForeachChild foreach_child;
>> +} ResettableClass;
>> +typedef struct ResettablePhases ResettablePhases;
>> +
>> +/**
>> + * ResetState:
>> + * Structure holding reset related state. The fields should not be accessed
>> + * directly, the definition is here to allow further inclusion into other
>> + * objects.
>> + *
>> + * @count: Number of reset level the object is into. It is incremented when
>> + * the reset operation starts and decremented when it finishes.
>> + * @hold_phase_needed: flag which indicates that we need to invoke the 'hold'
>> + * phase handler for this object.
>> + */
>> +struct ResetState {
>> +    uint32_t count;
>> +    bool hold_phase_needed;
>> +};
>> +
>> +/**
>> + * resettable_is_resetting:
>> + * Return true if @obj is under reset.
>> + *
>> + * @obj must implement Resettable interface.
>> + */
>> +bool resettable_is_resetting(Object *obj);
>> +
>> +/**
>> + * resettable_reset:
>> + * Trigger a reset on a object @obj of type @type. @obj must implement
>> + * Resettable interface.
>> + *
>> + * Calling this function is equivalent to calling @resettable_assert_reset then
>> + * @resettable_deassert_reset.
>> + */
>> +void resettable_reset(Object *obj, ResetType type);
>> +
>> +/**
>> + * resettable_cold_reset_fn:
>> + * Helper to call resettable_reset((Object *) opaque, RESET_TYPE_COLD).
>> + *
>> + * This function is typically useful to register a reset handler with
>> + * qemu_register_reset.
>> + */
>> +void resettable_cold_reset_fn(void *opaque);
>> +
>> +/**
>> + * resettable_class_set_parent_phases:
>> + *
>> + * Save @rc current reset phases into @parent_phases and override @rc phases
>> + * by the given new methods (@init, @hold and @exit).
>> + * Each phase is overridden only if the new one is not NULL allowing to
>> + * override a subset of phases.
>> + */
>> +void resettable_class_set_parent_phases(ResettableClass *rc,
>> +                                        ResettableInitPhase init,
>> +                                        ResettableHoldPhase hold,
>> +                                        ResettableExitPhase exit,
>> +                                        ResettablePhases *parent_phases);
>> +
>> +#endif
> 

