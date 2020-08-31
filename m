Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64632083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64632083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCm47-0007Q6-Pl
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3E-0005ls-UN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:48:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3C-0003KS-Q0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:48:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so5899316eds.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N+X/wmQC+7K4PmT7jzfXwludCepH5h+IUzgUzsrhZG0=;
 b=khbNzEloGZJe7kjnc4ztrZDd33HuAZYwUTFIcf4xcTywdmnOnm7CqRih6QI1tobwdb
 dkLN4/3NIFuE1bcJiteRZGlNJyiQGqfe0lBUieRthXsTH+Z27pf7i1QwmUfc/UDRB9fp
 lIzlcOo//Eg92H1bG6NoxeI5QStGVPlroHEo/uwWfWPgdrmPwBMR/7swjpgTYOqAbNTd
 +BUiB0jlr2jeFXGMIHiOfqYjG2kDukxbI4SSyF67l8zbRmZAdv1kdDKiqeqP/q8oCN5+
 XE5i0LZhb+WhCgFZKBqxfQlG6BFpc8tDPYg1AcBdz6AGPvI5j+JsO7NGvgtKOOxaAiAv
 /fSQ==
X-Gm-Message-State: AOAM531LK7xzX+krZwV5xypcJi67k1HIp743EbnwJJfXZSSZh+O51nXa
 IFf2Pxuzy2aCYM+NVx7vGV3goUYiAAXXRLTJ9l4=
X-Google-Smtp-Source: ABdhPJwnviLB4zwydvAR0O51uU8voi1DBR41zL3KF4jHyvX/2Wx0ZhL5U5fnPcbsoRxY6nX38DCeAe8d/FZYw6ZkqGs=
X-Received: by 2002:a05:6402:15:: with SMTP id
 d21mr1843205edu.324.1598888933510; 
 Mon, 31 Aug 2020 08:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200830154539.240902-1-pbonzini@redhat.com>
In-Reply-To: <20200830154539.240902-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 17:46:52 +0200
Message-ID: <CAAdtpL7uBZ-kk+qeo7xAiWOw5J_3UGbFw9x4mBaTqqMdLKknuw@mail.gmail.com>
Subject: Re: [PATCH] meson: add pixman dependency to UI modules
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ead31605ae2e5647"
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:48:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ead31605ae2e5647
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 30 ao=C3=BBt 2020 17:46, Paolo Bonzini <pbonzini@redhat.com> a =C3=
=A9crit :

> Pixman used to be included directly in QEMU_CFLAGS and therefore the
> include path was added to every compiler invocation.  Now that (just
> like basically everything else) it is a separate dependency, we
> need to add it to all build target, especially UI modules that need
> it due to their including ui/console.h.
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  ui/meson.build | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ui/meson.build b/ui/meson.build
> index aa8aa31516..82f60756d9 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -40,7 +40,7 @@ ui_modules =3D {}
>
>  if config_host.has_key('CONFIG_CURSES')
>    curses_ss =3D ss.source_set()
> -  curses_ss.add(when: [curses, iconv], if_true: files('curses.c'))
> +  curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'),
> pixman])
>    ui_modules +=3D {'curses' : curses_ss}
>  endif
>
> @@ -48,7 +48,7 @@ if config_host.has_key('CONFIG_GTK')
>    softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'=
))
>
>    gtk_ss =3D ss.source_set()
> -  gtk_ss.add(gtk, vte, files('gtk.c'))
> +  gtk_ss.add(gtk, vte, pixman, files('gtk.c'))
>    gtk_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
>    gtk_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('gtk-egl.c'=
))
>    gtk_ss.add(when: [opengl, 'CONFIG_GTK_GL'], if_true:
> files('gtk-gl-area.c'))
> @@ -71,7 +71,7 @@ endif
>
>  if config_host.has_key('CONFIG_SPICE') and
> config_host.has_key('CONFIG_GIO')
>    spice_ss =3D ss.source_set()
> -  spice_ss.add(spice, gio, files('spice-app.c'))
> +  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
>    ui_modules +=3D {'spice-app': spice_ss}
>  endif
>
> --
> 2.26.2
>
>
>

--000000000000ead31605ae2e5647
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le dim. 30 ao=C3=BBt 2020 17:46, Paolo Bonzini &lt;<a =
href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a =C3=A9cri=
t=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Pixman used to be included=
 directly in QEMU_CFLAGS and therefore the<br>
include path was added to every compiler invocation.=C2=A0 Now that (just<b=
r>
like basically everything else) it is a separate dependency, we<br>
need to add it to all build target, especially UI modules that need<br>
it due to their including ui/console.h.<br>
<br>
Reported-by: Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_b=
lank" rel=3D"noreferrer">sw@weilnetz.de</a>&gt;<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D=
"font-family:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-D=
aud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decor=
ation:none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px"=
>f4bug@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.696p=
x">&gt;</span><br></div><div dir=3D"auto"><span style=3D"font-family:sans-s=
erif;font-size:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0ui/meson.build | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/meson.build b/ui/meson.build<br>
index aa8aa31516..82f60756d9 100644<br>
--- a/ui/meson.build<br>
+++ b/ui/meson.build<br>
@@ -40,7 +40,7 @@ ui_modules =3D {}<br>
<br>
=C2=A0if config_host.has_key(&#39;CONFIG_CURSES&#39;)<br>
=C2=A0 =C2=A0curses_ss =3D ss.source_set()<br>
-=C2=A0 curses_ss.add(when: [curses, iconv], if_true: files(&#39;curses.c&#=
39;))<br>
+=C2=A0 curses_ss.add(when: [curses, iconv], if_true: [files(&#39;curses.c&=
#39;), pixman])<br>
=C2=A0 =C2=A0ui_modules +=3D {&#39;curses&#39; : curses_ss}<br>
=C2=A0endif<br>
<br>
@@ -48,7 +48,7 @@ if config_host.has_key(&#39;CONFIG_GTK&#39;)<br>
=C2=A0 =C2=A0softmmu_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#=
39;win32-kbd-hook.c&#39;))<br>
<br>
=C2=A0 =C2=A0gtk_ss =3D ss.source_set()<br>
-=C2=A0 gtk_ss.add(gtk, vte, files(&#39;gtk.c&#39;))<br>
+=C2=A0 gtk_ss.add(gtk, vte, pixman, files(&#39;gtk.c&#39;))<br>
=C2=A0 =C2=A0gtk_ss.add(when: [x11, &#39;CONFIG_X11&#39;], if_true: files(&=
#39;x_keymap.c&#39;))<br>
=C2=A0 =C2=A0gtk_ss.add(when: [opengl, &#39;CONFIG_OPENGL&#39;], if_true: f=
iles(&#39;gtk-egl.c&#39;))<br>
=C2=A0 =C2=A0gtk_ss.add(when: [opengl, &#39;CONFIG_GTK_GL&#39;], if_true: f=
iles(&#39;gtk-gl-area.c&#39;))<br>
@@ -71,7 +71,7 @@ endif<br>
<br>
=C2=A0if config_host.has_key(&#39;CONFIG_SPICE&#39;) and config_host.has_ke=
y(&#39;CONFIG_GIO&#39;)<br>
=C2=A0 =C2=A0spice_ss =3D ss.source_set()<br>
-=C2=A0 spice_ss.add(spice, gio, files(&#39;spice-app.c&#39;))<br>
+=C2=A0 spice_ss.add(spice, gio, pixman, files(&#39;spice-app.c&#39;))<br>
=C2=A0 =C2=A0ui_modules +=3D {&#39;spice-app&#39;: spice_ss}<br>
=C2=A0endif<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000ead31605ae2e5647--

