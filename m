Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499022464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="TeFv4kXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499022464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNtR-0005IK-MQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jvNcq-000651-EG
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:17:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1jvNco-0001g6-OQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:17:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z2so22864835wrp.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=9mHTll+qJYKuqrwnm8XlNBPIN4e3vINyniYx3lj49wQ=;
 b=TeFv4kXPa9QHdFWY2kW6oY7YkN+HtehqfHvCCglELnuuH9LcfTLPMnriOfibYgeHdW
 yWoXfkSod1Fua16rMdF7SIR9aLN4ckGjzurmDQcvXxwi4MQXTC9ANBZIqbfP0jJByVO2
 Zmqpu5iAy6wZYhl7aA14XzFDqcF5Zhk+ISDFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=9mHTll+qJYKuqrwnm8XlNBPIN4e3vINyniYx3lj49wQ=;
 b=MFbDrK4BrnQD4qn01Ui7Y5/+4IF4GA601ejL+/Waigl7ifvavrEcB4ilOlh0gVA5K+
 2gVoNdUkL0Iqh/y9+GQv1Lls7tX9YWS7WcKQH3/lEn8AslGFpVCCPBdmUJV0QUQ++8yy
 m+wV55d0LxY94+VtYXML76uHuAe7Fx/jGhBH3ziLOYhiM4/wUWiWTkjxZxpIZNt9rrcZ
 bcJ8Os75+ygQxwwL7u4OpLsNL7qfZDY9Y29XmmOU+0RyzJJgmCVA2W/IvIQkLmq1DOlo
 hVrDVwTQz6shm1OqSGj54kSPy1cahyWqcK5wjPJCJPAXHYPiXnkAvYUzF3p02Q4iBdTx
 +AvQ==
X-Gm-Message-State: AOAM532x2sYe2StCy/wFa+f7b2tA/QW7lgLAIedMBhisDNTmTSn73E/7
 mCmk8rKamJ2zh99zQIzwXNA+cNKIUZ6oYn1TxQt5Z6VGc9U=
X-Google-Smtp-Source: ABdhPJwkYNdFXo42z397tADAILnMDW22kJ5SBSVK6IX/GBeeKlwHYbmhOM800sXa6IQUuPGUvs/hU6cnRv/AzKRCdsA=
X-Received: by 2002:adf:b312:: with SMTP id j18mr6333169wrd.195.1594743464979; 
 Tue, 14 Jul 2020 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
In-Reply-To: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Tue, 14 Jul 2020 21:47:33 +0530
Message-ID: <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
Subject: Re: sysbus_create_simple Vs qdev_create
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bd03ff05aa69257d"
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2020 12:34:12 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd03ff05aa69257d
Content-Type: text/plain; charset="UTF-8"

Here is a brief context that might help you.
I am referring hw/arm/versatilepb.c

The ARM PrimeCell UART (PL011) device created as follows

    dev = qdev_create(NULL, "pl011");
    s = SYS_BUS_DEVICE(dev);
    qdev_prop_set_chr(dev, "chardev", chr);
    qdev_init_nofail(dev);
    sysbus_mmio_map(s, 0, addr);
    sysbus_connect_irq(s, 0, irq);

Whereas the PL031 RTC device is created as

    /* Add PL031 Real Time Clock. */
    sysbus_create_simple("pl031", 0x101e8000, pic[10]);

What is the difference between these two devices creation? How do I know
which method to use while creating an object?

Thanks & Regards,

Pratik

On Tue, Jul 14, 2020 at 9:39 PM Pratik Parvati <pratikp@vayavyalabs.com>
wrote:

> Hi Support team,
>
> Can someone please guide me to understand the difference between *sysbus_create_simple
> *and *qdev_create*?.
>
> I understand that these two methods are used to create a new device. But,
> when to use these functions is not clear to me.
>
> Regards,
> Pratik
>

--000000000000bd03ff05aa69257d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"markdown-here-wrapper" style=3D""><p style=
=3D"margin:0px 0px 1.2em!important">Here is a brief context that might help=
 you.<br>I am referring hw/arm/versatilepb.c </p>
<p style=3D"margin:0px 0px 1.2em!important">The ARM PrimeCell UART (PL011) =
device created as follows</p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-C" style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Co=
urier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;bo=
rder:1px solid rgb(234,234,234);background-color:rgb(248,248,248);border-ra=
dius:3px;display:inline;white-space:pre;overflow:auto;border-radius:3px;bor=
der:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important;=
display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);background:=
rgb(248,248,248)">    dev =3D qdev_create(NULL, <span class=3D"hljs-string"=
 style=3D"color:rgb(221,17,68)">&quot;pl011&quot;</span>);
    s =3D SYS_BUS_DEVICE(dev);
    qdev_prop_set_chr(dev, <span class=3D"hljs-string" style=3D"color:rgb(2=
21,17,68)">&quot;chardev&quot;</span>, chr);
    qdev_init_nofail(dev);
    sysbus_mmio_map(s, <span class=3D"hljs-number" style=3D"color:rgb(0,128=
,128)">0</span>, addr);
    sysbus_connect_irq(s, <span class=3D"hljs-number" style=3D"color:rgb(0,=
128,128)">0</span>, irq);
</code></pre>
<p style=3D"margin:0px 0px 1.2em!important">Whereas the PL031 RTC device is=
 created as</p>
<pre style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Courier,mon=
ospace;font-size:1em;line-height:1.2em;margin:1.2em 0px"><code class=3D"hlj=
s language-C" style=3D"font-size:0.85em;font-family:Consolas,Inconsolata,Co=
urier,monospace;margin:0px 0.15em;padding:0px 0.3em;white-space:pre-wrap;bo=
rder:1px solid rgb(234,234,234);background-color:rgb(248,248,248);border-ra=
dius:3px;display:inline;white-space:pre;overflow:auto;border-radius:3px;bor=
der:1px solid rgb(204,204,204);padding:0.5em 0.7em;display:block!important;=
display:block;overflow-x:auto;padding:0.5em;color:rgb(51,51,51);background:=
rgb(248,248,248)">    <span class=3D"hljs-comment" style=3D"color:rgb(153,1=
53,136);font-style:italic">/* Add PL031 Real Time Clock. */</span>
    sysbus_create_simple(<span class=3D"hljs-string" style=3D"color:rgb(221=
,17,68)">&quot;pl031&quot;</span>, <span class=3D"hljs-number" style=3D"col=
or:rgb(0,128,128)">0x101e8000</span>, pic[<span class=3D"hljs-number" style=
=3D"color:rgb(0,128,128)">10</span>]);
</code></pre>
<p style=3D"margin:0px 0px 1.2em!important">What is the difference between =
these two devices creation? How do I know which method to use while creatin=
g an object?</p>
<p style=3D"margin:0px 0px 1.2em!important">Thanks &amp; Regards,</p><p sty=
le=3D"margin:0px 0px 1.2em!important">Pratik</p>
<div title=3D"MDH:PGRpdiBkaXI9Imx0ciI+SGVyZSBpcyBhIGJyaWVmIGNvbnRleHQgdGhhd=
CBtaWdodCBoZWxwIHlv
dS48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gcmVmZXJyaW5nJm5ic3A7PGk+aHcvYXJtL3ZlcnN=
h
dGlsZXBiLmMmbmJzcDs8L2k+PC9kaXY+PGRpdj48aT48YnI+PC9pPjwvZGl2PjxkaXY+VGhlJm5=
i
c3A7QVJNIFByaW1lQ2VsbCBVQVJUIChQTDAxMSkgZGV2aWNlIGNyZWF0ZWQgYXMgZm9sbG93czw=
v
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YGBgQzwvZGl2PjxkaXY+Jm5ic3A7ICZuYnNwOyBkZXY=
g
PSBxZGV2X2NyZWF0ZShOVUxMLCAicGwwMTEiKTs8YnI+Jm5ic3A7ICZuYnNwOyBzID0gU1lTX0J=
V
U19ERVZJQ0UoZGV2KTs8YnI+Jm5ic3A7ICZuYnNwOyBxZGV2X3Byb3Bfc2V0X2NocihkZXYsICJ=
j
aGFyZGV2IiwgY2hyKTs8YnI+Jm5ic3A7ICZuYnNwOyBxZGV2X2luaXRfbm9mYWlsKGRldik7PGJ=
y
PiZuYnNwOyAmbmJzcDsgc3lzYnVzX21taW9fbWFwKHMsIDAsIGFkZHIpOzxicj4mbmJzcDsgJm5=
i
c3A7IHN5c2J1c19jb25uZWN0X2lycShzLCAwLCBpcnEpOzxicj48L2Rpdj48ZGl2PmBgYDwvZGl=
2
PjxkaXY+V2hlcmVhcyB0aGUgUEwwMzEgUlRDIGRldmljZSBpcyBjcmVhdGVkIGFzPC9kaXY+PGR=
p
dj48YnI+PC9kaXY+PGRpdj5gYGBDPC9kaXY+PGRpdj4mbmJzcDsgJm5ic3A7IC8qIEFkZCBQTDA=
z
MSBSZWFsIFRpbWUgQ2xvY2suICovPGJyPiZuYnNwOyAmbmJzcDsgc3lzYnVzX2NyZWF0ZV9zaW1=
w
bGUoInBsMDMxIiwgMHgxMDFlODAwMCwgcGljWzEwXSk7PGJyPjwvZGl2PjxkaXY+YGBgPC9kaXY=
+
PGRpdj48YnI+PC9kaXY+PGRpdj5XaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlc2U=
g
dHdvIDxzcGFuIHpldW00YzQ9IlBSXzNfMCIgZGF0YS1kZG53YWI9IlBSXzNfMCIgYXJpYS1pbnZ=
h
bGlkPSJncmFtbWFyIiBjbGFzcz0iTG0gbmciPmRldmljZXM8L3NwYW4+IDxzcGFuIHpldW00YzQ=
9
IlBSXzZfMCIgZGF0YS1kZG53YWI9IlBSXzZfMCIgYXJpYS1pbnZhbGlkPSJncmFtbWFyIiBjbGF=
z
cz0iTG0gbmciPmNyZWF0aW9uPC9zcGFuPj8gSG93IGRvIEkga25vdyB3aGljaCBtZXRob2QgdG8=
g
dXNlIHdoaWxlIGNyZWF0aW5nIGFuIG9iamVjdD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjx=
k
aXY+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI=
+
VGhhbmtzICZhbXA7IFJlZ2FyZHMsPGRpdj5QcmF0aWs8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4=
8
YnI+PC9kaXY+PC9kaXY+" style=3D"height:0;width:0;max-height:0;max-width:0;ov=
erflow:hidden;font-size:0em;padding:0;margin:0"></div></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 14,=
 2020 at 9:39 PM Pratik Parvati &lt;<a href=3D"mailto:pratikp@vayavyalabs.c=
om">pratikp@vayavyalabs.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">Hi Support team,<div><br></div>=
<div>Can someone please guide me to understand the difference between <b>sy=
sbus_create_simple </b>and <b>qdev_create</b>?.</div><div><br></div><div>I =
understand that these two methods are used to create=C2=A0a new device. But=
, when to use these functions is not clear to me.</div><div><br></div><div>=
<div><div dir=3D"ltr"><div dir=3D"ltr">Regards,<div>Pratik</div></div></div=
></div></div></div>
</blockquote></div>

--000000000000bd03ff05aa69257d--

