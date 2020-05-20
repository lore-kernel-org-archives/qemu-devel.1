Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C625E2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ6Sb62U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C625E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbGr9-0006Fw-W0
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbGq8-0005AZ-DX
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:00:24 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbGq6-0007Oz-Qg
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:00:24 -0400
Received: by mail-il1-x141.google.com with SMTP id 4so1866987ilg.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=26rAJ3zOwtqsXZKadiDLVMpKG1jn7bJyu8Xi8Ka+tUQ=;
 b=SQ6Sb62U/pEU35WMQx88bYnjPBpgf2Xw9/0RKAs00CSbgfl5OBofYOQLfeqprwZhj0
 hdjfY0OKYulHjmYeE22e1IGcRqjljS/BKfDfpMgapkmEMutcPAX2F3GqXNQziMnr6vtb
 WQNg+SpZfB5/n/NPU5XJm7v3YpWeBuQsEgNPljEMKUr0j5Rpy7UUEMRfxTLvNxAILvHp
 422hve+7BtzqZi34/xkqQGxZZ3tObmrz51INSfAT1JbMq1KwG3M8Zh4xT23J8KjZ120v
 tmVSUgv/wPQC73WxvWyKrTsteJ4lO7W+C43+/hXfTBZEUJ3hSVQE8hOf0D6U7bVX/0DK
 jKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=26rAJ3zOwtqsXZKadiDLVMpKG1jn7bJyu8Xi8Ka+tUQ=;
 b=ZwzIOMLmjc4XRVmKsqZ8o1ejwpzEu+HJJqIYucjjUlPRfdxf+tq8P4w7XInhVsGd0Y
 xlhIRvG2OphcZWwWeXy4sABxnj85fYYzHAuPaSEaF3l2K/46rQyXhX4rO//b7LZEd652
 ZgvdhkQNb0HPmpPAt4XRqswXRqI/HqPhEv7yDYH2DGJzTACujt15PSyyxIO2uZHaICpD
 8c+L1kZUJaXQyHTNkaUTAfqhICalqE64OlRuyokJFbYBJY4auI508fP15mnP6gt8xFkV
 77G1KXf5eIsnfYh2U5y51F0AWMuEMFp0oAGH56p6NqOSDeOyyaZIHuxGZ9ls/aexFKfE
 C2bQ==
X-Gm-Message-State: AOAM530wKVq1T8ZvH+CrjiVcme0p1gepiRWD0Q/zJXeTY0lfhMZ3zpLM
 UInXBQC8SqJSJJtkUTSj3Zn899ew+hFcnRIxwo4=
X-Google-Smtp-Source: ABdhPJwJqiQln8S7h1tnYipJawccJaYx5VXFg1N33YTakbCFVci5RM6rwvqHPHFK6tQnWnaXP4nqfumRwDwx3Vjp7yI=
X-Received: by 2002:a05:6e02:52e:: with SMTP id
 h14mr2379243ils.177.1589950821282; 
 Tue, 19 May 2020 22:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <CAKmqyKP6ccwxc+6DoxJ3kH1uA-PLL47OMxw9RjBzcMXHo3S9Fw@mail.gmail.com>
 <87mu63ut96.fsf@dusky.pond.sub.org>
In-Reply-To: <87mu63ut96.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 21:51:27 -0700
Message-ID: <CAKmqyKPMRdD=NptG0UrboaJnArR3F0kScdcZ-inARuQJW_X5xw@mail.gmail.com>
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 9:26 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > On Tue, May 19, 2020 at 8:11 AM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> We commonly plug devices into their bus right when we create them,
> >> like this:
> >>
> >>     dev = qdev_create(bus, type_name);
> >>
> >> Note that @dev is a weak reference.  The reference from @bus to @dev
> >> is the only strong one.
> >>
> >> We realize at some later time, either with
> >>
> >>     object_property_set_bool(OBJECT(dev), true, "realized", errp);
> >>
> >> or its convenience wrapper
> >>
> >>     qdev_init_nofail(dev);
> >>
> >> If @dev still has no QOM parent then, realizing makes the
> >> /machine/unattached/ orphanage its QOM parent.
> >>
> >> Note that the device returned by qdev_create() is plugged into a bus,
> >> but doesn't have a QOM parent, yet.  Until it acquires one,
> >> unrealizing the bus will hang in bus_unparent():
> >>
> >>     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
> >>         DeviceState *dev = kid->child;
> >>         object_unparent(OBJECT(dev));
> >>     }
> >>
> >> object_unparent() does nothing when its argument has no QOM parent,
> >> and the loop spins forever.
> >>
> >> Device state "no QOM parent, but plugged into bus" is dangerous.
> >>
> >> Paolo suggested to delay plugging into the bus until realize.  We need
> >> to plug into the parent bus before we call the device's realize
> >> method, in case it uses the parent bus.  So the dangerous state still
> >> exists, but only within realization, where we can manage it safely.
> >>
> >> This commit creates infrastructure to do this:
> >>
> >>     dev = qdev_new(type_name);
> >>     ...
> >>     qdev_realize_and_unref(dev, bus, errp)
> >>
> >> Note that @dev becomes a strong reference here.
> >> qdev_realize_and_unref() drops it.  There is also plain
> >> qdev_realize(), which doesn't drop it.
> >>
> >> The remainder of this series will convert all users to this new
> >> interface.
> >>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >> Cc: Alistair Francis <alistair@alistair23.me>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  include/hw/qdev-core.h | 11 ++++-
> >>  hw/core/bus.c          | 14 +++++++
> >>  hw/core/qdev.c         | 94 ++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 118 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> >> index b870b27966..fba29308f7 100644
> >> --- a/include/hw/qdev-core.h
> >> +++ b/include/hw/qdev-core.h
> >> @@ -57,7 +57,7 @@ typedef void (*BusUnrealize)(BusState *bus);
> >>   * After successful realization, setting static properties will fail.
> >>   *
> >>   * As an interim step, the #DeviceState:realized property can also be
> >> - * set with qdev_init_nofail().
> >> + * set with qdev_realize() or qdev_init_nofail().
> >>   * In the future, devices will propagate this state change to their children
> >>   * and along busses they expose.
> >>   * The point in time will be deferred to machine creation, so that values
> >> @@ -322,7 +322,13 @@ compat_props_add(GPtrArray *arr,
> >>
> >>  DeviceState *qdev_create(BusState *bus, const char *name);
> >>  DeviceState *qdev_try_create(BusState *bus, const char *name);
> >> +DeviceState *qdev_new(const char *name);
> >> +DeviceState *qdev_try_new(const char *name);
> >>  void qdev_init_nofail(DeviceState *dev);
> >> +bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
> >> +bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
> >> +void qdev_unrealize(DeviceState *dev);
> >> +
> >>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
> >>                                   int required_for_version);
> >>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
> >> @@ -411,6 +417,9 @@ typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
> >>  void qbus_create_inplace(void *bus, size_t size, const char *typename,
> >>                           DeviceState *parent, const char *name);
> >>  BusState *qbus_create(const char *typename, DeviceState *parent, const char *name);
> >> +bool qbus_realize(BusState *bus, Error **errp);
> >> +void qbus_unrealize(BusState *bus);
> >> +
> >>  /* Returns > 0 if either devfn or busfn skip walk somewhere in cursion,
> >>   *         < 0 if either devfn or busfn terminate walk somewhere in cursion,
> >>   *           0 otherwise. */
> >> diff --git a/hw/core/bus.c b/hw/core/bus.c
> >> index 08c5eab24a..bf622604a3 100644
> >> --- a/hw/core/bus.c
> >> +++ b/hw/core/bus.c
> >> @@ -169,6 +169,20 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
> >>      return bus;
> >>  }
> >>
> >> +bool qbus_realize(BusState *bus, Error **errp)
> >> +{
> >> +    Error *err = NULL;
> >> +
> >> +    object_property_set_bool(OBJECT(bus), true, "realized", &err);
> >> +    error_propagate(errp, err);
> >> +    return !err;
> >> +}
> >> +
> >> +void qbus_unrealize(BusState *bus)
> >> +{
> >> +    object_property_set_bool(OBJECT(bus), true, "realized", &error_abort);
> >
> > Not false?
> >
> > Alistair
>
> Reasons it's &error_abort:

I meant why is this not setting the bool to false instead of true?

>
> 1. PATCH 06 and 07 transform variations of
>
>       object_property_set_bool(..., false, "realized", &error_abort);
>
>    to
>
>       qdev_unrealize(...);
>
>    No untransformed unrealization remain.  Thus, we always abort on
>    unrealization error before this series.
>
> 2. If unrealize could fail, we'd be in deep trouble.  Recent commit
>    b69c3c21a5 "qdev: Unrealize must not fail" explains:
>
>    Devices may have component devices and buses.
>
>    Device realization may fail.  Realization is recursive: a device's
>    realize() method realizes its components, and device_set_realized()
>    realizes its buses (which should in turn realize the devices on that
>    bus, except bus_set_realized() doesn't implement that, yet).
>
>    When realization of a component or bus fails, we need to roll back:
>    unrealize everything we realized so far.  If any of these unrealizes
>    failed, the device would be left in an inconsistent state.  Must not
>    happen.

Makes sense. Maybe worth putting this in a comment here?

>
>    device_set_realized() lets it happen: it ignores errors in the roll
>    back code starting at label child_realize_fail.
>
>    Since realization is recursive, unrealization must be recursive, too.
>    But how could a partly failed unrealize be rolled back?  We'd have to
>    re-realize, which can fail.  This design is fundamentally broken.
>
>    device_set_realized() does not roll back at all.  Instead, it keeps
>    unrealizing, ignoring further errors.
>
>    It can screw up even for a device with no buses: if the lone
>    dc->unrealize() fails, it still unregisters vmstate, and calls
>    listeners' unrealize() callback.
>
>    bus_set_realized() does not roll back either.  Instead, it stops
>    unrealizing.
>
>    Fortunately, no unrealize method can fail, as we'll see below.
>
> Clearer now?

Clear on the error_abort.

>
> With any luck, people will use the simpler qdev_unrealize() and
> qbus_unrealize(), which is the form that doesn't let them get the error
> handling wrong.  I like it when interfaces make misuse hard :)

Sounds good :)

Alistair

>

