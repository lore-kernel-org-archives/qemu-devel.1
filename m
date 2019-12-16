Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC20C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7AD206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4ur0HEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7AD206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwL7-0000vW-QS
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igwJs-0000Cb-Ku
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igwJq-0003KO-Ur
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:46:16 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igwJq-0003Ju-Lc; Mon, 16 Dec 2019 14:46:14 -0500
Received: by mail-il1-x142.google.com with SMTP id f10so6392602ils.8;
 Mon, 16 Dec 2019 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OsHm0tUSHoKhbWzbKpZ0C/bNOhwpqgtB85Sg/g/m0rU=;
 b=f4ur0HEHZnc/2TQ0OcuK88IYSlQtgNyjvtVZp2GyoaCJx2PKY9cOXBsp2IIEPU9ZKK
 DcgfSlo3s+5fNJeRUtbK1wwHsXh73cGUW5k7BfDG6srs62kOpEv96jaBJCuvFXRMaZEp
 4MS4/uDr0ECvZav0WetCFdETlkElEKwC5+X9b2tg8035N+ENFpQvXOVYkVGtmEbth1bM
 FJN4Oykr5oVFZa4wTrYWlpyFRXWdQXu/Vgk2cvN3spbPggHzJm2M8xzEqQczS4njO7ni
 3uPjbgxdpsDTHEiP6Aal/QzS4mHAojJ1A3BcRJSLgqLNlyYysHKw413i6lm+OfYUdgWF
 nMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OsHm0tUSHoKhbWzbKpZ0C/bNOhwpqgtB85Sg/g/m0rU=;
 b=PRGiZyNtC5E7sDE0O4cYhmvKFjiF71l2e2lmJxGJHo0X+dnaMn90OwkObSrb7YxXX2
 3sQ5D81Ol/jIgWKN9EZmV7LN/GLSvDCGzPJvYKasNstxnlqjSayTGvz4xgOq5P3qctwv
 J4Tytp74eoqWZe4eu6YjdwtyRfoaGm1kJ8TRwEp7OJVvoZyKSxthGqc3+0tTkbdWdEHM
 SkXdh33ulBi/SBQj+hnhVDaym/7w4rBEMgr8c7WtsEYh+GnAMpPh5ahfoxd24U1SAogi
 6nv0OUeehLmyaZWSuXX2bbnntffSWYH2wGj9BCXeLtu2YaPGfdYaobG1ejXnDi3+lmHw
 WAmw==
X-Gm-Message-State: APjAAAWG08DX91Ce11ATi6I7j/tzrB+MY6PO6D6ooUGONWbYoQvhvHiX
 x9X85aTN97zLh0ZDu7u4aSCV+EzLQhaVYuwN37c=
X-Google-Smtp-Source: APXvYqztAQsm5gMqTB3ZjOvI0BjOvZnUSJcYwidpVx6noYr6OaCad7TEt8f4wbMHnLMaKlRLtW9ioIt51zYEPvqUvsc=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr13244508ilq.306.1576525573101; 
 Mon, 16 Dec 2019 11:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
 <CAPan3WpiWahU85-ZgV4BMPU8mUTxsq2TPn-szOHkHc5+PHUqpw@mail.gmail.com>
 <03a78f1d-e8fe-5a53-b061-d39de9ed7a9e@redhat.com>
In-Reply-To: <03a78f1d-e8fe-5a53-b061-d39de9ed7a9e@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 16 Dec 2019 20:46:01 +0100
Message-ID: <CAPan3WrHQk-apQhQrihF_71b3_PSqkaEu1dHYmeCXuygwnAy2A@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c39ead0599d776e2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c39ead0599d776e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 1:14 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/16/19 12:07 AM, Niek Linnenbank wrote:
> >
> >
> > On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     Hi Niek,
> >
> >     On 12/11/19 11:34 PM, Niek Linnenbank wrote:
> [...]
> >      >     +static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState *=
s,
> >      >     +                                          hwaddr desc_addr,
> >      >     +                                          TransferDescripto=
r
> >     *desc,
> >      >     +                                          bool is_write,
> >     uint32_t
> >      >     max_bytes)
> >      >     +{
> >      >     +    uint32_t num_done =3D 0;
> >      >     +    uint32_t num_bytes =3D max_bytes;
> >      >     +    uint8_t buf[1024];
> >      >     +
> >      >     +    /* Read descriptor */
> >      >     +    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc)=
);
> >
> >     Should we worry about endianess here?
> >
> >
> > I tried to figure out what is expected, but the
> > Allwinner_H3_Datasheet_V1.2.pdf does not
> > explicitly mention endianness for any of its I/O devices. Currently it
> > seems all devices are
> > happy with using the same endianness as the CPUs. In the MemoryRegionOp=
s
> > has DEVICE_NATIVE_ENDIAN
> > set to match the behavior seen.
>
> OK.
>
> [...]
> >      >     +static const MemoryRegionOps aw_h3_sdhost_ops =3D {
> >      >     +    .read =3D aw_h3_sdhost_read,
> >      >     +    .write =3D aw_h3_sdhost_write,
> >      >     +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >
> >     I haven't checked .valid accesses from the datasheet.
> >
> >     However due to:
> >
> >         res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) /
> sizeof(uint32_t))];
> >
> >     You seem to expect:
> >
> >                  .impl.min_access_size =3D 4,
> >
> >     .impl.max_access_size unset is 8, which should works.
> >
> > It seems that all registers are aligned on at least 32-bit boundaries.
> > And the section 5.3.5.1 mentions
> > that the DMA descriptors must be stored in memory 32-bit aligned. So
> > based on that information,
>
> So you are describing ".valid.min_access_size =3D 4", which is the minimu=
m
> access size on the bus.
> ".impl.min_access_size" is different, it is what access sizes is ready
> to handle your model.
> Your model read/write handlers expect addresses aligned on 32-bit
> boundary, this is why I suggested to use ".impl.min_access_size =3D 4". I=
f
> the guest were using a 16-bit access, your model would be buggy. If you
> describe your implementation to accept minimum 32-bit and the guest is
> allowed to use smaller accesses, QEMU will do a 32-bit access to the
> device, and return the 16-bit part to the guest. This way your model is
> safe. This is done by access_with_adjusted_size() in memory.c.
> If you restrict with ".valid.min_access_size =3D 4", you might think we
> don't need ".valid.min_access_size =3D 4" because all access from guest
> will be at least 32-bit. However keep in mind someone might find this
> device in another datasheet not limited to 32-bit, and let's say change
> to ".valid.min_access_size =3D 2". Without ".impl.min_access_size =3D 4"
> your model is buggy. So to be safe I'd use:
>
>    .impl.min_access_size =3D 4,
>    .valid.min_access_size =3D 4,
>

Now it makes more sense to me, thanks Philippe for explaining this!
Great, I'll add .impl.min_access_size =3D 4.

At this point, I've processed all the feedback that I received for all of
the patches
in this series. Is there anything else you would like to
see/discuss/review, or shall I send the v2 when I finish testing?

Regards,
Niek


>
> > I think 32-bit is a safe choice. I've verified this with Linux mainline
> > and U-Boot drivers and both are still working.
>
> Regards,
>
> Phil.
>
>

--=20
Niek Linnenbank

--000000000000c39ead0599d776e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16, 2019 at 1:14 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/16/19 12:07 AM, Niek Linnenbank wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
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
esting?<br></div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; I think 32-bit is a safe choice. I&#39;ve verified this with Linux mai=
nline <br>
&gt; and U-Boot drivers and both are still working.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000c39ead0599d776e2--

