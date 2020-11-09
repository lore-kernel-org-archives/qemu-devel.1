Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5818C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCD8206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOnT+GT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCD8206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8JJ-0000Lm-66
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc80B-0004HL-RD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:18:35 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc809-0005QU-R1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:18:35 -0500
Received: by mail-ed1-x541.google.com with SMTP id ay21so8914314edb.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6SL67MXDkpqciKU21DWb7uh9VzXvqZsGe2hTyZdTxHI=;
 b=wOnT+GT1WRI/ds4g9hjGaMY912qArJpfRgUm3JgsPD8It0RpIP6VSfH/05yCXpRi1J
 l2IK8IksKNo1Zkrei+NhTKU2uEMFAh9Le3xhIw5dflANv5WTvjlqnvewcbPFnTkF+Eu2
 rZXaKtbCOOaQ2xK50Z8jt5guQ/9kjescicHK6oHXpAo1dJqfzR6J2UX2vPVpFZGUAU9A
 1hgWmzqppc/2M0mOtBiZ4tnH5W37dQoJrlRPnRiXuruuVhM9kuPQQexoOeGgpshU6PbT
 XJkIR6yP+xdB8OhPZ+klJTA0xruODAR17X1UBFQOpktHqihI+FigkyCXihiiFSjkxWyF
 3+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6SL67MXDkpqciKU21DWb7uh9VzXvqZsGe2hTyZdTxHI=;
 b=b7LeWNqOjgQ62nMUngJAmQlmnhjTK3FVJlvVBlaBgIGdgxVvjiO12ENbJ1jDHIatnr
 YEbxtc7it2UW6NxLx9t/PMBB98Hr5QN/Kv2ZwvDqvmTPDB51L5WfjJaDh3/5MLXjU3i+
 iK1KXU21cTJaUJNnS66PyVn72HbN+HGRVFfn1GfmEKTVIcMLUYQBRlKDIeQQu4odWjUO
 a+1Bi66WMZ30pMzeGdGgzj/D9jLKY23CTW4yskCVyfMpwJCPl091ZMVieCB8CLBdSQl/
 313BeEU+/HuNoEf9kxGQSRFO0Wo0EWWLACUyqGIkLUXzNlMO1PqneS5DG/UlpS1cc0pP
 MYIQ==
X-Gm-Message-State: AOAM532wwMyfCcMIu+VVULw2l3cNbqIo/Wo591K1cDONnZUR8+GxPGl2
 V5eADNxXrTlkgq22ly8X6ew8aFMyZcfmCNujnToM3cAyx9c=
X-Google-Smtp-Source: ABdhPJyiPWGofBrc+i133q5FqNYXfxgjsV7K22adwJwnvt8kTGnsSDI2r6oBsuAHWENcbIduL3CdIFosPnGr1GJLB0c=
X-Received: by 2002:aa7:df82:: with SMTP id b2mr15032647edy.251.1604931512072; 
 Mon, 09 Nov 2020 06:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-3-peter.maydell@linaro.org>
 <b957ada3-cbc7-d1fa-750d-f201c3bef2c6@amsat.org>
In-Reply-To: <b957ada3-cbc7-d1fa-750d-f201c3bef2c6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 14:18:20 +0000
Message-ID: <CAFEAcA_UjvGGX7juQmX-tXh8Phs8oOnNcXAHzmidtYRxcDamMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/m68k/q800.c: Make the GLUE chip an actual QOM
 device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 at 14:15, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Peter,
>
> On 11/7/20 12:51 AM, Peter Maydell wrote:
> > The handling of the GLUE (General Logic Unit) device is
> > currently open-coded. Make this into a proper QOM device.
> >
> > This minor piece of modernisation gets rid of the free
> > floating qemu_irq array 'pic', which Coverity points out
> > is technically leaked when we exit the machine init function.
> > (The replacement glue device is not leaked because it gets
> > added to the sysbus, so it's accessible via that.)
> >
> > Fixes: Coverity CID 1421883
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/m68k/q800.c | 82 ++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 70 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> > index dc13007aaf2..05bb372f958 100644
> > --- a/hw/m68k/q800.c
> > +++ b/hw/m68k/q800.c
> > @@ -47,6 +47,7 @@
> >  #include "sysemu/qtest.h"
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/reset.h"
> > +#include "migration/vmstate.h"
> >
> >  #define MACROM_ADDR     0x40800000
> >  #define MACROM_SIZE     0x00100000
> > @@ -94,10 +95,14 @@
> >   * CPU.
> >   */
> >
> > -typedef struct {
> > +#define TYPE_GLUE "q800-glue"
> > +OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
> > +
> > +struct GLUEState {
> > +    SysBusDevice parent_obj;
> >      M68kCPU *cpu;
> >      uint8_t ipr;
> > -} GLUEState;
> > +};
> >
> >  static void GLUE_set_irq(void *opaque, int irq, int level)
> >  {
> > @@ -119,6 +124,58 @@ static void GLUE_set_irq(void *opaque, int irq, in=
t level)
> >      m68k_set_irq_level(s->cpu, 0, 0);
> >  }
> >
> > +static void glue_reset(DeviceState *dev)
> > +{
> > +    GLUEState *s =3D GLUE(dev);
> > +
> > +    s->ipr =3D 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_glue =3D {
> > +    .name =3D "q800-glue",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8(ipr, GLUEState),
> > +        VMSTATE_END_OF_LIST(),
> > +    },
> > +};
> > +
> > +/*
> > + * If the m68k CPU implemented its inbound irq lines as GPIO lines
> > + * rather than via the m68k_set_irq_level() function we would not need
> > + * this cpu link property and could instead provide outbound IRQ lines
> > + * that the board could wire up to the CPU.
> > + */
> > +static Property glue_properties[] =3D {
> > +    DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void glue_init(Object *obj)
> > +{
> > +    DeviceState *dev =3D DEVICE(obj);
> > +
> > +    qdev_init_gpio_in(dev, GLUE_set_irq, 8);
> > +}
> > +
> > +static void glue_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->vmsd =3D &vmstate_glue;
> > +    dc->reset =3D glue_reset;
>
> Don't we need a realize() handler checking s->cpu is non-NULL?
>
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Doesn't seem very necessary to me -- it's a sysbus device
used for a special purpose, the one user has to wire
it up correctly, and the failure mode if they get it wrong
is pretty obvious. But I guess we could add in the explicit
error check.

thanks
-- PMM

