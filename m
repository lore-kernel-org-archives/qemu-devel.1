Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0642071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL4/Ph0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0642071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAToE-0006vI-GW
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATnH-0006Lq-EW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:54:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATnF-0004a1-JJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598342096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxO8BLNucCc+Hw3R1NGMbFMxNrKO+OnFHTtkNr7QtgY=;
 b=XL4/Ph0OKP8JEdf3/nvP/IVzPmZlSV7HeEsXOtIEsOfjTY/uRwFcXbqMo/MnpZvIk0Qoty
 3U/dKBUiBMexn6VGArA+bEaj6xRkOLVEbkCHZse4LWRraKcnWO3L1GmprOZvtg48a2RZcw
 cvVIIY6MjxReIewQ+0gq2kotv+R13EI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-bEX2DJ9tM2mDMxbzIHmcdw-1; Tue, 25 Aug 2020 03:54:53 -0400
X-MC-Unique: bEX2DJ9tM2mDMxbzIHmcdw-1
Received: by mail-ed1-f72.google.com with SMTP id m25so2780848eds.16
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VxO8BLNucCc+Hw3R1NGMbFMxNrKO+OnFHTtkNr7QtgY=;
 b=TalcSUwIV7eO2HDNj9gCYERSIejTeeE0cqSHeajuJ+3JHuFkwSu1aqBjNo/aF6euBU
 SrXoSdK1TzMeQdRvWFLUn7L4vga5SEtXxOZXm9y0jyzTcA+hW5U+cubmxfC6mB3KMiCs
 FOhz5O2RpruhO4/SgqxJw0OsU4wolfJHnJjYsXh8h++Nw0ly8RMeoP1OOlEHPmkwRD+e
 bRseGem8lLdLDxOs6sqL65pxYKMI+XJRGieDOMKrjyx9KUTRf8TISx3EOFgbiUGq2zp1
 u+Q4HQ1vgB0a5T6bTWeYNAtsmeQmuVfqjsgkPuP19UquRvSfZFaCE1enGOrnqM/f9gHr
 mo2Q==
X-Gm-Message-State: AOAM530Jge8oT/NekUmBNgpAAQ9etsSLtYflxD+p8CBWGruBTNxA3jR9
 G3uajUTdzY1E0cZKGFKdWyuwfOtirHrGg+ZKIKkAPDXynd4SrZRcOV8TPooWUBjGDqi5Xh1gmDr
 bS36Fqvv7b/XhvLTHAb3KryFgOaejf58=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr9586034ejw.71.1598342092606; 
 Tue, 25 Aug 2020 00:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq0Ye/I7A823gj3PRxNLWJJwea98Fdoq0KDoGUIkBtM5TFdgjdIJLbLO+Sz4lBA9lFxSWlh9BydcXYI/dVEfs=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr9586019ejw.71.1598342092394; 
 Tue, 25 Aug 2020 00:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
In-Reply-To: <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:54:41 +0200
Message-ID: <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a5ac4005adaf0423"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a5ac4005adaf0423
Content-Type: text/plain; charset="UTF-8"

Great, thanks! Can you send it as a patch? I am collecting Meson fixes and
I should be able to send a pull request this week.

Also if you can please test the msys fixes that were sent on the list that
would be great.

Paolo

Il mar 25 ago 2020, 09:52 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> On 24/08/2020 12:37, Gerd Hoffmann wrote:
>
> >> 2) GTK UI now depends on CONFIG_VTE
> >>
> >> This one I spotted on my local Linux setup as I didn't have the
> libvte-dev package
> >> installed and couldn't understand why I couldn't run QEMU with the GTK
> UI as I always
> >> do, even though configure reported that it found the GTK library and
> headers.
> >>
> >> A quick search showed that the GTK UI was being guarded by "if
> >> config_host.has_key('CONFIG_GTK') and
> config_host.has_key('CONFIG_VTE')" in
> >> ui/meson.build.
> >
> > That is not correct.  vte is intentionally not a hard dependency ...
> >
> >> For me the easy solution was to install libvte-dev, but since there are
> no VTE
> >> packages for Windows my guess is this will now make the GTK UI
> unavailable for
> >> Windows users.
> >
> > .. because we don't have that on windows.
> >
> > I think simply dropping the "and config_host.has_key('CONFIG_VTE')"
> > should work, can you try that?
>
> Hi Gerd,
>
> I can't get the native Windows build to complete yet, however I've removed
> the
> libvte-dev headers again on my Linux setup and confirmed that GTK works
> once again
> with the below diff:
>
> diff --git a/ui/meson.build b/ui/meson.build
> index 81fd393432..cc71f51f37 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -42,7 +42,7 @@ if config_host.has_key('CONFIG_CURSES')
>    ui_modules += {'curses' : curses_ss}
>  endif
>
> -if config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')
> +if config_host.has_key('CONFIG_GTK')
>    softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
>
>    gtk_ss = ss.source_set()
>
>
> ATB,
>
> Mark.
>
>

--000000000000a5ac4005adaf0423
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Great, thanks! Can you send it as a patch? I am collectin=
g Meson fixes and I should be able to send a pull request this week.<div di=
r=3D"auto"><br></div><div dir=3D"auto">Also if you can please test the msys=
 fixes that were sent on the list that would be great.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 25 ago 2020, 09:52 Mark Ca=
ve-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ay=
land@ilande.co.uk</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On 24/08/2020 12:37, Gerd Hoffmann wrote:<br>
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

--000000000000a5ac4005adaf0423--


