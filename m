Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5474FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD462073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYEj0I9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD462073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIpsf-0006sX-0X
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jIprY-0006Fl-CF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jIprW-0003rT-EN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:33:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jIprW-0003pe-8O
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:33:38 -0400
Received: by mail-oi1-x243.google.com with SMTP id d63so14981085oig.6
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WycqDBcKnV94UouTvNq0GsH3OgWVioKUkC0Di9ggQPo=;
 b=EYEj0I9yt49xcrFpnVWAyZowIkh38Bgd9v5dqQY+Xg3SKYXmAtY4A8cakJ5ustHzd/
 1Edf+WE0f+86Yjjfyj3fuyav3JBSKO5cHtyGWRHIHpuCadNOY1Q/+wGzoCVlvA2JEHTE
 esnu6FeI0JzeSJn4X0fSEyIEL/Elen82WikJO2DY9SHp78/YinEGLO1FaPKoJimlyr23
 YvJajFPorIFE/VLyfRwbHyAssFhN5i1a0RlZYcsLvU5NFSp5U4MGqEu+weQbCmuCiwof
 09dRN5rrq1k6w9vhZNUAmf4kbPVUsLj73HowC6mwLOl5SpB6OmvuFzN1wk13GWRQEJsB
 bX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WycqDBcKnV94UouTvNq0GsH3OgWVioKUkC0Di9ggQPo=;
 b=o8xhh7fXBo013KI/Na7K8vYf/QLTBA4iDqgyhgahgEKQ0BrHTp8xH1hOrwfR6c7BpD
 BYNA30NtDyUmiaV6clI8DUJEupMz5dAulLl22nQqhq1HwK5Tg8bq5Mb+oUG7jQ7aZd2w
 KlviEqvQeLpxfLxjz4597pt35sh1qthS/4rYK1MSIXdH5FXKhAuxa9MKR+KIFpsF02U9
 hMnl9a0aHQz7l3EnPpnXwjvUz0x15JOv0oET83kRbx7+T/0Dr8KfRrb4wWjOYIiCxMr7
 1op1dXgYybgoM7D7jv9SSWs679PjHY287e5J6KN6GxNZ8vTtybJWRvIgY44SuKql8VA7
 levA==
X-Gm-Message-State: ANhLgQ2q7Mj3j6NcbNEukKAMUYSzvoay5NYw8EyrOOdoBNpl+kqhCsmd
 nyXDxpT8tD+LhcUErX4lWBp5lS7zwIsbEtveTiE=
X-Google-Smtp-Source: ADFU+vs+Sqf7vpXEWeBiQowUHziFfinzEUl2BcVsGLFXr2JwCyQIZ1MzARXeuKocV7ON2zUgMw1fdeHvHegu8a8B7Lc=
X-Received: by 2002:aca:a895:: with SMTP id r143mr6690437oie.150.1585557217021; 
 Mon, 30 Mar 2020 01:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200327161146.16402-1-liq3ea@163.com>
 <eaa70588-91cf-575a-a8ae-9e431b738222@redhat.com>
In-Reply-To: <eaa70588-91cf-575a-a8ae-9e431b738222@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 30 Mar 2020 16:33:01 +0800
Message-ID: <CAKXe6SKgtoL2t2vneV3_xa9tzVN8n=XaYeLLqtoaHRKT-yNBBA@mail.gmail.com>
Subject: Re: [PATCH] qtest: add tulip test case
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b1122c05a20e4e2e"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b1122c05a20e4e2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:25=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2020/3/28 =E4=B8=8A=E5=8D=8812:11, Li Qiang wrote:
> > The tulip networking card emulation has an OOB issue in
> > 'tulip_copy_tx_buffers' when the guest provide malformed descriptor.
> > This test will trigger a ASAN heap overflow crash.
>
>
> Hi Qiang:
>
> Thanks for the qtest patch.
>
> Few nitpicks, see above.
>
>
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >   tests/qtest/Makefile.include |  1 +
> >   tests/qtest/tulip-test.c     | 91 +++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 92 insertions(+)
> >   create mode 100644 tests/qtest/tulip-test.c
> >
> > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.includ=
e
> > index 10a28de8a3..9e5a51d033 100644
> > --- a/tests/qtest/Makefile.include
> > +++ b/tests/qtest/Makefile.include
> > @@ -217,6 +217,7 @@ qos-test-obj-y +=3D tests/qtest/es1370-test.o
> >   qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
> >   qos-test-obj-y +=3D tests/qtest/megasas-test.o
> >   qos-test-obj-y +=3D tests/qtest/ne2000-test.o
> > +qos-test-obj-y +=3D tests/qtest/tulip-test.o
> >   qos-test-obj-y +=3D tests/qtest/nvme-test.o
> >   qos-test-obj-y +=3D tests/qtest/pca9552-test.o
> >   qos-test-obj-y +=3D tests/qtest/pci-test.o
> > diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c
> > new file mode 100644
> > index 0000000000..d91ddfd765
> > --- /dev/null
> > +++ b/tests/qtest/tulip-test.c
> > @@ -0,0 +1,91 @@
> > +/*
> > + * QTest testcase for DEC/Intel Tulip 21143
> > + *
> > + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "qemu/module.h"
> > +#include "libqos/qgraph.h"
> > +#include "libqos/pci.h"
> > +#include "qemu/bitops.h"
> > +#include "hw/net/tulip.h"
> > +
> > +typedef struct QTulip_pci QTulip_pci;
> > +
> > +struct QTulip_pci {
> > +    QOSGraphObject obj;
> > +    QPCIDevice dev;
> > +};
> > +
> > +static void *tulip_pci_get_driver(void *obj, const char *interface)
> > +{
> > +    QTulip_pci *tulip_pci =3D obj;
> > +
> > +    if (!g_strcmp0(interface, "pci-device")) {
> > +        return &tulip_pci->dev;
> > +    }
> > +
> > +    fprintf(stderr, "%s not present in tulip_pci\n", interface);
> > +    g_assert_not_reached();
> > +}
> > +
> > +static void *tulip_pci_create(void *pci_bus, QGuestAllocator *alloc,
> void *addr)
> > +{
> > +    QTulip_pci *tulip_pci =3D g_new0(QTulip_pci, 1);
> > +    QPCIBus *bus =3D pci_bus;
> > +
> > +    qpci_device_init(&tulip_pci->dev, bus, addr);
> > +    tulip_pci->obj.get_driver =3D tulip_pci_get_driver;
> > +
> > +    return &tulip_pci->obj;
> > +}
> > +
> > +static void tulip_large_tx(void *obj, void *data, QGuestAllocator
> *alloc)
> > +{
> > +    QTulip_pci *tulip_pci =3D obj;
> > +    QPCIDevice *dev =3D &tulip_pci->dev;
> > +    QPCIBar bar;
> > +    struct tulip_descriptor context;
> > +    char guest_data[4096];
> > +    uint64_t context_pa;
> > +    uint64_t guest_pa;
> > +
> > +    qpci_device_enable(dev);
> > +    bar =3D qpci_iomap(dev, 0, NULL);
> > +    context_pa =3D guest_alloc(alloc, sizeof(context));
> > +    guest_pa =3D guest_alloc(alloc, 4096);
> > +    memset(guest_data, 'A', sizeof(guest_data));
>
>
> It would be better to have a comment on how the descriptor is structured
> to trigger the OOB.
>
>
Ok will write a detail description.


>
> > +    context.status =3D TDES0_OWN;
> > +    context.control =3D TDES1_BUF2_SIZE_MASK << TDES1_BUF2_SIZE_SHIFT =
|
> > +                      TDES1_BUF1_SIZE_MASK << TDES1_BUF1_SIZE_SHIFT;
> > +    context.buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor)=
;
> > +    context.buf_addr1 =3D guest_pa;
> > +
> > +    qtest_memwrite(dev->bus->qts, context_pa, &context,
> sizeof(context));
> > +    qtest_memwrite(dev->bus->qts, guest_pa, guest_data,
> sizeof(guest_data));
> > +    qpci_io_writel(dev, bar, 0x20, context_pa);
> > +    qpci_io_writel(dev, bar, 0x30, 1 << 13);
>
>
> Any chance to use macro instead of magic numbers?
>
>
>
Oh, I just replace the 'TDExxx' in the context construction but forget here=
.

Will post a new revision per these review.

Thanks,
Li Qiang


> > +    guest_free(alloc, context_pa);
> > +    guest_free(alloc, guest_pa);
> > +}
> > +
> > +static void tulip_register_nodes(void)
> > +{
> > +    QOSGraphEdgeOptions opts =3D {
> > +        .extra_device_opts =3D "addr=3D04.0",
> > +    };
> > +    add_qpci_address(&opts, &(QPCIAddress) { .devfn =3D QPCI_DEVFN(4, =
0)
> });
> > +
> > +    qos_node_create_driver("tulip", tulip_pci_create);
> > +    qos_node_consumes("tulip", "pci-bus", &opts);
> > +    qos_node_produces("tulip", "pci-device");
> > +
> > +    qos_add_test("tulip_large_tx", "tulip", tulip_large_tx, NULL);
> > +}
> > +
> > +libqos_init(tulip_register_nodes);
>
>

--000000000000b1122c05a20e4e2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com">jasowang@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:25=E5=86=99=E9=81=93=
=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/28 =E4=B8=8A=E5=8D=8812:11, Li Qiang wrote:<br>
&gt; The tulip networking card emulation has an OOB issue in<br>
&gt; &#39;tulip_copy_tx_buffers&#39; when the guest provide malformed descr=
iptor.<br>
&gt; This test will trigger a ASAN heap overflow crash.<br>
<br>
<br>
Hi Qiang:<br>
<br>
Thanks for the qtest patch.<br>
<br>
Few nitpicks, see above.<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com" target=
=3D"_blank">liq3ea@163.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/qtest/Makefile.include |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0tests/qtest/tulip-test.c=C2=A0 =C2=A0 =C2=A0| 91 +++++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 92 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/qtest/tulip-test.c<br>
&gt;<br>
&gt; diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.inclu=
de<br>
&gt; index 10a28de8a3..9e5a51d033 100644<br>
&gt; --- a/tests/qtest/Makefile.include<br>
&gt; +++ b/tests/qtest/Makefile.include<br>
&gt; @@ -217,6 +217,7 @@ qos-test-obj-y +=3D tests/qtest/es1370-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/megasas-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/ne2000-test.o<br>
&gt; +qos-test-obj-y +=3D tests/qtest/tulip-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/nvme-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/pca9552-test.o<br>
&gt;=C2=A0 =C2=A0qos-test-obj-y +=3D tests/qtest/pci-test.o<br>
&gt; diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..d91ddfd765<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qtest/tulip-test.c<br>
&gt; @@ -0,0 +1,91 @@<br>
&gt; +/*<br>
&gt; + * QTest testcase for DEC/Intel Tulip 21143<br>
&gt; + *<br>
&gt; + * Copyright (c) 2020 Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com=
" target=3D"_blank">liq3ea@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;libqos/pci.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;hw/net/tulip.h&quot;<br>
&gt; +<br>
&gt; +typedef struct QTulip_pci QTulip_pci;<br>
&gt; +<br>
&gt; +struct QTulip_pci {<br>
&gt; +=C2=A0 =C2=A0 QOSGraphObject obj;<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice dev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void *tulip_pci_get_driver(void *obj, const char *interface)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTulip_pci *tulip_pci =3D obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!g_strcmp0(interface, &quot;pci-device&quot;)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;tulip_pci-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s not present in tulip_pci\n&quo=
t;, interface);<br>
&gt; +=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void *tulip_pci_create(void *pci_bus, QGuestAllocator *alloc, =
void *addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTulip_pci *tulip_pci =3D g_new0(QTulip_pci, 1);<br>
&gt; +=C2=A0 =C2=A0 QPCIBus *bus =3D pci_bus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qpci_device_init(&amp;tulip_pci-&gt;dev, bus, addr);<br=
>
&gt; +=C2=A0 =C2=A0 tulip_pci-&gt;obj.get_driver =3D tulip_pci_get_driver;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return &amp;tulip_pci-&gt;obj;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void tulip_large_tx(void *obj, void *data, QGuestAllocator *al=
loc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTulip_pci *tulip_pci =3D obj;<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice *dev =3D &amp;tulip_pci-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 QPCIBar bar;<br>
&gt; +=C2=A0 =C2=A0 struct tulip_descriptor context;<br>
&gt; +=C2=A0 =C2=A0 char guest_data[4096];<br>
&gt; +=C2=A0 =C2=A0 uint64_t context_pa;<br>
&gt; +=C2=A0 =C2=A0 uint64_t guest_pa;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qpci_device_enable(dev);<br>
&gt; +=C2=A0 =C2=A0 bar =3D qpci_iomap(dev, 0, NULL);<br>
&gt; +=C2=A0 =C2=A0 context_pa =3D guest_alloc(alloc, sizeof(context));<br>
&gt; +=C2=A0 =C2=A0 guest_pa =3D guest_alloc(alloc, 4096);<br>
&gt; +=C2=A0 =C2=A0 memset(guest_data, &#39;A&#39;, sizeof(guest_data));<br=
>
<br>
<br>
It would be better to have a comment on how the descriptor is structured <b=
r>
to trigger the OOB.<br>
<br></blockquote><div><br></div><div>Ok will write a detail description.=C2=
=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; +=C2=A0 =C2=A0 context.status =3D TDES0_OWN;<br>
&gt; +=C2=A0 =C2=A0 context.control =3D TDES1_BUF2_SIZE_MASK &lt;&lt; TDES1=
_BUF2_SIZE_SHIFT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TDES1_BUF1_SIZE_MASK &lt;&lt; TDES1_BUF1_SIZE_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 context.buf_addr2 =3D context_pa + sizeof(struct tulip_=
descriptor);<br>
&gt; +=C2=A0 =C2=A0 context.buf_addr1 =3D guest_pa;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_memwrite(dev-&gt;bus-&gt;qts, context_pa, &amp;co=
ntext, sizeof(context));<br>
&gt; +=C2=A0 =C2=A0 qtest_memwrite(dev-&gt;bus-&gt;qts, guest_pa, guest_dat=
a, sizeof(guest_data));<br>
&gt; +=C2=A0 =C2=A0 qpci_io_writel(dev, bar, 0x20, context_pa);<br>
&gt; +=C2=A0 =C2=A0 qpci_io_writel(dev, bar, 0x30, 1 &lt;&lt; 13);<br>
<br>
<br>
Any chance to use macro instead of magic numbers?<br>
<br>
<br></blockquote><div><br></div><div>Oh, I just replace the &#39;TDExxx&#39=
; in the context construction but forget here.</div><div><br></div><div>Wil=
l post a new revision per these review.</div><div><br></div><div>Thanks,</d=
iv><div>Li Qiang=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 guest_free(alloc, context_pa);<br>
&gt; +=C2=A0 =C2=A0 guest_free(alloc, guest_pa);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void tulip_register_nodes(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QOSGraphEdgeOptions opts =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .extra_device_opts =3D &quot;addr=3D04.0&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 add_qpci_address(&amp;opts, &amp;(QPCIAddress) { .devfn=
 =3D QPCI_DEVFN(4, 0) });<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qos_node_create_driver(&quot;tulip&quot;, tulip_pci_cre=
ate);<br>
&gt; +=C2=A0 =C2=A0 qos_node_consumes(&quot;tulip&quot;, &quot;pci-bus&quot=
;, &amp;opts);<br>
&gt; +=C2=A0 =C2=A0 qos_node_produces(&quot;tulip&quot;, &quot;pci-device&q=
uot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qos_add_test(&quot;tulip_large_tx&quot;, &quot;tulip&qu=
ot;, tulip_large_tx, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +libqos_init(tulip_register_nodes);<br>
<br>
</blockquote></div></div>

--000000000000b1122c05a20e4e2e--

