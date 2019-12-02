Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9409C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4821774
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AixxexQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4821774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmnW-00005H-JZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibmmq-000818-C2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibmmo-00086K-Fm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:34:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibmmo-000867-8g
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:34:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id k14so15570394otn.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 06:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OOx/U42IwCgVTBRpxJArTPlYznxoXFOGHOWbSCNf3W0=;
 b=AixxexQ6NC6ix+9Y/G6mMoBv8oToordZIDm9iTjHK/NuaqLFlE+SJF0xWbD9Jp+jHD
 lRZDytoHgV2TRX6Lz1YUFn1w0n+jt7Nw/b5tTXd01Hgxzx+FVnr4dN6veJEH5FOibRdF
 vp7UUGZcWeMrswboob5fEMMDUzjSiJsgcp8Or63Y2B5jxxr+alTpR6Xv78MJaC2hCFhK
 pj7mzRPSjFvekMQftUSefI1hl+ySCjf2XJhktOeQXbZTh+LZaLJqfTEphmrvvTpcUUyh
 TNzWzSD2y5Olli2o/br/1H680YdLirHieiWrfED5+jYiUEHOweJIt4ueLzTnQMuTBM6X
 r0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OOx/U42IwCgVTBRpxJArTPlYznxoXFOGHOWbSCNf3W0=;
 b=Q823TM87GxuxZQMBvPd6mDZc+O1saJJmsKBbKFkrJNFJ1mGP5yMX42lmWMtRAEcGbm
 hOAFV6wtww0I8DjsxJjQpOloTdG6XcO8/TZQyNJcQhtfE2CUm6ukMzSVLxMfdc5tav2z
 2EDT9WWasTDHBcNvWZu2HZ8rBUXU2XYuq+4GfUI760tevI0FYeOjoKDmwDoatuN5UpHG
 kHw2SBapbpLJ4L3ShHPzS9WnDWDNHKjqnoehan7yKfeaFlWRYYXJ3XCPGxAzL4XTc+5n
 RDxIt8QXhXbDUlqLgnjTJYrwOY2NbO3qtzx93vio3eXssQ1AbyDBcU0XEMJeMUI4bMda
 rWbA==
X-Gm-Message-State: APjAAAVkqIBW8vnKeU9u9SD7LOlfw87pUBadZ/ZNezuEWKQJWBqexyIs
 e0nffaj9RVo8AbYkCcu4PO+vHzp3mn/K1FGnVaktlQ==
X-Google-Smtp-Source: APXvYqxbEvify2wKC5QA+Sk8C6vxS+H1KevVgESZEHs+P0D4n8PkjtHbW1p4L+9iM5azzAMgb0nsowM1CCED19svHuY=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr21860696otk.91.1575297288933; 
 Mon, 02 Dec 2019 06:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-4-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 14:34:37 +0000
Message-ID: <CAFEAcA9M4qR89wykURrUxqxeWoNqYHxuJSwC5Mum6GfmWSG=nA@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add functions to easily add input or output clocks to a device.
> A clock objects is added as a child of the device.

"object"

> The api is very similar the gpio's one.

"API"; "to the GPIO API".

>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>

> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
> +        bool forward)
> +{
> +    NamedClockList *ncl;
> +
> +    /*
> +     * The clock path will be computed by the device's realize function call.
> +     * This is required to ensure the clock's canonical path is right and log
> +     * messages are meaningfull.

"meaningful"

> +     */
> +    assert(name);
> +    assert(!dev->realized);
> +
> +    /* The ncl structure will be freed in device's finalize function call */

Do you mean "in device_finalize()", or "in the finalize method
of the device" ?  If you mean a specific function, then it's
good to name it, so the reader can go and check that code if
they need to confirm that there's a matching free()/deref/etc.

> +    ncl = g_malloc0(sizeof(*ncl));

Prefer g_new0(NamedClockList, 1).

> +    ncl->name = g_strdup(name);
> +    ncl->forward = forward;
> +
> +    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> +    return ncl;
> +}
> +
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl = qdev_init_clocklist(dev, name, false);
> +
> +    clk = object_new(TYPE_CLOCK_OUT);
> +
> +    /* will fail if name already exists */

This is true but it would be more helpful to say
 /*
  * Trying to create a clock whose name clashes with some other
  * clock or property is a bug in the caller and we will abort().
  */

(assuming that's what's going on here).

> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +    object_unref(clk); /* remove the initial ref made by object_new */
> +
> +    ncl->out = CLOCK_OUT(clk);
> +    return ncl->out;
> +}
> +
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                        ClockCallback *callback, void *opaque)
> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl = qdev_init_clocklist(dev, name, false);
> +
> +    clk = object_new(TYPE_CLOCK_IN);
> +    /*
> +     * the ref initialized by object_new will be cleared during dev finalize.

This means "in device_finalize()", I think from reading later patches ?

> +     * It allows us to safely remove the callback.
> +     */
> +
> +    /* will fail if name already exists */

Similar remark as for earlier comment.

> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +
> +    ncl->in = CLOCK_IN(clk);
> +    if (callback) {
> +        clock_set_callback(ncl->in, callback, opaque);
> +    }
> +    return ncl->in;
> +}

> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(dev && name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +    return ncl ? ncl->in : NULL;
> +}

Do we expect to want to be able to pass in the name of
a clock that doesn't exist ? Should that be an error
rather than returning NULL ?

> +
> +static ClockOut *qdev_get_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    assert(dev && name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +    return ncl ? ncl->out : NULL;

Ditto.

> +}
> +
> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn *clk,
> +                            Error **errp)
> +{
> +    ClockOut *clkout = qdev_get_clock_out(dev, name);
> +
> +    if (!clk) {
> +        error_setg(errp, "NULL input clock");
> +        return;
> +    }
> +
> +    if (!clkout) {
> +        error_setg(errp, "no output clock '%s' in device", name);
> +        return;
> +    }
> +
> +    clock_connect(clk, clkout);

Do we need to support returning an error here, or would it
always be a programming bug to try to connect a non-existent clock?

> --- /dev/null
> +++ b/include/hw/qdev-clock.h
> @@ -0,0 +1,67 @@
> +#ifndef QDEV_CLOCK_H
> +#define QDEV_CLOCK_H

Another missing copyright/license comment.

> +
> +#include "hw/clock.h"
> +
> +/**
> + * qdev_init_clock_in:
> + * @dev: the device in which to add a clock

"the device to add a clock input to"

> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @opaque:   argument for the callback
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a input clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + * The callback will be called with @dev as opaque parameter.

Isn't it called with @opaque, not @dev ?

> + */
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                            ClockCallback *callback, void *opaque);
> +
> +/**
> + * qdev_init_clock_out:
> + * @dev: the device to add a clock to

"the device to add a clock output to"

> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a output clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + */
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_get_clock_in:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @returns: a pointer to the clock
> + *
> + * Get the clock @name from @dev or NULL if does not exists.

"if it does not exist"

> + */
> +ClockIn *qdev_get_clock_in(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_connect_clock_out:
> + * @dev: the device which has the clock
> + * @name: the name of the clock (can't be NULL).
> + * @errp: error report
> + *
> + * Connect @clk to the output clock @name of @dev.
> + * Reports an error if clk is NULL or @name does not exists in @dev.

"or if @name does not exist in @dev"

> + */
> +void qdev_connect_clock_out(DeviceState *dev, const char *name, ClockIn *clk,
> +                            Error **errp);
> +
> +/**
> + * qdev_pass_clock:
> + * @dev: the device to forward the clock to
> + * @name: the name of the clock to be added (can't be NULL)
> + * @container: the device which already has the clock
> + * @cont_name: the name of the clock in the container device
> + *
> + * Add a clock @name to @dev which forward to the clock @cont_name in @container
> + */

'container' seems odd terminology here, because I would expect
the usual use of this function to be when a 'container' object
like an SoC wants to forward a clock to one of its components;
in that case the 'container' SoC would be @dev, wouldn't it?
We should get this to be the same way round as qdev_pass_gpios(),
which takes "DeviceState *dev, DeviceState *container", and
passes the gpios that exist on 'dev' over to 'container' so that
'container' now has gpios which it did not before.

Also, your use of 'forward to' is inconsistent: in the 'dev'
documentation you say we're forwarding the clock to 'dev',
but in the body of the documentation you say we're forwarding
the clock to the clock in 'container'.

I think the way to resolve this is to stick to the terminology
in the function name itself:
 @dev: the device which has the clock
 @name: the name of the clock on @dev
 @container: the name of the device which the clock should
  be passed to
 @cont_name: the name to use for the clock on @container

Q: if you pass a clock to another device with this function,
does it still exist to be used directly on the original
device? For qdev_pass_gpios it does not (I think), but
this is more accident of implementation than anything else.

> +void qdev_pass_clock(DeviceState *dev, const char *name,
> +                     DeviceState *container, const char *cont_name);
> +
> +#endif /* QDEV_CLOCK_H */
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index eb11f0f801..60a65f6142 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -131,6 +131,19 @@ struct NamedGPIOList {
>      QLIST_ENTRY(NamedGPIOList) node;
>  };
>
> +typedef struct NamedClockList NamedClockList;
> +
> +typedef struct ClockIn ClockIn;
> +typedef struct ClockOut ClockOut;
> +
> +struct NamedClockList {
> +    char *name;

Could this be 'const char*' ?

> +    bool forward;
> +    ClockIn *in;
> +    ClockOut *out;
> +    QLIST_ENTRY(NamedClockList) node;
> +};

thanks
-- PMM

