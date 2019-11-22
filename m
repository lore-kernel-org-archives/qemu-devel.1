Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99FE20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3WqSTlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99FE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9HM-0000Qo-Pn
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kafiler0911@gmail.com>) id 1iY69r-0005lo-CR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kafiler0911@gmail.com>) id 1iY69q-0002il-2i
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:23 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kafiler0911@gmail.com>)
 id 1iY69p-0002i8-Qp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:22 -0500
Received: by mail-ot1-x32f.google.com with SMTP id b16so5726477otk.9
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=A6jiDWLrymswxK8GY0hxXoVqXg/2najgI09cx6ORghI=;
 b=Z3WqSTlSc/qTXFe5RiKjAcqG547/6oraJ9rQflVWwl/ULHCWgHWGZ+cyZxyBrYHUGX
 Wzuw8v7icCpu4C8NCmEWlf/ywV61mgAQbLnpUXdej5mrMq1HuH+OFA6VqP/CpHAKcpbB
 bomJwC0QLGk/xMY5jdbbWRH15DbieX04D6f8G5mUi8jgJSryodB1yxZRQ6+NLJsjkQmn
 gHOJgm0UzoBhwmg5Gm7mLTBczI3IxeDteXlSsV4eYpxOCbCwCFa8I2bklg9/k05aHSKJ
 fV+cJKTcsp33VZI94kYpGIzzJVbJ6tDxmaE9lf6wbqPPDZ1zX41Ajt3fFYnSReOYkF2J
 VMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=A6jiDWLrymswxK8GY0hxXoVqXg/2najgI09cx6ORghI=;
 b=KJa+aaBdg2yXeVfySS+OcoKCiofBwSVypSobnE7dtxwJt3flzDrMPsHZaNFbHSg/XS
 dkDKTowghzvwQmzYrHMaJtqD+ptTkwoVPAPtjkEGcoCDkNtYpbCaFlg7C2cC8AGyhvow
 t31U4zef8rzDUOGTgNZ3JbeD3BptUogBfzZsa2lp611IQ17i8CgQbXavVBQ7xIduizQn
 n6EzsWsy3tjTyw9gEHyvI9T/FXkp3LdETCc9vLTrt1WEXFsOE42RZwxcds4YWTZyLZYI
 H+uurD8o17XrIXydbHyK2XfzR/y1qtEOCHmSSSlB7nZvWrTrm0NrrynpB14RRIIJwkBd
 yq3A==
X-Gm-Message-State: APjAAAUR96bWjvAVvRWhr8Rw0ZUAZ1QZwMhK835D3SXVfJxW2CwvtsX7
 tFaW7Ef9qpJCfyv1w15SvpE8oTxhlBVj0nZSGG74oW4+
X-Google-Smtp-Source: APXvYqwBYGN3LvLIlDrYVLevMIdDyqAr/MXO/xJ949o9JAIRUUt+mUwpWNu68ghiPz5R3lK2Rv9flXusuy8gjiuPzws=
X-Received: by 2002:a05:6830:1da:: with SMTP id
 r26mr10317466ota.186.1574418440137; 
 Fri, 22 Nov 2019 02:27:20 -0800 (PST)
MIME-Version: 1.0
From: karina filer <kafiler0911@gmail.com>
Date: Fri, 22 Nov 2019 15:57:07 +0530
Message-ID: <CAM+cExHMQQTxOHT7vmWNDTpGcoJZAbt-T=X+4WZBRwNzvFYqeg@mail.gmail.com>
Subject: QEMU Licensing query
To: qemu-devel@nongnu.org, quintela@redhat.com
Content-Type: multipart/alternative; boundary="000000000000da30540597ecdb46"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
X-Mailman-Approved-At: Fri, 22 Nov 2019 08:44:30 -0500
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

--000000000000da30540597ecdb46
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

--000000000000da30540597ecdb46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,</div><div><br></div><div><fo=
nt color=3D"#000000" face=3D"Times New Roman" size=3D"3">

</font><p style=3D"margin:0in 0in 0pt"><font color=3D"#000000" face=3D"Cali=
bri" size=3D"3"></font><br></p><font color=3D"#000000" face=3D"Times New Ro=
man" size=3D"3">

<font color=3D"#000000" face=3D"Calibri" size=3D"3"><font color=3D"#000000"=
 face=3D"Times New Roman" size=3D"3"><a href=3D"https://en.wikipedia.org/wi=
ki/QEMU"><font color=3D"#0563c1" face=3D"Calibri" size=3D"3">QEMU</font></a=
><font color=3D"#000000" face=3D"Calibri" size=3D"3"> is
used in Android Emulator and is licensed under </font><a title=3D"GNU Gener=
al Public License" href=3D"https://en.wikipedia.org/wiki/GNU_General_Public=
_License#Version_2"><span style=3D"background:rgb(248,249,250);color:rgb(11=
,0,128);font-family:&quot;Arial&quot;,sans-serif;font-size:9pt;text-decorat=
ion:none">GPLv2</span></a><font color=3D"#000000" face=3D"Calibri" size=3D"=
3">. </font></font><font color=3D"#000000" face=3D"Times New Roman" size=3D=
"3">

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

--000000000000da30540597ecdb46--

