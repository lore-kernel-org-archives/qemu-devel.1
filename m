Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A063C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E5921941
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro2oxOvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5921941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzeU-0003ke-Pd
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFzdM-0002Cp-6y; Wed, 09 Sep 2020 08:55:32 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFzdJ-00013Q-BZ; Wed, 09 Sep 2020 08:55:31 -0400
Received: by mail-lj1-x242.google.com with SMTP id b19so3347767lji.11;
 Wed, 09 Sep 2020 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=juauL75ug80LTc38xn2MfEn4iLIjdeYZWpHxodZf24M=;
 b=ro2oxOvShoCzGFDY4Q9pAasH+jaK5CJVkumYNojGpeHUAmwWOGjgW4NvFgGPGx7vYP
 HOm1Dpxjyty9xU/sj7A9zVrtILGSfw0wlehl1+/byJHdC2PSr4LM+/9qcL375VygyoiO
 gEGYZs9F82f3OdOrb/KOEmdzca01N/0HgS1SCZW+sjzNKLh4BElILrTcuj52i5KcVtiH
 bHrEGV2sFPJmZ/DxxRI7BjC341txkBb++Oq05yh7uRO4pwoJG9Io7Pklc8PgM4clX52y
 Y9KFB7pMh3+t67wQXujhQalTjqFdKI0J+rZ+Lm2F2aBwULNVWw4MutZA1me/WQoFkArI
 baOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=juauL75ug80LTc38xn2MfEn4iLIjdeYZWpHxodZf24M=;
 b=VMEC4bPSIUXn3H/kxz/GPwjyrWem5tHW9RmMmI0/z7rGF8crzBc5O7uwFhzTMNVMeh
 V6yPfjPaHm/4j1B4Bop2FQSbF9KWDdClB+glWyScDDtMMgKzFK2I1L4OKx/GhUuG9qZw
 Vf2AIsxgCIZF2DDuklkhdlSP2MNeqmMsoMKzfhDwErq34WP5lyj/nf316r/DmO1KtpqA
 O6ov63ppt90k80RX//avQy/CUQvI9NsDQNWAWeKEeXahjrkCj/X6WOlB4O882Lj4Ngzy
 smIyTNTNPShlrdglqTJyzitA2thdlo9lhqyACaUe8hNAiLUuujSy5Tr5l8dkoaH0JM+T
 UjkA==
X-Gm-Message-State: AOAM5305ZxJymtydIda7rkEuCUv60ov12Oq1eMapjbdo6YZw6jV0Swk8
 uDx96xF8J18B8WqGgRs661W/MDfCBR1KRkVLM3A=
X-Google-Smtp-Source: ABdhPJwUkP7RUCxNvyMeFOOwBmdta5bRE3mpdKCYxv0D4F3ert3iYCh4rwgVqFh9C2ey1GhSCrpUBXEMjodj02F8CK4=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr1921945lji.171.1599656127012; 
 Wed, 09 Sep 2020 05:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-4-luoyonggang@gmail.com>
 <20200909125049.GU1011023@redhat.com>
In-Reply-To: <20200909125049.GU1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 20:55:15 +0800
Message-ID: <CAE2XoE_02FDvGmwUCAFEOrog4z1iwtqoVYuSiZThBrFRLx0WfA@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000036a32e05aee0f7ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000036a32e05aee0f7ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 8:51 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 05:45:59PM +0800, Yonggang Luo wrote:
> > The mingw pkg-config are showing following absolute path and contains :
> as the separator,
> > so we must handling : properly.
> >
> > -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L
> -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> -lncursesw
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> -lcursesw
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe
> -lncursesw -lgnurx -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx
> -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
> >
> > msys2/mingw lacks the POSIX-required langinfo.h.
> >
> > gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe
> -lncursesw -lgnurx -ltre -lintl -liconv
> > test.c:4:10: fatal error: langinfo.h: No such file or directory
> >     4 | #include <langinfo.h>
> >       |          ^~~~~~~~~~~~
> > compilation terminated.
> >
> > So we using g_get_codeset instead of nl_langinfo(CODESET)
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  configure   |  9 +++------
> >  ui/curses.c | 10 +++++-----
> >  2 files changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/configure b/configure
> > index f4f8bc3756..2e6d54e15b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3653,8 +3653,8 @@ if test "$iconv" =3D "no" ; then
> >  fi
> >  if test "$curses" !=3D "no" ; then
> >    if test "$mingw32" =3D "yes" ; then
> > -    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"
> > -    curses_lib_list=3D"$($pkg_config --libs ncurses
> 2>/dev/null):-lpdcurses"
> > +    curses_inc_list=3D"$($pkg_config --cflags ncursesw
> 2>/dev/null):-I/${MSYSTEM,,}/include/ncursesw:"
> > +    curses_lib_list=3D"$($pkg_config --libs ncursesw
> 2>/dev/null):-lncursesw"
>
> The original code would try  ncurses via pkg-config and if that failed,
> would
> falback to pdcurses.
>
> The new code tries ncursesw via pkg-config and then tries ncursesw again
> via manually specified args, and doesn't try  ncurses or pdcurses at all.
>
Gotcha, Indeed   $pkg_config --cflags ncurses can find curses on mingw32,
the problem is onw mingw32 the include path
have :, so we can not use : as the path sepaerator, for cross-paltform
reason, which is best for path separator?

>
> This fixes your build as you've installed ncursesw, but breaks anyone
> who was using ncurses or pdcurses previously. At least on Fedora only
> pdcurses is available for mingw, so I don't think we should be dropping
> this. It looks like we just need to check all three of ncursesw, ncurses
> and pdcurses.
>
> Copying Samuel who introduced this logic originally in
> commit 8ddc5bf9e5de51c2a4842c01dd3a97f5591776fd
>
> >    else
> >      curses_inc_list=3D"$($pkg_config --cflags ncursesw
> 2>/dev/null):-I/usr/include/ncursesw:"
> >      curses_lib_list=3D"$($pkg_config --libs ncursesw
> 2>/dev/null):-lncursesw:-lcursesw"
> > @@ -3664,17 +3664,14 @@ if test "$curses" !=3D "no" ; then
> >  #include <locale.h>
> >  #include <curses.h>
> >  #include <wchar.h>
> > -#include <langinfo.h>
> >  int main(void) {
> > -  const char *codeset;
> >    wchar_t wch =3D L'w';
> >    setlocale(LC_ALL, "");
> >    resize_term(0, 0);
> >    addwstr(L"wide chars\n");
> >    addnwstr(&wch, 1);
> >    add_wch(WACS_DEGREE);
> > -  codeset =3D nl_langinfo(CODESET);
> > -  return codeset !=3D 0;
> > +  return 0;
> >  }
> >  EOF
> >    IFS=3D:
> > diff --git a/ui/curses.c b/ui/curses.c
> > index a59b23a9cf..12bc682cf9 100644
> > --- a/ui/curses.c
> > +++ b/ui/curses.c
> > @@ -30,7 +30,6 @@
> >  #endif
> >  #include <locale.h>
> >  #include <wchar.h>
> > -#include <langinfo.h>
> >  #include <iconv.h>
> >
> >  #include "qapi/error.h"
> > @@ -526,6 +525,7 @@ static void font_setup(void)
> >      iconv_t nativecharset_to_ucs2;
> >      iconv_t font_conv;
> >      int i;
> > +    g_autofree gchar *local_codeset =3D g_get_codeset();
> >
> >      /*
> >       * Control characters are normally non-printable, but VGA does hav=
e
> > @@ -566,14 +566,14 @@ static void font_setup(void)
> >        0x25bc
> >      };
> >
> > -    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), "UCS-2"=
);
> > +    ucs2_to_nativecharset =3D iconv_open(local_codeset, "UCS-2");
> >      if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
> >          fprintf(stderr, "Could not convert font glyphs from UCS-2:
> '%s'\n",
> >                          strerror(errno));
> >          exit(1);
> >      }
> >
> > -    nativecharset_to_ucs2 =3D iconv_open("UCS-2", nl_langinfo(CODESET)=
);
> > +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", local_codeset);
> >      if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
> >          iconv_close(ucs2_to_nativecharset);
> >          fprintf(stderr, "Could not convert font glyphs to UCS-2:
> '%s'\n",
> > @@ -581,7 +581,7 @@ static void font_setup(void)
> >          exit(1);
> >      }
> >
> > -    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
> > +    font_conv =3D iconv_open(local_codeset, font_charset);
> >      if (font_conv =3D=3D (iconv_t) -1) {
> >          iconv_close(ucs2_to_nativecharset);
> >          iconv_close(nativecharset_to_ucs2);
> > @@ -602,7 +602,7 @@ static void font_setup(void)
> >      /* DEL */
> >      convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
> >
> > -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> > +    if (strcmp(local_codeset, "UTF-8")) {
> >          /* Non-Unicode capable, use termcap equivalents for those
> available */
> >          for (i =3D 0; i <=3D 0xFF; i++) {
> >              wchar_t wch[CCHARW_MAX];
> > --
> > 2.28.0.windows.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000036a32e05aee0f7ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 8:51 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 05:45:59PM +0800, Yonggang Luo wrote:<br>
&gt; The mingw pkg-config are showing following absolute path and contains =
: as the separator,<br>
&gt; so we must handling : properly.<br>
&gt; <br>
&gt; -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC:/CI-Tools/msys64=
/mingw64/include/ncursesw:-I/usr/include/ncursesw:<br>
&gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -=
IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv<br>
&gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -=
IC -lncursesw<br>
&gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -=
IC -lcursesw<br>
&gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe -ln=
cursesw -lgnurx -ltre -lintl -liconv<br>
&gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncurses=
w<br>
&gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw=
<br>
&gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -l=
tre -lintl -liconv<br>
&gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw<br>
&gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw<br>
&gt; <br>
&gt; msys2/mingw lacks the POSIX-required langinfo.h.<br>
&gt; <br>
&gt; gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncur=
sesw -lgnurx -ltre -lintl -liconv<br>
&gt; test.c:4:10: fatal error: langinfo.h: No such file or directory<br>
&gt;=C2=A0 =C2=A0 =C2=A04 | #include &lt;langinfo.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~=
~~~~<br>
&gt; compilation terminated.<br>
&gt; <br>
&gt; So we using g_get_codeset instead of nl_langinfo(CODESET)<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" ta=
rget=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0|=C2=A0 9 +++------<br>
&gt;=C2=A0 ui/curses.c | 10 +++++-----<br>
&gt;=C2=A0 2 files changed, 8 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index f4f8bc3756..2e6d54e15b 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -3653,8 +3653,8 @@ if test &quot;$iconv&quot; =3D &quot;no&quot; ; =
then<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 if test &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>
&gt;=C2=A0 =C2=A0 if test &quot;$mingw32&quot; =3D &quot;yes&quot; ; then<b=
r>
&gt; -=C2=A0 =C2=A0 curses_inc_list=3D&quot;$($pkg_config --cflags ncurses =
2&gt;/dev/null):&quot;<br>
&gt; -=C2=A0 =C2=A0 curses_lib_list=3D&quot;$($pkg_config --libs ncurses 2&=
gt;/dev/null):-lpdcurses&quot;<br>
&gt; +=C2=A0 =C2=A0 curses_inc_list=3D&quot;$($pkg_config --cflags ncursesw=
 2&gt;/dev/null):-I/${MSYSTEM,,}/include/ncursesw:&quot;<br>
&gt; +=C2=A0 =C2=A0 curses_lib_list=3D&quot;$($pkg_config --libs ncursesw 2=
&gt;/dev/null):-lncursesw&quot;<br>
<br>
The original code would try=C2=A0 ncurses via pkg-config and if that failed=
, would<br>
falback to pdcurses.<br>
<br>
The new code tries ncursesw via pkg-config and then tries ncursesw again<br=
>
via manually specified args, and doesn&#39;t try=C2=A0 ncurses or pdcurses =
at all.<br></blockquote><div>Gotcha, Indeed=C2=A0=C2=A0

$pkg_config --cflags ncurses can find curses on mingw32, the problem is onw=
 mingw32 the include path</div><div>have :, so we can not use : as the path=
 sepaerator, for cross-paltform reason, which is best for path separator?=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
This fixes your build as you&#39;ve installed ncursesw, but breaks anyone<b=
r>
who was using ncurses or pdcurses previously. At least on Fedora only<br>
pdcurses is available for mingw, so I don&#39;t think we should be dropping=
<br>
this. It looks like we just need to check all three of ncursesw, ncurses<br=
>
and pdcurses.<br>
<br>
Copying Samuel who introduced this logic originally in <br>
commit 8ddc5bf9e5de51c2a4842c01dd3a97f5591776fd<br>
<br>
&gt;=C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 curses_inc_list=3D&quot;$($pkg_config --cflags ncu=
rsesw 2&gt;/dev/null):-I/usr/include/ncursesw:&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 curses_lib_list=3D&quot;$($pkg_config --libs ncurs=
esw 2&gt;/dev/null):-lncursesw:-lcursesw&quot;<br>
&gt; @@ -3664,17 +3664,14 @@ if test &quot;$curses&quot; !=3D &quot;no&quot=
; ; then<br>
&gt;=C2=A0 #include &lt;locale.h&gt;<br>
&gt;=C2=A0 #include &lt;curses.h&gt;<br>
&gt;=C2=A0 #include &lt;wchar.h&gt;<br>
&gt; -#include &lt;langinfo.h&gt;<br>
&gt;=C2=A0 int main(void) {<br>
&gt; -=C2=A0 const char *codeset;<br>
&gt;=C2=A0 =C2=A0 wchar_t wch =3D L&#39;w&#39;;<br>
&gt;=C2=A0 =C2=A0 setlocale(LC_ALL, &quot;&quot;);<br>
&gt;=C2=A0 =C2=A0 resize_term(0, 0);<br>
&gt;=C2=A0 =C2=A0 addwstr(L&quot;wide chars\n&quot;);<br>
&gt;=C2=A0 =C2=A0 addnwstr(&amp;wch, 1);<br>
&gt;=C2=A0 =C2=A0 add_wch(WACS_DEGREE);<br>
&gt; -=C2=A0 codeset =3D nl_langinfo(CODESET);<br>
&gt; -=C2=A0 return codeset !=3D 0;<br>
&gt; +=C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 EOF<br>
&gt;=C2=A0 =C2=A0 IFS=3D:<br>
&gt; diff --git a/ui/curses.c b/ui/curses.c<br>
&gt; index a59b23a9cf..12bc682cf9 100644<br>
&gt; --- a/ui/curses.c<br>
&gt; +++ b/ui/curses.c<br>
&gt; @@ -30,7 +30,6 @@<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #include &lt;locale.h&gt;<br>
&gt;=C2=A0 #include &lt;wchar.h&gt;<br>
&gt; -#include &lt;langinfo.h&gt;<br>
&gt;=C2=A0 #include &lt;iconv.h&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; @@ -526,6 +525,7 @@ static void font_setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 iconv_t nativecharset_to_ucs2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 iconv_t font_conv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *local_codeset =3D g_get_codeset();<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Control characters are normally non-printa=
ble, but VGA does have<br>
&gt; @@ -566,14 +566,14 @@ static void font_setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x25bc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESE=
T), &quot;UCS-2&quot;);<br>
&gt; +=C2=A0 =C2=A0 ucs2_to_nativecharset =3D iconv_open(local_codeset, &qu=
ot;UCS-2&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Could not conv=
ert font glyphs from UCS-2: &#39;%s&#39;\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot;,=
 nl_langinfo(CODESET));<br>
&gt; +=C2=A0 =C2=A0 nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot;,=
 local_codeset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv_close(ucs2_to_nativecharset);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Could not conv=
ert font glyphs to UCS-2: &#39;%s&#39;\n&quot;,<br>
&gt; @@ -581,7 +581,7 @@ static void font_setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 font_conv =3D iconv_open(nl_langinfo(CODESET), font_cha=
rset);<br>
&gt; +=C2=A0 =C2=A0 font_conv =3D iconv_open(local_codeset, font_charset);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (font_conv =3D=3D (iconv_t) -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv_close(ucs2_to_nativecharset);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv_close(nativecharset_to_ucs2);<=
br>
&gt; @@ -602,7 +602,7 @@ static void font_setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* DEL */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);<=
br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (strcmp(nl_langinfo(CODESET), &quot;UTF-8&quot;)) {<=
br>
&gt; +=C2=A0 =C2=A0 if (strcmp(local_codeset, &quot;UTF-8&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Non-Unicode capable, use termcap =
equivalents for those available */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt;=3D 0xFF; i++) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wchar_t wch[CCHARW_MAX=
];<br>
&gt; -- <br>
&gt; 2.28.0.windows.1<br>
&gt; <br>
&gt; <br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000036a32e05aee0f7ac--

