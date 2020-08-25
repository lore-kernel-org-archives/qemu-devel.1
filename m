Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F56C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558262065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTy3Uhil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558262065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUcd-0008Hy-Gc
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUSQ-0003De-Ix
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:37:30 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130]:34342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUSN-000191-4u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:37:30 -0400
Received: by mail-lf1-x130.google.com with SMTP id d2so5971228lfj.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=7PK68tLJ3YYsROnPRvKslDvwC89TMsaWH5AyvvlU1F0=;
 b=CTy3Uhilf052p47Nj8fy83j0fuEv/wy3EhN/Gb0xh4+iQW2zn03j0/XbcHkJeDYXl7
 D5bMFyTn8cbxTTRkl2zf7HCf56kc0WtjRn/5sAoi0dccILYI+A2W3EZVzAgZsWHWdMOC
 8xqDBcxVp0FsTGzHH8W3xT3hPmN8IfZVbJ7HgW9wNNManuVUUHfwxM1IF8HNTW6Vy6Me
 3JU4lnCgx6WLcjZOY/jZ9QwF+Iula/KjV3uliyCOVWll5ivo3y3qQHlnlKltm0VaC4Pl
 h9zFtckfu0SPEzNFiRIpCe6XEScdSA3FyiyrdU0unjXxsha3gDHQPnRBvo1ZL51LdGGX
 xSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=7PK68tLJ3YYsROnPRvKslDvwC89TMsaWH5AyvvlU1F0=;
 b=Av/QdLl5fzqmOAhD03zg3zh3O7Q94Xp9yi3pBygabR+3eb/84aSj68UXlJQnR2BovB
 Onx/6QP32Vo/Qvdx1s4gvH15T2Ku4psIR6xiCMmln12LQnC6wQHQeWVn/6A7nJb9y+BU
 i4xD6t6KkZYeui0em9Upuxc9kdh26wTCWzGd+8w7RNrvCeZU/eyzhMJ4q9h+WdDnYYfw
 7ZdrJw+W2ZYe3UQ3gxcXYbAdO5kvrG1KeWwksoBaez3906U9r6991+wgHZosnQdNMG27
 G/hFPf89vjDemIo1JLsyZAnpCODUAvJMXF6cby3G7b1VasciYd7upd1SErW/xWZOBysF
 wBQQ==
X-Gm-Message-State: AOAM531XkfOvrYK5CN+XWM8YnY0nNt5mp5YdJFgivovM4glksZauid4O
 udBptQG8tHmj1+iGsq5anRvjShaxZ91uxE5GMVI=
X-Google-Smtp-Source: ABdhPJwT1Vtge4a+4JX8MIozV00Qg+j9xbY8ppjDKEP6U9kmJHu1eSH0tH3P06attMZpIaOWzXOgVNDnsxRsT2sDCpE=
X-Received: by 2002:ac2:592d:: with SMTP id v13mr604845lfi.213.1598344644980; 
 Tue, 25 Aug 2020 01:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
 <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
 <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
 <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
In-Reply-To: <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 16:37:14 +0800
Message-ID: <CAE2XoE81v1aV+e=UEffPdSwtq_bbxtTx_56Eg06jU8+U-6zNYA@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000caf3ec05adaf9c7b"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x130.google.com
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

--000000000000caf3ec05adaf9c7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I resend the patches in consecutive ways.
and for througfully fixes msys2 build, we need upstream meson pull request
https://github.com/mesonbuild/meson/pull/7637

On Tue, Aug 25, 2020 at 4:34 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> I saw it, thanks. I would like to have someone else (like Mark) test it
> and then I will include it.
>
> Paolo
>
> Il mar 25 ago 2020, 10:24 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoy=
onggang@gmail.com> ha
> scritto:
>
>> Hi Paolo Bonzini,
>> I've already sent a series of fixes for msys, do you have a look at that=
?
>>
>>
>> On Tue, Aug 25, 2020 at 3:55 PM Paolo Bonzini <pbonzini@redhat.com>
>> wrote:
>>
>>> Great, thanks! Can you send it as a patch? I am collecting Meson fixes
>>> and I should be able to send a pull request this week.
>>>
>>> Also if you can please test the msys fixes that were sent on the list
>>> that would be great.
>>>
>>> Paolo
>>>
>>> Il mar 25 ago 2020, 09:52 Mark Cave-Ayland <
>>> mark.cave-ayland@ilande.co.uk> ha scritto:
>>>
>>>> On 24/08/2020 12:37, Gerd Hoffmann wrote:
>>>>
>>>> >> 2) GTK UI now depends on CONFIG_VTE
>>>> >>
>>>> >> This one I spotted on my local Linux setup as I didn't have the
>>>> libvte-dev package
>>>> >> installed and couldn't understand why I couldn't run QEMU with the
>>>> GTK UI as I always
>>>> >> do, even though configure reported that it found the GTK library an=
d
>>>> headers.
>>>> >>
>>>> >> A quick search showed that the GTK UI was being guarded by "if
>>>> >> config_host.has_key('CONFIG_GTK') and
>>>> config_host.has_key('CONFIG_VTE')" in
>>>> >> ui/meson.build.
>>>> >
>>>> > That is not correct.  vte is intentionally not a hard dependency ...
>>>> >
>>>> >> For me the easy solution was to install libvte-dev, but since there
>>>> are no VTE
>>>> >> packages for Windows my guess is this will now make the GTK UI
>>>> unavailable for
>>>> >> Windows users.
>>>> >
>>>> > .. because we don't have that on windows.
>>>> >
>>>> > I think simply dropping the "and config_host.has_key('CONFIG_VTE')"
>>>> > should work, can you try that?
>>>>
>>>> Hi Gerd,
>>>>
>>>> I can't get the native Windows build to complete yet, however I've
>>>> removed the
>>>> libvte-dev headers again on my Linux setup and confirmed that GTK work=
s
>>>> once again
>>>> with the below diff:
>>>>
>>>> diff --git a/ui/meson.build b/ui/meson.build
>>>> index 81fd393432..cc71f51f37 100644
>>>> --- a/ui/meson.build
>>>> +++ b/ui/meson.build
>>>> @@ -42,7 +42,7 @@ if config_host.has_key('CONFIG_CURSES')
>>>>    ui_modules +=3D {'curses' : curses_ss}
>>>>  endif
>>>>
>>>> -if config_host.has_key('CONFIG_GTK') and
>>>> config_host.has_key('CONFIG_VTE')
>>>> +if config_host.has_key('CONFIG_GTK')
>>>>    softmmu_ss.add(when: 'CONFIG_WIN32', if_true:
>>>> files('win32-kbd-hook.c'))
>>>>
>>>>    gtk_ss =3D ss.source_set()
>>>>
>>>>
>>>> ATB,
>>>>
>>>> Mark.
>>>>
>>>>
>>
>> --
>>          =E6=AD=A4=E8=87=B4
>> =E7=A4=BC
>> =E7=BD=97=E5=8B=87=E5=88=9A
>> Yours
>>     sincerely,
>> Yonggang Luo
>>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000caf3ec05adaf9c7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, I resend the patches in consecutive ways.<div>and for =
througfully fixes msys2 build, we need upstream meson pull request</div><di=
v><a href=3D"https://github.com/mesonbuild/meson/pull/7637">https://github.=
com/mesonbuild/meson/pull/7637</a>=C2=A0=C2=A0<br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 202=
0 at 4:34 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonz=
ini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"auto">I saw it, thanks. I would like to have some=
one else (like Mark) test it and then I will include it.<div dir=3D"auto"><=
br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Il mar 25 ago 2020, 10:24 =E7=BD=97=
=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Pao=
lo Bonzini,</div>I&#39;ve already sent a series of fixes for msys, do you h=
ave a look at that?<div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 3:55 PM Paolo Bon=
zini &lt;<a href=3D"mailto:pbonzini@redhat.com" rel=3D"noreferrer" target=
=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"auto">Great, thanks! Can you s=
end it as a patch? I am collecting Meson fixes and I should be able to send=
 a pull request this week.<div dir=3D"auto"><br></div><div dir=3D"auto">Als=
o if you can please test the msys fixes that were sent on the list that wou=
ld be great.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
Il mar 25 ago 2020, 09:52 Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-=
ayland@ilande.co.uk" rel=3D"noreferrer" target=3D"_blank">mark.cave-ayland@=
ilande.co.uk</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 24/08/2020 12:37, Gerd Hoffmann wrote:<br>
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
>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div>
</blockquote></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000caf3ec05adaf9c7b--

