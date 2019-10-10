Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A3C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F6920B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMMeXbVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F6920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIN82-0005ZG-IL
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIN6e-0004Il-0V
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIN6c-0007D3-Tw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:19:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iIN6c-0007CK-OA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:19:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id o44so3404362ota.10
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IZEb44kN9r9sFzaOE1JCasowxLKxar/foYi+90IiRww=;
 b=cMMeXbVmKQi4AayvNKgaOk9ftytCJF3+AGtzC0DyrKCoKOamfPD0IAJ4zLOkQnn+QH
 lat1wOLYJYC273xJ2qa4SqqyvJ0JnovgDkBwMeQWMhZFnqJ2hIx9riF61WIcX3Rv01k/
 v832XLUKC2/lOgU4TS6NCr5H5pdPK3HfbunqC+X9Kn3gOtVCgfOXXME7PuEIvG90hzqj
 u4wplars6D6K2+Dm6Rm3UkHMBDi5C6vvk4b5yyvH2jHO3Wwt/D2MI4wGoORIfYaW5L/r
 vFqID/TJyN4wotS5Fon/XXdz4sffj2oT89ECrJr7+1uhY/NeM0t5kDH2Ck7eO1vJnm8m
 UZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IZEb44kN9r9sFzaOE1JCasowxLKxar/foYi+90IiRww=;
 b=G9zCpo2zwTIFoA/tEhsSwD3T1L0E4AsqNntdZDm6JpiUz+MAzC7k6amLP5o+KKvG3J
 UIWgiqOC2SlnhgxmGJGLycP2drNtjgqr0uPC1eN6B0Vf8aoW20Is7iIe9U0MKNQUAuYI
 KIxHppyv63U1XdV497bHhMUh5UK/1Iat4QlaBdHdR+dtyuJkhZ6kfKKHyYQ9qAunaOlg
 KMoLllCeqIez7mUwopKDiB8sbIUD5nbMIkWfSC8FOh67/w+tRonoTziqURc0jp/Cc+5q
 dwIFEBbOCQdyEXEHBVjztP9Kpdp5xi5k4WU47OmzDvjQt5MHEqHk9n1iIXwSrMt7d02c
 CcLw==
X-Gm-Message-State: APjAAAVP3Go3BKkdEyaQLuRHU+OuzLlD911W4x118GtFcpV3ud0BSgpK
 UTd2/FKWtCkkgIyGVeRp8NQ1jIrE7vciBHgtAAQ=
X-Google-Smtp-Source: APXvYqyBg+OrluWqyG9e2zzxfrdnrD8xX49EFQ9/gt0SnCv0qodss4JoWAe1WycxSTXzJLSppVl+iL+IUKyV8wrImHg=
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr5120564otf.353.1570670341969; 
 Wed, 09 Oct 2019 18:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008143455.8524-1-philmd@redhat.com>
In-Reply-To: <20191008143455.8524-1-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:18:25 +0800
Message-ID: <CAKXe6SJZcmr=cTr6cV6bhGANtVwgjk44=tnET3bDe8X=jPKxMA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] hw/misc/vmcoreinfo: Add comment about reset handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cade350594842faf"
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cade350594842faf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:40=E5=86=99=E9=81=
=93=EF=BC=9A

> The VM coreinfo device does not sit on a bus, so it won't be
> reset automatically. This is why it calls qemu_register_reset().
>
> Add a comment about it, so we don't convert its reset handler
> to a DeviceReset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>

There are some other device-related code using 'qemu_register_reset'.
Maybe we can also add theses comment.

Thanks,
Li Qiang


> ---
>  hw/misc/vmcoreinfo.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index 326a3ce8f4..a9d718fc23 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -61,6 +61,10 @@ static void vmcoreinfo_realize(DeviceState *dev, Error
> **errp)
>                               NULL, fw_cfg_vmci_write, s,
>                               &s->vmcoreinfo, sizeof(s->vmcoreinfo),
> false);
>
> +    /*
> +     * This device requires to register a global reset because it is
> +     * not plugged to a bus (which, as its QOM parent, would reset it).
> +     */
>      qemu_register_reset(vmcoreinfo_reset, dev);
>      vmcoreinfo_state =3D s;
>  }
> --
> 2.21.0
>
>
>

--000000000000cade350594842faf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:40=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The VM coreinfo device does not sit on a bus, so it won&#39;t be<br>
reset automatically. This is why it calls qemu_register_reset().<br>
<br>
Add a comment about it, so we don&#39;t convert its reset handler<br>
to a DeviceReset method.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div>=
=C2=A0</div><div><br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto=
:liq3ea@gmail.com" target=3D"_blank">liq3ea@gmail.com</a>&gt;<br></div><div=
><br></div><div><div>There are some other device-related code using &#39;qe=
mu_register_reset&#39;.</div><div>Maybe we can also add theses comment.</di=
v><div><br></div><div></div></div><div>Thanks,</div><div>Li Qiang</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/misc/vmcoreinfo.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c<br>
index 326a3ce8f4..a9d718fc23 100644<br>
--- a/hw/misc/vmcoreinfo.c<br>
+++ b/hw/misc/vmcoreinfo.c<br>
@@ -61,6 +61,10 @@ static void vmcoreinfo_realize(DeviceState *dev, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, fw_cfg_vmci_write, s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;vmcoreinfo, sizeof(s-&gt;vmcorei=
nfo), false);<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* This device requires to register a global reset beca=
use it is<br>
+=C2=A0 =C2=A0 =C2=A0* not plugged to a bus (which, as its QOM parent, woul=
d reset it).<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(vmcoreinfo_reset, dev);<br>
=C2=A0 =C2=A0 =C2=A0vmcoreinfo_state =3D s;<br>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000cade350594842faf--

