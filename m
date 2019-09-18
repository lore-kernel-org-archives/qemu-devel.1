Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B4C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7387B218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nRYGPjF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7387B218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAW13-0002G7-FI
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAW0B-0001pJ-FP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAW08-0001XI-0J
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:11:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41473 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iAW06-0001WF-Jv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:11:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YDkV2NJ5z9sNw; Wed, 18 Sep 2019 19:11:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568797906;
 bh=t5XjoFqoRBU7Q1UDUNod/HcFS78bNayJslHkRM3ElNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nRYGPjF5GBnfxKo8PCGf2Vr5BOgDB6K5nDPQ7gQHLGiFPIXYGrNhqxKfpCzyX7cCi
 JAvdSa+PmxkEWr38AI4wTkGPdP1GSH7XuioOP8nXspOSj0fKoJGzDoFDQXW+xgzR7a
 2cn+OgS1gLNpDuI8Bs067Uelu/GLuumnNuRCA6SE=
Date: Wed, 18 Sep 2019 19:11:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190918091135.GA22790@umbus.fritz.box>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <20190911080642.GC13785@umbus.fritz.box>
 <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 04:56:13PM +0200, Damien Hedde wrote:
>=20
>=20
> On 9/11/19 10:06 AM, David Gibson wrote:
> > On Wed, Aug 21, 2019 at 06:33:33PM +0200, Damien Hedde wrote:
> >> This commit defines an interface allowing multi-phase reset. This aims
> >> to solve a problem of the actual single-phase reset (built in
> >> DeviceClass and BusClass): reset behavior is dependent on the order
> >> in which reset handlers are called. In particular doing external
> >> side-effect (like setting an qemu_irq) is problematic because receiving
> >> object may not be reset yet.
> >>
> >> The Resettable interface divides the reset in 3 well defined phases.
> >> To reset an object tree, all 1st phases are executed then all 2nd then
> >> all 3rd. See the comments in include/hw/resettable.h for a more comple=
te
> >> description. There is 3 phases to allow a device to be held in reset
> >> state; the ability to control this state will be added in a following
> >> commits.
> >>
> >> The qdev/qbus reset in DeviceClass and BusClass will be modified in
> >> following commits to use this interface.
> >> No change of behavior is expected because the init phase execution ord=
er
> >> follows the children-then-parent order inside a tree. Since this is the
> >> actual order of qdev/qbus reset, we will be able to map current reset
> >> handlers on init phase for example.
> >>
> >> In this patch only cold reset is introduced, which is pretty much the
> >> actual semantics of the current reset handlers. The interface can be
> >> extended to support more reset types.
> >>
> >> Documentation will be added in a following commit.
> >>
> >> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> >> ---
> >>
> >> I kept the non-recursive count approach (a given object counts reset
> >> initiated on it as well as reset initiated on its parents in reset
> >> hierarchy). I implemented the other approach, it is possible but is mo=
re
> >> complex (an object has to know its direct parent(s) and we need to scan
> >> the reset hierarchy to know if we are in reset) so I prefer not
> >> to introduce it here.
> >> Moreover I think it has drawbacks if we want to handle complex reset
> >> use cases with more reset type.
> >> Anyway, as long as we don't migrate the reset-related state, there is
> >> no problem to switch between approaches.
> >> ---
> >=20
> > So, I certainly prefer the more general "reset type" approach taken in
> > this version.  That said, I find it pretty hard to imagine what types
> > of reset other than cold will exist that have well enough defined
> > semantics to be meaningfully used from an external subsystem.
>=20
> Maybe I should completely remove the type then ?

That makes sense to me.  I don't know if other possible users of the
mechanism have different opinions though.

> >=20
> >>  Makefile.objs           |   1 +
> >>  hw/core/Makefile.objs   |   1 +
> >>  hw/core/resettable.c    | 186 ++++++++++++++++++++++++++++++++++++++++
> >>  hw/core/trace-events    |  36 ++++++++
> >>  include/hw/resettable.h | 159 ++++++++++++++++++++++++++++++++++
> >>  5 files changed, 383 insertions(+)
> >>  create mode 100644 hw/core/resettable.c
> >>  create mode 100644 hw/core/trace-events
> >>  create mode 100644 include/hw/resettable.h
> >>
> >> diff --git a/Makefile.objs b/Makefile.objs
> >> index 6a143dcd57..a723a47e14 100644
> >> --- a/Makefile.objs
> >> +++ b/Makefile.objs
> >> @@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
> >>  trace-events-subdirs +=3D net
> >>  trace-events-subdirs +=3D ui
> >>  endif
> >> +trace-events-subdirs +=3D hw/core
> >>  trace-events-subdirs +=3D hw/display
> >>  trace-events-subdirs +=3D qapi
> >>  trace-events-subdirs +=3D qom
> >> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> >> index b49f880a0c..69b408ad1c 100644
> >> --- a/hw/core/Makefile.objs
> >> +++ b/hw/core/Makefile.objs
> >> @@ -1,6 +1,7 @@
> >>  # core qdev-related obj files, also used by *-user:
> >>  common-obj-y +=3D qdev.o qdev-properties.o
> >>  common-obj-y +=3D bus.o reset.o
> >> +common-obj-y +=3D resettable.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
> >>  # irq.o needed for qdev GPIO handling:
> >> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> >> new file mode 100644
> >> index 0000000000..b534c2c7a4
> >> --- /dev/null
> >> +++ b/hw/core/resettable.c
> >> @@ -0,0 +1,186 @@
> >> +/*
> >> + * Resettable interface.
> >> + *
> >> + * Copyright (c) 2019 GreenSocs SAS
> >> + *
> >> + * Authors:
> >> + *   Damien Hedde
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
> >> + * See the COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/module.h"
> >> +#include "hw/resettable.h"
> >> +#include "trace.h"
> >> +
> >> +#define RESETTABLE_GET_CLASS(obj) \
> >> +    OBJECT_GET_CLASS(ResettableClass, (obj), TYPE_RESETTABLE_INTERFAC=
E)
> >> +
> >> +static void resettable_foreach_child(ResettableClass *rc,
> >> +                                     Object *obj,
> >> +                                     void (*func)(Object *, ResetType=
 type),
> >> +                                     ResetType type)
> >> +{
> >> +    if (rc->foreach_child) {
> >> +        rc->foreach_child(obj, func, type);
> >> +    }
> >> +}
> >> +
> >> +static void resettable_init_reset(Object *obj, ResetType type)
> >=20
> > I wonder if "enter reset" would be better terminology so this doesn't
> > get confused with the initial, well, initialization of the device.
>=20
> Do you mean for the function here or in general for the name of the phase=
 ?

In general.

> >> +{
> >> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> >> +    ResetState *s =3D rc->get_state(obj);
> >> +    bool action_needed =3D false;
> >> +
> >> +    /* Only take action if we really enter reset for the 1st time. */
> >> +    /*
> >> +     * TODO: if adding more ResetType support, some additional checks
> >> +     * are probably needed here.
> >> +     */
> >> +    if (s->count =3D=3D 0) {
> >> +        action_needed =3D true;
> >> +    }
> >> +    s->count +=3D 1;
> >> +    /*
> >> +     * We limit the count to an arbitrary "big" value. The value is b=
ig
> >> +     * enough not to be triggered nominally.
> >> +     * The assert will stop an infinite loop if there is a cycle in t=
he
> >> +     * reset tree. The loop goes through resettable_foreach_child bel=
ow
> >> +     * which at some point will call us again.
> >> +     */
> >> +    assert(s->count <=3D 50);
> >> +    trace_resettable_phase_init(obj, object_get_typename(obj), type,
> >> +                                s->count, action_needed);
> >> +
> >> +    /*
> >> +     * handle the children even if action_needed is at false so that
> >> +     * children counts are incremented too
> >> +     */
> >> +    resettable_foreach_child(rc, obj, resettable_init_reset, type);
> >> +
> >> +    /* exec init phase */
> >> +    if (action_needed) {
> >> +        s->hold_phase_needed =3D true;
> >> +        if (rc->phases.init) {
> >> +            rc->phases.init(obj, type);
> >> +        }
> >> +    }
> >> +    trace_resettable_phase_init_end(obj);
> >> +}
> >> +
> >> +static void resettable_hold_reset_child(Object *obj, ResetType type)
> >> +{
> >> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> >> +    ResetState *s =3D rc->get_state(obj);
> >> +
> >> +    trace_resettable_phase_hold(obj, object_get_typename(obj));
> >> +
> >> +    /* handle children first */
> >> +    resettable_foreach_child(rc, obj, resettable_hold_reset_child, 0);
> >> +
> >> +    /* exec hold phase */
> >> +    if (s->hold_phase_needed) {
> >> +        s->hold_phase_needed =3D false;
> >> +        if (rc->phases.hold) {
> >> +            rc->phases.hold(obj);
> >=20
> > I was about to ask what purpose the hold phase has since it's always
> > executed right after the init phase, before realizing that it's
> > because it can happen after parent devices have completed their init
> > phase.
> >=20
> > Point that out in a comment here might help to avoid confusion.
>=20
> noted.
>=20
> >=20
> >> +        }
> >> +    }
> >> +    trace_resettable_phase_hold_end(obj, s->hold_phase_needed);
> >> +}
> >> +
> >> +static void resettable_hold_reset(Object *obj)
> >> +{
> >> +    /* we don't care of 2nd argument here */
> >> +    resettable_hold_reset_child(obj, 0);
> >> +}
> >> +
> >> +static void resettable_exit_reset_child(Object *obj, ResetType type)
> >> +{
> >> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> >> +    ResetState *s =3D rc->get_state(obj);
> >> +
> >> +    trace_resettable_phase_exit(obj, object_get_typename(obj));
> >> +
> >> +    resettable_foreach_child(rc, obj, resettable_exit_reset_child, 0);
> >> +
> >> +    /*
> >> +     * we could assert that count > 0 but there are some corner cases
> >> +     * where we prefer to let it go as it is probably harmless.
> >> +     * For example: if there is reset support addition between
> >> +     * hosts when doing a migration. We may do such things as
> >> +     * deassert a non-existing reset.
> >> +     */
> >> +    if (s->count > 0) {
> >> +        s->count -=3D 1;
> >> +    } else {
> >> +        trace_resettable_count_underflow(obj);
> >=20
> > Should this be an assert(), IIUC this could only come about from an
> > error within the qemu code, right?
>=20
> Initially I was thinking that so I put an assert.
>=20
> But while testing I found out that it is triggered by the raspi machine
> during its reset because the qbus tree is modified during it.
>=20
> So it depends if we consider this kind of action to be faulty. With no
> migration support, the only way to trigger it is to modify the qdev
> hierarchy during reset.

Hm, I see.  It feels like just ignoring underflow is ignoring the
error rather than really addressing it.  When we add a device to the
heirarchy, do we need to initialize its reset count based on its
parent's current count or something.

> But it made me think about the migration cases (with "staying in reset
> state"). There are some cases where migration between 2 different
> versions can lead to problem with the counter (typically if you migrate
> to a new version that have a new device on a bus held in reset).

Uh... migration is only permitted between identical machines.  I don't
see how a new device is possible.

>=20
> >=20
> >> +    }
> >> +    if (s->count =3D=3D 0) {
> >> +        if (rc->phases.exit) {
> >> +            rc->phases.exit(obj);
> >=20
> > Hm.  It's not really clear to me whether child resets should go before
> > or after the parent.  It seems odd that it would be the same for both
> > entering and exiting reset, though.
>=20
> Since the whole point of the phases is to make the reset independent of
> the order in which it is "scheduled", I think we could consider it as
> "unspecified". If we find out that we need some hierarchical order for a
> yet unknown reason, we can change it.
>=20
> I've used the order children then parent because it is the actual qdev
> reset order and we do not want to modify the actual order now.

Hm, ok.

>=20
> >=20
> >> +        }
> >> +    }
> >> +    trace_resettable_phase_exit_end(obj, s->count);
> >> +}
> >> +
> >> +static void resettable_exit_reset(Object *obj)
> >> +{
> >> +    /* we don't care of 2nd argument here */
> >> +    resettable_exit_reset_child(obj, 0);
> >> +}
> >> +
> >> +void resettable_reset(Object *obj, ResetType type)
> >> +{
> >> +    /* TODO: change that when adding support for other reset types */
> >> +    assert(type =3D=3D RESET_TYPE_COLD);
> >> +    trace_resettable_reset(obj, type);
> >> +    resettable_init_reset(obj, type);
> >> +    resettable_hold_reset(obj);
> >> +    resettable_exit_reset(obj);
> >> +}
> >> +
> >> +void resettable_cold_reset_fn(void *opaque)
> >> +{
> >> +    resettable_reset((Object *) opaque, RESET_TYPE_COLD);
> >> +}
> >> +
> >> +bool resettable_is_resetting(Object *obj)
> >> +{
> >> +    ResettableClass *rc =3D RESETTABLE_GET_CLASS(obj);
> >> +    ResetState *s =3D rc->get_state(obj);
> >> +
> >> +    return (s->count > 0);
> >> +}
> >> +
> >> +void resettable_class_set_parent_phases(ResettableClass *rc,
> >> +                                        ResettableInitPhase init,
> >> +                                        ResettableHoldPhase hold,
> >> +                                        ResettableExitPhase exit,
> >> +                                        ResettablePhases *parent_phas=
es)
> >> +{
> >> +    *parent_phases =3D rc->phases;
> >> +    if (init) {
> >> +        rc->phases.init =3D init;
> >> +    }
> >> +    if (hold) {
> >> +        rc->phases.hold =3D hold;
> >> +    }
> >> +    if (exit) {
> >> +        rc->phases.exit =3D exit;
> >> +    }
> >> +}
> >> +
> >> +static const TypeInfo resettable_interface_info =3D {
> >> +    .name       =3D TYPE_RESETTABLE_INTERFACE,
> >> +    .parent     =3D TYPE_INTERFACE,
> >> +    .class_size =3D sizeof(ResettableClass),
> >> +};
> >> +
> >> +static void reset_register_types(void)
> >> +{
> >> +    type_register_static(&resettable_interface_info);
> >> +}
> >> +
> >> +type_init(reset_register_types)
> >> diff --git a/hw/core/trace-events b/hw/core/trace-events
> >> new file mode 100644
> >> index 0000000000..ecf966c314
> >> --- /dev/null
> >> +++ b/hw/core/trace-events
> >> @@ -0,0 +1,36 @@
> >> +# See docs/devel/tracing.txt for syntax documentation.
> >> +#
> >> +# This file is processed by the tracetool script during the build.
> >> +#
> >> +# To add a new trace event:
> >> +#
> >> +# 1. Choose a name for the trace event.  Declare its arguments and fo=
rmat
> >> +#    string.
> >> +#
> >> +# 2. Call the trace event from code using trace_##name, e.g. multiwri=
te_cb() ->
> >> +#    trace_multiwrite_cb().  The source file must #include "trace.h".
> >> +#
> >> +# Format of a trace event:
> >> +#
> >> +# [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-str=
ing>"
> >> +#
> >> +# Example: g_malloc(size_t size) "size %zu"
> >> +#
> >> +# The "disable" keyword will build without the trace event.
> >> +#
> >> +# The <name> must be a valid as a C function name.
> >> +#
> >> +# Types should be standard C types.  Use void * for pointers because =
the trace
> >> +# system may not have the necessary headers included.
> >> +#
> >> +# The <format-string> should be a sprintf()-compatible format string.
> >> +
> >> +# resettable.c
> >> +resettable_reset(void *obj, int cold) "obj=3D%p cold=3D%d"
> >> +resettable_phase_init(void *obj, const char *type, int cold, uint32_t=
 count, int needed) "obj=3D%p(%s) cold=3D%d count=3D%" PRIu32 " needed=3D%d"
> >> +resettable_phase_init_end(void *obj) "obj=3D%p"
> >> +resettable_phase_hold(void *obj, const char *type) "obj=3D%p(%s)"
> >> +resettable_phase_hold_end(void *obj, int needed) "obj=3D%p needed=3D%=
d"
> >> +resettable_phase_exit(void *obj, const char *type) "obj=3D%p(%s)"
> >> +resettable_phase_exit_end(void *obj, uint32_t count) "obj=3D%p count=
=3D%" PRIu32
> >> +resettable_count_underflow(void *obj) "obj=3D%p"
> >> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> >> new file mode 100644
> >> index 0000000000..5808c3c187
> >> --- /dev/null
> >> +++ b/include/hw/resettable.h
> >> @@ -0,0 +1,159 @@
> >> +#ifndef HW_RESETTABLE_H
> >> +#define HW_RESETTABLE_H
> >> +
> >> +#include "qom/object.h"
> >> +
> >> +#define TYPE_RESETTABLE_INTERFACE "resettable"
> >> +
> >> +#define RESETTABLE_CLASS(class) \
> >> +    OBJECT_CLASS_CHECK(ResettableClass, (class), TYPE_RESETTABLE_INTE=
RFACE)
> >> +
> >> +typedef struct ResetState ResetState;
> >> +
> >> +/**
> >> + * ResetType:
> >> + * Types of reset.
> >> + *
> >> + * + Cold: reset resulting from a power cycle of the object.
> >> + *
> >> + * TODO: Support has to be added to handle more types. In particular,
> >> + * ResetState structure needs to be expanded.
> >> + */
> >> +typedef enum ResetType {
> >> +    RESET_TYPE_COLD,
> >> +} ResetType;
> >> +
> >> +/*
> >> + * ResettableClass:
> >> + * Interface for resettable objects.
> >> + *
> >> + * See docs/devel/reset.rst for more detailed information about
> >> + * how QEMU models reset.
> >> + *
> >> + * All objects which can be reset must implement this interface;
> >> + * it is usually provided by a base class such as DeviceClass or BusC=
lass.
> >> + * Every Resettable object must maintain some state tracking the
> >> + * progress of a reset operation by providing a ResetState structure.
> >> + * The functions defined in this module take care of updating the
> >> + * state of the reset.
> >> + * The base class implementation of the interface provides this
> >> + * state and implements the associated method: get_state.
> >> + *
> >> + * Concrete object implementations (typically specific devices
> >> + * such as a UART model) should provide the functions
> >> + * for the phases.init, phases.hold and phases.exit methods, which
> >> + * they can set in their class init function, either directly or
> >> + * by calling resettable_class_set_parent_phases().
> >> + * The phase methods are guaranteed to only only ever be called once
> >> + * for any reset event, in the order 'init', 'hold', 'exit'.
> >> + * An object will always move quickly from 'init' to 'hold'
> >> + * but might remain in 'hold' for an arbitrary period of time
> >> + * before eventually reset is deasserted and the 'exit' phase is call=
ed.
> >> + * Object implementations should be prepared for functions handling
> >> + * inbound connections from other devices (such as qemu_irq handler
> >> + * functions) to be called at any point during reset after their
> >> + * 'init' method has been called.
> >> + *
> >> + * Users of a resettable object should not call these methods
> >> + * directly, but instead use the function resettable_reset().
> >> + *
> >> + * @phases.init: This phase is called when the object enters reset. It
> >> + * should reset local state of the object, but it must not do anythin=
g that
> >> + * has a side-effect on other objects, such as raising or lowering a =
qemu_irq
> >> + * line or reading or writing guest memory. It takes the reset's type=
 as
> >> + * argument.
> >> + *
> >> + * @phases.hold: This phase is called for entry into reset, once ever=
y object
> >> + * in the system which is being reset has had its @phases.init method=
 called.
> >> + * At this point devices can do actions that affect other objects.
> >> + *
> >> + * @phases.exit: This phase is called when the object leaves the rese=
t state.
> >> + * Actions affecting other objects are permitted.
> >> + *
> >> + * @get_state: Mandatory method which must return a pointer to a Rese=
tState.
> >> + *
> >> + * @foreach_child: Executes a given function on every Resettable chil=
d. Child
> >> + * in this context means a child in the qbus tree, so the children of=
 a qbus
> >> + * are the devices on it, and the children of a device are all the bu=
ses it
> >> + * owns. This is not the same as the QOM object hierarchy. The functi=
on takes
> >> + * an additional ResetType argument which is passed to foreach_child.
> >> + */
> >> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
> >> +typedef void (*ResettableHoldPhase)(Object *obj);
> >> +typedef void (*ResettableExitPhase)(Object *obj);
> >> +typedef ResetState * (*ResettableGetState)(Object *obj);
> >> +typedef void (*ResettableForeachChild)(Object *obj,
> >> +                                       void (*func)(Object *, ResetTy=
pe type),
> >> +                                       ResetType type);
> >> +typedef struct ResettableClass {
> >> +    InterfaceClass parent_class;
> >> +
> >> +    struct ResettablePhases {
> >> +        ResettableInitPhase init;
> >> +        ResettableHoldPhase hold;
> >> +        ResettableExitPhase exit;
> >> +    } phases;
> >> +
> >> +    ResettableGetState get_state;
> >> +    ResettableForeachChild foreach_child;
> >> +} ResettableClass;
> >> +typedef struct ResettablePhases ResettablePhases;
> >> +
> >> +/**
> >> + * ResetState:
> >> + * Structure holding reset related state. The fields should not be ac=
cessed
> >> + * directly, the definition is here to allow further inclusion into o=
ther
> >> + * objects.
> >> + *
> >> + * @count: Number of reset level the object is into. It is incremente=
d when
> >> + * the reset operation starts and decremented when it finishes.
> >> + * @hold_phase_needed: flag which indicates that we need to invoke th=
e 'hold'
> >> + * phase handler for this object.
> >> + */
> >> +struct ResetState {
> >> +    uint32_t count;
> >> +    bool hold_phase_needed;
> >> +};
> >> +
> >> +/**
> >> + * resettable_is_resetting:
> >> + * Return true if @obj is under reset.
> >> + *
> >> + * @obj must implement Resettable interface.
> >> + */
> >> +bool resettable_is_resetting(Object *obj);
> >> +
> >> +/**
> >> + * resettable_reset:
> >> + * Trigger a reset on a object @obj of type @type. @obj must implement
> >> + * Resettable interface.
> >> + *
> >> + * Calling this function is equivalent to calling @resettable_assert_=
reset then
> >> + * @resettable_deassert_reset.
> >> + */
> >> +void resettable_reset(Object *obj, ResetType type);
> >> +
> >> +/**
> >> + * resettable_cold_reset_fn:
> >> + * Helper to call resettable_reset((Object *) opaque, RESET_TYPE_COLD=
).
> >> + *
> >> + * This function is typically useful to register a reset handler with
> >> + * qemu_register_reset.
> >> + */
> >> +void resettable_cold_reset_fn(void *opaque);
> >> +
> >> +/**
> >> + * resettable_class_set_parent_phases:
> >> + *
> >> + * Save @rc current reset phases into @parent_phases and override @rc=
 phases
> >> + * by the given new methods (@init, @hold and @exit).
> >> + * Each phase is overridden only if the new one is not NULL allowing =
to
> >> + * override a subset of phases.
> >> + */
> >> +void resettable_class_set_parent_phases(ResettableClass *rc,
> >> +                                        ResettableInitPhase init,
> >> +                                        ResettableHoldPhase hold,
> >> +                                        ResettableExitPhase exit,
> >> +                                        ResettablePhases *parent_phas=
es);
> >> +
> >> +#endif
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2B9MQACgkQbDjKyiDZ
s5Iwug/9GCnEc/pbKAzaPRWRbhI8dUy6/RUrlSK0y5Ps9/K8X21vV6TdFAwv6Nyf
Ca2Fpyc92fesahLmdGT9QQ16clXt/cYfZNEfFJbWh6itdF9cFj1qqn87gxjtLE39
CxKd1vB9K1xYzz9f62VBTVy5sJCtr5bedNNB4lNKOx0ThEI96qszib+PesBikD4n
HeyhnVrYoQIC49z+BQ2XsFVkyIJIjRRhF9fxmtZ6VJoQ+TR3k5dizm86VXTLiBve
f75sTa4QUu5szTcabtDrXeTkLfy/hBC04H9sDR7o6p97dPUXNwErmZvNAM5i3w2d
+CMJsnAVuVH7luC6H6wPNHmJq0Lslpn1e9BAWFZLvMap5bWifpSYMWfSIbLy81Rd
TNYQ7sOIMyBpqYpScs0U5cdl9qjLDm0Nho07GRFO36+PCcn7Ywfs6J7bTusrRffJ
a+eF8bApUOqidptyd2PZ0vWyWvXsD1tgoLvfRZ5e1PpvMgsIEKSbCf8A5LxfqF4G
RX9Ona50LMHCnDgcKI0ceLYH+EHeo/ErBsuBSOE1iY3cs7hUD+VEfuQPn+P2A8c5
l0VHCxUGlBsYjqQ3lMl4ISaapSerCoHSKB7BDIQ8u7Dt4krovQ4P0YAfcYe6kbxF
h5slv+QRFqAcFngU7KxmXS5wsUaUWs5FnHM4ePFoDqCvhGM1EwE=
=Tjn6
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

