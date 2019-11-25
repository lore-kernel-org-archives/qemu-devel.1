Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DC6207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6fXP4iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DC6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZIwb-0004vp-Du
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kafiler0911@gmail.com>) id 1iZIvM-0004MG-Qa
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kafiler0911@gmail.com>) id 1iZIvL-0001PT-HW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:17:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kafiler0911@gmail.com>)
 id 1iZIvL-0001P0-Bk; Mon, 25 Nov 2019 13:17:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id 94so13465629oty.8;
 Mon, 25 Nov 2019 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=VlusTfss8F24UBypVKDUSyZvodmHwwoXcYHqyFikb4s=;
 b=b6fXP4iz7VoPrTV+6fI8gcY+pncoIWFbwmcZ31IqSqOyG4+I6tmWdU+TKQJFmGqP0h
 RelFwkD0ek/6S6F/FWLrBrDz4bhtyN0MxELWEB2uIWk+2BV3IsH1r2N+mNZ4DESQ8JNV
 EPQV09Q1+PSVrJwYpa5IPEZE9IsjPAoi9oKM5gZzYSODSorRep46UiZ4wDSp2+jI9wU+
 jjsIognRIQpQHhmeBPCiUADbU8Wn0WvkSzt8C20WsXDVmL3ZEXM7E/afkxVMydp26sm9
 9XAiRztxtuezW1C0AlYgDNkefcKSAe8gnEG3mY5OfSFD2gz9i1F74XwLq24lEIjeOPH6
 Fjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=VlusTfss8F24UBypVKDUSyZvodmHwwoXcYHqyFikb4s=;
 b=lzfKzAs1zKUtlOAxQgd0ZVNdD6IWEKTI+TYzunNOAxar72XruaGQDN6acl2SnqJ7QE
 L7uL21MfK8E0eJ/OmpRUu7dHZz1cwc42Dqm4StDYUdwsnXcdj5AJbhlN6ONJcGfVixph
 5PV9y+oahvI+rUAQ3DSoRf9iODGTBu32dAqvMGTIeuh0WW1OWfckq9YsT/g1Y6Olw1N3
 9wPwbwXRCDXcryvXq10giGytRV+S8iIlyv7yNBrXfT/qvVXc2RMARepZ9UJxhgKw/vNr
 g1qhvC/ClhF4NHjHYHg2+Ggywo9kACBAEDujCtSw3bhDCOIbTY+Vok0zV/8iYpNhOr/a
 8Xfw==
X-Gm-Message-State: APjAAAWemfSqXRgCA9+M/bSDAcTFCU/T3LkheR2Yg0MVdJ68pDmC5APr
 U9fx7kcekuBqo7vxHbit0aWGSteXcZPAUMeUHlO+edHq
X-Google-Smtp-Source: APXvYqzje/jNLP8R5Yiegd9yyJQELNoE0IO6o5yqcm/xuAi1lwom8WQoXOeiZPFJT3kg2Dyg0//+QKF2JeHKFFvCS6Q=
X-Received: by 2002:a9d:6149:: with SMTP id c9mr20470623otk.279.1574705839875; 
 Mon, 25 Nov 2019 10:17:19 -0800 (PST)
MIME-Version: 1.0
References: <CAM+cExHMQQTxOHT7vmWNDTpGcoJZAbt-T=X+4WZBRwNzvFYqeg@mail.gmail.com>
In-Reply-To: <CAM+cExHMQQTxOHT7vmWNDTpGcoJZAbt-T=X+4WZBRwNzvFYqeg@mail.gmail.com>
From: karina filer <kafiler0911@gmail.com>
Date: Mon, 25 Nov 2019 23:47:08 +0530
Message-ID: <CAM+cExFnj3n4mp9fZD=A=UX4dgwe5JuH=4VKa+F=ffsYNXDTgg@mail.gmail.com>
Subject: Re: QEMU Licensing query
To: qemu-devel@nongnu.org, quintela@redhat.com, qemu-discuss@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000362bec05982fc635"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

--000000000000362bec05982fc635
Content-Type: text/plain; charset="UTF-8"

Hi All,


QEMU <https://en.wikipedia.org/wiki/QEMU> is used in Android Emulator and
is licensed under GPLv2
<https://en.wikipedia.org/wiki/GNU_General_Public_License#Version_2>.

For one of our customer support we may have to modify QEMU.


 I have below queries,

   - *Case 1: No modification in QEMU *(QEMU delivered by Google)

Is there any implications if we are not modifying and releasing QEMU
externally, but we are sharing an Android image externally that runs on QEMU



   - *Case 2: Modification in QEMU *(QEMU delivered by Google)

What are the implications if we need to modify and release QEMU,
considering that we will also have to release an Android image that will
run on this QEMU.



Regards
            Karina

On Fri, Nov 22, 2019 at 3:57 PM karina filer <kafiler0911@gmail.com> wrote:

> Hi All,
>
>
> QEMU <https://en.wikipedia.org/wiki/QEMU> is used in Android Emulator and
> is licensed under GPLv2
> <https://en.wikipedia.org/wiki/GNU_General_Public_License#Version_2>.
>
> For one of our customer support we may have to modify QEMU.
>
>
>  I have below queries,
>
>    - *Case 1: No modification in QEMU *(QEMU delivered by Google)
>
> Is there any implications if we are not modifying and releasing QEMU
> externally, but we are sharing an Android image externally that runs on QEMU
>
>
>
>    - *Case 2: Modification in QEMU *(QEMU delivered by Google)
>
> What are the implications if we need to modify and release QEMU,
> considering that we will also have to release an Android image that will
> run on this QEMU.
>
>
>
> Regards
>
> Karina
>
>
>
>

--000000000000362bec05982fc635
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,</div><div><br></div><div><fo=
nt color=3D"#000000" face=3D"Times New Roman" size=3D"3"></font><p style=3D=
"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"Calibri" size=3D"3"></=
font><br></p><font color=3D"#000000" face=3D"Times New Roman" size=3D"3"><f=
ont color=3D"#000000" face=3D"Calibri" size=3D"3"><font color=3D"#000000" f=
ace=3D"Times New Roman" size=3D"3"><a href=3D"https://en.wikipedia.org/wiki=
/QEMU" target=3D"_blank"><font color=3D"#0563c1" face=3D"Calibri" size=3D"3=
">QEMU</font></a><font color=3D"#000000" face=3D"Calibri" size=3D"3"> is us=
ed in Android Emulator and is licensed under </font><a title=3D"GNU General=
 Public License" href=3D"https://en.wikipedia.org/wiki/GNU_General_Public_L=
icense#Version_2" target=3D"_blank"><span style=3D"background:rgb(248,249,2=
50);color:rgb(11,0,128);font-family:&quot;Arial&quot;,sans-serif;font-size:=
9pt;text-decoration:none">GPLv2</span></a><font color=3D"#000000" face=3D"C=
alibri" size=3D"3">. </font></font><font color=3D"#000000" face=3D"Times Ne=
w Roman" size=3D"3"> </font></font></font><p style=3D"margin:0in 0in 0pt"><=
font color=3D"#000000" face=3D"Calibri" size=3D"3">For one of our customer =
support we may have to modify QEMU.</font></p><font color=3D"#000000" face=
=3D"Times New Roman" size=3D"3"></font><p style=3D"margin:0in 0in 0pt"><fon=
t face=3D"Calibri"><font color=3D"#000000" size=3D"3"><strong></strong></fo=
nt></font><br></p><font color=3D"#000000" face=3D"Times New Roman" size=3D"=
3"></font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"C=
alibri" size=3D"3">=C2=A0<font color=3D"#000000" face=3D"Times New Roman" s=
ize=3D"3"><font color=3D"#000000" face=3D"Calibri" size=3D"3">I have below =
queries, </font></font><font color=3D"#000000" face=3D"Times New Roman" siz=
e=3D"3"> </font></font></p><ul type=3D"disc" style=3D"margin-top:0in"><font=
 color=3D"#000000" face=3D"Times New Roman" size=3D"3"></font><li style=3D"=
margin:0in 0in 0pt;font-style:normal;font-weight:normal"><b><span>Case 1: N=
o modification in QEMU </span></b><span>(QEMU delivered by     Google)</spa=
n></li><font color=3D"#000000" face=3D"Times New Roman" size=3D"3"></font><=
/ul><font color=3D"#000000" face=3D"Times New Roman" size=3D"3"></font><p s=
tyle=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=3D"Calibri" =
size=3D"3">Is there any implications if we are not modifying and releasing =
QEMU externally, but we are sharing an Android image externally that runs o=
n QEMU</font></p><font color=3D"#000000" face=3D"Times New Roman" size=3D"3=
"></font><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=
=3D"Calibri" size=3D"3">=C2=A0</font></p><font color=3D"#000000" face=3D"Ti=
mes New Roman" size=3D"3"></font><ul type=3D"disc" style=3D"margin-top:0in"=
><font color=3D"#000000" face=3D"Times New Roman" size=3D"3">  </font><li s=
tyle=3D"margin:0in 0in 0pt;font-style:normal;font-weight:normal"><b><span>C=
ase 2: Modification in QEMU </span></b><span>(QEMU delivered by     Google)=
</span></li><font color=3D"#000000" face=3D"Times New Roman" size=3D"3"></f=
ont></ul><font color=3D"#000000" face=3D"Times New Roman" size=3D"3"></font=
><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=3D"Cali=
bri" size=3D"3">What are the implications if we need to modify and release =
QEMU, considering that we will also have to release an Android image that w=
ill run on this QEMU.</font></p><p style=3D"margin:0in 0in 0pt 0.5in"><font=
 color=3D"#000000" face=3D"Calibri" size=3D"3"></font><br></p><p style=3D"m=
argin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=3D"Calibri" size=3D"3=
"></font><br></p><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#0000=
00" face=3D"Calibri" size=3D"3">Regards</font></p><div class=3D"gmail-yj6qo=
 gmail-ajU"><div tabindex=3D"0" class=3D"gmail-ajR" id=3D"gmail-:ao"><img c=
lass=3D"gmail-ajT" src=3D"https://ssl.gstatic.com/ui/v1/icons/mail/images/c=
leardot.gif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<span class=3D"gmail-HOEnZb gmail-adL"><font color=3D"#888888">=
<font color=3D"#000000" face=3D"Calibri" size=3D"3">Karina</font><br></font=
></span></div></div></div></div></div><br><div class=3D"gmail_quote"><div c=
lass=3D"gmail_attr" dir=3D"ltr">On Fri, Nov 22, 2019 at 3:57 PM karina file=
r &lt;<a href=3D"mailto:kafiler0911@gmail.com">kafiler0911@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;padding-left:1ex;border-left-color:rgb(204,204,204);border-left-=
width:1px;border-left-style:solid"><div dir=3D"ltr"><div dir=3D"ltr"><div>H=
i All,</div><div><br></div><div><font color=3D"#000000" face=3D"Times New R=
oman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"Cali=
bri" size=3D"3"></font><br></p><font color=3D"#000000" face=3D"Times New Ro=
man" size=3D"3">

<font color=3D"#000000" face=3D"Calibri" size=3D"3"><font color=3D"#000000"=
 face=3D"Times New Roman" size=3D"3"><a href=3D"https://en.wikipedia.org/wi=
ki/QEMU" target=3D"_blank"><font color=3D"#0563c1" face=3D"Calibri" size=3D=
"3">QEMU</font></a><font color=3D"#000000" face=3D"Calibri" size=3D"3"> is
used in Android Emulator and is licensed under </font><a title=3D"GNU Gener=
al Public License" href=3D"https://en.wikipedia.org/wiki/GNU_General_Public=
_License#Version_2" target=3D"_blank"><span style=3D"background:rgb(248,249=
,250);color:rgb(11,0,128);font-family:&quot;Arial&quot;,sans-serif;font-siz=
e:9pt;text-decoration:none">GPLv2</span></a><font color=3D"#000000" face=3D=
"Calibri" size=3D"3">. </font></font><font color=3D"#000000" face=3D"Times =
New Roman" size=3D"3">

</font></font></font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000=
" face=3D"Calibri" size=3D"3">For one of our customer support we may have t=
o modify QEMU.</font></p><font color=3D"#000000" face=3D"Times New Roman" s=
ize=3D"3">

</font><p style=3D"margin:0in 0in 0pt"><font face=3D"Calibri"><font color=
=3D"#000000" size=3D"3"><strong></strong></font></font><br></p><font color=
=3D"#000000" face=3D"Times New Roman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"Cali=
bri" size=3D"3">=C2=A0<font color=3D"#000000" face=3D"Times New Roman" size=
=3D"3"><font color=3D"#000000" face=3D"Calibri" size=3D"3">I have below que=
ries, </font></font><font color=3D"#000000" face=3D"Times New Roman" size=
=3D"3">

</font></font></p><ul type=3D"disc" style=3D"margin-top:0in"><font color=3D=
"#000000" face=3D"Times New Roman" size=3D"3">
 </font><li style=3D"margin:0in 0in 0pt;font-style:normal;font-weight:norma=
l"><b><span>Case 1: No modification in QEMU </span></b><span>(QEMU delivere=
d by
     Google)</span></li><font color=3D"#000000" face=3D"Times New Roman" si=
ze=3D"3">
</font></ul><font color=3D"#000000" face=3D"Times New Roman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=
=3D"Calibri" size=3D"3">Is there any implications if we are not modifying a=
nd
releasing QEMU externally, but we are sharing an Android image externally t=
hat
runs on QEMU</font></p><font color=3D"#000000" face=3D"Times New Roman" siz=
e=3D"3">

</font><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=
=3D"Calibri" size=3D"3">=C2=A0</font></p><font color=3D"#000000" face=3D"Ti=
mes New Roman" size=3D"3">

</font><ul type=3D"disc" style=3D"margin-top:0in"><font color=3D"#000000" f=
ace=3D"Times New Roman" size=3D"3">
 </font><li style=3D"margin:0in 0in 0pt;font-style:normal;font-weight:norma=
l"><b><span>Case 2: Modification in QEMU </span></b><span>(QEMU delivered b=
y
     Google)</span></li><font color=3D"#000000" face=3D"Times New Roman" si=
ze=3D"3">
</font></ul><font color=3D"#000000" face=3D"Times New Roman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=
=3D"Calibri" size=3D"3">What are the implications if we need to modify and
release QEMU, considering that we will also have to release an Android imag=
e
that will run on this QEMU.</font></p><p style=3D"margin:0in 0in 0pt 0.5in"=
><font color=3D"#000000" face=3D"Calibri" size=3D"3"></font><br></p><p styl=
e=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" face=3D"Calibri" siz=
e=3D"3"></font><br></p><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D=
"#000000" face=3D"Calibri" size=3D"3">Regards</font></p><p style=3D"margin:=
0in 0in 0pt 0.5in"><font color=3D"#000000" face=3D"Calibri" size=3D"3">Kari=
na</font></p><p style=3D"margin:0in 0in 0pt 0.5in"><font color=3D"#000000" =
face=3D"Calibri" size=3D"3"></font><br></p><font color=3D"#000000" face=3D"=
Times New Roman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"Cali=
bri" size=3D"3">=C2=A0</font></p><font color=3D"#000000" face=3D"Times New =
Roman" size=3D"3">

</font></div></div></div>
</blockquote></div>

--000000000000362bec05982fc635--

