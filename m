Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABBC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D94206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW+/sHA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D94206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIB8w-00038X-Bf
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIAvc-0005X6-Jz; Tue, 15 Sep 2020 09:23:25 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIAvY-0001Ka-KH; Tue, 15 Sep 2020 09:23:24 -0400
Received: by mail-lf1-x142.google.com with SMTP id x69so3097590lff.3;
 Tue, 15 Sep 2020 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=6DN2mcILOwzBoK4UP9pw9h1MJyuDkVP/POdo6WdvDxc=;
 b=OW+/sHA86qNmSVwo69hi89MTDdVUmrJMRuJK+e21r21HPBKlOx/sVpK3uHFeUS9aUv
 Tt5PYDUq4vpAaGq5kCl3ibBWfBuOvB0lS/op2lpO8p1vF0Yw+huvx62YBc+xs3e44y50
 AeoqEvhzT7gT39PsljnoKQ9rAC1YO8VqNjd0xuOFG7vBFztaOg/hT/tNsZ/dw4MqZRDo
 TDhLEHPU5mhwPlzr+FbTvAuw7cLImQQWN6fclzuNZkeyYSODPtW6Cmsh8fgzn+5cLepI
 3PVMcpdkIjdNMKzPSX2eCeqw+BC+6bLpiSLQM2b3qK0ZpNO1CItHZJomV3gZrMhT6COA
 vDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=6DN2mcILOwzBoK4UP9pw9h1MJyuDkVP/POdo6WdvDxc=;
 b=ow6jL3daet4CH/Y+46KDEJKuJIyXhSh8QQcH+TLBchAC5d1VlDh/eN/G26zJA8+5v6
 z5caUt71y3Q20NA8+BY2UjKQSwMNZgLhFHHp876sn6iMPTOYRlCybAZ7fmiG2ocE3cSo
 BwKdS/ytQXxp/aE0i6nVoMdvvFCbRDy0XqQG5qYcLKTan+Azm8+IvT1TCm5sHADz5u72
 hrlx4pLDX6u3a8pgi9LMCwUvrJmbwMcERbFCdAZgl9GxYsp53Pz7LNDvOOM+tNi5im3/
 pbFLFlThsLo374g+USYI6TjnLGTkvbrUVAxs2blFod4bbmjkZ5gkmehjJ/SHcvVzZJGB
 nNnA==
X-Gm-Message-State: AOAM532bLobRcicqLj9XpvXGUAHWtsEyVDq4C1OwWIB3q+lonAyTfUAr
 RL+2adGcnMYz5L23fn/ukUUhZEzoEOLtakBAT98=
X-Google-Smtp-Source: ABdhPJw9K67gJ+CfAee0V3mHlLTaxCxltmhcQe6Bi3zKFn8WuFjIQ/UVzsYWgrqksdnK7qtWswQqOFVdRRpLAcKRd78=
X-Received: by 2002:a19:484d:: with SMTP id v74mr5852401lfa.382.1600176198046; 
 Tue, 15 Sep 2020 06:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200915121318.247-1-luoyonggang@gmail.com>
 <20200915121318.247-5-luoyonggang@gmail.com>
 <20200915130001.GG1502912@redhat.com>
In-Reply-To: <20200915130001.GG1502912@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 15 Sep 2020 21:23:05 +0800
Message-ID: <CAE2XoE9RT7kL9gynTZ=h3oOQhhci_OjWujaWFO82906PCQrP0A@mail.gmail.com>
Subject: Re: [PATCH v9 04/26] win32: Simplify gmtime_r detection direct base
 on _POSIX_THREAD_SAFE_FUNCTIONS.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dcdf6605af5a0d4e"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dcdf6605af5a0d4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 9:00 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:
>
> On Tue, Sep 15, 2020 at 08:12:56PM +0800, Yonggang Luo wrote:
> > First, this reduce the size of configure, configure are tending to
removal in future,
> > and this didn't introduce any new feature or remove any exist feature.
> > Second, the current localtime_r detection are conflict with ncursesw
detection in
> > mingw, when ncursesw detected, it will provide the following compile
flags
> > pkg-config --cflags ncursesw
> > -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L
-IC:/CI-Tools/msys64/mingw64/include/ncursesw
> > And the compile flag _POSIX_C_SOURCE will always cause
_POSIX_THREAD_SAFE_FUNCTIONS to
> > be defined, in new version of mingw, that's will cause localtime_r to
be defined.
> > But the configure script didn't provide _POSIX_C_SOURCE macro, and
that's will result
> > localtime_r not detected because localtime_r are defined in forceinline
manner.
>
> ncursesw is just one of the three curses impls we can select for
> building against, so it doesn't feel right to make an assumption
> that _POSIX_C_SOURCE is always defined.

That's what I am trying to do, not depends on if  _POSIX_C_SOURCE are
defined.
After this patch, whenever   ncursesw or other  curses lib trying define or
not define  _POSIX_C_SOURCE, the source will building properly
Because now, we don't make any assumption about  _POSIX_C_SOURCE, but
before this patch,
The configure always assume msys2/mingw `not define _POSIX_C_SOURCE ` at
all.
Now this restriction are removed, only depends on mingw related
_POSIX_THREAD_SAFE_FUNCTIONS
>
> >
> > And finally cause conflict between QEMU defined localtime_r
> > struct tm *localtime_r(const time_t *timep, struct tm *result);
> > with mingw defined localtime_r
> >
> > ```
> > #if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
> > #define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
> > #endif
> >
> > #ifdef _POSIX_THREAD_SAFE_FUNCTIONS
> > __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time,
struct tm *_Tm) {
> >   return localtime_s(_Tm, _Time) ? NULL : _Tm;
> > }
> > __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct
tm *_Tm) {
> >   return gmtime_s(_Tm, _Time) ? NULL : _Tm;
> > }
> > __forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) =
{
> >   return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
> > }
> > __forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char *
_Str) {
> >   return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
> > }
> > #endif
> > ```
> >
> > So I suggest remove this configure script, and restrict msys2/mingw
version to easy to maintain.
> > And use _POSIX_THREAD_SAFE_FUNCTIONS to guard the localtime_r and
counterpart functions
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  configure                 | 34 ----------------------------------
> >  include/sysemu/os-win32.h |  4 ++--
> >  util/oslib-win32.c        |  2 +-
> >  3 files changed, 3 insertions(+), 37 deletions(-)
> >
> > diff --git a/configure b/configure
> > index dc4b7a2e55..bac48b5b49 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2496,37 +2496,6 @@ if test "$vhost_net" =3D ""; then
> >    test "$vhost_kernel" =3D "yes" && vhost_net=3Dyes
> >  fi
> >
> > -##########################################
> > -# MinGW / Mingw-w64 localtime_r/gmtime_r check
> > -
> > -if test "$mingw32" =3D "yes"; then
> > -    # Some versions of MinGW / Mingw-w64 lack localtime_r
> > -    # and gmtime_r entirely.
> > -    #
> > -    # Some versions of Mingw-w64 define a macro for
> > -    # localtime_r/gmtime_r.
> > -    #
> > -    # Some versions of Mingw-w64 will define functions
> > -    # for localtime_r/gmtime_r, but only if you have
> > -    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun
> > -    # though, unistd.h and pthread.h both define
> > -    # that for you.
> > -    #
> > -    # So this #undef localtime_r and #include <unistd.h>
> > -    # are not in fact redundant.
> > -cat > $TMPC << EOF
> > -#include <unistd.h>
> > -#include <time.h>
> > -#undef localtime_r
> > -int main(void) { localtime_r(NULL, NULL); return 0; }
> > -EOF
> > -    if compile_prog "" "" ; then
> > -        localtime_r=3D"yes"
> > -    else
> > -        localtime_r=3D"no"
> > -    fi
> > -fi
> > -
> >  ##########################################
> >  # pkg-config probe
> >
> > @@ -7088,9 +7057,6 @@ if [ "$bsd" =3D "yes" ] ; then
> >    echo "CONFIG_BSD=3Dy" >> $config_host_mak
> >  fi
> >
> > -if test "$localtime_r" =3D "yes" ; then
> > -  echo "CONFIG_LOCALTIME_R=3Dy" >> $config_host_mak
> > -fi
> >  if test "$qom_cast_debug" =3D "yes" ; then
> >    echo "CONFIG_QOM_CAST_DEBUG=3Dy" >> $config_host_mak
> >  fi
> > diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> > index d8978e28c0..3ac8a53bac 100644
> > --- a/include/sysemu/os-win32.h
> > +++ b/include/sysemu/os-win32.h
> > @@ -48,12 +48,12 @@
> >  #define siglongjmp(env, val) longjmp(env, val)
> >
> >  /* Missing POSIX functions. Don't use MinGW-w64 macros. */
> > -#ifndef CONFIG_LOCALTIME_R
> > +#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
> >  #undef gmtime_r
> >  struct tm *gmtime_r(const time_t *timep, struct tm *result);
> >  #undef localtime_r
> >  struct tm *localtime_r(const time_t *timep, struct tm *result);
> > -#endif /* CONFIG_LOCALTIME_R */
> > +#endif
> >
> >  static inline void os_setup_signal_handling(void) {}
> >  static inline void os_daemonize(void) {}
> > diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> > index c654dafd93..f2fa9a3549 100644
> > --- a/util/oslib-win32.c
> > +++ b/util/oslib-win32.c
> > @@ -106,7 +106,7 @@ void qemu_anon_ram_free(void *ptr, size_t size)
> >      }
> >  }
> >
> > -#ifndef CONFIG_LOCALTIME_R
> > +#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
> >  /* FIXME: add proper locking */
> >  struct tm *gmtime_r(const time_t *timep, struct tm *result)
> >  {
> > --
> > 2.28.0.windows.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000dcdf6605af5a0d4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Sep 15, 2020 at 9:00 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Tue, Sep 15, 2020 at 08:12:56PM +0800, Yonggan=
g Luo wrote:<br>&gt; &gt; First, this reduce the size of configure, configu=
re are tending to removal in future,<br>&gt; &gt; and this didn&#39;t intro=
duce any new feature or remove any exist feature.<br>&gt; &gt; Second, the =
current localtime_r detection are conflict with ncursesw detection in<br>&g=
t; &gt; mingw, when ncursesw detected, it will provide the following compil=
e flags<br>&gt; &gt; pkg-config --cflags ncursesw<br>&gt; &gt; -D_XOPEN_SOU=
RCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC:/CI-Tools/msys64/mingw64/include/=
ncursesw<br>&gt; &gt; And the compile flag _POSIX_C_SOURCE will always caus=
e _POSIX_THREAD_SAFE_FUNCTIONS to<br>&gt; &gt; be defined, in new version o=
f mingw, that&#39;s will cause localtime_r to be defined.<br>&gt; &gt; But =
the configure script didn&#39;t provide _POSIX_C_SOURCE macro, and that&#39=
;s will result<br>&gt; &gt; localtime_r not detected because localtime_r ar=
e defined in forceinline manner.<br>&gt;<br>&gt; ncursesw is just one of th=
e three curses impls we can select for<br>&gt; building against, so it does=
n&#39;t feel right to make an assumption<br>&gt; that _POSIX_C_SOURCE is al=
ways defined.<br><br>That&#39;s what I am trying to do, not depends on if =
=C2=A0_POSIX_C_SOURCE are defined.<br>After this patch, whenever =C2=A0 ncu=
rsesw or other =C2=A0curses lib trying define or not define =C2=A0_POSIX_C_=
SOURCE, the source will building properly<br>Because now, we don&#39;t make=
 any assumption about=C2=A0

_POSIX_C_SOURCE, but before this patch,<div>The configure always assume msy=
s2/mingw `not define _POSIX_C_SOURCE ` at all.</div><div>Now this restricti=
on are removed, only depends on mingw related=C2=A0

_POSIX_THREAD_SAFE_FUNCTIONS=20

<br>&gt;<br>&gt; &gt;<br>&gt; &gt; And finally cause conflict between QEMU =
defined localtime_r<br>&gt; &gt; struct tm *localtime_r(const time_t *timep=
, struct tm *result);<br>&gt; &gt; with mingw defined localtime_r<br>&gt; &=
gt;<br>&gt; &gt; ```<br>&gt; &gt; #if defined(_POSIX_C_SOURCE) &amp;&amp; !=
defined(_POSIX_THREAD_SAFE_FUNCTIONS)<br>&gt; &gt; #define _POSIX_THREAD_SA=
FE_FUNCTIONS 200112L<br>&gt; &gt; #endif<br>&gt; &gt;<br>&gt; &gt; #ifdef _=
POSIX_THREAD_SAFE_FUNCTIONS<br>&gt; &gt; __forceinline struct tm *__CRTDECL=
 localtime_r(const time_t *_Time, struct tm *_Tm) {<br>&gt; &gt; =C2=A0 ret=
urn localtime_s(_Tm, _Time) ? NULL : _Tm;<br>&gt; &gt; }<br>&gt; &gt; __for=
ceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm)=
 {<br>&gt; &gt; =C2=A0 return gmtime_s(_Tm, _Time) ? NULL : _Tm;<br>&gt; &g=
t; }<br>&gt; &gt; __forceinline char *__CRTDECL ctime_r(const time_t *_Time=
, char *_Str) {<br>&gt; &gt; =C2=A0 return ctime_s(_Str, 0x7fffffff, _Time)=
 ? NULL : _Str;<br>&gt; &gt; }<br>&gt; &gt; __forceinline char *__CRTDECL a=
sctime_r(const struct tm *_Tm, char * _Str) {<br>&gt; &gt; =C2=A0 return as=
ctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;<br>&gt; &gt; }<br>&gt; &gt; #=
endif<br>&gt; &gt; ```<br>&gt; &gt;<br>&gt; &gt; So I suggest remove this c=
onfigure script, and restrict msys2/mingw version to easy to maintain.<br>&=
gt; &gt; And use _POSIX_THREAD_SAFE_FUNCTIONS to guard the localtime_r and =
counterpart functions<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo=
 &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;=
<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 34 ----------------------------------<br>&gt;=
 &gt; =C2=A0include/sysemu/os-win32.h | =C2=A04 ++--<br>&gt; &gt; =C2=A0uti=
l/oslib-win32.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; &gt; =C2=A0=
3 files changed, 3 insertions(+), 37 deletions(-)<br>&gt; &gt;<br>&gt; &gt;=
 diff --git a/configure b/configure<br>&gt; &gt; index dc4b7a2e55..bac48b5b=
49 100755<br>&gt; &gt; --- a/configure<br>&gt; &gt; +++ b/configure<br>&gt;=
 &gt; @@ -2496,37 +2496,6 @@ if test &quot;$vhost_net&quot; =3D &quot;&quot=
;; then<br>&gt; &gt; =C2=A0 =C2=A0test &quot;$vhost_kernel&quot; =3D &quot;=
yes&quot; &amp;&amp; vhost_net=3Dyes<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; <br=
>&gt; &gt; -##########################################<br>&gt; &gt; -# MinG=
W / Mingw-w64 localtime_r/gmtime_r check<br>&gt; &gt; -<br>&gt; &gt; -if te=
st &quot;$mingw32&quot; =3D &quot;yes&quot;; then<br>&gt; &gt; - =C2=A0 =C2=
=A0# Some versions of MinGW / Mingw-w64 lack localtime_r<br>&gt; &gt; - =C2=
=A0 =C2=A0# and gmtime_r entirely.<br>&gt; &gt; - =C2=A0 =C2=A0#<br>&gt; &g=
t; - =C2=A0 =C2=A0# Some versions of Mingw-w64 define a macro for<br>&gt; &=
gt; - =C2=A0 =C2=A0# localtime_r/gmtime_r.<br>&gt; &gt; - =C2=A0 =C2=A0#<br=
>&gt; &gt; - =C2=A0 =C2=A0# Some versions of Mingw-w64 will define function=
s<br>&gt; &gt; - =C2=A0 =C2=A0# for localtime_r/gmtime_r, but only if you h=
ave<br>&gt; &gt; - =C2=A0 =C2=A0# _POSIX_THREAD_SAFE_FUNCTIONS defined. For=
 fun<br>&gt; &gt; - =C2=A0 =C2=A0# though, unistd.h and pthread.h both defi=
ne<br>&gt; &gt; - =C2=A0 =C2=A0# that for you.<br>&gt; &gt; - =C2=A0 =C2=A0=
#<br>&gt; &gt; - =C2=A0 =C2=A0# So this #undef localtime_r and #include &lt=
;unistd.h&gt;<br>&gt; &gt; - =C2=A0 =C2=A0# are not in fact redundant.<br>&=
gt; &gt; -cat &gt; $TMPC &lt;&lt; EOF<br>&gt; &gt; -#include &lt;unistd.h&g=
t;<br>&gt; &gt; -#include &lt;time.h&gt;<br>&gt; &gt; -#undef localtime_r<b=
r>&gt; &gt; -int main(void) { localtime_r(NULL, NULL); return 0; }<br>&gt; =
&gt; -EOF<br>&gt; &gt; - =C2=A0 =C2=A0if compile_prog &quot;&quot; &quot;&q=
uot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0localtime_r=3D&quot;y=
es&quot;<br>&gt; &gt; - =C2=A0 =C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0localtime_r=3D&quot;no&quot;<br>&gt; &gt; - =C2=A0 =C2=A0fi<br>&g=
t; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; =C2=A0#############################=
#############<br>&gt; &gt; =C2=A0# pkg-config probe<br>&gt; &gt; <br>&gt; &=
gt; @@ -7088,9 +7057,6 @@ if [ &quot;$bsd&quot; =3D &quot;yes&quot; ] ; the=
n<br>&gt; &gt; =C2=A0 =C2=A0echo &quot;CONFIG_BSD=3Dy&quot; &gt;&gt; $confi=
g_host_mak<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; <br>&gt; &gt; -if test &quot;=
$localtime_r&quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0echo &qu=
ot;CONFIG_LOCALTIME_R=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; -fi<=
br>&gt; &gt; =C2=A0if test &quot;$qom_cast_debug&quot; =3D &quot;yes&quot; =
; then<br>&gt; &gt; =C2=A0 =C2=A0echo &quot;CONFIG_QOM_CAST_DEBUG=3Dy&quot;=
 &gt;&gt; $config_host_mak<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; diff --git a/=
include/sysemu/os-win32.h b/include/sysemu/os-win32.h<br>&gt; &gt; index d8=
978e28c0..3ac8a53bac 100644<br>&gt; &gt; --- a/include/sysemu/os-win32.h<br=
>&gt; &gt; +++ b/include/sysemu/os-win32.h<br>&gt; &gt; @@ -48,12 +48,12 @@=
<br>&gt; &gt; =C2=A0#define siglongjmp(env, val) longjmp(env, val)<br>&gt; =
&gt; <br>&gt; &gt; =C2=A0/* Missing POSIX functions. Don&#39;t use MinGW-w6=
4 macros. */<br>&gt; &gt; -#ifndef CONFIG_LOCALTIME_R<br>&gt; &gt; +#ifndef=
 _POSIX_THREAD_SAFE_FUNCTIONS<br>&gt; &gt; =C2=A0#undef gmtime_r<br>&gt; &g=
t; =C2=A0struct tm *gmtime_r(const time_t *timep, struct tm *result);<br>&g=
t; &gt; =C2=A0#undef localtime_r<br>&gt; &gt; =C2=A0struct tm *localtime_r(=
const time_t *timep, struct tm *result);<br>&gt; &gt; -#endif /* CONFIG_LOC=
ALTIME_R */<br>&gt; &gt; +#endif<br>&gt; &gt; <br>&gt; &gt; =C2=A0static in=
line void os_setup_signal_handling(void) {}<br>&gt; &gt; =C2=A0static inlin=
e void os_daemonize(void) {}<br>&gt; &gt; diff --git a/util/oslib-win32.c b=
/util/oslib-win32.c<br>&gt; &gt; index c654dafd93..f2fa9a3549 100644<br>&gt=
; &gt; --- a/util/oslib-win32.c<br>&gt; &gt; +++ b/util/oslib-win32.c<br>&g=
t; &gt; @@ -106,7 +106,7 @@ void qemu_anon_ram_free(void *ptr, size_t size)=
<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; =C2=A0}<br>&gt; &gt; <br>&=
gt; &gt; -#ifndef CONFIG_LOCALTIME_R<br>&gt; &gt; +#ifndef _POSIX_THREAD_SA=
FE_FUNCTIONS<br>&gt; &gt; =C2=A0/* FIXME: add proper locking */<br>&gt; &gt=
; =C2=A0struct tm *gmtime_r(const time_t *timep, struct tm *result)<br>&gt;=
 &gt; =C2=A0{<br>&gt; &gt; --<br>&gt; &gt; 2.28.0.windows.1<br>&gt; &gt;<br=
>&gt; &gt;<br>&gt;<br>&gt; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a=
 href=3D"https://berrange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=
=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.flickr.com/photos/dberrange">htt=
ps://www.flickr.com/photos/dberrange</a> :|<br>&gt; |: <a href=3D"https://l=
ibvirt.org">https://libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com"=
>https://fstop138.berrange.com</a> :|<br>&gt; |: <a href=3D"https://entangl=
e-photo.org">https://entangle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<=
a href=3D"https://www.instagram.com/dberrange">https://www.instagram.com/db=
errange</a> :|<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000dcdf6605af5a0d4e--

