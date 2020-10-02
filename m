Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FEC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21889206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V25yaO4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21889206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPDs-0000Mi-A9
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPBb-0005jM-Pu; Fri, 02 Oct 2020 13:49:39 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPBZ-0004aS-Hm; Fri, 02 Oct 2020 13:49:39 -0400
Received: by mail-lf1-x144.google.com with SMTP id 77so2895602lfj.0;
 Fri, 02 Oct 2020 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=qhdPSQASd9dTS1JlTfzx2hCJahu/uOC0T2dj3rgIzXQ=;
 b=V25yaO4lbzS7nyLnaprxO0HLNlW5DO6EByLpiSAhr2oRB0EAG1OjW9w0Td6J6QAvQU
 31WDRskQLaYDT/NT5HzDPkbEEKboUSSZdQ3lcd6rv4XLTBN15N/v/lZdI7KIzKpaEX4w
 zZtfC50hcyc/Gk2xuoGy8aOpf87CMJBGC5UDn8ZndcJZg9XsQvld+OKRAMkBAfP4xmf3
 1JR9B2Ak4+6ZWhmqT78PwChHeA6mQKHRci/zP/1FcZ72Qs4x+3OUdOMMCegC3Z0F3Rmx
 7/G673gXf3N84xzH4c3vg/bF7DKcV9haGuLGugiXJTMCu5iT+m5f564N0H4n0/xrjkCU
 yrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=qhdPSQASd9dTS1JlTfzx2hCJahu/uOC0T2dj3rgIzXQ=;
 b=n/xCll+JwAlY296iq8RX03QlHfVfrZrUOBM1STKd7hA8yh14YWT1cMemwu67L3U1Aw
 VjRDpmJi29XvWBTOV3DI2+JlLvZ75t8zB3t/i7gTtPz6v83IxA6eaYce/d6kbBZAAmsN
 L0WD20uzuPNIthfVjqn4JrgWWa1BmseBL0q7Wk7r9obWotVoW+Tki3J+vTZljpb8vM3G
 ACSkieBhw1E5xcfoxSYlViNFoTCKTuue8ALefR/5QHffPPUnKj5WpoW2f1MYX6JtDQqw
 O4FuhkEnEKYsI0+uKK5dbGTasVI3mNlclA+efICqtOEdX22oNbu6cSLrsTEOpHOgTDKx
 IUXQ==
X-Gm-Message-State: AOAM532nLHjV9HUfUlLRqPS2Imfw8RCA+gaz7BGopcV1MYA7w0Ss/pl0
 pnTLAtDgBOayIQvkined4spE6yHrbp4oTvavFC5zCj8enmr9IA==
X-Google-Smtp-Source: ABdhPJxo7qbCqr3u3w14b0kkJU7A/769rtY5kFOuZVcLOqRRBH8FLAK8EUjTNt+dukgZPx7zcD8x7wKLtX8OzYBeVNk=
X-Received: by 2002:a19:a407:: with SMTP id q7mr1192160lfc.377.1601660975038; 
 Fri, 02 Oct 2020 10:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-4-luoyonggang@gmail.com>
In-Reply-To: <20200909094617.1582-4-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 01:49:23 +0800
Message-ID: <CAE2XoE8y3L7sZcfESuVbRTCU28RhcpF0QKZEWSms_GCF3ZUMPQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
To: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000077c69905b0b3c14a"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000077c69905b0b3c14a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can queue this instead

On Wed, Sep 9, 2020 at 5:46 PM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> The mingw pkg-config are showing following absolute path and contains :
as the separator,
> so we must handling : properly.
>
> -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L
-IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC
-pipe -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC
-lncursesw
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC
-lcursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe
-lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre
-lintl -liconv
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
>
> msys2/mingw lacks the POSIX-required langinfo.h.
>
> gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe
-lncursesw -lgnurx -ltre -lintl -liconv
> test.c:4:10: fatal error: langinfo.h: No such file or directory
>     4 | #include <langinfo.h>
>       |          ^~~~~~~~~~~~
> compilation terminated.
>
> So we using g_get_codeset instead of nl_langinfo(CODESET)
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure   |  9 +++------
>  ui/curses.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/configure b/configure
> index f4f8bc3756..2e6d54e15b 100755
> --- a/configure
> +++ b/configure
> @@ -3653,8 +3653,8 @@ if test "$iconv" =3D "no" ; then
>  fi
>  if test "$curses" !=3D "no" ; then
>    if test "$mingw32" =3D "yes" ; then
> -    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"
> -    curses_lib_list=3D"$($pkg_config --libs ncurses
2>/dev/null):-lpdcurses"
> +    curses_inc_list=3D"$($pkg_config --cflags ncursesw
2>/dev/null):-I/${MSYSTEM,,}/include/ncursesw:"
> +    curses_lib_list=3D"$($pkg_config --libs ncursesw
2>/dev/null):-lncursesw"
>    else
>      curses_inc_list=3D"$($pkg_config --cflags ncursesw
2>/dev/null):-I/usr/include/ncursesw:"
>      curses_lib_list=3D"$($pkg_config --libs ncursesw
2>/dev/null):-lncursesw:-lcursesw"
> @@ -3664,17 +3664,14 @@ if test "$curses" !=3D "no" ; then
>  #include <locale.h>
>  #include <curses.h>
>  #include <wchar.h>
> -#include <langinfo.h>
>  int main(void) {
> -  const char *codeset;
>    wchar_t wch =3D L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  codeset =3D nl_langinfo(CODESET);
> -  return codeset !=3D 0;
> +  return 0;
>  }
>  EOF
>    IFS=3D:
> diff --git a/ui/curses.c b/ui/curses.c
> index a59b23a9cf..12bc682cf9 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -30,7 +30,6 @@
>  #endif
>  #include <locale.h>
>  #include <wchar.h>
> -#include <langinfo.h>
>  #include <iconv.h>
>
>  #include "qapi/error.h"
> @@ -526,6 +525,7 @@ static void font_setup(void)
>      iconv_t nativecharset_to_ucs2;
>      iconv_t font_conv;
>      int i;
> +    g_autofree gchar *local_codeset =3D g_get_codeset();
>
>      /*
>       * Control characters are normally non-printable, but VGA does have
> @@ -566,14 +566,14 @@ static void font_setup(void)
>        0x25bc
>      };
>
> -    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), "UCS-2");
> +    ucs2_to_nativecharset =3D iconv_open(local_codeset, "UCS-2");
>      if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
>          fprintf(stderr, "Could not convert font glyphs from UCS-2:
'%s'\n",
>                          strerror(errno));
>          exit(1);
>      }
>
> -    nativecharset_to_ucs2 =3D iconv_open("UCS-2", nl_langinfo(CODESET));
> +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", local_codeset);
>      if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
>          iconv_close(ucs2_to_nativecharset);
>          fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n"=
,
> @@ -581,7 +581,7 @@ static void font_setup(void)
>          exit(1);
>      }
>
> -    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
> +    font_conv =3D iconv_open(local_codeset, font_charset);
>      if (font_conv =3D=3D (iconv_t) -1) {
>          iconv_close(ucs2_to_nativecharset);
>          iconv_close(nativecharset_to_ucs2);
> @@ -602,7 +602,7 @@ static void font_setup(void)
>      /* DEL */
>      convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
>
> -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> +    if (strcmp(local_codeset, "UTF-8")) {
>          /* Non-Unicode capable, use termcap equivalents for those
available */
>          for (i =3D 0; i <=3D 0xFF; i++) {
>              wchar_t wch[CCHARW_MAX];
> --
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000077c69905b0b3c14a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You can queue this instead<br><br>On Wed, Sep 9, 2020 at 5=
:46 PM Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggan=
g@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; The mingw pkg-config are showing=
 following absolute path and contains : as the separator,<br>&gt; so we mus=
t handling : properly.<br>&gt;<br>&gt; -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOU=
RCE=3D199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/=
ncursesw:<br>&gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURC=
E=3D199506L -IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv<br>&gt; -DNCU=
RSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC -lncurs=
esw<br>&gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D19=
9506L -IC -lcursesw<br>&gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/inc=
lude/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv<br>&gt; -DNCURS=
ES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw<br>&gt; -D=
NCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw<br>&gt=
; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre=
 -lintl -liconv<br>&gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncurse=
sw<br>&gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw<br>&gt;<br>=
&gt; msys2/mingw lacks the POSIX-required langinfo.h.<br>&gt;<br>&gt; gcc t=
est.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncursesw -lgnu=
rx -ltre -lintl -liconv<br>&gt; test.c:4:10: fatal error: langinfo.h: No su=
ch file or directory<br>&gt; =C2=A0 =C2=A0 4 | #include &lt;langinfo.h&gt;<=
br>&gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~=
~~<br>&gt; compilation terminated.<br>&gt;<br>&gt; So we using g_get_codese=
t instead of nl_langinfo(CODESET)<br>&gt;<br>&gt; Signed-off-by: Yonggang L=
uo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&g=
t;<br>&gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.c=
om">kraxel@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0configure =C2=A0 | =
=C2=A09 +++------<br>&gt; =C2=A0ui/curses.c | 10 +++++-----<br>&gt; =C2=A02=
 files changed, 8 insertions(+), 11 deletions(-)<br>&gt;<br>&gt; diff --git=
 a/configure b/configure<br>&gt; index f4f8bc3756..2e6d54e15b 100755<br>&gt=
; --- a/configure<br>&gt; +++ b/configure<br>&gt; @@ -3653,8 +3653,8 @@ if =
test &quot;$iconv&quot; =3D &quot;no&quot; ; then<br>&gt; =C2=A0fi<br>&gt; =
=C2=A0if test &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>&gt; =C2=A0=
 =C2=A0if test &quot;$mingw32&quot; =3D &quot;yes&quot; ; then<br>&gt; - =
=C2=A0 =C2=A0curses_inc_list=3D&quot;$($pkg_config --cflags ncurses 2&gt;/d=
ev/null):&quot;<br>&gt; - =C2=A0 =C2=A0curses_lib_list=3D&quot;$($pkg_confi=
g --libs ncurses 2&gt;/dev/null):-lpdcurses&quot;<br>&gt; + =C2=A0 =C2=A0cu=
rses_inc_list=3D&quot;$($pkg_config --cflags ncursesw 2&gt;/dev/null):-I/${=
MSYSTEM,,}/include/ncursesw:&quot;<br>&gt; + =C2=A0 =C2=A0curses_lib_list=
=3D&quot;$($pkg_config --libs ncursesw 2&gt;/dev/null):-lncursesw&quot;<br>=
&gt; =C2=A0 =C2=A0else<br>&gt; =C2=A0 =C2=A0 =C2=A0curses_inc_list=3D&quot;=
$($pkg_config --cflags ncursesw 2&gt;/dev/null):-I/usr/include/ncursesw:&qu=
ot;<br>&gt; =C2=A0 =C2=A0 =C2=A0curses_lib_list=3D&quot;$($pkg_config --lib=
s ncursesw 2&gt;/dev/null):-lncursesw:-lcursesw&quot;<br>&gt; @@ -3664,17 +=
3664,14 @@ if test &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>&gt; =
=C2=A0#include &lt;locale.h&gt;<br>&gt; =C2=A0#include &lt;curses.h&gt;<br>=
&gt; =C2=A0#include &lt;wchar.h&gt;<br>&gt; -#include &lt;langinfo.h&gt;<br=
>&gt; =C2=A0int main(void) {<br>&gt; - =C2=A0const char *codeset;<br>&gt; =
=C2=A0 =C2=A0wchar_t wch =3D L&#39;w&#39;;<br>&gt; =C2=A0 =C2=A0setlocale(L=
C_ALL, &quot;&quot;);<br>&gt; =C2=A0 =C2=A0resize_term(0, 0);<br>&gt; =C2=
=A0 =C2=A0addwstr(L&quot;wide chars\n&quot;);<br>&gt; =C2=A0 =C2=A0addnwstr=
(&amp;wch, 1);<br>&gt; =C2=A0 =C2=A0add_wch(WACS_DEGREE);<br>&gt; - =C2=A0c=
odeset =3D nl_langinfo(CODESET);<br>&gt; - =C2=A0return codeset !=3D 0;<br>=
&gt; + =C2=A0return 0;<br>&gt; =C2=A0}<br>&gt; =C2=A0EOF<br>&gt; =C2=A0 =C2=
=A0IFS=3D:<br>&gt; diff --git a/ui/curses.c b/ui/curses.c<br>&gt; index a59=
b23a9cf..12bc682cf9 100644<br>&gt; --- a/ui/curses.c<br>&gt; +++ b/ui/curse=
s.c<br>&gt; @@ -30,7 +30,6 @@<br>&gt; =C2=A0#endif<br>&gt; =C2=A0#include &=
lt;locale.h&gt;<br>&gt; =C2=A0#include &lt;wchar.h&gt;<br>&gt; -#include &l=
t;langinfo.h&gt;<br>&gt; =C2=A0#include &lt;iconv.h&gt;<br>&gt;<br>&gt; =C2=
=A0#include &quot;qapi/error.h&quot;<br>&gt; @@ -526,6 +525,7 @@ static voi=
d font_setup(void)<br>&gt; =C2=A0 =C2=A0 =C2=A0iconv_t nativecharset_to_ucs=
2;<br>&gt; =C2=A0 =C2=A0 =C2=A0iconv_t font_conv;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0int i;<br>&gt; + =C2=A0 =C2=A0g_autofree gchar *local_codeset =3D g_get_=
codeset();<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0/*<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 * Control characters are normally non-printable, but VGA does have<br>&=
gt; @@ -566,14 +566,14 @@ static void font_setup(void)<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x25bc<br>&gt; =C2=A0 =C2=A0 =C2=A0};<br>&gt;<br>&gt; - =
=C2=A0 =C2=A0ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), &qu=
ot;UCS-2&quot;);<br>&gt; + =C2=A0 =C2=A0ucs2_to_nativecharset =3D iconv_ope=
n(local_codeset, &quot;UCS-2&quot;);<br>&gt; =C2=A0 =C2=A0 =C2=A0if (ucs2_t=
o_nativecharset =3D=3D (iconv_t) -1) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(stderr, &quot;Could not convert font glyphs from UCS-2: &#39;=
%s&#39;\n&quot;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errno));<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt;<b=
r>&gt; - =C2=A0 =C2=A0nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot=
;, nl_langinfo(CODESET));<br>&gt; + =C2=A0 =C2=A0nativecharset_to_ucs2 =3D =
iconv_open(&quot;UCS-2&quot;, local_codeset);<br>&gt; =C2=A0 =C2=A0 =C2=A0i=
f (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0iconv_close(ucs2_to_nativecharset);<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Could not convert font glyphs to =
UCS-2: &#39;%s&#39;\n&quot;,<br>&gt; @@ -581,7 +581,7 @@ static void font_s=
etup(void)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&gt; =C2=
=A0 =C2=A0 =C2=A0}<br>&gt;<br>&gt; - =C2=A0 =C2=A0font_conv =3D iconv_open(=
nl_langinfo(CODESET), font_charset);<br>&gt; + =C2=A0 =C2=A0font_conv =3D i=
conv_open(local_codeset, font_charset);<br>&gt; =C2=A0 =C2=A0 =C2=A0if (fon=
t_conv =3D=3D (iconv_t) -1) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ico=
nv_close(ucs2_to_nativecharset);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
iconv_close(nativecharset_to_ucs2);<br>&gt; @@ -602,7 +602,7 @@ static void=
 font_setup(void)<br>&gt; =C2=A0 =C2=A0 =C2=A0/* DEL */<br>&gt; =C2=A0 =C2=
=A0 =C2=A0convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);<br>&gt;<br>&gt;=
 - =C2=A0 =C2=A0if (strcmp(nl_langinfo(CODESET), &quot;UTF-8&quot;)) {<br>&=
gt; + =C2=A0 =C2=A0if (strcmp(local_codeset, &quot;UTF-8&quot;)) {<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Non-Unicode capable, use termcap equiv=
alents for those available */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for=
 (i =3D 0; i &lt;=3D 0xFF; i++) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0wchar_t wch[CCHARW_MAX];<br>&gt; --<br>&gt; 2.28.0.windows=
.1<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div>

--00000000000077c69905b0b3c14a--

