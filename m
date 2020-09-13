Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B2FC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC98C221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7tDsmKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC98C221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUgf-0001ve-Tw
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUg3-0001Qk-4w; Sun, 13 Sep 2020 12:16:31 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:37731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUg0-0002yB-RH; Sun, 13 Sep 2020 12:16:30 -0400
Received: by mail-lj1-x22e.google.com with SMTP id n25so16522520ljj.4;
 Sun, 13 Sep 2020 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=1F+p81rdEl0vWfGhhgCv+uqvTJ5n9egWHk0hYOIJ8NE=;
 b=h7tDsmKAP6EFPKOEA7W3gFMooKHXz7Sqy6zAFhC4tEfHCFzoCU4vIipTWXPvJ6RhFz
 pJTUlZPMX/DCt1Wfm8gfIEU5xeNncQRsUh3hooacLsn8SJlH1Ieoad/TlX4I8aqKtCsI
 zrR6umwROJCBwqVsrUubRb0fgEt+dHh8Hx3w8aQu0r0HeMseFjSRtJ8e58v7x6guhOsU
 O7edKb5vNFL6xJmPM0LmGdJKa2YVO4fYyMNG65pU6JAbNBLjNyFkzoiY28TtF7AZ7BJ9
 3y1+cNnPtvT7NNoMrRMrnOfJXJX608lazKgS2S2ea9X1HuRL8T06yuvExowHa5BFdFLA
 izqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=1F+p81rdEl0vWfGhhgCv+uqvTJ5n9egWHk0hYOIJ8NE=;
 b=bc6H7eYK1uDmC3LJfXZIUAXnszhQGg2FZm+TI5sI1puCOFqPBZPVipimv/7fnDWDjM
 lWV8vA4j0tFnuypTdM+TSolUKvj3AT9J2Qv3j5iJ6jl6BmHJt5RdmDmYtlHIgmg+6sOf
 1pgC4FWAjPmcXswnZ9U0VZoCx3+hJ8UmhHa1HvEpGYqnkOZHgLtM04t19klDKXIDmzfA
 eAHwqUKY+UWU/W39QztoZ7ryUrCIeIu8cZ+L1/ylSfp8zwDZxAssv1YpBOdJmopuM8sy
 LIMWb9uh3EwFa1ssbcWtRwY5g1YhR5i0lsc9OQuGkRDuLxIxc8DE4+cQQvDVPmwm0187
 iQsQ==
X-Gm-Message-State: AOAM532XVUVZcIj+I+OkZZSvBoFpuqJusyMS8hA9dF8qy/k2LE3JgrKc
 Z1TyXR+Uxg805ig8yYcFgoi7KDF7iBse4Y7T6Uk=
X-Google-Smtp-Source: ABdhPJyyd+khojC1EV2k8H0GFvt5dXkrrP6H28nrXn6QbprEBRzZz+NOqhxPbyu3VsAOpkZCS1oeEkp6fWSO/7wkGjw=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr3751159ljj.120.1600013786699; 
 Sun, 13 Sep 2020 09:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
 <CAE2XoE9GEB2svRZVJVWxc4uC1afv9hEvij0G8Xxygw_Xk4DxXw@mail.gmail.com>
 <404087db-7710-653b-da39-f47d4d4b26da@redhat.com>
In-Reply-To: <404087db-7710-653b-da39-f47d4d4b26da@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 00:16:15 +0800
Message-ID: <CAE2XoE_pSYzeaObV9a52_MwNBr91_rbnatnY9k0iJ2Ly9RXuVA@mail.gmail.com>
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000645d0805af343dd7"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000645d0805af343dd7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 12:12 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 13/09/20 18:03, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> > _WIN32 are more precise and only depends on the compiler, on the
> > other hand, CONFIG_POSIX  and  CONFIG_WIN32  need configure
> > scripts. I prefer  _WIN32  unless the compiler can not provide enough
> > information.
>
> That's not what the QEMU coding standards say; we generally don't test
> the preprocessor symbols.  If we were to change to _WIN32, it should be
> done at once on the whole codebase (don't do it :)).>
>

  CONFIG_WIN32  are rarely used, most of the are using _WIN32

Search CONFIG_WIN32
```

> 36 results - 20 files
>
> configure:
>   6511  if test "$mingw32" =3D "yes" ; then
>   6512:   echo "CONFIG_WIN32=3Dy" >> $config_host_mak
>   6513    rc_version=3D$(cat $source_path/VERSION)
>
> Makefile:
>   274   @echo  ''
>   275: ifdef CONFIG_WIN32
>   276   @echo  'Windows targets:'
>
> meson.build:
>   853  blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c')=
)
>   854: softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')=
])
>   855
>
> backends\qemu\configure:
>   6511  if test "$mingw32" =3D "yes" ; then
>   6512:   echo "CONFIG_WIN32=3Dy" >> $config_host_mak
>   6513    rc_version=3D$(cat $source_path/VERSION)
>
> backends\qemu\Makefile:
>   272   @echo  ''
>   273: ifdef CONFIG_WIN32
>   274   @echo  'Windows targets:'
>
> backends\qemu\meson.build:
>   856  blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c')=
)
>   857: softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')=
])
>   858
>
> block\meson.build:
>   58  block_ss.add(when: [libxml2, 'CONFIG_PARALLELS'], if_true:
> files('parallels.c'))
>   59: block_ss.add(when: 'CONFIG_WIN32', if_true: files('file-win32.c',
> 'win32-aio.c'))
>   60  block_ss.add(when: 'CONFIG_POSIX', if_true: [files('file-posix.c'),
> coref, iokit])
>
> chardev\meson.build:
>   20  ))
>   21: chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
>   22    'char-console.c',
>
> hw\usb\host-libusb.c:
>     37  #include "qom/object.h"
>     38: #ifndef CONFIG_WIN32
>     39  #include <poll.h>
>
>    228
>    229: #ifndef CONFIG_WIN32
>    230
>
>    249
>    250: #endif /* !CONFIG_WIN32 */
>    251
>
>    253  {
>    254: #ifndef CONFIG_WIN32
>    255      const struct libusb_pollfd **poll;
>
>    270  #endif
>    271: #ifdef CONFIG_WIN32
>    272      /* FIXME: add support for Windows. */
>
>    916      } else {
>    917: #if LIBUSB_API_VERSION >=3D 0x01000107 && !defined(CONFIG_WIN32)
>    918          trace_usb_host_open_hostfd(hostfd);
>
>   1145
>   1146: #if LIBUSB_API_VERSION >=3D 0x01000107 && !defined(CONFIG_WIN32)
>   1147      if (s->hostdevice) {
>
> io\channel-watch.c:
>    32
>    33: #ifdef CONFIG_WIN32
>    34  typedef struct QIOChannelSocketSource QIOChannelSocketSource;
>
>    98
>    99: #ifdef CONFIG_WIN32
>   100  static gboolean
>
>   267
>   268: #ifdef CONFIG_WIN32
>   269      ssource->fd.fd =3D (gint64)_get_osfhandle(fd);
>
>   279
>   280: #ifdef CONFIG_WIN32
>   281  GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
>
>   337
>   338: #ifdef CONFIG_WIN32
>   339      ssource->fdread.fd =3D (gint64)_get_osfhandle(fdread);
>
> net\meson.build:
>   36  softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files(tap_posix))
>   37: softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('tap-win32.c'))
>   38  softmmu_ss.add(when: 'CONFIG_VHOST_NET_VDPA', if_true:
> files('vhost-vdpa.c'))
>
> qga\meson.build:
>   39    'commands-posix.c'))
>   40: qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
>   41    'channel-win32.c',
>
> scripts\checkpatch.pl:
>   2775  # check of hardware specific defines
>   2776: # we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
>   2777  # where they might be necessary.
>
> target\i386\hax-i386.h:
>   22
>   23: #ifdef CONFIG_WIN32
>   24  typedef HANDLE hax_fd;
>
>   87
>   88: #ifdef CONFIG_WIN32
>   89  #include "target/i386/hax-windows.h"
>
> target\i386\meson.build:
>   34  i386_softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_HAX'], if_true:
> files('hax-all.c', 'hax-mem.c', 'hax-posix.c'))
>   35: i386_softmmu_ss.add(when: ['CONFIG_WIN32', 'CONFIG_HAX'], if_true:
> files('hax-all.c', 'hax-mem.c', 'hax-windows.c'))
>   36
>
> ui\gtk.c:
>   1171  {
>   1172: #ifdef CONFIG_WIN32
>   1173      /*
>
> ui\meson.build:
>   48  if config_host.has_key('CONFIG_GTK')
>   49:   softmmu_ss.add(when: 'CONFIG_WIN32', if_true:
> files('win32-kbd-hook.c'))
>   50
>
>   59  if sdl.found()
>   60:   softmmu_ss.add(when: 'CONFIG_WIN32', if_true:
> files('win32-kbd-hook.c'))
>   61
>
> ui\sdl2.c:
>   332  {
>   333: #ifdef CONFIG_WIN32
>   334      SDL_SysWMinfo info;
>
> util\meson.build:
>   14  util_ss.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
>   15: util_ss.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
>   16: util_ss.add(when: 'CONFIG_WIN32', if_true:
> files('event_notifier-win32.c'))
>   17: util_ss.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
>   18: util_ss.add(when: 'CONFIG_WIN32', if_true:
> files('qemu-thread-win32.c'))
>   19: util_ss.add(when: 'CONFIG_WIN32', if_true: winmm)
>   20  util_ss.add(files('envlist.c', 'path.c', 'module.c'))
>
> util\sys_membarrier.c:
>   25  {
>   26: #if defined CONFIG_WIN32
>   27      FlushProcessWriteBuffers();
> ```
>


> Paolo
>
>

Search _WIN32
```
561 results - 257 files

block.c:
   59
   60: #ifdef _WIN32
   61  #include <windows.h>

   85
   86: #ifdef _WIN32
   87  static int is_windows_drive_prefix(const char *filename)

  130
  131: #ifdef _WIN32
  132      if (is_windows_drive(path) ||
```

  145  {--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000645d0805af343dd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14, 2020 at 12:12 AM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
13/09/20 18:03, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <br>
&gt; _WIN32 are more precise and only depends on the compiler, on the<br>
&gt; other hand, CONFIG_POSIX=C2=A0 and=C2=A0 CONFIG_WIN32=C2=A0 need confi=
gure<br>
&gt; scripts. I prefer=C2=A0 _WIN32=C2=A0 unless the compiler can not provi=
de enough<br>
&gt; information.<br>
<br>
That&#39;s not what the QEMU coding standards say; we generally don&#39;t t=
est<br>
the preprocessor symbols.=C2=A0 If we were to change to _WIN32, it should b=
e<br>
done at once on the whole codebase (don&#39;t do it :)).&gt;<br></blockquot=
e><div><br></div><div>=C2=A0 CONFIG_WIN32=C2=A0 are rarely used, most of th=
e are using _WIN32=C2=A0<br></div><div><br></div><div>Search CONFIG_WIN32</=
div><div>```=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">3=
6 results - 20 files<br><br>configure:<br>=C2=A0 6511 =C2=A0if test &quot;$=
mingw32&quot; =3D &quot;yes&quot; ; then<br>=C2=A0 6512: =C2=A0 echo &quot;=
CONFIG_WIN32=3Dy&quot; &gt;&gt; $config_host_mak<br>=C2=A0 6513 =C2=A0 =C2=
=A0rc_version=3D$(cat $source_path/VERSION)<br><br>Makefile:<br>=C2=A0 274 =
=C2=A0 @echo =C2=A0&#39;&#39;<br>=C2=A0 275: ifdef CONFIG_WIN32<br>=C2=A0 2=
76 =C2=A0 @echo =C2=A0&#39;Windows targets:&#39;<br><br>meson.build:<br>=C2=
=A0 853 =C2=A0blockdev_ss.add(when: &#39;CONFIG_POSIX&#39;, if_true: files(=
&#39;os-posix.c&#39;))<br>=C2=A0 854: softmmu_ss.add(when: &#39;CONFIG_WIN3=
2&#39;, if_true: [files(&#39;os-win32.c&#39;)])<br>=C2=A0 855 =C2=A0<br><br=
>backends\qemu\configure:<br>=C2=A0 6511 =C2=A0if test &quot;$mingw32&quot;=
 =3D &quot;yes&quot; ; then<br>=C2=A0 6512: =C2=A0 echo &quot;CONFIG_WIN32=
=3Dy&quot; &gt;&gt; $config_host_mak<br>=C2=A0 6513 =C2=A0 =C2=A0rc_version=
=3D$(cat $source_path/VERSION)<br><br>backends\qemu\Makefile:<br>=C2=A0 272=
 =C2=A0 @echo =C2=A0&#39;&#39;<br>=C2=A0 273: ifdef CONFIG_WIN32<br>=C2=A0 =
274 =C2=A0 @echo =C2=A0&#39;Windows targets:&#39;<br><br>backends\qemu\meso=
n.build:<br>=C2=A0 856 =C2=A0blockdev_ss.add(when: &#39;CONFIG_POSIX&#39;, =
if_true: files(&#39;os-posix.c&#39;))<br>=C2=A0 857: softmmu_ss.add(when: &=
#39;CONFIG_WIN32&#39;, if_true: [files(&#39;os-win32.c&#39;)])<br>=C2=A0 85=
8 =C2=A0<br><br>block\meson.build:<br>=C2=A0 58 =C2=A0block_ss.add(when: [l=
ibxml2, &#39;CONFIG_PARALLELS&#39;], if_true: files(&#39;parallels.c&#39;))=
<br>=C2=A0 59: block_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#=
39;file-win32.c&#39;, &#39;win32-aio.c&#39;))<br>=C2=A0 60 =C2=A0block_ss.a=
dd(when: &#39;CONFIG_POSIX&#39;, if_true: [files(&#39;file-posix.c&#39;), c=
oref, iokit])<br><br>chardev\meson.build:<br>=C2=A0 20 =C2=A0))<br>=C2=A0 2=
1: chardev_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(<br>=C2=A0 2=
2 =C2=A0 =C2=A0&#39;char-console.c&#39;,<br><br>hw\usb\host-libusb.c:<br>=
=C2=A0 =C2=A0 37 =C2=A0#include &quot;qom/object.h&quot;<br>=C2=A0 =C2=A0 3=
8: #ifndef CONFIG_WIN32<br>=C2=A0 =C2=A0 39 =C2=A0#include &lt;poll.h&gt;<b=
r><br>=C2=A0 =C2=A0228 =C2=A0<br>=C2=A0 =C2=A0229: #ifndef CONFIG_WIN32<br>=
=C2=A0 =C2=A0230 =C2=A0<br><br>=C2=A0 =C2=A0249 =C2=A0<br>=C2=A0 =C2=A0250:=
 #endif /* !CONFIG_WIN32 */<br>=C2=A0 =C2=A0251 =C2=A0<br><br>=C2=A0 =C2=A0=
253 =C2=A0{<br>=C2=A0 =C2=A0254: #ifndef CONFIG_WIN32<br>=C2=A0 =C2=A0255 =
=C2=A0 =C2=A0 =C2=A0const struct libusb_pollfd **poll;<br><br>=C2=A0 =C2=A0=
270 =C2=A0#endif<br>=C2=A0 =C2=A0271: #ifdef CONFIG_WIN32<br>=C2=A0 =C2=A02=
72 =C2=A0 =C2=A0 =C2=A0/* FIXME: add support for Windows. */<br><br>=C2=A0 =
=C2=A0916 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0917: #if LIBUSB_API_=
VERSION &gt;=3D 0x01000107 &amp;&amp; !defined(CONFIG_WIN32)<br>=C2=A0 =C2=
=A0918 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_host_open_hostfd(hostfd)=
;<br><br>=C2=A0 1145 =C2=A0<br>=C2=A0 1146: #if LIBUSB_API_VERSION &gt;=3D =
0x01000107 &amp;&amp; !defined(CONFIG_WIN32)<br>=C2=A0 1147 =C2=A0 =C2=A0 =
=C2=A0if (s-&gt;hostdevice) {<br><br>io\channel-watch.c:<br>=C2=A0 =C2=A032=
 =C2=A0<br>=C2=A0 =C2=A033: #ifdef CONFIG_WIN32<br>=C2=A0 =C2=A034 =C2=A0ty=
pedef struct QIOChannelSocketSource QIOChannelSocketSource;<br><br>=C2=A0 =
=C2=A098 =C2=A0<br>=C2=A0 =C2=A099: #ifdef CONFIG_WIN32<br>=C2=A0 100 =C2=
=A0static gboolean<br><br>=C2=A0 267 =C2=A0<br>=C2=A0 268: #ifdef CONFIG_WI=
N32<br>=C2=A0 269 =C2=A0 =C2=A0 =C2=A0ssource-&gt;fd.fd =3D (gint64)_get_os=
fhandle(fd);<br><br>=C2=A0 279 =C2=A0<br>=C2=A0 280: #ifdef CONFIG_WIN32<br=
>=C2=A0 281 =C2=A0GSource *qio_channel_create_socket_watch(QIOChannel *ioc,=
<br><br>=C2=A0 337 =C2=A0<br>=C2=A0 338: #ifdef CONFIG_WIN32<br>=C2=A0 339 =
=C2=A0 =C2=A0 =C2=A0ssource-&gt;fdread.fd =3D (gint64)_get_osfhandle(fdread=
);<br><br>net\meson.build:<br>=C2=A0 36 =C2=A0softmmu_ss.add(when: &#39;CON=
FIG_POSIX&#39;, if_true: files(tap_posix))<br>=C2=A0 37: softmmu_ss.add(whe=
n: &#39;CONFIG_WIN32&#39;, if_true: files(&#39;tap-win32.c&#39;))<br>=C2=A0=
 38 =C2=A0softmmu_ss.add(when: &#39;CONFIG_VHOST_NET_VDPA&#39;, if_true: fi=
les(&#39;vhost-vdpa.c&#39;))<br><br>qga\meson.build:<br>=C2=A0 39 =C2=A0 =
=C2=A0&#39;commands-posix.c&#39;))<br>=C2=A0 40: qga_ss.add(when: &#39;CONF=
IG_WIN32&#39;, if_true: files(<br>=C2=A0 41 =C2=A0 =C2=A0&#39;channel-win32=
.c&#39;,<br><br>scripts\<a href=3D"http://checkpatch.pl">checkpatch.pl</a>:=
<br>=C2=A0 2775 =C2=A0# check of hardware specific defines<br>=C2=A0 2776: =
# we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases<br>=C2=A0 277=
7 =C2=A0# where they might be necessary.<br><br>target\i386\hax-i386.h:<br>=
=C2=A0 22 =C2=A0<br>=C2=A0 23: #ifdef CONFIG_WIN32<br>=C2=A0 24 =C2=A0typed=
ef HANDLE hax_fd;<br><br>=C2=A0 87 =C2=A0<br>=C2=A0 88: #ifdef CONFIG_WIN32=
<br>=C2=A0 89 =C2=A0#include &quot;target/i386/hax-windows.h&quot;<br><br>t=
arget\i386\meson.build:<br>=C2=A0 34 =C2=A0i386_softmmu_ss.add(when: [&#39;=
CONFIG_POSIX&#39;, &#39;CONFIG_HAX&#39;], if_true: files(&#39;hax-all.c&#39=
;, &#39;hax-mem.c&#39;, &#39;hax-posix.c&#39;))<br>=C2=A0 35: i386_softmmu_=
ss.add(when: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG_HAX&#39;], if_true: files=
(&#39;hax-all.c&#39;, &#39;hax-mem.c&#39;, &#39;hax-windows.c&#39;))<br>=C2=
=A0 36 =C2=A0<br><br>ui\gtk.c:<br>=C2=A0 1171 =C2=A0{<br>=C2=A0 1172: #ifde=
f CONFIG_WIN32<br>=C2=A0 1173 =C2=A0 =C2=A0 =C2=A0/*<br><br>ui\meson.build:=
<br>=C2=A0 48 =C2=A0if config_host.has_key(&#39;CONFIG_GTK&#39;)<br>=C2=A0 =
49: =C2=A0 softmmu_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#39=
;win32-kbd-hook.c&#39;))<br>=C2=A0 50 =C2=A0<br><br>=C2=A0 59 =C2=A0if sdl.=
found()<br>=C2=A0 60: =C2=A0 softmmu_ss.add(when: &#39;CONFIG_WIN32&#39;, i=
f_true: files(&#39;win32-kbd-hook.c&#39;))<br>=C2=A0 61 =C2=A0<br><br>ui\sd=
l2.c:<br>=C2=A0 332 =C2=A0{<br>=C2=A0 333: #ifdef CONFIG_WIN32<br>=C2=A0 33=
4 =C2=A0 =C2=A0 =C2=A0SDL_SysWMinfo info;<br><br>util\meson.build:<br>=C2=
=A0 14 =C2=A0util_ss.add(when: &#39;CONFIG_POSIX&#39;, if_true: files(&#39;=
memfd.c&#39;))<br>=C2=A0 15: util_ss.add(when: &#39;CONFIG_WIN32&#39;, if_t=
rue: files(&#39;aio-win32.c&#39;))<br>=C2=A0 16: util_ss.add(when: &#39;CON=
FIG_WIN32&#39;, if_true: files(&#39;event_notifier-win32.c&#39;))<br>=C2=A0=
 17: util_ss.add(when: &#39;CONFIG_WIN32&#39;, if_true: files(&#39;oslib-wi=
n32.c&#39;))<br>=C2=A0 18: util_ss.add(when: &#39;CONFIG_WIN32&#39;, if_tru=
e: files(&#39;qemu-thread-win32.c&#39;))<br>=C2=A0 19: util_ss.add(when: &#=
39;CONFIG_WIN32&#39;, if_true: winmm)<br>=C2=A0 20 =C2=A0util_ss.add(files(=
&#39;envlist.c&#39;, &#39;path.c&#39;, &#39;module.c&#39;))<br><br>util\sys=
_membarrier.c:<br>=C2=A0 25 =C2=A0{<br>=C2=A0 26: #if defined CONFIG_WIN32<=
br>=C2=A0 27 =C2=A0 =C2=A0 =C2=A0FlushProcessWriteBuffers();<br>```<br>=C2=
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div><div><br></div><div><br></div><div>Search _WIN32</div>``=
`<br>561 results - 257 files<br><br>block.c:<br>=C2=A0 =C2=A059 =C2=A0<br>=
=C2=A0 =C2=A060: #ifdef _WIN32<br>=C2=A0 =C2=A061 =C2=A0#include &lt;window=
s.h&gt;<br><br>=C2=A0 =C2=A085 =C2=A0<br>=C2=A0 =C2=A086: #ifdef _WIN32<br>=
=C2=A0 =C2=A087 =C2=A0static int is_windows_drive_prefix(const char *filena=
me)<br><br>=C2=A0 130 =C2=A0<br>=C2=A0 131: #ifdef _WIN32<br>=C2=A0 132 =C2=
=A0 =C2=A0 =C2=A0if (is_windows_drive(path) ||<br>```<br><br>=C2=A0 145 =C2=
=A0{-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000645d0805af343dd7--

