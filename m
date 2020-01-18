Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F5C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FC0246A5
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZGNHnkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FC0246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iswy4-0006WU-RS
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 17:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswxB-0005y8-6h
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswx8-0007Lw-81
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:52:29 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:43069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iswx7-0007LM-VG; Sat, 18 Jan 2020 17:52:26 -0500
Received: by mail-io1-xd2b.google.com with SMTP id n21so29829361ioo.10;
 Sat, 18 Jan 2020 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+QRlbAbgoDTWc6TJp7OSzCZ0jnqrg6c9PW2TD15g8OU=;
 b=qZGNHnkRdmntptQsKYD8+a1EdUOEZJNOuPD9xy6RwSR47jjrTh+R/7rJP9iXFAIo5L
 7CrHZ1J95FXJih7zPfUbp29fGoKNzaMtRnwwSJQMVIpyuG7QSVaIR33ZrJ1+IGPxAnNv
 vSXI1TPFXCqjNZ5LMV7RRGPmjrTUiEPUrm0TaRapv9AcGCOd839HD4F8fqAaP21ThzPs
 Clpwk5HTi0kGhdVspcQStBumnUQB+3PUSXtcnGlXRGZWw3OrX5hfJeGyfNNhcByY7Sg1
 Z2apfcaDmg6Vzz2nbkEBQu5oMlWaEY6b1rSXMFk+OtB8BbmQo/mc9dFc8Pa06rBeNsiU
 O73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+QRlbAbgoDTWc6TJp7OSzCZ0jnqrg6c9PW2TD15g8OU=;
 b=ofZHXHA1/JH/m69ZmoTpd6crsF7vxl1+nkm0uvkA6PxxbxYBdfrSZZap7QIcbZCbR1
 FyC8uz2jDOeTmp2zqOmT6XtiulUv2frqGOvzf3ss2XJhpz9GqksAyFOoQr6j5f2F/GmE
 huREyPvkXFeFDyzSCb7HFLU3CEb33ZwEiiOYwyptJSHcBmtA2/vFGTGyW7zdny6l7qJD
 9hzHvMWQ76FG3ja5H3y5kaFxtR27NPfgPXX8Hv0bvvsy2P3Z6fNdLKufLnYm5YnZg1ER
 W0wtnw9iz2+NX5vQpILz1NqGCfTLX9nFBH/9vfMRY0iw4K1EzHkZ2O51BDmzLYaoBXsf
 WS0A==
X-Gm-Message-State: APjAAAXOcdla5RJS3LWiQJ3Geh8rPMtV8wE7Ajkqd0SCgKp+Vi7QV4EP
 MSx1F9HeSdDAFRwJzsKXubk3pYbFm9fI9T0TDmg=
X-Google-Smtp-Source: APXvYqz9hMjEe9SrwWBd1XGzlZB7bf7HqhgdA+cR3GNBf20ImpCKVeF8Q36c2CcdMEiIzYNAtVyQo3HPZ++PwuFxViM=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr36587827ioc.28.1579387945075; 
 Sat, 18 Jan 2020 14:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-13-nieklinnenbank@gmail.com>
 <cca7b552-ed09-fdc4-e80e-fc172e30e9bf@redhat.com>
 <CAPan3Wqso11h47mGdWxbDFE7dPL7wzNGCM6XVB-12SAZhJ0mqA@mail.gmail.com>
 <CAPan3WrkQVb7VhJRYZET_BjEWEOYow-28ft2+4=G-9SNUDm6WA@mail.gmail.com>
 <128940fd-eda9-8151-eb4f-4d29c2c1d72a@redhat.com>
In-Reply-To: <128940fd-eda9-8151-eb4f-4d29c2c1d72a@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 18 Jan 2020 23:52:14 +0100
Message-ID: <CAPan3WqDvperv=rVtdmMHaWKk=vZNjtXKb2n2kniD-+O1jEg=w@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] hw/arm/allwinner: add RTC device support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006dc74b059c71e9ec"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006dc74b059c71e9ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sat, Jan 18, 2020 at 4:05 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Niek,
>
> On 1/14/20 11:57 PM, Niek Linnenbank wrote:
> > On Tue, Jan 14, 2020 at 11:52 PM Niek Linnenbank
> > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
> >
> >     Hi Philippe,
> >
> >     On Mon, Jan 13, 2020 at 11:57 PM Philippe Mathieu-Daud=C3=A9
> >     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >         On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> >          > Allwinner System-on-Chips usually contain a Real Time Clock
> (RTC)
> >          > for non-volatile system date and time keeping. This commit
> >         adds a generic
> >          > Allwinner RTC device that supports the RTC devices found in
> >         Allwinner SoC
> >          > family sun4i (A10), sun7i (A20) and sun6i and newer (A31,
> >         H2+, H3, etc).
> [...]
> >          > +static uint64_t allwinner_rtc_read(void *opaque, hwaddr
> offset,
> >          > +                                   unsigned size)
> >          > +{
> >          > +    AwRtcState *s =3D AW_RTC(opaque);
> >          > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
> >          > +    uint64_t val =3D 0;
> >          > +
> >          > +    if (offset >=3D AW_RTC_REGS_MAXADDR) {
> >          > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds
> >         offset 0x%04x\n",
> >          > +                      __func__, (uint32_t)offset);
> >          > +        return 0;
> >          > +    }
> >          > +
> >          > +    if (!c->regmap[offset]) {
> >          > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid
> >         register 0x%04x\n",
> >          > +                          __func__, (uint32_t)offset);
> >          > +        return 0;
> >          > +    }
> >          > +
> >          > +    switch (c->regmap[offset]) {
> >          > +    case REG_LOSC:       /* Low Oscillator Control */
> >          > +        val =3D s->regs[REG_LOSC];
> >          > +        s->regs[REG_LOSC] &=3D ~(REG_LOSC_YMD | REG_LOSC_HM=
S);
> >          > +        break;
> >          > +    case REG_YYMMDD:     /* RTC Year-Month-Day */
> >          > +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
> >          > +    case REG_GP0:        /* General Purpose Register 0 */
> >          > +    case REG_GP1:        /* General Purpose Register 1 */
> >          > +    case REG_GP2:        /* General Purpose Register 2 */
> >          > +    case REG_GP3:        /* General Purpose Register 3 */
> >          > +        val =3D s->regs[c->regmap[offset]];
> >          > +        break;
> >          > +    default:
> >          > +        if (!c->read(s, offset)) {
> >          > +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented
> >         register 0x%04x\n",
> >          > +                          __func__, (uint32_t)offset);
> >          > +        }
> >          > +        val =3D s->regs[c->regmap[offset]];
> >          > +        break;
> >          > +    }
> >          > +
> >          > +    trace_allwinner_rtc_read(offset, val);
> >          > +    return val;
> >          > +}
> >          > +
> >          > +static void allwinner_rtc_write(void *opaque, hwaddr offset=
,
> >          > +                                uint64_t val, unsigned size=
)
> >          > +{
> >          > +    AwRtcState *s =3D AW_RTC(opaque);
> >          > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
> >          > +
> >          > +    if (offset >=3D AW_RTC_REGS_MAXADDR) {
> >          > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds
> >         offset 0x%04x\n",
> >          > +                      __func__, (uint32_t)offset);
> >          > +        return;
> >          > +    }
> >          > +
> >          > +    if (!c->regmap[offset]) {
> >          > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid
> >         register 0x%04x\n",
> >          > +                          __func__, (uint32_t)offset);
> >          > +        return;
> >          > +    }
> >          > +
> >          > +    trace_allwinner_rtc_write(offset, val);
> >          > +
> >          > +    switch (c->regmap[offset]) {
> >          > +    case REG_YYMMDD:     /* RTC Year-Month-Day */
> >          > +        s->regs[REG_YYMMDD] =3D val;
> >          > +        s->regs[REG_LOSC]  |=3D REG_LOSC_YMD;
> >          > +        break;
> >          > +    case REG_HHMMSS:     /* RTC Hour-Minute-Second */
> >          > +        s->regs[REG_HHMMSS] =3D val;
> >          > +        s->regs[REG_LOSC]  |=3D REG_LOSC_HMS;
> >          > +        break;
> >          > +    case REG_GP0:        /* General Purpose Register 0 */
> >          > +    case REG_GP1:        /* General Purpose Register 1 */
> >          > +    case REG_GP2:        /* General Purpose Register 2 */
> >          > +    case REG_GP3:        /* General Purpose Register 3 */
> >          > +        s->regs[c->regmap[offset]] =3D val;
> >          > +        break;
> >          > +    default:
> >          > +        if (!c->write(s, offset, val)) {
> >          > +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented
> >         register 0x%04x\n",
> >          > +                          __func__, (uint32_t)offset);
> >          > +        }
> >          > +        break;
> >          > +    }
> >          > +}
> >          > +
> >          > +static const MemoryRegionOps allwinner_rtc_ops =3D {
> >          > +    .read =3D allwinner_rtc_read,
> >          > +    .write =3D allwinner_rtc_write,
> >          > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >          > +    .valid =3D {
> >          > +        .min_access_size =3D 4,
> >          > +        .max_access_size =3D 4,
> >          > +    },
> >          > +    .impl.min_access_size =3D 4,
> >          > +};
> >          > +
> >          > +static void allwinner_rtc_reset(DeviceState *dev)
> >          > +{
> >          > +    AwRtcState *s =3D AW_RTC(dev);
> >          > +    const AwRtcClass *c =3D AW_RTC_GET_CLASS(dev);
> >          > +    struct tm now;
> >          > +
> >          > +    /* Clear registers */
> >          > +    memset(s->regs, 0, sizeof(s->regs));
> >          > +
> >          > +    /* Get current datetime */
> >          > +    qemu_get_timedate(&now, 0);
> >          > +
> >          > +    /* Set RTC with current datetime */
> >          > +    s->regs[REG_YYMMDD] =3D  ((now.tm_year - c->year_offset=
)
> >         << 16) |
> >          > +                           ((now.tm_mon + 1) << 8) |
> >          > +                             now.tm_mday;
> >          > +    s->regs[REG_HHMMSS] =3D (((now.tm_wday + 6) % 7) << 29)=
 |
> >          > +                              (now.tm_hour << 16) |
> >          > +                              (now.tm_min << 8) |
> >          > +                               now.tm_sec;
> >
> >         This doesn't look correct.
> >
> >           From H3 Datasheet (Rev1.2):
> >             4.8.3.4. RTC YY-MM-DD Register (Default Value: 0x00000000)
> >             4.8.3.5. RTC HH-MM-SS Register (Default Value: 0x00000000)
> >
> >
> >     I don't yet fully understand what you mean. Could you please explai=
n
> >     a bit more what should be changed?
>
> I was thinking about:
>
> - Start a VM on Monday at 12:34
>
> - Pause the VM on Tuesday at 12:34
>    rtc_time=3DTuesday,12:34
>
> - [Eventually savevm/migrate/loadvm]
>    rtc_time=3DTuesday,12:34
>
> - Resume the VM on Wednesday 12:34
>    (time should be Tuesday at 12:34)
>    so rtc_time=3DTuesday,12:34
>
> - Check time on Thursday at 12:33
>    (time should be Wednesday at 12:33)
>    rtc_time=3DWednesday,12:34
>
> - Reset the VM on Thursday at 12:34
>    (time was Wednesday at 12:34)
>
> - Check time on Thursday at 12:35
>    (time should be Wednesday at 12:35)
>
> However due to reset() calling qemu_get_timedate(), the rtc_time will be
> Thursday at 12:35 instead of Wednesday.
>
>
Ah now I see what you mean. So indeed this means that the RTC date & time
is currently
not persistent in the emulated device, while on hardware it is.


> I don't know how the hardware keep these 2*32-bit safe when powered off.
>
> Laurent Vivier posted a patch where he uses a block backend for his
> machine NVRAM (used by RTC). This seems to me the clever way to do this:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg666837.html
>
> I'd use a block of 8 bytes for your RTC.
> If we start a machine without rtc block backend, the 2*32-bit are
> initialized as zero as the datasheet. If we provide a block, the machine
> will power-on from that stored time.
>
> You might want to look at the global -rtc command line option:
>
>    -rtc
>    [base=3Dutc|localtime|datetime][,clock=3Dhost|rt|vm][,driftfix=3Dnone|=
slew]
>          Specify base as "utc" or "localtime" to let the RTC start
>          at the current UTC or local time, respectively. "localtime"
>          is required for correct date in MS-DOS or Windows. To start
>          at a specific point in time, provide datetime in the format
>          "2006-06-17T16:01:21" or "2006-06-17". The default base is
>          UTC.
>
> But it might be specific to the MC146818 RTC.
>

Thanks for these suggestions. I'll need to look into it. I don't think I'll
have this ready
in the v4 update. Meanwhile I'll add it as a limitation in the cover letter=
.

Regards,
Niek

>
> >     For filling the YYMMDD and HHMMSS register fields, I simply looked
> >     at the 4.8.3.4 and 4.8.3.5 sections
> >     and filled it with the time retrieved from qemu_get_timedate. The
> >     shifts are done so the values are set in the proper bits.
> >     If I read it with the hwclock -r command under Linux, this reads ou=
t
> OK.
> >     On NetBSD, this works as well, except for the base year mismatch
> >     which I explained above.
> >
> >
> >         I'm not sure what is the proper to model this, maybe set this
> >         value in
> >         init()? If we suspend a machine, migrate it, and resume it, wha=
t
> >         RTC are
> >         we expecting?
> >
> > I forgot to reply on this one.
> >
> > I have not used migration very often, but I did manage to test it a
> > couple of times
> > using the 'migrate' command on the Qemu monitor console before I
> > submitted each
> > new version of the patch series. My expectation would be that the RTC
> > time is suspended
> > along with all the other state of the machine such as memory, I/O
> > devices etc. So that would mean
> > the time is 'frozen' until resumed. I think that is what we currently
> > have here.
> >
> > Do you think that is correct or should it work differently?
>
> Yes, this is the behavior I'd expect. Maybe other would disagree.
>
>

--=20
Niek Linnenbank

--0000000000006dc74b059c71e9ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 4:05 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Niek,<br>
<br>
On 1/14/20 11:57 PM, Niek Linnenbank wrote:<br>
&gt; On Tue, Jan 14, 2020 at 11:52 PM Niek Linnenbank <br>
&gt; &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">niek=
linnenbank@gmail.com</a> &lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.=
com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Philippe,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Jan 13, 2020 at 11:57 PM Philippe Mathieu-D=
aud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"=
_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 1/8/20 9:00 PM, Niek Linnenbank wr=
ote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Allwinner System-on-Chips usual=
ly contain a Real Time Clock (RTC)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; for non-volatile system date an=
d time keeping. This commit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adds a generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Allwinner RTC device that suppo=
rts the RTC devices found in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Allwinner SoC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; family sun4i (A10), sun7i (A20)=
 and sun6i and newer (A31,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0H2+, H3, etc).<br>
[...]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +static uint64_t allwinner_rtc_=
read(void *opaque, hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwRtcState *s =
=3D AW_RTC(opaque);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const AwRtcClass=
 *c =3D AW_RTC_GET_CLASS(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t val =3D=
 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (offset &gt;=
=3D AW_RTC_REGS_MAXADDR) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qe=
mu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-of-bounds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!c-&gt;regma=
p[offset]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: invalid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (u=
int32_t)offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 switch (c-&gt;re=
gmap[offset]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_LOSC:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Low Oscillator Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va=
l =3D s-&gt;regs[REG_LOSC];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[REG_LOSC] &amp;=3D ~(REG_LOSC_YMD | REG_LOSC_HMS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_YYMMDD:=
=C2=A0 =C2=A0 =C2=A0/* RTC Year-Month-Day */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_HHMMSS:=
=C2=A0 =C2=A0 =C2=A0/* RTC Hour-Minute-Second */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP0:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP1:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP2:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 2 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP3:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 3 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va=
l =3D s-&gt;regs[c-&gt;regmap[offset]];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (!c-&gt;read(s, offset)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimplemented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (u=
int32_t)offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va=
l =3D s-&gt;regs[c-&gt;regmap[offset]];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_allwinner_=
rtc_read(offset, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +static void allwinner_rtc_writ=
e(void *opaque, hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint64_t val, unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwRtcState *s =
=3D AW_RTC(opaque);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const AwRtcClass=
 *c =3D AW_RTC_GET_CLASS(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (offset &gt;=
=3D AW_RTC_REGS_MAXADDR) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qe=
mu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-of-bounds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (!c-&gt;regma=
p[offset]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: invalid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (u=
int32_t)offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_allwinner_=
rtc_write(offset, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 switch (c-&gt;re=
gmap[offset]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_YYMMDD:=
=C2=A0 =C2=A0 =C2=A0/* RTC Year-Month-Day */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[REG_YYMMDD] =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[REG_LOSC]=C2=A0 |=3D REG_LOSC_YMD;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_HHMMSS:=
=C2=A0 =C2=A0 =C2=A0/* RTC Hour-Minute-Second */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[REG_HHMMSS] =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[REG_LOSC]=C2=A0 |=3D REG_LOSC_HMS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP0:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP1:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP2:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 2 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GP3:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Purpose Register 3 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;regs[c-&gt;regmap[offset]] =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (!c-&gt;write(s, offset, val)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimplemented<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register 0x%04x\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (u=
int32_t)offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +static const MemoryRegionOps a=
llwinner_rtc_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .read =3D allwin=
ner_rtc_read,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .write =3D allwi=
nner_rtc_write,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .endianness =3D =
DEVICE_NATIVE_ENDIAN,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .m=
in_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .m=
ax_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .impl.min_access=
_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +static void allwinner_rtc_rese=
t(DeviceState *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AwRtcState *s =
=3D AW_RTC(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 const AwRtcClass=
 *c =3D AW_RTC_GET_CLASS(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 struct tm now;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Clear registe=
rs */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memset(s-&gt;reg=
s, 0, sizeof(s-&gt;regs));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Get current d=
atetime */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_get_timedat=
e(&amp;now, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Set RTC with =
current datetime */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_Y=
YMMDD] =3D=C2=A0 ((now.tm_year - c-&gt;year_offset)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; 16) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((now.=
tm_mon + 1) &lt;&lt; 8) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0now.tm_mday;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;regs[REG_H=
HMMSS] =3D (((now.tm_wday + 6) % 7) &lt;&lt; 29) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (now.tm_hour &lt;&lt; 16) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (now.tm_min &lt;&lt; 8) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0now.tm_sec;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This doesn&#39;t look correct.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0From H3 Datasheet (Rev1.2):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04.8.3.4. RTC YY-MM-DD R=
egister (Default Value: 0x00000000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04.8.3.5. RTC HH-MM-SS R=
egister (Default Value: 0x00000000)<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t yet fully understand what you mean. Cou=
ld you please explain<br>
&gt;=C2=A0 =C2=A0 =C2=A0a bit more what should be changed?<br>
<br>
I was thinking about:<br>
<br>
- Start a VM on Monday at 12:34<br>
<br>
- Pause the VM on Tuesday at 12:34<br>
=C2=A0 =C2=A0rtc_time=3DTuesday,12:34<br>
<br>
- [Eventually savevm/migrate/loadvm]<br>
=C2=A0 =C2=A0rtc_time=3DTuesday,12:34<br>
<br>
- Resume the VM on Wednesday 12:34<br>
=C2=A0 =C2=A0(time should be Tuesday at 12:34)<br>
=C2=A0 =C2=A0so rtc_time=3DTuesday,12:34<br>
<br>
- Check time on Thursday at 12:33<br>
=C2=A0 =C2=A0(time should be Wednesday at 12:33)<br>
=C2=A0 =C2=A0rtc_time=3DWednesday,12:34<br>
<br>
- Reset the VM on Thursday at 12:34<br>
=C2=A0 =C2=A0(time was Wednesday at 12:34)<br>
<br>
- Check time on Thursday at 12:35<br>
=C2=A0 =C2=A0(time should be Wednesday at 12:35)<br>
<br>
However due to reset() calling qemu_get_timedate(), the rtc_time will be <b=
r>
Thursday at 12:35 instead of Wednesday.<br>
<br></blockquote><div><br></div><div>Ah now I see what you mean. So indeed =
this means that the RTC date &amp; time is currently</div><div> not persist=
ent in the emulated device, while on hardware it is.<br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
I don&#39;t know how the hardware keep these 2*32-bit safe when powered off=
.<br>
<br>
Laurent Vivier posted a patch where he uses a block backend for his <br>
machine NVRAM (used by RTC). This seems to me the clever way to do this:<br=
>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg666837.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg666837.html</a><br>
<br>
I&#39;d use a block of 8 bytes for your RTC.<br>
If we start a machine without rtc block backend, the 2*32-bit are <br>
initialized as zero as the datasheet. If we provide a block, the machine <b=
r>
will power-on from that stored time.<br>
<br>
You might want to look at the global -rtc command line option:<br>
<br>
=C2=A0 =C2=A0-rtc<br>
=C2=A0 =C2=A0[base=3Dutc|localtime|datetime][,clock=3Dhost|rt|vm][,driftfix=
=3Dnone|slew]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify base as &quot;utc&quot; or &quot;=
localtime&quot; to let the RTC start<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at the current UTC or local time, respect=
ively. &quot;localtime&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is required for correct date in MS-DOS or=
 Windows. To start<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at a specific point in time, provide date=
time in the format<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;2006-06-17T16:01:21&quot; or &quot;=
2006-06-17&quot;. The default base is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UTC.<br>
<br>
But it might be specific to the MC146818 RTC.<br></blockquote><div><br></di=
v><div>Thanks for these suggestions. I&#39;ll need to look into it. I don&#=
39;t think I&#39;ll have this ready</div><div>in the v4 update. Meanwhile I=
&#39;ll add it as a limitation in the cover letter.<br></div><div>=C2=A0</d=
iv><div>Regards,</div><div>Niek<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0For filling the YYMMDD and HHMMSS register fields, =
I simply looked<br>
&gt;=C2=A0 =C2=A0 =C2=A0at the 4.8.3.4 and 4.8.3.5 sections<br>
&gt;=C2=A0 =C2=A0 =C2=A0and filled it with the time retrieved from qemu_get=
_timedate. The<br>
&gt;=C2=A0 =C2=A0 =C2=A0shifts are done so the values are set in the proper=
 bits.<br>
&gt;=C2=A0 =C2=A0 =C2=A0If I read it with the hwclock -r command under Linu=
x, this reads out OK.<br>
&gt;=C2=A0 =C2=A0 =C2=A0On NetBSD, this works as well, except for the base =
year mismatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0which I explained above.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;m not sure what is the proper t=
o model this, maybe set this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init()? If we suspend a machine, migr=
ate it, and resume it, what<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTC are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0we expecting?<br>
&gt; <br>
&gt; I forgot to reply on this one.<br>
&gt; <br>
&gt; I have not used migration very often, but I did manage to test it a <b=
r>
&gt; couple of times<br>
&gt; using the &#39;migrate&#39; command on the Qemu monitor console before=
 I <br>
&gt; submitted each<br>
&gt; new version of the patch series. My expectation would be that the RTC =
<br>
&gt; time is suspended<br>
&gt; along with all the other state of the machine such as memory, I/O <br>
&gt; devices etc. So that would mean<br>
&gt; the time is &#39;frozen&#39; until resumed. I think that is what we cu=
rrently <br>
&gt; have here.<br>
&gt; <br>
&gt; Do you think that is correct or should it work differently?<br>
<br>
Yes, this is the behavior I&#39;d expect. Maybe other would disagree.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000006dc74b059c71e9ec--

