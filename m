Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B242067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okAmlMoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B242067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUGt-0000De-Rk
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUGD-0008FN-SA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:24:53 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:45929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUGB-0007uk-UY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:24:53 -0400
Received: by mail-lj1-x22e.google.com with SMTP id w25so12755291ljo.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=t6mnzZNI/DL+O5sHYdHP+mDYgyknxyErrOwG6JSIAf8=;
 b=okAmlMozD/NFSzAFyCz9zqtxKGaDR1sq2RBl/DW3vpbuYXUAUbd+CZRANfJWR/SXk/
 5HQqarQ9cFVft3NN61gp92rlklAhWHJ9MyDxt3JnIceYLl0xV1vsoh/fQ8oKyOvD2gvN
 vfkQ+sdaq0Y4lOD95bZrwnEQepXDCuFo5VxROGbQO1uPnV1rDDTusbFAw4+9PFz4aNvT
 XfGcRjYD2MQ5I86jzDEWK7c5IfSQ04kp8P6TGb6S7CPcq7GkKiY0/7PD6JyiOZ/FxGW2
 AEW4BRclt/qLXqAMzHLSNDanUcKeLT5DaNtZaL5PeVhj1LWfpmYRyYvWIyH9mED+MUt8
 06iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=t6mnzZNI/DL+O5sHYdHP+mDYgyknxyErrOwG6JSIAf8=;
 b=bcdlH6SFQ82jI1vpOqH72V9dsGfKTDFacBGDRnwsLEMuK1m/hkrhAnZ71+UmOapJ46
 iowTwYaiXXlQ82ObWeFDDDSZTXrPbl5TJFKvvL4p3h3/JXRk2i+hPpdZQS0a2mzHzCuG
 g5KQB0SZOQ8Eho2cRZMiUPm4N3M3X+YkvFiLPpMLu8wr5KsJXezGuXOq7by2RpENEoEe
 jcmWmThbAPxnqj/+MSS6cF75kvBqYqJSAg5LPFJmcUaW7BU8iA6k7F3ORGXByV06901B
 kwxCMz2qBdDic0gyrzcvwrgyskTp9lkt18NsQF7xcPn9X5yVFbOjga4A31pPdxreygg7
 6Mxg==
X-Gm-Message-State: AOAM533/8kyctlVkVUtR3AXJuDsfyy+FTJR+yBbyV0yMZ+DlZ3GTPqaM
 x2H66XLXRAFldGtoTvWQvg3Yj5bqR922ZUHssaQ=
X-Google-Smtp-Source: ABdhPJzl8JlY2u3NiHZmp2KvoKTIsUKW2/jHDrZbIBEh4rnWiapLeB9Us7iocItxbjaRglRbh0CNOur+opRI0IIvLpg=
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr3999569lji.300.1598343889451; 
 Tue, 25 Aug 2020 01:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
 <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
In-Reply-To: <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 16:24:39 +0800
Message-ID: <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c27fdc05adaf6f74"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c27fdc05adaf6f74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo Bonzini,
I've already sent a series of fixes for msys, do you have a look at that?


On Tue, Aug 25, 2020 at 3:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Great, thanks! Can you send it as a patch? I am collecting Meson fixes an=
d
> I should be able to send a pull request this week.
>
> Also if you can please test the msys fixes that were sent on the list tha=
t
> would be great.
>
> Paolo
>
> Il mar 25 ago 2020, 09:52 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk=
>
> ha scritto:
>
>> On 24/08/2020 12:37, Gerd Hoffmann wrote:
>>
>> >> 2) GTK UI now depends on CONFIG_VTE
>> >>
>> >> This one I spotted on my local Linux setup as I didn't have the
>> libvte-dev package
>> >> installed and couldn't understand why I couldn't run QEMU with the GT=
K
>> UI as I always
>> >> do, even though configure reported that it found the GTK library and
>> headers.
>> >>
>> >> A quick search showed that the GTK UI was being guarded by "if
>> >> config_host.has_key('CONFIG_GTK') and
>> config_host.has_key('CONFIG_VTE')" in
>> >> ui/meson.build.
>> >
>> > That is not correct.  vte is intentionally not a hard dependency ...
>> >
>> >> For me the easy solution was to install libvte-dev, but since there
>> are no VTE
>> >> packages for Windows my guess is this will now make the GTK UI
>> unavailable for
>> >> Windows users.
>> >
>> > .. because we don't have that on windows.
>> >
>> > I think simply dropping the "and config_host.has_key('CONFIG_VTE')"
>> > should work, can you try that?
>>
>> Hi Gerd,
>>
>> I can't get the native Windows build to complete yet, however I've
>> removed the
>> libvte-dev headers again on my Linux setup and confirmed that GTK works
>> once again
>> with the below diff:
>>
>> diff --git a/ui/meson.build b/ui/meson.build
>> index 81fd393432..cc71f51f37 100644
>> --- a/ui/meson.build
>> +++ b/ui/meson.build
>> @@ -42,7 +42,7 @@ if config_host.has_key('CONFIG_CURSES')
>>    ui_modules +=3D {'curses' : curses_ss}
>>  endif
>>
>> -if config_host.has_key('CONFIG_GTK') and
>> config_host.has_key('CONFIG_VTE')
>> +if config_host.has_key('CONFIG_GTK')
>>    softmmu_ss.add(when: 'CONFIG_WIN32', if_true:
>> files('win32-kbd-hook.c'))
>>
>>    gtk_ss =3D ss.source_set()
>>
>>
>> ATB,
>>
>> Mark.
>>
>>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c27fdc05adaf6f74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Paolo Bonzini,</div>I&#39;ve already sent a series=
 of fixes for msys, do you have a look at that?<div><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 2=
5, 2020 at 3:55 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com"=
>pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"auto">Great, thanks! Can you send it as a p=
atch? I am collecting Meson fixes and I should be able to send a pull reque=
st this week.<div dir=3D"auto"><br></div><div dir=3D"auto">Also if you can =
please test the msys fixes that were sent on the list that would be great.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 25 ago=
 2020, 09:52 Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande=
.co.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt; ha scritto:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 24/08/2020 1=
2:37, Gerd Hoffmann wrote:<br>
<br>
&gt;&gt; 2) GTK UI now depends on CONFIG_VTE<br>
&gt;&gt;<br>
&gt;&gt; This one I spotted on my local Linux setup as I didn&#39;t have th=
e libvte-dev package<br>
&gt;&gt; installed and couldn&#39;t understand why I couldn&#39;t run QEMU =
with the GTK UI as I always<br>
&gt;&gt; do, even though configure reported that it found the GTK library a=
nd headers.<br>
&gt;&gt;<br>
&gt;&gt; A quick search showed that the GTK UI was being guarded by &quot;i=
f<br>
&gt;&gt; config_host.has_key(&#39;CONFIG_GTK&#39;) and config_host.has_key(=
&#39;CONFIG_VTE&#39;)&quot; in<br>
&gt;&gt; ui/meson.build.<br>
&gt; <br>
&gt; That is not correct.=C2=A0 vte is intentionally not a hard dependency =
...<br>
&gt; <br>
&gt;&gt; For me the easy solution was to install libvte-dev, but since ther=
e are no VTE<br>
&gt;&gt; packages for Windows my guess is this will now make the GTK UI una=
vailable for<br>
&gt;&gt; Windows users.<br>
&gt; <br>
&gt; .. because we don&#39;t have that on windows.<br>
&gt; <br>
&gt; I think simply dropping the &quot;and config_host.has_key(&#39;CONFIG_=
VTE&#39;)&quot;<br>
&gt; should work, can you try that?<br>
<br>
Hi Gerd,<br>
<br>
I can&#39;t get the native Windows build to complete yet, however I&#39;ve =
removed the<br>
libvte-dev headers again on my Linux setup and confirmed that GTK works onc=
e again<br>
with the below diff:<br>
<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index 81fd393432..cc71f51f37 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -42,7 +42,7 @@ if config_host.has_key(&#39;CONFIG_CURSES&#39;)<br>
=C2=A0 =C2=A0ui_modules +=3D {&#39;curses&#39; : curses_ss}<br>
=C2=A0endif<br>
<br>
-if config_host.has_key(&#39;CONFIG_GTK&#39;) and config_host.has_key(&#39;=
CONFIG_VTE&#39;)<br>
+if config_host.has_key(&#39;CONFIG_GTK&#39;)<br>
=C2=A0 =C2=A0softmmu_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#=
39;win32-kbd-hook.c&#39;))<br>
<br>
=C2=A0 =C2=A0gtk_ss =3D ss.source_set()<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000c27fdc05adaf6f74--

