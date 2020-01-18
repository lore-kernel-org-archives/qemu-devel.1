Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7AC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EFE2469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHRWBPCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EFE2469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ispgX-0007Cp-2D
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 10:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ispfS-0006Mv-1w
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ispfM-0003qg-Jn
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:05:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ispfM-0003oE-1O
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579359935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnFA1cOU4c0Ow0cB6UHREl1Tw1EHeh/JI+7GYsynQRY=;
 b=eHRWBPCXp4DSHn+Z7nvI8MLVuXI15ckgBheO9YqYaOPBiz2Acn6s9MZjPd6UxXX15Dj4i+
 CRYR+gTcQmX2pjCy5qV/mH1uhvPnu102ZUfzHm8zy1Ozoz1aVzVadovh90jo7/jzRHkxKL
 igNpNfmhpxSc5LSiAew/LL38qsSsawA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-RGLox6eHMYSpJVwmKMswZA-1; Sat, 18 Jan 2020 10:05:33 -0500
Received: by mail-wm1-f71.google.com with SMTP id t4so2904716wmf.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 07:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qFM0Bodz3dXGTB4n0xDVQcQoWUXbQWKnLXvk3tXI7VY=;
 b=n22XP9RNib9vyzPTUWjs4u3big06yjo5WpeB34FZXRwGdVnsKPiB1xNNSo+TgMuGwx
 QRcJmvxx2taF1WFPkYkWOoCIyPZ5pHinH0YUcLMrInW36O3mrz3WSk63DqZrTLo/gDp7
 JcXNlw96Exg78WFcWPlM/KXMK8XWlbWc+juME/1uBs32bWkUM06Ejsq9D1/t787813WU
 6l0U2Op0bf+279C8Zdotp49Q8cCQOLc8rjBVPuc7DmSwuq+/NTyquKHBokWDuqUhB4G2
 ly5wgBCKI11KtodFnFSjxoXvTb/WYysnqzZH96rnsUidfZO/+tnvaVPJB2RMjYdmu9VH
 h+bg==
X-Gm-Message-State: APjAAAVP1PFY1G8iTrgyeHAHURqWn95E9Iac6OxMC/3CxkE+kzynRkwc
 SBpGtd5CwV++GnsFBiOerOU0XM7XFlD+UtWlNC7mnPsMFmUgR2vD6FM6FfhRBPAfNJLOBrhV5lu
 o/MSq3JSBDgaO7MI=
X-Received: by 2002:a05:600c:2551:: with SMTP id
 e17mr9916926wma.26.1579359932107; 
 Sat, 18 Jan 2020 07:05:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFVZizbEzbIalemmwN+fhkGhK9ZuCXtTeD925Mu9p0BZsbwsws44SCp6COiaGOyvvG9EiG8A==
X-Received: by 2002:a05:600c:2551:: with SMTP id
 e17mr9916898wma.26.1579359931744; 
 Sat, 18 Jan 2020 07:05:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r6sm40073636wrq.92.2020.01.18.07.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 07:05:30 -0800 (PST)
Subject: Re: [PATCH v3 12/17] hw/arm/allwinner: add RTC device support
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-13-nieklinnenbank@gmail.com>
 <cca7b552-ed09-fdc4-e80e-fc172e30e9bf@redhat.com>
 <CAPan3Wqso11h47mGdWxbDFE7dPL7wzNGCM6XVB-12SAZhJ0mqA@mail.gmail.com>
 <CAPan3WrkQVb7VhJRYZET_BjEWEOYow-28ft2+4=G-9SNUDm6WA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <128940fd-eda9-8151-eb4f-4d29c2c1d72a@redhat.com>
Date: Sat, 18 Jan 2020 16:05:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WrkQVb7VhJRYZET_BjEWEOYow-28ft2+4=G-9SNUDm6WA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: RGLox6eHMYSpJVwmKMswZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Hi Niek,

On 1/14/20 11:57 PM, Niek Linnenbank wrote:
> On Tue, Jan 14, 2020 at 11:52 PM Niek Linnenbank=20
> <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
>=20
>     Hi Philippe,
>=20
>     On Mon, Jan 13, 2020 at 11:57 PM Philippe Mathieu-Daud=C3=A9
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>         On 1/8/20 9:00 PM, Niek Linnenbank wrote:
>          > Allwinner System-on-Chips usually contain a Real Time Clock (R=
TC)
>          > for non-volatile system date and time keeping. This commit
>         adds a generic
>          > Allwinner RTC device that supports the RTC devices found in
>         Allwinner SoC
>          > family sun4i (A10), sun7i (A20) and sun6i and newer (A31,
>         H2+, H3, etc).
[...]
>          > +static uint64_t allwinner_rtc_read(void *opaque, hwaddr offse=
t,
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
size)
>          > +{
>          > +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(opaque);
>          > +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>          > +=C2=A0 =C2=A0 uint64_t val =3D 0;
>          > +
>          > +=C2=A0 =C2=A0 if (offset >=3D AW_RTC_REGS_MAXADDR) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%=
s: out-of-bounds
>         offset 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>          > +=C2=A0 =C2=A0 }
>          > +
>          > +=C2=A0 =C2=A0 if (!c->regmap[offset]) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_G=
UEST_ERROR, "%s: invalid
>         register 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>          > +=C2=A0 =C2=A0 }
>          > +
>          > +=C2=A0 =C2=A0 switch (c->regmap[offset]) {
>          > +=C2=A0 =C2=A0 case REG_LOSC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Low=
 Oscillator Control */
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s->regs[REG_LOSC];
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[REG_LOSC] &=3D ~(REG_LOSC=
_YMD | REG_LOSC_HMS);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 case REG_YYMMDD:=C2=A0 =C2=A0 =C2=A0/* RTC Year=
-Month-Day */
>          > +=C2=A0 =C2=A0 case REG_HHMMSS:=C2=A0 =C2=A0 =C2=A0/* RTC Hour=
-Minute-Second */
>          > +=C2=A0 =C2=A0 case REG_GP0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 0 */
>          > +=C2=A0 =C2=A0 case REG_GP1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 1 */
>          > +=C2=A0 =C2=A0 case REG_GP2:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 2 */
>          > +=C2=A0 =C2=A0 case REG_GP3:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 3 */
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s->regs[c->regmap[offset]=
];
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 default:
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c->read(s, offset)) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_U=
NIMP, "%s: unimplemented
>         register 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D s->regs[c->regmap[offset]=
];
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 }
>          > +
>          > +=C2=A0 =C2=A0 trace_allwinner_rtc_read(offset, val);
>          > +=C2=A0 =C2=A0 return val;
>          > +}
>          > +
>          > +static void allwinner_rtc_write(void *opaque, hwaddr offset,
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned=
 size)
>          > +{
>          > +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(opaque);
>          > +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(s);
>          > +
>          > +=C2=A0 =C2=A0 if (offset >=3D AW_RTC_REGS_MAXADDR) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, "%=
s: out-of-bounds
>         offset 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>          > +=C2=A0 =C2=A0 }
>          > +
>          > +=C2=A0 =C2=A0 if (!c->regmap[offset]) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_G=
UEST_ERROR, "%s: invalid
>         register 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>          > +=C2=A0 =C2=A0 }
>          > +
>          > +=C2=A0 =C2=A0 trace_allwinner_rtc_write(offset, val);
>          > +
>          > +=C2=A0 =C2=A0 switch (c->regmap[offset]) {
>          > +=C2=A0 =C2=A0 case REG_YYMMDD:=C2=A0 =C2=A0 =C2=A0/* RTC Year=
-Month-Day */
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[REG_YYMMDD] =3D val;
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[REG_LOSC]=C2=A0 |=3D REG_=
LOSC_YMD;
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 case REG_HHMMSS:=C2=A0 =C2=A0 =C2=A0/* RTC Hour=
-Minute-Second */
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[REG_HHMMSS] =3D val;
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[REG_LOSC]=C2=A0 |=3D REG_=
LOSC_HMS;
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 case REG_GP0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 0 */
>          > +=C2=A0 =C2=A0 case REG_GP1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 1 */
>          > +=C2=A0 =C2=A0 case REG_GP2:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 2 */
>          > +=C2=A0 =C2=A0 case REG_GP3:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Gen=
eral Purpose Register 3 */
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->regs[c->regmap[offset]] =3D va=
l;
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 default:
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c->write(s, offset, val)) {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_U=
NIMP, "%s: unimplemented
>         register 0x%04x\n",
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, (uint32_t)offset);
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>          > +=C2=A0 =C2=A0 }
>          > +}
>          > +
>          > +static const MemoryRegionOps allwinner_rtc_ops =3D {
>          > +=C2=A0 =C2=A0 .read =3D allwinner_rtc_read,
>          > +=C2=A0 =C2=A0 .write =3D allwinner_rtc_write,
>          > +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>          > +=C2=A0 =C2=A0 .valid =3D {
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,
>          > +=C2=A0 =C2=A0 },
>          > +=C2=A0 =C2=A0 .impl.min_access_size =3D 4,
>          > +};
>          > +
>          > +static void allwinner_rtc_reset(DeviceState *dev)
>          > +{
>          > +=C2=A0 =C2=A0 AwRtcState *s =3D AW_RTC(dev);
>          > +=C2=A0 =C2=A0 const AwRtcClass *c =3D AW_RTC_GET_CLASS(dev);
>          > +=C2=A0 =C2=A0 struct tm now;
>          > +
>          > +=C2=A0 =C2=A0 /* Clear registers */
>          > +=C2=A0 =C2=A0 memset(s->regs, 0, sizeof(s->regs));
>          > +
>          > +=C2=A0 =C2=A0 /* Get current datetime */
>          > +=C2=A0 =C2=A0 qemu_get_timedate(&now, 0);
>          > +
>          > +=C2=A0 =C2=A0 /* Set RTC with current datetime */
>          > +=C2=A0 =C2=A0 s->regs[REG_YYMMDD] =3D=C2=A0 ((now.tm_year - c=
->year_offset)
>         << 16) |
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((now.tm_mon + 1) << 8) |
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now.tm_mday;
>          > +=C2=A0 =C2=A0 s->regs[REG_HHMMSS] =3D (((now.tm_wday + 6) % 7=
) << 29) |
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (now.tm_hour << 16) |
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (now.tm_min << 8) |
>          > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0now.tm_sec;
>=20
>         This doesn't look correct.
>=20
>          =C2=A0From H3 Datasheet (Rev1.2):
>          =C2=A0 =C2=A04.8.3.4. RTC YY-MM-DD Register (Default Value: 0x00=
000000)
>          =C2=A0 =C2=A04.8.3.5. RTC HH-MM-SS Register (Default Value: 0x00=
000000)
>=20
>=20
>     I don't yet fully understand what you mean. Could you please explain
>     a bit more what should be changed?

I was thinking about:

- Start a VM on Monday at 12:34

- Pause the VM on Tuesday at 12:34
   rtc_time=3DTuesday,12:34

- [Eventually savevm/migrate/loadvm]
   rtc_time=3DTuesday,12:34

- Resume the VM on Wednesday 12:34
   (time should be Tuesday at 12:34)
   so rtc_time=3DTuesday,12:34

- Check time on Thursday at 12:33
   (time should be Wednesday at 12:33)
   rtc_time=3DWednesday,12:34

- Reset the VM on Thursday at 12:34
   (time was Wednesday at 12:34)

- Check time on Thursday at 12:35
   (time should be Wednesday at 12:35)

However due to reset() calling qemu_get_timedate(), the rtc_time will be=20
Thursday at 12:35 instead of Wednesday.

I don't know how the hardware keep these 2*32-bit safe when powered off.

Laurent Vivier posted a patch where he uses a block backend for his=20
machine NVRAM (used by RTC). This seems to me the clever way to do this:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg666837.html

I'd use a block of 8 bytes for your RTC.
If we start a machine without rtc block backend, the 2*32-bit are=20
initialized as zero as the datasheet. If we provide a block, the machine=20
will power-on from that stored time.

You might want to look at the global -rtc command line option:

   -rtc
   [base=3Dutc|localtime|datetime][,clock=3Dhost|rt|vm][,driftfix=3Dnone|sl=
ew]
         Specify base as "utc" or "localtime" to let the RTC start
         at the current UTC or local time, respectively. "localtime"
         is required for correct date in MS-DOS or Windows. To start
         at a specific point in time, provide datetime in the format
         "2006-06-17T16:01:21" or "2006-06-17". The default base is
         UTC.

But it might be specific to the MC146818 RTC.

>     For filling the YYMMDD and HHMMSS register fields, I simply looked
>     at the 4.8.3.4 and 4.8.3.5 sections
>     and filled it with the time retrieved from qemu_get_timedate. The
>     shifts are done so the values are set in the proper bits.
>     If I read it with the hwclock -r command under Linux, this reads out =
OK.
>     On NetBSD, this works as well, except for the base year mismatch
>     which I explained above.
>=20
>=20
>         I'm not sure what is the proper to model this, maybe set this
>         value in
>         init()? If we suspend a machine, migrate it, and resume it, what
>         RTC are
>         we expecting?
>=20
> I forgot to reply on this one.
>=20
> I have not used migration very often, but I did manage to test it a=20
> couple of times
> using the 'migrate' command on the Qemu monitor console before I=20
> submitted each
> new version of the patch series. My expectation would be that the RTC=20
> time is suspended
> along with all the other state of the machine such as memory, I/O=20
> devices etc. So that would mean
> the time is 'frozen' until resumed. I think that is what we currently=20
> have here.
>=20
> Do you think that is correct or should it work differently?

Yes, this is the behavior I'd expect. Maybe other would disagree.


