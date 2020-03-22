Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203CBC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE6C20722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFRRI5HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE6C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG78y-0002nz-1d
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG78A-0001vn-Gj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG788-0006ug-UO
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:23:34 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130]:33437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jG788-0006uI-Oo
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:23:32 -0400
Received: by mail-il1-x130.google.com with SMTP id k29so11250497ilg.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JXMRykbmY8ZLivTCypVCrjABILt3a9cyNgq3MABQq3g=;
 b=HFRRI5HUVDFcHZ47ugCkKv8Z8cNarppupI0iBD6N5zhu6yCusi669SnPxfT0/1xMBm
 +xG6SyTPuayXrD7MxZo7vWa95DaHkJuSNk7at9i8wWuByoOmJ3XlEA+7897F3ViqupN0
 TwANjtsxAUE4ijdZs9PubEk6fnp0vPFVWm5IbdB7ly2poiZ5104XpMg5g+usweCatW2A
 M/MLK9pqCNzlPoZ73NiN9FooZp9zP3PDmuIhNyrfA5tGmO0Rce0dbPm5WSCeiqBl7l2j
 xqkcNlYTDGh1orklq1HuqSdv2IoH13hmgiSfHVQepXxEt96grFdLgYDz7SKwrITFNSxg
 F+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JXMRykbmY8ZLivTCypVCrjABILt3a9cyNgq3MABQq3g=;
 b=Um7Nyh+B1+sMsN1WvlYvnMrMo5ztahalTNjvIVPud2NG8gev6sSbc112Oalae3Aohz
 b9FUfOfXGAHyOYowXHP+zq5n1nEywB1QkVLNZxy4kHScxjRcchtDj574xMIGFaXQPWw+
 aqnDh1MgNzKSXIcNPBD8x9/QM8Mbg7NXHgfZdfnWKkG31o0IQhKg4VaUB0myJkDKo6IW
 t0Y4KsZXUnuF7RuiSu21dhMe45sdcf55MNrVRANR0yONkm7Yq7mTASSseO6Hapw/HCsc
 9NaZmtQt9XiGubKdgXBV+4al+6qWXyj8pr5iaXSnzyV3mDdR5suOOjo/eeQQJzG2LkDh
 L6Vg==
X-Gm-Message-State: ANhLgQ2rBmj7AzXv218hZAPiKpgEhaq6O1RJZp52GxoGwQwXoG+j9Vgu
 4aMR5u/SNiOSYFs0Y5FAQ0TTqED+OEtnDI6ucZY=
X-Google-Smtp-Source: ADFU+vtyEQc05rYEu6q3S2zU3E02t8WLJFd69kJRWHPf9SkUMDMTdkr/2vdlawHV8sEYid031gCgHeJn1U1yfLvLMs4=
X-Received: by 2002:a92:58d0:: with SMTP id z77mr16853818ilf.67.1584908611684; 
 Sun, 22 Mar 2020 13:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-23-peter.maydell@linaro.org>
 <CAFEAcA8zWZO_eqQRq+=NRKfohmRUPOkE_4uHBDRbu-tO=mxB=w@mail.gmail.com>
In-Reply-To: <CAFEAcA8zWZO_eqQRq+=NRKfohmRUPOkE_4uHBDRbu-tO=mxB=w@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 22 Mar 2020 21:23:20 +0100
Message-ID: <CAPan3WpS=ixityrUsDUqpuuzWo3JYLFRM+tJXmVdGwaom9nLbg@mail.gmail.com>
Subject: Re: [PULL 22/36] hw/arm/allwinner-h3: add SDRAM controller device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cd0f1c05a1774ab2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::130
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd0f1c05a1774ab2
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Fri, Mar 20, 2020 at 4:46 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 12 Mar 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > From: Niek Linnenbank <nieklinnenbank@gmail.com>
> >
> > In the Allwinner H3 SoC the SDRAM controller is responsible
> > for interfacing with the external Synchronous Dynamic Random
> > Access Memory (SDRAM). Types of memory that the SDRAM controller
> > supports are DDR2/DDR3 and capacities of up to 2GiB. This commit
> > adds emulation support of the Allwinner H3 SDRAM controller.
>
> Hi; Coverity has flagged a possible issue with this patch
> (CID 1421912):
>
> > +static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t
> row_bits,
> > +                                        uint8_t bank_bits, uint16_t
> page_size)
> > +{
> > +    /*
> > +     * This function simulates row addressing behavior when bootloader
> > +     * software attempts to detect the amount of available SDRAM. In
> U-Boot
> > +     * the controller is configured with the widest row addressing
> available.
> > +     * Then a pattern is written to RAM at an offset on the row
> boundary size.
> > +     * If the value read back equals the value read back from the
> > +     * start of RAM, the bootloader knows the amount of row bits.
> > +     *
> > +     * This function inserts a mirrored memory region when the
> configured row
> > +     * bits are not matching the actual emulated memory, to simulate the
> > +     * same behavior on hardware as expected by the bootloader.
> > +     */
> > +    uint8_t row_bits_actual = 0;
> > +
> > +    /* Calculate the actual row bits using the ram_size property */
> > +    for (uint8_t i = 8; i < 12; i++) {
> > +        if (1 << i == s->ram_size) {
> > +            row_bits_actual = i + 3;
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (s->ram_size == (1 << (row_bits - 3))) {
> > +        /* When row bits is the expected value, remove the mirror */
> > +        memory_region_set_enabled(&s->row_mirror_alias, false);
> > +        trace_allwinner_h3_dramc_rowmirror_disable();
> > +
> > +    } else if (row_bits_actual) {
> > +        /* Row bits not matching ram_size, install the rows mirror */
> > +        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
> > +                                                  bank_bits)) *
> page_size);
>
> In this calculation we do the multiply as a signed 32-bit operation,
> which then gets sign-extended to 64 bits for the addition; that
> means that if the multiply result is greater than 0x7fffffff then
> the upper bits of the result will all be 1s. Is this a "can't happen"
> situation, or should we be using "1ULL" to force a 64-bit multiply?
>

The allwinner_h3_dramcom_write() function invokes this function when the
'Control' register
is written. Basically allwinner_h3_dramc_map_rows() needs to insert a
memory region such
that the bootloader can detect the amount of RAM. Currently U-Boot only
searches up to page_size
values up to 8192, so in practise that would not trigger a result greater
than 0x7fffffff.

However in theory, the Control register can indeed be written with larger
page_size values.
So to be safe, I'll just make a small patch to replace the 1 with 1UL,
thanks!

Regards,
Niek



>
> thanks
> -- PMM
>


-- 
Niek Linnenbank

--000000000000cd0f1c05a1774ab2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2020 at 4:46 PM Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Thu, 12 Mar 2020 at 16:45, Peter Maydell &lt;<a href=3D"mailto:peter.=
maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrot=
e:<br>
&gt;<br>
&gt; From: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" =
target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;<br>
&gt; In the Allwinner H3 SoC the SDRAM controller is responsible<br>
&gt; for interfacing with the external Synchronous Dynamic Random<br>
&gt; Access Memory (SDRAM). Types of memory that the SDRAM controller<br>
&gt; supports are DDR2/DDR3 and capacities of up to 2GiB. This commit<br>
&gt; adds emulation support of the Allwinner H3 SDRAM controller.<br>
<br>
Hi; Coverity has flagged a possible issue with this patch<br>
(CID 1421912):<br>
<br>
&gt; +static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t =
row_bits,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
8_t bank_bits, uint16_t page_size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* This function simulates row addressing behavior=
 when bootloader<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* software attempts to detect the amount of avail=
able SDRAM. In U-Boot<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the controller is configured with the widest ro=
w addressing available.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Then a pattern is written to RAM at an offset o=
n the row boundary size.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If the value read back equals the value read ba=
ck from the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* start of RAM, the bootloader knows the amount o=
f row bits.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* This function inserts a mirrored memory region =
when the configured row<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* bits are not matching the actual emulated memor=
y, to simulate the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* same behavior on hardware as expected by the bo=
otloader.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 uint8_t row_bits_actual =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Calculate the actual row bits using the ram_size pro=
perty */<br>
&gt; +=C2=A0 =C2=A0 for (uint8_t i =3D 8; i &lt; 12; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (1 &lt;&lt; i =3D=3D s-&gt;ram_size) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 row_bits_actual =3D i + 3;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;ram_size =3D=3D (1 &lt;&lt; (row_bits - 3))) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* When row bits is the expected value, r=
emove the mirror */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_set_enabled(&amp;s-&gt;row_=
mirror_alias, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_allwinner_h3_dramc_rowmirror_disabl=
e();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 } else if (row_bits_actual) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Row bits not matching ram_size, instal=
l the rows mirror */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr row_mirror =3D s-&gt;ram_addr + ((=
1 &lt;&lt; (row_bits_actual +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank_bits)) * page_size);<br>
<br>
In this calculation we do the multiply as a signed 32-bit operation,<br>
which then gets sign-extended to 64 bits for the addition; that<br>
means that if the multiply result is greater than 0x7fffffff then<br>
the upper bits of the result will all be 1s. Is this a &quot;can&#39;t happ=
en&quot;<br>
situation, or should we be using &quot;1ULL&quot; to force a 64-bit multipl=
y?<br></blockquote><div><br></div><div>The allwinner_h3_dramcom_write() fun=
ction invokes this function when the &#39;Control&#39; register</div><div>i=
s written. Basically allwinner_h3_dramc_map_rows() needs to insert a memory=
 region such</div><div>that the bootloader can detect the amount of RAM. Cu=
rrently U-Boot only searches up to page_size</div><div>values up to 8192, s=
o in practise that would not trigger a result greater than 0x7fffffff.</div=
><div><br></div><div>However in theory, the Control register can indeed be =
written with larger page_size values.</div><div>So to be safe, I&#39;ll jus=
t make a small patch to replace the 1 with 1UL, thanks!</div><div><br></div=
><div>Regards,</div><div>Niek<br></div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000cd0f1c05a1774ab2--

