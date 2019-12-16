Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D539C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 21:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3B02465E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 21:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3B02465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igxve-0005SC-0W
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 16:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1igxuo-0004v9-OH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 16:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1igxun-0004Kl-4S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 16:28:30 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1igxuj-0004Id-Fe; Mon, 16 Dec 2019 16:28:25 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so3101801ywv.5;
 Mon, 16 Dec 2019 13:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hngYlw1ZLnncQM83R3mqcAXHiBFV3HcVdNJ/QZK7/Kc=;
 b=Xc9JuvpzJnt+eWOeYz98a1xNDhVh4EHaNpfc3NlC9F6wX6zdJ12QxS7FPkyKEwol2U
 uAmAdZxETSkAtxFb0QOLVsr48905CL8ucwQowxIIocE4bcNL5HP2SkIiDBwlRHPxDnz/
 lViV9oyeYbQzvyxch/pidgQsv3kYECJ7+lI2Wyuj9ZWdqVzew1QUOnTtdUdxySDq3jAa
 ywcWz4H60w7QICSCZotozKCHa/QM7qNc88VNqsq1ERHxlN5+eNby/+fJZLFaEGsrug8l
 SzwpxgRhgfVbdM+Sj1QUnVq4ZcA9mVbPSpI+W8PeLhj9cOu6kL6HVMIQ/WeigX3DvmlZ
 +IKQ==
X-Gm-Message-State: APjAAAXy/S/4AW7HrL7ReczZL3z30+Tcik9ImUJbwatEKGrqIapvBCDZ
 ff8tP2SyRCltkmCPupt0YNPksVo7L7qNvLosuiM=
X-Google-Smtp-Source: APXvYqwg+gh4zL4+SjgxHYG2P16RV3uXk/AMrtS8Ilb9Tn9I0MPvFGEqMvYput+rYPXAZXf4/cYMPLr7c1gnmiLG2bE=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr8106449ywa.37.1576531704611; 
 Mon, 16 Dec 2019 13:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
 <CAPan3WpiWahU85-ZgV4BMPU8mUTxsq2TPn-szOHkHc5+PHUqpw@mail.gmail.com>
 <03a78f1d-e8fe-5a53-b061-d39de9ed7a9e@redhat.com>
 <CAPan3WrHQk-apQhQrihF_71b3_PSqkaEu1dHYmeCXuygwnAy2A@mail.gmail.com>
In-Reply-To: <CAPan3WrHQk-apQhQrihF_71b3_PSqkaEu1dHYmeCXuygwnAy2A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Dec 2019 22:28:12 +0100
Message-ID: <CAAdtpL6Vik9zVwSpVshWWicNMNitJ--0Xz7WHxd_wOLNGNkwgg@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003b09be0599d8e485"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.68
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003b09be0599d8e485
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 16 d=C3=A9c. 2019 20:46, Niek Linnenbank <nieklinnenbank@gmail.com>=
 a
=C3=A9crit :

>
>
> On Mon, Dec 16, 2019 at 1:14 AM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> On 12/16/19 12:07 AM, Niek Linnenbank wrote:
>> >
>> >
>> > On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9
>> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>> >
>> >     Hi Niek,
>> >
>> >     On 12/11/19 11:34 PM, Niek Linnenbank wrote:
>> [...]
>> >      >     +static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState
>> *s,
>> >      >     +                                          hwaddr desc_addr=
,
>> >      >     +                                          TransferDescript=
or
>> >     *desc,
>> >      >     +                                          bool is_write,
>> >     uint32_t
>> >      >     max_bytes)
>> >      >     +{
>> >      >     +    uint32_t num_done =3D 0;
>> >      >     +    uint32_t num_bytes =3D max_bytes;
>> >      >     +    uint8_t buf[1024];
>> >      >     +
>> >      >     +    /* Read descriptor */
>> >      >     +    cpu_physical_memory_read(desc_addr, desc,
>> sizeof(*desc));
>> >
>> >     Should we worry about endianess here?
>> >
>> >
>> > I tried to figure out what is expected, but the
>> > Allwinner_H3_Datasheet_V1.2.pdf does not
>> > explicitly mention endianness for any of its I/O devices. Currently it
>> > seems all devices are
>> > happy with using the same endianness as the CPUs. In the
>> MemoryRegionOps
>> > has DEVICE_NATIVE_ENDIAN
>> > set to match the behavior seen.
>>
>> OK.
>>
>> [...]
>> >      >     +static const MemoryRegionOps aw_h3_sdhost_ops =3D {
>> >      >     +    .read =3D aw_h3_sdhost_read,
>> >      >     +    .write =3D aw_h3_sdhost_write,
>> >      >     +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> >
>> >     I haven't checked .valid accesses from the datasheet.
>> >
>> >     However due to:
>> >
>> >         res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) /
>> sizeof(uint32_t))];
>> >
>> >     You seem to expect:
>> >
>> >                  .impl.min_access_size =3D 4,
>> >
>> >     .impl.max_access_size unset is 8, which should works.
>> >
>> > It seems that all registers are aligned on at least 32-bit boundaries.
>> > And the section 5.3.5.1 mentions
>> > that the DMA descriptors must be stored in memory 32-bit aligned. So
>> > based on that information,
>>
>> So you are describing ".valid.min_access_size =3D 4", which is the minim=
um
>> access size on the bus.
>> ".impl.min_access_size" is different, it is what access sizes is ready
>> to handle your model.
>> Your model read/write handlers expect addresses aligned on 32-bit
>> boundary, this is why I suggested to use ".impl.min_access_size =3D 4". =
If
>> the guest were using a 16-bit access, your model would be buggy. If you
>> describe your implementation to accept minimum 32-bit and the guest is
>> allowed to use smaller accesses, QEMU will do a 32-bit access to the
>> device, and return the 16-bit part to the guest. This way your model is
>> safe. This is done by access_with_adjusted_size() in memory.c.
>> If you restrict with ".valid.min_access_size =3D 4", you might think we
>> don't need ".valid.min_access_size =3D 4" because all access from guest
>> will be at least 32-bit. However keep in mind someone might find this
>> device in another datasheet not limited to 32-bit, and let's say change
>> to ".valid.min_access_size =3D 2". Without ".impl.min_access_size =3D 4"
>> your model is buggy. So to be safe I'd use:
>>
>>    .impl.min_access_size =3D 4,
>>    .valid.min_access_size =3D 4,
>>
>
> Now it makes more sense to me, thanks Philippe for explaining this!
> Great, I'll add .impl.min_access_size =3D 4.
>
> At this point, I've processed all the feedback that I received for all of
> the patches
> in this series. Is there anything else you would like to
> see/discuss/review, or shall I send the v2 when I finish testing?
>

Send it! We'll discuss on updated v2 :)

Regards,

Phil.

--0000000000003b09be0599d8e485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le lun. 16 d=C3=A9c. 2019 20:46, Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; a =C3=
=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Mon, Dec 16, 2019 at 1:14 AM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"noref=
errer">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 12/16/19 12:07 AM, Niek Linnenbank wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;&gt; wrote=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Niek,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/11/19 11:34 PM, Niek Linnenbank wrote:<br>
[...]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+static uint32_t aw_h3_sdh=
ost_process_desc(AwH3SDHostState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr desc_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TransferDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0*desc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_write,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0max_bytes)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint32_t nu=
m_done =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint32_t nu=
m_bytes =3D max_bytes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t buf=
[1024];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 /* Read des=
criptor */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 cpu_physica=
l_memory_read(desc_addr, desc, sizeof(*desc));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Should we worry about endianess here?<br>
&gt; <br>
&gt; <br>
&gt; I tried to figure out what is expected, but the <br>
&gt; Allwinner_H3_Datasheet_V1.2.pdf does not<br>
&gt; explicitly mention endianness for any of its I/O devices. Currently it=
 <br>
&gt; seems all devices are<br>
&gt; happy with using the same endianness as the CPUs. In the MemoryRegionO=
ps <br>
&gt; has DEVICE_NATIVE_ENDIAN<br>
&gt; set to match the behavior seen.<br>
<br>
OK.<br>
<br>
[...]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+static const MemoryRegion=
Ops aw_h3_sdhost_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .read =3D a=
w_h3_sdhost_read,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .write =3D =
aw_h3_sdhost_write,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 .endianness=
 =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I haven&#39;t checked .valid accesses from the data=
sheet.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0However due to:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D s-&gt;data_crc[((offset - REG=
_SD_DATA7_CRC) / sizeof(uint32_t))];<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You seem to expect:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .impl.mi=
n_access_size =3D 4,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0.impl.max_access_size unset is 8, which should work=
s.<br>
&gt; <br>
&gt; It seems that all registers are aligned on at least 32-bit boundaries.=
 <br>
&gt; And the section 5.3.5.1 mentions<br>
&gt; that the DMA descriptors must be stored in memory 32-bit aligned. So <=
br>
&gt; based on that information,<br>
<br>
So you are describing &quot;.valid.min_access_size =3D 4&quot;, which is th=
e minimum <br>
access size on the bus.<br>
&quot;.impl.min_access_size&quot; is different, it is what access sizes is =
ready <br>
to handle your model.<br>
Your model read/write handlers expect addresses aligned on 32-bit <br>
boundary, this is why I suggested to use &quot;.impl.min_access_size =3D 4&=
quot;. If <br>
the guest were using a 16-bit access, your model would be buggy. If you <br=
>
describe your implementation to accept minimum 32-bit and the guest is <br>
allowed to use smaller accesses, QEMU will do a 32-bit access to the <br>
device, and return the 16-bit part to the guest. This way your model is <br=
>
safe. This is done by access_with_adjusted_size() in memory.c.<br>
If you restrict with &quot;.valid.min_access_size =3D 4&quot;, you might th=
ink we <br>
don&#39;t need &quot;.valid.min_access_size =3D 4&quot; because all access =
from guest <br>
will be at least 32-bit. However keep in mind someone might find this <br>
device in another datasheet not limited to 32-bit, and let&#39;s say change=
 <br>
to &quot;.valid.min_access_size =3D 2&quot;. Without &quot;.impl.min_access=
_size =3D 4&quot; <br>
your model is buggy. So to be safe I&#39;d use:<br>
<br>
=C2=A0 =C2=A0.impl.min_access_size =3D 4,<br>
=C2=A0 =C2=A0.valid.min_access_size =3D 4,<br></blockquote><div><br></div><=
div>Now it makes more sense to me, thanks Philippe for explaining this!<br>=
</div><div>Great, I&#39;ll add .impl.min_access_size =3D 4.</div><div><br><=
/div><div>At this point, I&#39;ve processed all the feedback that I receive=
d for all of the patches</div><div>in this series. Is there anything else y=
ou would like to see/discuss/review, or shall I send the v2 when I finish t=
esting?<br></div></div></div></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Send it! We&#39;ll discuss on updated v2 :)</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Regards,=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Phil.</div></div>

--0000000000003b09be0599d8e485--

