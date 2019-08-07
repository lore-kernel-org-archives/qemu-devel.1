Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C46FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486A422296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czmSL6ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486A422296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42959 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOLY-00078V-GL
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOKo-0006J7-0N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOKl-0000Iz-N3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:58:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvOKl-0000H9-FV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:58:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id d17so106389010oth.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nDCrpao1DoUXvHLGq8oQ8nGL/3V+y9My6Yv9BJkV1/c=;
 b=czmSL6oxe/XI1/OGJz/FBW7SUWvAJxg3Fs2UJr7lDTBbTuLVSIvQE+hiqwaKy3cmgm
 4woa/+r1pjIGTFddQ1RCSc65A78MAUNRNzYB8A+T4oSl5AChAo7VUQQ9yejGN63lxeaO
 sEV9455e++VIgLXKHazkBusmUsPuILiU+cLsvGu1r8AkwAL/099sR2qdzHX+/yb0H1bQ
 76U6XUvNiDb5dZNkmd3yPhlgarxkCGAW0b2lSO7/NzEeHhZfUmgXWNbSFbkDL0VzAcox
 L4LwKx1iBE6/RCI6LukJHL8OCp5fV4eSmxPKKoZ41q6RWygYpFbumdRdE+xLA9crHRpJ
 n5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nDCrpao1DoUXvHLGq8oQ8nGL/3V+y9My6Yv9BJkV1/c=;
 b=sK9nS67S+381kvTM9Cyok7tf9KGrgzYeL56cL80xccogNWWaHX9bxLPQbluh8VM42z
 TbpUsZLUcolTy5Ka71i70ALu0eo2zmOggsZ7JVqLRYnWD8PPmUx1yVvchBP66xKiW8QZ
 4iOhrdR40rYBYiWG7GtZwdn02VZI+POh3nwSFY6S/xH/g6+Q4vj6mXrphAOsLPYt641b
 i2ZVDizfu79FkDS6R3FxZH33OcEF/eArFeP0MIy/sgO1SuERDL0PwDbCCFlXhgkJyVC2
 drex7CjNJPqWW8LjuTFm2oIdGg7U019clq5UP255YKcjumELNfWe/XI+hNUCptZqR6If
 7xLg==
X-Gm-Message-State: APjAAAUcE9+aX0vXYTDVOHK4k7pxRFukuqBXtZnqAYMpBqU2Y0ODKe29
 qrD32NBidWHuX4a1YV1VNewXJyl4taUmuucm+6jT+Q==
X-Google-Smtp-Source: APXvYqzT5xfqJYHvb4cnj9/ak6+FqmH+neZLwV71NGUlA2qRkX+/0OR4Dt+xJNSle5B/A6D4IqH43iNxrfY7I6YJIqg=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr7692455otk.221.1565193518332; 
 Wed, 07 Aug 2019 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-10-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:58:27 +0100
Message-ID: <CAFEAcA_Uyd0kFCOB2SzS13n=5qfrFRV0AFBUfu8J0KmOBth+Mg@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  docs/devel/reset.txt | 165 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 docs/devel/reset.txt
>
> diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
> new file mode 100644
> index 0000000000..c7a1eb068f
> --- /dev/null
> +++ b/docs/devel/reset.txt
> @@ -0,0 +1,165 @@
> +
> +=====
> +Reset
> +=====
> +
> +The reset of qemu objects is handled using the Resettable interface declared
> +in *include/hw/resettable.h*.
> +As of now DeviceClass and BusClass implement this interface.
> +> +
> +Triggering reset
> +----------------

I think this would be clearer if we documented it the other way around:

  This section documents the APIs which "users" of a resettable
  object should use to control it.

  A resettable object can be put into its "in reset" state and
  held there indefinitely.

  [documentation for resettable_assert/deassert_reset goes here]

  If you want to just trigger a reset event but not leave the
  object in reset for any period of time, you can use
  resettable_reset(), which is a convenience function identical
  in behaviour to calling resettable_assert() and then immediately
  calling resettable_deassert().

  [resettable_reset() docs here]

> +
> +The function *resettable_reset* is used to trigger a reset on a given
> +object.
> +void resettable_reset(Object *obj, bool cold)
> +
> +The parameter *obj* must implement the Resettable interface.
> +The parameter *cold* is a boolean specifying whether to do a cold or warm
> +reset
> +
> +For Devices and Buses there is also the corresponding helpers:
> +void device_reset(Device *dev, bool cold)
> +void bus_reset(Device *dev, bool cold)

We should explain what these do.

> +
> +If one wants to put an object into a reset state. There is the
> +*resettable_assert_reset* function.
> +void resettable_assert_reset(Object *obj, bool cold)
> +
> +One must eventually call the function *resettable_deassert_reset* to end the
> +reset state:
> +void resettable_deassert_reset(Object *obj, bool cold)
> +
> +Calling *resettable_assert_reset* then *resettable_deassert_reset* is the
> +same as calling *resettable_reset*.
> +
> +It is possible to interleave multiple calls to
> + - resettable_reset,
> + - resettable_assert_reset, and
> + - resettable_deassert_reset.
> +The only constraint is that *resettable_deassert_reset* must be called once
> +per *resettable_assert_reset* call so that the object leaves the reset state.
> +
> +Therefore there may be several reset sources/controllers of a given object.
> +The interface handle everything and the controllers do not need to know

"handles"

> +anything about each others. The object will leave reset state only when all

"each other"

> +controllers released their reset.

"release"

> +
> +All theses functions must called while holding the iothread lock.

"these"; "be called"

> +
> +
> +Implementing reset for a Resettable object : Multi-phase reset
> +--------------------------------------------------------------

  This section documents the APIs that an implementation of a
  resettable object must provide.

> +
> +The Resettable uses a multi-phase mechanism to handle some ordering constraints
> +when resetting multiple object at the same time. For a given object the reset

"objects"

> +procedure is split into three different phases executed in order:
> + 1 INIT: This phase should set/reset the state of the Resettable it has when is
> +         in reset state. Side-effects to others object is forbidden (such as
> +         setting IO level).
> + 2 HOLD: This phase corresponds to the external side-effects due to staying into
> +         the reset state.
> + 3 EXIT: This phase corresponds to leaving the reset state. It have both
> +         local and external effects.

We should be a bit more detailed here. I had some text in
my review of patch 1 for the doc-comments which we can put here too.

> +
> +*resettable_assert_reset* does the INIT and HOLD phases. While
> +*resettable_deassert_reset* does the EXIT phase.

Delete this bit -- we don't want to muddle the reader up between
the 'user' APIs and the 'implementer' APIs.

> +
> +When resetting multiple object at the same time. The interface executes the

Comma, not full stop.

> +given phase of the objects before going to the next phase. This guarantee that

"guarantees"

> +all INIT phases are done before any HOLD phase and so on.
> +
> +There is three methods in the interface so must be implemented in an object.

"are"; "that must"

> +The methods corresponds to the three phases:

"correspond"

> +```
> +typedef void (*ResettableInitPhase)(Object *obj);
> +typedef void (*ResettableHoldPhase)(Object *obj);
> +typedef void (*ResettableExitPhase)(Object *obj);
> +typedef struct ResettableClass {
> +    InterfaceClass parent_class;
> +
> +    struct ResettablePhases {
> +        ResettableInitPhase init;
> +        ResettableHoldPhase hold;
> +        ResettableExitPhase exit;
> +    } phases;
> +    [...]
> +} ResettableClass;
> +```
> +
> +Theses methods should be updated when specializing an object. For this the

"These"

> +helper function *resettable_class_set_parent_reset_phases* can be used to
> +backup parent methods while changing the specialized ones.
> +void resettable_class_set_parent_reset_phases(ResettableClass *rc,
> +                                              ResettableInitPhase init,
> +                                              ResettableHoldPhase hold,
> +                                              ResettableExitPhase exit,
> +
> +For Devices and Buses, some helper exists to know if a device/bus is under

"helpers"

> +reset and what type of reset it is:
> +```
> +bool device_is_resetting(DeviceState *dev);
> +bool device_is_reset_cold(DeviceState *dev);
> +bool bus_is_resetting(BusState *bus);
> +bool bus_is_reset_cold(BusState *bus);
> +```

What are these for? Are they part of the API intended for 'users'
of a resettable device', or something that the 'implementor' might
want to use as part of their implementation. More detail would be good.

> +
> +
> +Implementing the base Resettable behavior : Re-entrance, Hierarchy and Cold/Warm
> +--------------------------------------------------------------------------------

  This section documents parts of the reset mechanism that you only
  need to know about if you are extending it to work with a new
  base class other than DeviceClass or BusClass, or maintaining
  the existing code in those classes. Most people can ignore it.

> +
> +There is five others methods in the interface to handle the base mechanics

"are five other methods"

> +of the Resettable interface. The methods should be implemented in object
> +base class. DeviceClass and BusClass implement them.
> +
> +```
> +typedef bool (*ResettableSetCold)(Object *obj, bool cold);
> +typedef bool (*ResettableSetHoldNeeded)(Object *obj, bool hold_needed);
> +typedef uint32_t (*ResettableGetCount)(Object *obj);
> +typedef uint32_t (*ResettableIncrementCount)(Object *obj);
> +typedef uint32_t (*ResettableDecrementCount)(Object *obj);
> +typedef void (*ResettableForeachChild)(Object *obj, void (*visitor)(Object *));
> +typedef struct ResettableClass {
> +    InterfaceClass parent_class;
> +
> +    [...]
> +
> +    ResettableSetCold set_cold;
> +    ResettableSetHoldNeeded set_hold_needed;
> +    ResettableGetCount get_count;
> +    ResettableIncrementCount increment_count;
> +    ResettableDecrementCount decrement_count;
> +    ResettableForeachChild foreach_child;
> +} ResettableClass;
> +```
> +
> +*set_cold* is used when entering reset, before calling the init phase, to
> +indicate the reset type.
> +
> +*set_hold_needed* is used to set/clear and retrieve an "hold_needed" flag.
> +This flag allows to omly execute the hold pahse when required.
> +
> +As stated above, several reset procedures can be concurrent on an object.
> +This is handled with the three methods *get_count*, *increment_count* and
> +*decrement_count*. An object is in reset state if the count is non-zero.
> +
> +The reset hierarchy is handled using the *foreach_child* method. This method
> +executes a given function on every reset "child".
> +
> +In DeviceClass and BusClass the base behavior is to mimic the legacy qdev
> +reset. Reset hierarchy follows the qdev/qbus tree.

We should document the behaviour of the new system specifically,
without saying it's like the old legacy reset. After all the idea
is that the legacy reset is going to go away, so readers should be
able to understand the new system without first knowing about the
old one.

> +
> +Reset control through GPIO
> +--------------------------
> +
> +For devices, two reset inputs can be added: one for the cold, one the warm
> +reset. This is done using the following function.
> +```
> +typedef enum DeviceResetActiveType {
> +    DEVICE_RESET_ACTIVE_LOW,
> +    DEVICE_RESET_ACTIVE_HIGH,
> +} DeviceResetActiveType;
> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
> +                                   bool cold, DeviceResetActiveType type);
> +```

Rather than just quoting the prototype of the function, we should
provide a more descriptive documentation of what this feature is
for and why you'd want to use it. Then we can just refer the
reader to the function (which should have its own doc comment)
for the exact details of how the API works.

thanks
-- PMM

