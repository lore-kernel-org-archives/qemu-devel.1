Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9FEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0153206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT0G81d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0153206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJNL-0001Ko-1V
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJMR-0000tQ-44
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJMO-0002cl-LE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:46:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ijJMO-0002Yo-9o
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:46:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id d7so16832891otf.5
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=X6+euXsxCgL34ci3FdYRfxOdNMfnzZGK29qO8oA8dcc=;
 b=fT0G81d7BIFJ8/qdfuw8jZlYzxyf6d7oYrcq7aEJtvrwjldhW+7XuOHoe3EEcj9fun
 22GzZDjXcSYnTAAipiB6xYH7MhP5m9s/IlTXdD1YCKEz4a+ojUgQ/X5zNjVMJX/0ZgDB
 mEH+d7wUfSAXsP05f1qTCEiQCKSok+wCDzmtm4n+w+tmVbBbFEg0oceuix7sEYOmAh46
 HitjOFB0WG8/2m29lGvFAHw8kglkt2KYKQJipwslba5eojRmBcm5Y+KzrYG6KoMKjLFl
 Qd9LjT/oaw90dtcjuQM2ggMnkzOD9sBP4IVswfZroe/T3rmwo/zvijNqUiHXkTYdxagN
 bD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=X6+euXsxCgL34ci3FdYRfxOdNMfnzZGK29qO8oA8dcc=;
 b=pQggRijbGoZn/NTLzDVrBzG8YsWEDQNxE05hJkSfahU5yzkUda1bycvLq4QlC0hX9c
 jAEMFKoMrNdAHKm/Qi+X0BSq9+A1bvX8GFe9k+KFtFQiH7cNxLesUP8gFjoTuej538wD
 PIXuwr13dG7zgXyjUecs+GS1hQkznUliP6395m+ZMJoi9fR3q/GGr3Q1tu6Oj9UREcdx
 Kfkuk9V6LX9wEQWlFgoryAugP7VxKtGQMi+wKBG4x99U256ftOMAwtv81aSfjDInieko
 NNBnzM3bGfrWtHh3XyIi8Etu2QJlycTVsg5thDIH3LdZWDQlp7ORtUNnWl4QeamdKL5W
 T+/g==
X-Gm-Message-State: APjAAAXiVQu+l8aZ/t1vpsCEr1egPhfbM1xS6VZ4U8/a8wniMmsQFGhG
 8CUGsnT4tvBoobzWVdgHWKb/w0APoNS7xKBrXmQ=
X-Google-Smtp-Source: APXvYqz+ZxxVKJtPUi4h7TM1soohXcvtqRPe/ND7oBFzoS4siByfWXMEGit98+wYU+YeeRbyvNzprRi2HK8abvrLQH8=
X-Received: by 2002:a05:6830:3054:: with SMTP id
 p20mr30613571otr.121.1577090799441; 
 Mon, 23 Dec 2019 00:46:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 23 Dec 2019 00:46:38 -0800 (PST)
In-Reply-To: <20191218210329.1960-15-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-15-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 23 Dec 2019 09:46:38 +0100
Message-ID: <CAL1e-=ggk1_RqUSk2M=b9cBjzJA0VBpsH8qAQ9Uvbya2rCNStg@mail.gmail.com>
Subject: Re: [PATCH v39 14/22] target/avr: Add dummy mask device
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e11b3c059a5b1024"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e11b3c059a5b1024
Content-Type: text/plain; charset="UTF-8"

On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---


Hi, Michael.

Please avoid empty commit messages.

At the very beginning, there is a line:

+ * AVR Power Reduction

Why is that? There is a power reduction register in the docs, but is it
covered in this patch?

Further, "mask" is too genetic word. Pkease use more specific name bot fir
filename and variables within this patch. "interrupt controller",
"irq_masq", "IrqMask", "irq" are justsome of ideas.

Yours,
Aleksandar


>  include/hw/misc/avr_mask.h |  47 ++++++++++++++++
>  hw/misc/avr_mask.c         | 112 +++++++++++++++++++++++++++++++++++++
>  hw/misc/Kconfig            |   3 +
>  hw/misc/Makefile.objs      |   2 +
>  4 files changed, 164 insertions(+)
>  create mode 100644 include/hw/misc/avr_mask.h
>  create mode 100644 hw/misc/avr_mask.c
>
> diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h
> new file mode 100644
> index 0000000000..d3e21972d8
> --- /dev/null
> +++ b/include/hw/misc/avr_mask.h
> @@ -0,0 +1,47 @@
> +/*
> + * AVR Power Reduction
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_avr_mask_H
> +#define HW_avr_mask_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "hw/hw.h"
> +
> +
> +#define TYPE_AVR_MASK "avr-mask"
> +#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
> +
> +typedef struct {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion iomem;
> +
> +    uint8_t val;
> +    qemu_irq irq[8];
> +} AVRMaskState;
> +
> +#endif /* HW_avr_mask_H */
> diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
> new file mode 100644
> index 0000000000..3af82ed9c1
> --- /dev/null
> +++ b/hw/misc/avr_mask.c
> @@ -0,0 +1,112 @@
> +/*
> + * AVR Power Reduction
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/avr_mask.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/irq.h"
> +
> +#define DB_PRINT(fmt, args...) /* Nothing */
> +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
> args)*/
> +
> +static void avr_mask_reset(DeviceState *dev)
> +{
> +    AVRMaskState *s = AVR_MASK(dev);
> +
> +    s->val = 0x00;
> +
> +    for (int i = 0; i < 8; i++) {
> +        qemu_set_irq(s->irq[i], 0);
> +    }
> +}
> +
> +static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    assert(size == 1);
> +    assert(offset == 0);
> +    AVRMaskState *s = opaque;
> +
> +    return (uint64_t)s->val;
> +}
> +
> +static void avr_mask_write(void *opaque, hwaddr offset,
> +                              uint64_t val64, unsigned size)
> +{
> +    assert(size == 1);
> +    assert(offset == 0);
> +    AVRMaskState *s = opaque;
> +    uint8_t val8 = val64;
> +
> +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> +
> +    s->val = val8;
> +    for (int i = 0; i < 8; i++) {
> +        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
> +    }
> +}
> +
> +static const MemoryRegionOps avr_mask_ops = {
> +    .read = avr_mask_read,
> +    .write = avr_mask_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {.max_access_size = 1}
> +};
> +
> +static void avr_mask_init(Object *dev)
> +{
> +    AVRMaskState *s = AVR_MASK(dev);
> +    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s,
> TYPE_AVR_MASK,
> +            0x01);
> +    sysbus_init_mmio(busdev, &s->iomem);
> +
> +    for (int i = 0; i < 8; i++) {
> +        sysbus_init_irq(busdev, &s->irq[i]);
> +    }
> +    s->val = 0x00;
> +}
> +
> +static void avr_mask_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = avr_mask_reset;
> +}
> +
> +static const TypeInfo avr_mask_info = {
> +    .name          = TYPE_AVR_MASK,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AVRMaskState),
> +    .class_init    = avr_mask_class_init,
> +    .instance_init = avr_mask_init,
> +};
> +
> +static void avr_mask_register_types(void)
> +{
> +    type_register_static(&avr_mask_info);
> +}
> +
> +type_init(avr_mask_register_types)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 2164646553..e79841e3a4 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -125,4 +125,7 @@ config MAC_VIA
>      select MOS6522
>      select ADB
>
> +config AVR_MASK
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ba898a5781..3a8093be6a 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>  obj-$(CONFIG_MAC_VIA) += mac_via.o
>
>  common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
> +
> +obj-$(CONFIG_AVR_MASK) += avr_mask.o
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000e11b3c059a5b1024
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, December 18, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@g=
mail.com">mrolnik@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Hi, Michael.</div><div><br></div><div>P=
lease avoid empty commit messages.</div><div><br></div><div>At the very beg=
inning, there is a line:</div><div><br></div><div>+ * AVR Power Reduction<b=
r></div><div><br></div><div>Why is that? There is a power reduction registe=
r in the docs, but is it covered in this patch?</div><div><br></div><div>Fu=
rther, &quot;mask&quot; is too genetic word. Pkease use more specific name =
bot fir filename and variables within this patch. &quot;interrupt controlle=
r&quot;, &quot;irq_masq&quot;, &quot;IrqMask&quot;, &quot;irq&quot; are jus=
tsome of ideas.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0include/hw/misc/avr_mask.h |=C2=A0 47 ++++++++++++++++<br>
=C2=A0hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 112 +++++++++++=
+++++++++++++++++++<wbr>+++++++<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A04 files changed, 164 insertions(+)<br>
=C2=A0create mode 100644 include/hw/misc/avr_mask.h<br>
=C2=A0create mode 100644 hw/misc/avr_mask.c<br>
<br>
diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h<br>
new file mode 100644<br>
index 0000000000..d3e21972d8<br>
--- /dev/null<br>
+++ b/include/hw/misc/avr_mask.h<br>
@@ -0,0 +1,47 @@<br>
+/*<br>
+ * AVR Power Reduction<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#ifndef HW_avr_mask_H<br>
+#define HW_avr_mask_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;chardev/char-fe.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+<br>
+<br>
+#define TYPE_AVR_MASK &quot;avr-mask&quot;<br>
+#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+<br>
+=C2=A0 =C2=A0 uint8_t val;<br>
+=C2=A0 =C2=A0 qemu_irq irq[8];<br>
+} AVRMaskState;<br>
+<br>
+#endif /* HW_avr_mask_H */<br>
diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c<br>
new file mode 100644<br>
index 0000000000..3af82ed9c1<br>
--- /dev/null<br>
+++ b/hw/misc/avr_mask.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * AVR Power Reduction<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/misc/avr_mask.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+<br>
+#define DB_PRINT(fmt, args...) /* Nothing */<br>
+/*#define DB_PRINT(fmt, args...) printf(&quot;%s: &quot; fmt &quot;\n&quot=
;, __func__, ## args)*/<br>
+<br>
+static void avr_mask_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i], 0);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)<=
br>
+{<br>
+=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
+=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 return (uint64_t)s-&gt;val;<br>
+}<br>
+<br>
+static void avr_mask_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val64, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 assert(size =3D=3D 1);<br>
+=C2=A0 =C2=A0 assert(offset =3D=3D 0);<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D opaque;<br>
+=C2=A0 =C2=A0 uint8_t val8 =3D val64;<br>
+<br>
+=C2=A0 =C2=A0 DB_PRINT(&quot;write %d to offset %d&quot;, val8, (uint8_t)o=
ffset);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;val =3D val8;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[i], (val8 &amp; (1 &lt;=
&lt; i)) !=3D 0);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps avr_mask_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D avr_mask_read,<br>
+=C2=A0 =C2=A0 .write =3D avr_mask_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+=C2=A0 =C2=A0 .impl =3D {.max_access_size =3D 1}<br>
+};<br>
+<br>
+static void avr_mask_init(Object *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AVRMaskState *s =3D AVR_MASK(dev);<br>
+=C2=A0 =C2=A0 SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;<wbr>iomem, dev, &amp;avr_m=
ask_ops, s, TYPE_AVR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(busdev, &amp;s-&gt;iomem);<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 8; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(busdev, &amp;s-&gt;irq[i]);<br=
>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;val =3D 0x00;<br>
+}<br>
+<br>
+static void avr_mask_class_init(<wbr>ObjectClass *klass, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D avr_mask_reset;<br>
+}<br>
+<br>
+static const TypeInfo avr_mask_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AVR_MASK,<b=
r>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AVRMaskState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D avr_mask_class_init,<br>
+=C2=A0 =C2=A0 .instance_init =3D avr_mask_init,<br>
+};<br>
+<br>
+static void avr_mask_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;avr_<wbr>mask_info);<br>
+}<br>
+<br>
+type_init(avr_mask_register_<wbr>types)<br>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
index 2164646553..e79841e3a4 100644<br>
--- a/hw/misc/Kconfig<br>
+++ b/hw/misc/Kconfig<br>
@@ -125,4 +125,7 @@ config MAC_VIA<br>
=C2=A0 =C2=A0 =C2=A0select MOS6522<br>
=C2=A0 =C2=A0 =C2=A0select ADB<br>
<br>
+config AVR_MASK<br>
+=C2=A0 =C2=A0 bool<br>
+<br>
=C2=A0source macio/Kconfig<br>
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
index ba898a5781..3a8093be6a 100644<br>
--- a/hw/misc/Makefile.objs<br>
+++ b/hw/misc/Makefile.objs<br>
@@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o<br>
=C2=A0obj-$(CONFIG_MAC_VIA) +=3D mac_via.o<br>
<br>
=C2=A0common-obj-$(CONFIG_GRLIB) +=3D grlib_ahb_apb_pnp.o<br>
+<br>
+obj-$(CONFIG_AVR_MASK) +=3D avr_mask.o<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000e11b3c059a5b1024--

