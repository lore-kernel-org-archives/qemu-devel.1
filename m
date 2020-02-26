Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD523C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E85524656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLeluk/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E85524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7179-0005as-PS
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j716Q-0004tU-9K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j716O-0002k3-Tj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:08:10 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j716O-0002aO-LV; Wed, 26 Feb 2020 13:08:08 -0500
Received: by mail-lj1-x242.google.com with SMTP id d10so78803ljl.9;
 Wed, 26 Feb 2020 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LMPU1kRD84wPi625eY4a3VdFBmAdtYN7HHupO0TFJhw=;
 b=ZLeluk/zdnf24X+tjiLyM93lKGcePSoU7HZluJi5cXaR9ZYFjNUh8O6GP664DDezNt
 ZsgyW48ac+1VRw6jWEhkVB+LOiC/QZXUn+RhQDGlD7X22AG1akQuWequelzOu33e8trY
 h1pt7fvLiVM4aOx+pN0uBJl/Dez8AEZHgI+nEwulTpUxNcO0Ey00Fmh4UDrsLfLXEI+g
 MCbs/K61raKghejx6Tl9gsQ4mNRZPsaxn7UbEOQ/xs9N/xmwVnd5AgM8JNIQWDp5tHrw
 flVkanJZlNPJIMHMUOcyrMkQAUqaGGRQJ/koeFp+IStfLBND9bh4BlEs7akNZx/mFayB
 5+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LMPU1kRD84wPi625eY4a3VdFBmAdtYN7HHupO0TFJhw=;
 b=QSiHvCbin9qkH22DBEmrx5TcQPnTpl0Q8BJmKJdrda5gw/IZZROgsEPsMMyye4yjLq
 PLOArbX2jiU+TflYwqKEicp1mbCVjHZBPRk1SleGM9XkUOZt+J50cnPEgcVlWPhhAwi3
 xHlR8+MPjS4rOiBcKgozs/Nd+vT+bdUrMZq5sYVc7FoMFQ54jtAYm53hezpb5Y70hzuz
 IQV+zvnq+AgIdadD/FYV6mD5O6sTJXqhE0p+RSbtZt1X3Aw5ZvpeN5WI9jinysDiVdPO
 bH79PyFnfRpgqzXe68la6vfko6oiQovoUtyC/82icdLQORq+G6BbIwGqrlQXInvXIQ+9
 4wVg==
X-Gm-Message-State: ANhLgQ3j3nWkLfHYOWhWgFFplsPd4jG0OtuVgNnxZtjrSekZmFA1AOgA
 OhQEaTdjR2cGN3nj9QgCJ2V4BPJ1ltPjupeoNkI=
X-Google-Smtp-Source: ADFU+vtlH67YZBiKlAY47y+g6q1uVD3dqwcskUdZWgByun/7tqKuBYOMlKA1aKfWKdpOxn34Ul1sl+Ntl9uG9GoVH9c=
X-Received: by 2002:a2e:7609:: with SMTP id r9mr120290ljc.238.1582740486539;
 Wed, 26 Feb 2020 10:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-5-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-5-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 10:00:26 -0800
Message-ID: <CAKmqyKOzR9RKEbdv_BUxJmwNNsnAOdupMXAMJ=kfDh0u4FsM4A@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] qdev-clock: introduce an init array to ease the
 device construction
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

On Tue, Feb 25, 2020 at 5:56 AM Damien Hedde <damien.hedde@greensocs.com> w=
rote:
>
> Introduce a function and macro helpers to setup several clocks
> in a device from a static array description.
>
> An element of the array describes the clock (name and direction) as
> well as the related callback and an optional offset to store the
> created object pointer in the device state structure.
>
> The array must be terminated by a special element QDEV_CLOCK_END.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> --
>
> v7:
>  + update ClockIn/Out types
>  + remove the QDEV_CLOCK_IN_NOFIELD macro
>  + remove leading underscores in macro arguments (Peter)
>  + updated some comments (Peter)
>  + removed trivial asserts (Peter)
> ---
>  include/hw/qdev-clock.h | 55 +++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev-clock.c    | 17 +++++++++++++
>  2 files changed, 72 insertions(+)
>
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> index b3b3a3e021..a340f65ff9 100644
> --- a/include/hw/qdev-clock.h
> +++ b/include/hw/qdev-clock.h
> @@ -101,4 +101,59 @@ Clock *qdev_alias_clock(DeviceState *dev, const char=
 *name,
>   */
>  void qdev_finalize_clocklist(DeviceState *dev);
>
> +/**
> + * ClockPortInitElem:
> + * @name: name of the clock (can't be NULL)
> + * @output: indicates whether the clock is input or output
> + * @callback: for inputs, optional callback to be called on clock's upda=
te
> + * with device as opaque
> + * @offset: optional offset to store the ClockIn or ClockOut pointer in =
device
> + * state structure (0 means unused)
> + */
> +struct ClockPortInitElem {
> +    const char *name;
> +    bool is_output;
> +    ClockCallback *callback;
> +    size_t offset;
> +};
> +
> +#define clock_offset_value(devstate, field) \
> +    (offsetof(devstate, field) + \
> +     type_check(Clock *, typeof_field(devstate, field)))
> +
> +#define QDEV_CLOCK(out_not_in, devstate, field, cb) { \
> +    .name =3D (stringify(field)), \
> +    .is_output =3D out_not_in, \
> +    .callback =3D cb, \
> +    .offset =3D clock_offset_value(devstate, field), \
> +}
> +
> +/**
> + * QDEV_CLOCK_(IN|OUT):
> + * @devstate: structure type. @dev argument of qdev_init_clocks below mu=
st be
> + * a pointer to that same type.
> + * @field: a field in @_devstate (must be Clock*)
> + * @callback: (for input only) callback (or NULL) to be called with the =
device
> + * state as argument
> + *
> + * The name of the clock will be derived from @field
> + */
> +#define QDEV_CLOCK_IN(devstate, field, callback) \
> +    QDEV_CLOCK(false, devstate, field, callback)
> +
> +#define QDEV_CLOCK_OUT(devstate, field) \
> +    QDEV_CLOCK(true, devstate, field, NULL)
> +
> +#define QDEV_CLOCK_END { .name =3D NULL }
> +
> +typedef struct ClockPortInitElem ClockPortInitArray[];
> +
> +/**
> + * qdev_init_clocks:
> + * @dev: the device to add clocks to
> + * @clocks: a QDEV_CLOCK_END-terminated array which contains the
> + * clocks information.
> + */
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)=
;
> +
>  #endif /* QDEV_CLOCK_H */
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 62035aef83..a94cc44437 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -116,6 +116,23 @@ Clock *qdev_init_clock_in(DeviceState *dev, const ch=
ar *name,
>      return ncl->clock;
>  }
>
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
> +{
> +    const struct ClockPortInitElem *elem;
> +
> +    for (elem =3D &clocks[0]; elem->name !=3D NULL; elem++) {
> +        Clock **clkp;
> +        /* offset cannot be inside the DeviceState part */
> +        assert(elem->offset > sizeof(DeviceState));
> +        clkp =3D (Clock **)(((void *) dev) + elem->offset);
> +        if (elem->is_output) {
> +            *clkp =3D qdev_init_clock_out(dev, elem->name);
> +        } else {
> +            *clkp =3D qdev_init_clock_in(dev, elem->name, elem->callback=
, dev);
> +        }
> +    }
> +}
> +
>  static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *=
name)
>  {
>      NamedClockList *ncl;
> --
> 2.25.1
>
>

