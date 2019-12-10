Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD52220663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgH0w3n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD52220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieowl-0001tW-3I
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 18:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieovo-0001Tg-AR
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieovm-0003n1-Mv
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:28:39 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieovm-0003ln-Fm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:28:38 -0500
Received: by mail-oi1-x243.google.com with SMTP id 6so11537780oix.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=95ojAfAY/s+L3jbquXMRN+qhJYsl03UMSDfZTvKAp/c=;
 b=rgH0w3n2Mnq87py/fqFWIQ3UYrrCP+wuk5cGxOQt68t/haa7R6rKPNbq1U215tSGZe
 jhOf+h1bF/7NufF2x6qNu2quCuQVOtnXKsiTP8PR5fSMngYAmZpLr6ZS47SAQaNHO9Uc
 rHX5jyTFXZm4F79Pzdr2VOgEqcIq2jhoAnn3oLX72QeOsmKF4QKcm5fEOXnZUR1qFnpM
 rWQjTeayEfHm3sp3Ns1Ot1X/gXGja3thsSrCpry9H9MUUbHwYYiOeaPNJXBKvOlNC/ib
 VPO6l7zskvyhFwEEuUxso8LMaFSoouIOCtPcqqwLUrhTlV1ZgQwzaH1Wh//p34M0aYrY
 XhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=95ojAfAY/s+L3jbquXMRN+qhJYsl03UMSDfZTvKAp/c=;
 b=fwAIYSLinxVwdhJuOe3Ysr4GzYSxmQCXHce0s/tqq7f3rbiFSfux/AS7isesQ4UCaW
 I9v+1a7+TbdU8t30Zu/I0HrhqaBfsS2+s2cz5V55+PaAugkqu1Ol0U4PQFzgLkFuEMnf
 p9kV4EjYX4fYUNjvPk5iBtCTOa4cMqOmWiJA1X/uIws58EeOrLN+jF6dpW5ct5D3j1LZ
 h+yPI4Nw/ltadCfOdTKa4IKBvEslwVA8zfKB9Mkw7mGO5TdYkAMWHLZUq1p88+JIcqgt
 smy017iPkyYbFa96EGSmu2p0/gUQ6GfaRubWh5rSyc7NkmuSQdBwy8ZFOw496XW5pBmi
 WOHA==
X-Gm-Message-State: APjAAAXu1cGFGalUm4snj1pgnD6RSvnP9Dsoicz4U7Ew0Yh/YaRPmLUn
 nfnMRCUZ2whIBdybkEjlQG/aa2dyv+AUkWhW66M=
X-Google-Smtp-Source: APXvYqwgzZnyJAvWv3qUHjNGFj0+5tQZ0fA4AuVfpnbSc2uYmeXB5PkQAofOXjzcVEPC3bK4Skbx6EOlHfBKMRIPcC0=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr489296oif.53.1576020517559; 
 Tue, 10 Dec 2019 15:28:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 10 Dec 2019 15:28:37 -0800 (PST)
In-Reply-To: <61e67881-55fd-faf3-3112-31a525106465@redhat.com>
References: <cover.1576013209.git.dirty@apple.com>
 <d6c26e68db134c7b0c7ce8b61596ca2e65e01e12.1576013209.git.dirty@apple.com>
 <61e67881-55fd-faf3-3112-31a525106465@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 11 Dec 2019 00:28:37 +0100
Message-ID: <CAL1e-=hsLfJKFgOewTFbhUtTO5QMDtUdAT+vDu-fJy=wCsrAyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] display/bochs-display: fix memory leak
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001ba374059961dfc1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001ba374059961dfc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 11, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 12/10/19 10:27 PM, Cameron Esfahani via wrote:
>
>> Fix memory leak in bochs_display_update().  Leaks 304 bytes per frame.
>>
>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>>
>
> Funny to have a dirty@ email fixing a DirtyBitmapSnapshot leak =3D)
>
> Fixes: 33ebad54056


Dirty fixing bad in a snap. What a fix. :-o


> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> ---
>>   hw/display/bochs-display.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
>> index dc1bd1641d..215db9a231 100644
>> --- a/hw/display/bochs-display.c
>> +++ b/hw/display/bochs-display.c
>> @@ -252,6 +252,8 @@ static void bochs_display_update(void *opaque)
>>               dpy_gfx_update(s->con, 0, ys,
>>                              mode.width, y - ys);
>>           }
>> +
>> +        g_free(snap);
>>       }
>>   }
>>
>>
>
>
>

--0000000000001ba374059961dfc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, December 11, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On 12/10/19 10:27 PM, Cameron Esfahani via wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Fix memory leak in bochs_display_update().=C2=A0 Leaks 304 bytes per frame.=
<br>
<br>
Signed-off-by: Cameron Esfahani &lt;<a href=3D"mailto:dirty@apple.com" targ=
et=3D"_blank">dirty@apple.com</a>&gt;<br>
</blockquote>
<br>
Funny to have a dirty@ email fixing a DirtyBitmapSnapshot leak =3D)<br>
<br>
Fixes: 33ebad54056</blockquote><div><br></div><div>Dirty fixing bad in a sn=
ap. What a fix. :-o</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=C2=A0 hw/display/bochs-display.c | 2 ++<br>
=C2=A0 1 file changed, 2 insertions(+)<br>
<br>
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c<br>
index dc1bd1641d..215db9a231 100644<br>
--- a/hw/display/bochs-display.c<br>
+++ b/hw/display/bochs-display.c<br>
@@ -252,6 +252,8 @@ static void bochs_display_update(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update(s-&gt;con, =
0, ys,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode.width, y - ys);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(snap);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 }<br>
=C2=A0 <br>
</blockquote>
<br>
<br>
</blockquote>

--0000000000001ba374059961dfc1--

