Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA612C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA0F2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yba2toiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA0F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblzd-0006nF-QI
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iblyZ-0005xQ-Uf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iblyY-0001Cz-85
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:42:55 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iblyY-0001CU-27
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:42:54 -0500
Received: by mail-oi1-x243.google.com with SMTP id k196so16058585oib.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 05:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VZX6lBHSz0FQNHjiAsYon2lwI6dwOqr/6nqKVc9ThqE=;
 b=Yba2toiYPk6rL0kRll0oHDiISouSWrtXErfJ7yVUciQ6NEArLMRlsKfRm1zgbZHycC
 dMlT+aUrvs68rXktUUmysGFUyRBKp/BNB3Vv7UOnwwc0L9IqTglNY82e1Ib9TuBEdP7J
 +7I5pEHNdxIL/fAlBsn0KSIPFLPSy8cs4vGv4DaFMbvFtvpRStB9ff9wwBe3pQLE23S1
 qdV6yRbbMqN3wM9gv5fLa4K7nXpfUA60Mn6vA3NJg37qpZHO5q/BFsrLWKfDmOc2SGPQ
 5bEHvHVm5td898ZQxxJQ41QYR9TdudC0Fr/D45lGrTdjSLBlBqpJB4DRyOXnnCp2n3Wq
 GB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VZX6lBHSz0FQNHjiAsYon2lwI6dwOqr/6nqKVc9ThqE=;
 b=ZbRkIGpg1q9UoBXuzPosfYQAk8TL1yVSyDYGziV32cMbZin65CyRc8CiLvUvZteLAF
 Bhb7rm9tI+4IAW3R0NaBLOND+CjC2Q5as1Jcxy2g8WU5/qBYM5IkJIjZWgIdTMnEoh/F
 +a/c4nutJAy+BQ4zrm/SUvkU18NJAZ7z9nwjJJCoDT7vsfWSCrktblJE2av/i2uO22+X
 9MO0l8z8JzXlEC7Dd7qhVrnc2ghFlt9ePz2BZN5C33yFAd6I5R+GbbYOyfwBbSCgrqLe
 uswnsKJMoBCTS56jQ5jgNhc5ntqQ6Je8AB9PoK0v3vnTo9BwIJCOsZNmSDu7sJa+n1mm
 4M1g==
X-Gm-Message-State: APjAAAUVcRK3/5GrOFdpVlzaFLuFCzDEIip2SJmei4DyvM8yh9VhN+i+
 5c925TtLSZG5rCkxyuW64c/EOJdLIW3T2SvjAioTdg==
X-Google-Smtp-Source: APXvYqxgi7SIi4bUEgJdtAl4rpjWd+RBE3NW34UdDA6aCgrvYTyGLo7iA7lKp1GJC1KWQMxUb5mg6+UoGFG8E+doumo=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr13381262oix.170.1575294172927; 
 Mon, 02 Dec 2019 05:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-2-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-2-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 13:42:41 +0000
Message-ID: <CAFEAcA99wzV9-dQ6oWxs7OPjxZ4vQWD_FXRLnBg7H-N1W2BMLA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] hw/core/clock: introduce clock objects
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrot=
e:
>
> Introduce clock objects: ClockIn and ClockOut.
>
> These objects may be used to distribute clocks from an object to several
> other objects. Each ClockIn object contains the current state of the
> clock: the frequency; it allows an object to migrate its input clock stat=
e
> independently of other objects.
>
> A ClockIn may be connected to a ClockOut so that it receives update,

"updates" (or "an update")

> through a callback, whenever the Clockout is updated using the
> ClockOut's set function.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile.objs         |   1 +
>  hw/core/Makefile.objs |   1 +
>  hw/core/clock.c       | 144 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/trace-events  |   6 ++
>  include/hw/clock.h    | 124 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 276 insertions(+)
>  create mode 100644 hw/core/clock.c
>  create mode 100644 include/hw/clock.h
>
> diff --git a/Makefile.objs b/Makefile.objs
> index a723a47e14..4da623c759 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -153,6 +153,7 @@ trace-events-subdirs +=3D hw/audio
>  trace-events-subdirs +=3D hw/block
>  trace-events-subdirs +=3D hw/block/dataplane
>  trace-events-subdirs +=3D hw/char
> +trace-events-subdirs +=3D hw/core
>  trace-events-subdirs +=3D hw/dma
>  trace-events-subdirs +=3D hw/hppa
>  trace-events-subdirs +=3D hw/i2c
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 69b408ad1c..c66a5b2c6b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y +=3D irq.o
>  common-obj-y +=3D hotplug.o
> +common-obj-y +=3D clock.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
>
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> new file mode 100644
> index 0000000000..888f247f2a
> --- /dev/null
> +++ b/hw/core/clock.c
> @@ -0,0 +1,144 @@
> +/*
> + * Clock inputs and outputs
> + *
> + * Copyright GreenSocs 2016-2018
> + *
> + * Authors:
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *  Damien Hedde <damien.hedde@greensocs.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/clock.h"
> +#include "trace.h"
> +
> +#define CLOCK_PATH(_clk) (_clk->canonical_path)

Don't use leading underscores in identifiers, please.

> +
> +void clock_out_setup_canonical_path(ClockOut *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_in_setup_canonical_path(ClockIn *clk)
> +{
> +    g_free(clk->canonical_path);
> +    clk->canonical_path =3D object_get_canonical_path(OBJECT(clk));
> +}
> +
> +void clock_set_callback(ClockIn *clk, ClockCallback *cb, void *opaque)
> +{
> +    assert(clk);
> +
> +    clk->callback =3D cb;
> +    clk->callback_opaque =3D opaque;
> +}
> +
> +void clock_init_frequency(ClockIn *clk, uint64_t freq)
> +{
> +    assert(clk);

This sort of assert isn't necessary. Asserts are good
when they help to make a bug visible sooner and more
obviously -- when they avoid "something goes wrong
much later on and further from the site of the actual
error". In this case, if the assert was not present
then the code would just segfault on the next line:

> +
> +    clk->frequency =3D freq;

which is already a very easy bug to diagnose and
where the offending caller will be in the backtrace.

If the parameter isn't supposed to be NULL, and the
method doesn't actually do anything that would
dereference it, that might be a good candidate to
assert on.

The same kind of unnecessary assert is also in some of
the other functions here (and probably in other patches).


> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index ecf966c314..aa940e268b 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -34,3 +34,9 @@ resettable_phase_hold_end(void *obj, int needed) "obj=
=3D%p needed=3D%d"
>  resettable_phase_exit(void *obj, const char *type) "obj=3D%p(%s)"
>  resettable_phase_exit_end(void *obj, uint32_t count) "obj=3D%p count=3D%=
" PRIu32
>  resettable_count_underflow(void *obj) "obj=3D%p"
> +
> +# hw/core/clock-port.c
> +clock_connect(const char *clk, const char *driver) "'%s' drived-by '%s'"

"driven-by"

> +clock_disconnect(const char *clk) "'%s'"
> +clock_set_frequency(const char *clk, uint64_t freq) "'%s' freq_hz=3D%" P=
RIu64
> +clock_propagate(const char *clko, const char *clki) "'%s' =3D> '%s'"
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> new file mode 100644
> index 0000000000..fd11202ba4
> --- /dev/null
> +++ b/include/hw/clock.h
> @@ -0,0 +1,124 @@
> +#ifndef QEMU_HW_CLOCK_H
> +#define QEMU_HW_CLOCK_H

All new files need a copyright-and-license comment header (could
you check the rest of the patchset for this, please?).

> +

> +/**
> + * clock_get_frequency:
> + * @clk: the clk to fetch the clock
> + *
> + * @return: the current frequency of @clk in Hz. If @clk is NULL, return=
 0.
> + */
> +static inline uint64_t clock_get_frequency(const ClockIn *clk)
> +{
> +    return clk ? clk->frequency : 0;
> +}

Is there a use case where we want to support "pass in NULL"
rather than just making it a programming error for the caller
to try that ?

> +
> +/**
> + * clock_is_enabled:
> + * @clk: a clock state
> + *
> + * @return: true if the clock is running. If @clk is NULL return false.
> + */
> +static inline bool clock_is_enabled(const ClockIn *clk)
> +{
> +    return clock_get_frequency(clk) !=3D 0;
> +}

Ditto here.

thanks
-- PMM

