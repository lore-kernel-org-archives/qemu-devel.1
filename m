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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10736C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E79B206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0/q2YBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E79B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGUM-0006Un-JJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIGSC-0004M1-8C; Tue, 15 Sep 2020 15:17:24 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIGS8-0002Rr-0J; Tue, 15 Sep 2020 15:17:23 -0400
Received: by mail-lf1-x143.google.com with SMTP id b22so4258107lfs.13;
 Tue, 15 Sep 2020 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=gAQCC2THZ4BDSX7taD02VqYincq+fZsD23hrk3Iq2wU=;
 b=K0/q2YBCKdO16eP4S2kGd6BGZEwRPRgoQ+gEcYZx2xroZuwwqCcUbSBHNNajvN9i9A
 Hd2d8LBHt1unzbwGGzibObJqr4AP/Zjr1JCPqb9xydizNJLPVgb54pj6PbsQKctfgS+0
 5f5qs6LzIWqM91tDYWZII9a+5eCA36hIMU1JP5efKDIfa3CdZzodirrVgTA3MYvkHxt6
 Jhd9s4PdeD6VpJvmijyGfts5aOjb/JnZTQPOod4rm03cbRNe0FuC8EsjjYurVR30JvJk
 VbbeZeKqhyElRil2x/NNxko3lOUtMzW5w7JkDY/fcIokZGCBNwUMUNX4l0pJiOggeTzZ
 z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=gAQCC2THZ4BDSX7taD02VqYincq+fZsD23hrk3Iq2wU=;
 b=lrIBCNpcs2bLdGv6TSikeGY+oDdKjfUahrq+XQ3QyH+1pvyMvqf43wsxwgQIvOnmId
 4kqS07wLMBL+aa1yH+f18FpkUG232BOX5mY3Z/OD1MXf33q3VObWZ5CEtbsdhwKt1fqt
 sYXo2+8pZRmb9kDqr4xSTus1QZFDxblNujLmvW47n4mTk8eKpk909xVJAr7xEFRBuTuD
 CUjqoY/adu8dH1eJPNqgZVdMJtw837RFZulcrmfUmHUZThhm8wlxB1lttHQfxBiTpNQB
 GfOD0YrPqD9jvBV4ga+90/AbRnk/nWBxvXgu42Y4SFFsij0Xr/oq71v23BlZK6jMAKdK
 QBeA==
X-Gm-Message-State: AOAM532dj3r1Y/D1zFgrfYeMgyAZSKlQZeeWBHecUdW1KSylq1k00cAO
 gI3rc2CAmCbYXmPPHBHKn4WXqsCvMKTQ6tTNGcQ=
X-Google-Smtp-Source: ABdhPJwRC4fpqWvkiWcS03WUFZqzr/CbbdSFt7MhRIoCNzIs9vPUBUAfZT2buZJNSe1cG/bqgFucHQxw3qkLNbXpjhI=
X-Received: by 2002:a19:9141:: with SMTP id y1mr5931227lfj.554.1600197437771; 
 Tue, 15 Sep 2020 12:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200915163343.1100-1-luoyonggang@gmail.com>
 <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
 <CAE2XoE8OmSSnzzUivS0jNQu=QEe8c_gPasfksoihdYhO6f4CYg@mail.gmail.com>
 <ba164474-7cb0-1f8f-ef01-2529954a1df9@amsat.org>
In-Reply-To: <ba164474-7cb0-1f8f-ef01-2529954a1df9@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 03:17:04 +0800
Message-ID: <CAE2XoE_N=XWeg1y74=ohb_p5qiH+rewDtwSGfSwkhHJpA2V06A@mail.gmail.com>
Subject: Re: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d954f505af5eff65"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d954f505af5eff65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 1:55 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:
>
> On 9/15/20 7:41 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > On Wed, Sep 16, 2020 at 12:41 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >>
> >> On 9/15/20 6:33 PM, Yonggang Luo wrote:
> >> > error message:
> >> > "cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi"
> > "-Itrace" "-Iui" "-Iui/shader" "-IC:/CI-Tools/msys64/mingw64/include"
> > "-IC:/CI-Tools/msys64/mingw64/include/glib-2.0"
> > "-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/include"
> > "-fdiagnostics-color=3Dauto" "-pipe" "-Wall" "-Winvalid-pch" "-Werror"
> > "-std=3Dgnu99" "-g" "-m64" "-mcx16" "-D_GNU_SOURCE"
> > "-D_FILE_OFFSET_BITS=3D64" "-D_LARGEFILE_SOURCE" "-Wstrict-prototypes"
> > "-Wredundant-decls" "-Wundef" "-Wwrite-strings" "-Wmissing-prototypes"
> > "-fno-strict-aliasing" "-fno-common" "-fwrapv" "-Wold-style-declaration=
"
> > "-Wold-style-definition" "-Wtype-limits" "-Wformat-security"
> > "-Wformat-y2k" "-Winit-self" "-Wignored-qualifiers" "-Wempty-body"
> > "-Wnested-externs" "-Wendif-labels" "-Wexpansion-to-defined"
> > "-Wno-missing-include-dirs" "-Wno-shift-negative-value" "-Wno-psabi"
> > "-fstack-protector-strong" "-iquote" "/c/work/xemu/qemu/tcg/i386"
> > "-iquote" "." "-iquote" "/c/work/xemu/qemu" "-iquote"
> > "/c/work/xemu/qemu/accel/tcg" "-iquote" "/c/work/xemu/qemu/include"
> > "-iquote" "/c/work/xemu/qemu/disas/libvixl" "-pthread" "-mms-bitfields"
> > -MD -MQ qga/qemu-ga.exe.p/commands-win32.c.obj -MF
> > "qga/qemu-ga.exe.p/commands-win32.c.obj.d" -o
> > qga/qemu-ga.exe.p/commands-win32.c.obj "-c" ../qga/commands-win32.c -MP
> >> > ../qga/commands-win32.c:62:24: error: redundant redeclaration of
> > 'CM_Get_DevNode_PropertyW' [-Werror=3Dredundant-decls]
> >> >    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> >> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> >> > In file included from ../qga/commands-win32.c:26:
> >> >
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26=
:
> > note: previous declaration of 'CM_Get_DevNode_PropertyW' was here
> >> >   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST
> > dnDevInst, const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType,
> > PBYTE PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
> >> >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
> >> > cc1.exe: all warnings being treated as errors
> >> > make: [Makefile.ninja:5143=EF=BC=9Aqga/qemu-ga.exe.p/commands-win32.=
c.obj]
> > =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
> >> >
> >> > This error comes from qemu configure didn't add predefined macro
> > -DUNICODE -D_UNICODE in QEMU_CFLAGS,
> >> > and these too macro are standard config for win32 if using windows
> > wide api.
> >> >
> >> > in cfgmgr32.h
> >> >   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,
> > const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
> > PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
> >> > #ifdef UNICODE
> >> > #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> >> > #endif
> >> >
> >> > macro CM_Get_DevNode_Property defined only when UNICODE are defined.
> >> > and in win32, UNICODE and _UNICODE should be defined at the same tim=
e
> >> >
> >> > #endif
> >> >
> >> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > <mailto:luoyonggang@gmail.com>>
> >> > ---
> >> >  configure | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/configure b/configure
> >> > index 9f141891ea..f5d661af4a 100755
> >> > --- a/configure
> >> > +++ b/configure
> >> > @@ -812,6 +812,7 @@ MINGW32*)
> >> >    mingw32=3D"yes"
> >> >    hax=3D"yes"
> >> >    whpx=3D""
> >> > +  QEMU_CFLAGS=3D"-DUNICODE -D_UNICODE $QEMU_CFLAGS"
> >>
> >> What about declaring them in include/qemu/osdep.h
> >> instead?
> > That's a good idea.
> > But more compiling error warns me that the windows version of qemu are
> > not in a good situation.
>
> :)
>
> > On Win32, all API should call the wide version so that support for
> > Unicode properly.
> > But obviously the currently qemu didn't do that
> >
> > ```
> [...]
> > ../util/qemu-sockets.c: In function 'socket_sockaddr_to_address_inet':
> > C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s'
> > expects argument of type 'char *', but argument 6 has type 'WCHAR *'
> > {aka 'short unsigned int *'} [-Werror=3Dformat=3D]
> >   319 |                         (fmt), ## __VA_ARGS__)
> >       |                         ^~~~~
> > ../util/qemu-sockets.c:1235:9: note: in expansion of macro 'error_setg'
> >  1235 |         error_setg(errp, "Cannot format numeric socket address:
%s",
> >       |         ^~~~~~~~~~
> > In file included from ../io/dns-resolver.c:26:
> > ../io/dns-resolver.c: In function 'qio_dns_resolver_lookup_sync_inet':
> > C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s'
> > expects argument of type 'char *', but argument 8 has type 'WCHAR *'
> > {aka 'short unsigned int *'} [-Werror=3Dformat=3D]
> >   319 |                         (fmt), ## __VA_ARGS__)
> >       |                         ^~~~~
> > ../io/dns-resolver.c:93:9: note: in expansion of macro 'error_setg'
> >    93 |         error_setg(errp, "address resolution failed for %s:%s:
%s",
> >       |         ^~~~~~~~~~
> > cc1.exe: all warnings being treated as errors
> > make: [Makefile.ninja:756=EF=BC=9Aio/libio.fa.p/dns-resolver.c.obj] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2
> > =E5=BF=BD=E7=95=A5=EF=BC=89
> > cc1.exe: all warnings being treated as errors
> > make: [Makefile.ninja:697=EF=BC=9Alibqemuutil.a.p/util_qemu-sockets.c.o=
bj] =E9=94=99=E8=AF=AF
> > 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
> > Linking static target io/libio.fa
> > C:\CI-Tools\msys64\mingw64\bin\ar.exe: io/libio.fa.p/dns-resolver.c.obj=
:
> > No such file or directory
> > make: [Makefile.ninja:764=EF=BC=9Aio/libio.fa] =E9=94=99=E8=AF=AF 1 (=
=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
> > ../net/tap-win32.c: In function 'is_tap_win32_dev':
> > ../net/tap-win32.c:62:21: error: passing argument 2 of 'RegOpenKeyExW'
> > from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >    62 | #define ADAPTER_KEY
> >
"SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002B=
E10318}"
> >       |
> >
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >       |                     |
> >       |                     const char *
> > ../net/tap-win32.c:62:21: note: in definition of macro 'ADAPTER_KEY'
> >    62 | #define ADAPTER_KEY
> >
"SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002B=
E10318}"
> >       |
> >
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> > In file included from
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
> >                  from
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
> >                  from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
> >                  from C:/work/xemu/qemu/include/qemu/osdep.h:119,
> >                  from ../net/tap-win32.c:29:
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
> > note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argumen=
t
> > is of type 'const char *'
> >   195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
> > lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
> >       |                                                 ~~~~~~~~^~~~~~~=
~
> > ../net/tap-win32.c:229:13: error: passing argument 3 of 'RegEnumKeyExW'
> > from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >   229 |             enum_name,
> >       |             ^~~~~~~~~
> >       |             |
> >       |             char *
> > In file included from
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
> >                  from
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
> >                  from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
> >                  from C:/work/xemu/qemu/include/qemu/osdep.h:119,
> >                  from ../net/tap-win32.c:29:
> > C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:184:70:
> > note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
> > type 'char *'
> >   184 |   WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey,DWORD
> > dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR
> > lpClass,LPDWORD lpcchClass,PFILETIME lpftLastWriteTime);
> >       |
> > ~~~~~~~^~~~~~
> > ../net/tap-win32.c:247:13: error: passing argument 2 of 'RegOpenKeyExW'
> > from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >   247 |             unit_string,
> >       |             ^~~~~~~~~~~
> >       |             |
> >       |             char *
>
> I'm not sure fixing all these warnings would produce a
> maintainable code base. I'd rather disable these 2 warning
> classes on Windows.
I agree with that, seems QEMU currently are calling ANSI api all the time,
better not change that,
 so globally define -DUNICODE -D_UNICODE is not a option


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d954f505af5eff65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 1:55 AM Philippe Mathieu-D=
aud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wr=
ote:<br>&gt;<br>&gt; On 9/15/20 7:41 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yongga=
ng Luo) wrote:<br>&gt; &gt; On Wed, Sep 16, 2020 at 12:41 AM Philippe Mathi=
eu-Daud=C3=A9<br>&gt; &gt; &lt;<a href=3D"mailto:philmd@redhat.com">philmd@=
redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com">philmd@redha=
t.com</a>&gt;&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 9/15/20 6:33 =
PM, Yonggang Luo wrote:<br>&gt; &gt;&gt; &gt; error message:<br>&gt; &gt;&g=
t; &gt; &quot;cc&quot; &quot;-Iqga/qemu-ga.exe.p&quot; &quot;-Iqga&quot; &q=
uot;-I../qga&quot; &quot;-I.&quot; &quot;-Iqapi&quot;<br>&gt; &gt; &quot;-I=
trace&quot; &quot;-Iui&quot; &quot;-Iui/shader&quot; &quot;-IC:/CI-Tools/ms=
ys64/mingw64/include&quot;<br>&gt; &gt; &quot;-IC:/CI-Tools/msys64/mingw64/=
include/glib-2.0&quot;<br>&gt; &gt; &quot;-IC:/CI-Tools/msys64/mingw64/lib/=
glib-2.0/include&quot;<br>&gt; &gt; &quot;-fdiagnostics-color=3Dauto&quot; =
&quot;-pipe&quot; &quot;-Wall&quot; &quot;-Winvalid-pch&quot; &quot;-Werror=
&quot;<br>&gt; &gt; &quot;-std=3Dgnu99&quot; &quot;-g&quot; &quot;-m64&quot=
; &quot;-mcx16&quot; &quot;-D_GNU_SOURCE&quot;<br>&gt; &gt; &quot;-D_FILE_O=
FFSET_BITS=3D64&quot; &quot;-D_LARGEFILE_SOURCE&quot; &quot;-Wstrict-protot=
ypes&quot;<br>&gt; &gt; &quot;-Wredundant-decls&quot; &quot;-Wundef&quot; &=
quot;-Wwrite-strings&quot; &quot;-Wmissing-prototypes&quot;<br>&gt; &gt; &q=
uot;-fno-strict-aliasing&quot; &quot;-fno-common&quot; &quot;-fwrapv&quot; =
&quot;-Wold-style-declaration&quot;<br>&gt; &gt; &quot;-Wold-style-definiti=
on&quot; &quot;-Wtype-limits&quot; &quot;-Wformat-security&quot;<br>&gt; &g=
t; &quot;-Wformat-y2k&quot; &quot;-Winit-self&quot; &quot;-Wignored-qualifi=
ers&quot; &quot;-Wempty-body&quot;<br>&gt; &gt; &quot;-Wnested-externs&quot=
; &quot;-Wendif-labels&quot; &quot;-Wexpansion-to-defined&quot;<br>&gt; &gt=
; &quot;-Wno-missing-include-dirs&quot; &quot;-Wno-shift-negative-value&quo=
t; &quot;-Wno-psabi&quot;<br>&gt; &gt; &quot;-fstack-protector-strong&quot;=
 &quot;-iquote&quot; &quot;/c/work/xemu/qemu/tcg/i386&quot;<br>&gt; &gt; &q=
uot;-iquote&quot; &quot;.&quot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu=
&quot; &quot;-iquote&quot;<br>&gt; &gt; &quot;/c/work/xemu/qemu/accel/tcg&q=
uot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu/include&quot;<br>&gt; &gt;=
 &quot;-iquote&quot; &quot;/c/work/xemu/qemu/disas/libvixl&quot; &quot;-pth=
read&quot; &quot;-mms-bitfields&quot;<br>&gt; &gt; -MD -MQ qga/qemu-ga.exe.=
p/commands-win32.c.obj -MF<br>&gt; &gt; &quot;qga/qemu-ga.exe.p/commands-wi=
n32.c.obj.d&quot; -o<br>&gt; &gt; qga/qemu-ga.exe.p/commands-win32.c.obj &q=
uot;-c&quot; ../qga/commands-win32.c -MP<br>&gt; &gt;&gt; &gt; ../qga/comma=
nds-win32.c:62:24: error: redundant redeclaration of<br>&gt; &gt; &#39;CM_G=
et_DevNode_PropertyW&#39; [-Werror=3Dredundant-decls]<br>&gt; &gt;&gt; &gt;=
 =C2=A0 =C2=A062 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>&gt;=
 &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~<br=
>&gt; &gt;&gt; &gt; In file included from ../qga/commands-win32.c:26:<br>&g=
t; &gt;&gt; &gt;<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32=
/include/cfgmgr32.h:840:26:<br>&gt; &gt; note: previous declaration of &#39=
;CM_Get_DevNode_PropertyW&#39; was here<br>&gt; &gt;&gt; &gt; =C2=A0 840 | =
=C2=A0 CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST<br>&gt; &gt;=
 dnDevInst, const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType,<br>&g=
t; &gt; PBYTE PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);<br=
>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~=
~~~~~~~~<br>&gt; &gt;&gt; &gt; cc1.exe: all warnings being treated as error=
s<br>&gt; &gt;&gt; &gt; make: [Makefile.ninja:5143=EF=BC=9Aqga/qemu-ga.exe.=
p/commands-win32.c.obj]<br>&gt; &gt; =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=
=BD=E7=95=A5=EF=BC=89<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; This erro=
r comes from qemu configure didn&#39;t add predefined macro<br>&gt; &gt; -D=
UNICODE -D_UNICODE in QEMU_CFLAGS,<br>&gt; &gt;&gt; &gt; and these too macr=
o are standard config for win32 if using windows<br>&gt; &gt; wide api.<br>=
&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; in cfgmgr32.h<br>&gt; &gt;&gt; &gt=
; =C2=A0 CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,=
<br>&gt; &gt; const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBY=
TE<br>&gt; &gt; PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);<=
br>&gt; &gt;&gt; &gt; #ifdef UNICODE<br>&gt; &gt;&gt; &gt; #define CM_Get_D=
evNode_Property CM_Get_DevNode_PropertyW<br>&gt; &gt;&gt; &gt; #endif<br>&g=
t; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; macro CM_Get_DevNode_Property define=
d only when UNICODE are defined.<br>&gt; &gt;&gt; &gt; and in win32, UNICOD=
E and _UNICODE should be defined at the same time<br>&gt; &gt;&gt; &gt;<br>=
&gt; &gt;&gt; &gt; #endif<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Signe=
d-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyong=
gang@gmail.com</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:luoyonggang@gm=
ail.com">luoyonggang@gmail.com</a>&gt;&gt;<br>&gt; &gt;&gt; &gt; ---<br>&gt=
; &gt;&gt; &gt; =C2=A0configure | 1 +<br>&gt; &gt;&gt; &gt; =C2=A01 file ch=
anged, 1 insertion(+)<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; diff --gi=
t a/configure b/configure<br>&gt; &gt;&gt; &gt; index 9f141891ea..f5d661af4=
a 100755<br>&gt; &gt;&gt; &gt; --- a/configure<br>&gt; &gt;&gt; &gt; +++ b/=
configure<br>&gt; &gt;&gt; &gt; @@ -812,6 +812,7 @@ MINGW32*)<br>&gt; &gt;&=
gt; &gt; =C2=A0 =C2=A0mingw32=3D&quot;yes&quot;<br>&gt; &gt;&gt; &gt; =C2=
=A0 =C2=A0hax=3D&quot;yes&quot;<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0whpx=3D&=
quot;&quot;<br>&gt; &gt;&gt; &gt; + =C2=A0QEMU_CFLAGS=3D&quot;-DUNICODE -D_=
UNICODE $QEMU_CFLAGS&quot;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; What about dec=
laring them in include/qemu/osdep.h<br>&gt; &gt;&gt; instead?<br>&gt; &gt; =
That&#39;s a good idea.<br>&gt; &gt; But more compiling error warns me that=
 the windows version of qemu are<br>&gt; &gt; not in a good situation.<br>&=
gt;<br>&gt; :)<br>&gt;<br>&gt; &gt; On Win32, all API should call the wide =
version so that support for<br>&gt; &gt; Unicode properly.<br>&gt; &gt; But=
 obviously the currently qemu didn&#39;t do that<br>&gt; &gt;<br>&gt; &gt; =
```<br>&gt; [...]<br>&gt; &gt; ../util/qemu-sockets.c: In function &#39;soc=
ket_sockaddr_to_address_inet&#39;:<br>&gt; &gt; C:/work/xemu/qemu/include/q=
api/error.h:319:25: error: format &#39;%s&#39;<br>&gt; &gt; expects argumen=
t of type &#39;char *&#39;, but argument 6 has type &#39;WCHAR *&#39;<br>&g=
t; &gt; {aka &#39;short unsigned int *&#39;} [-Werror=3Dformat=3D]<br>&gt; =
&gt; =C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~~~~<br>&gt; &gt; ../util/qemu-sockets.c:1235:9: not=
e: in expansion of macro &#39;error_setg&#39;<br>&gt; &gt; =C2=A01235 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cannot format numeric socke=
t address: %s&quot;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~~<br>&gt; &gt; In file included from ../io/dns-resolver=
.c:26:<br>&gt; &gt; ../io/dns-resolver.c: In function &#39;qio_dns_resolver=
_lookup_sync_inet&#39;:<br>&gt; &gt; C:/work/xemu/qemu/include/qapi/error.h=
:319:25: error: format &#39;%s&#39;<br>&gt; &gt; expects argument of type &=
#39;char *&#39;, but argument 8 has type &#39;WCHAR *&#39;<br>&gt; &gt; {ak=
a &#39;short unsigned int *&#39;} [-Werror=3Dformat=3D]<br>&gt; &gt; =C2=A0=
 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~<br>&gt; &gt; ../io/dns-resolver.c:93:9: note: in expansion=
 of macro &#39;error_setg&#39;<br>&gt; &gt; =C2=A0 =C2=A093 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 error_setg(errp, &quot;address resolution failed for %s:%s: =
%s&quot;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
~~~~~~~~~<br>&gt; &gt; cc1.exe: all warnings being treated as errors<br>&gt=
; &gt; make: [Makefile.ninja:756=EF=BC=9Aio/libio.fa.p/dns-resolver.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2<br>&gt; &gt; =E5=BF=BD=E7=95=A5=EF=BC=89<br=
>&gt; &gt; cc1.exe: all warnings being treated as errors<br>&gt; &gt; make:=
 [Makefile.ninja:697=EF=BC=9Alibqemuutil.a.p/util_qemu-sockets.c.obj] =E9=
=94=99=E8=AF=AF<br>&gt; &gt; 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>&gt=
; &gt; Linking static target io/libio.fa<br>&gt; &gt; C:\CI-Tools\msys64\mi=
ngw64\bin\ar.exe: io/libio.fa.p/dns-resolver.c.obj:<br>&gt; &gt; No such fi=
le or directory<br>&gt; &gt; make: [Makefile.ninja:764=EF=BC=9Aio/libio.fa]=
 =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>&gt; &gt; ..=
/net/tap-win32.c: In function &#39;is_tap_win32_dev&#39;:<br>&gt; &gt; ../n=
et/tap-win32.c:62:21: error: passing argument 2 of &#39;RegOpenKeyExW&#39;<=
br>&gt; &gt; from incompatible pointer type [-Werror=3Dincompatible-pointer=
-types]<br>&gt; &gt; =C2=A0 =C2=A062 | #define ADAPTER_KEY<br>&gt; &gt; &qu=
ot;SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-0800=
2BE10318}&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>&gt; &gt; ^~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>&=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *=
<br>&gt; &gt; ../net/tap-win32.c:62:21: note: in definition of macro &#39;A=
DAPTER_KEY&#39;<br>&gt; &gt; =C2=A0 =C2=A062 | #define ADAPTER_KEY<br>&gt; =
&gt; &quot;SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-B=
FC1-08002BE10318}&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>&gt; &gt; ^~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~<br>&gt; &gt; In file included from<br>&gt; &gt; C:/CI-Tools/msys64/mingw=
64/x86_64-w64-mingw32/include/windows.h:76,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>&gt; &gt; C:/CI-Tools/=
msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/o=
sdep.h:119,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>&gt; &gt; C:/CI-Tools/msys64/mi=
ngw64/x86_64-w64-mingw32/include/winreg.h:195:57:<br>&gt; &gt; note: expect=
ed &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argumen=
t<br>&gt; &gt; is of type &#39;const char *&#39;<br>&gt; &gt; =C2=A0 195 | =
=C2=A0 WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR<br>&gt; &gt; l=
pSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~<br>&gt; &gt; ../=
net/tap-win32.c:229:13: error: passing argument 3 of &#39;RegEnumKeyExW&#39=
;<br>&gt; &gt; from incompatible pointer type [-Werror=3Dincompatible-point=
er-types]<br>&gt; &gt; =C2=A0 229 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enum_name,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>&gt; &gt; In file included=
 from<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/wi=
ndows.h:76,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw3=
2/include/winsock2.h:23,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h=
:29,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../net/tap-win3=
2.c:29:<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/=
winreg.h:184:70:<br>&gt; &gt; note: expected &#39;LPWSTR&#39; {aka &#39;sho=
rt unsigned int *&#39;} but argument is of<br>&gt; &gt; type &#39;char *&#3=
9;<br>&gt; &gt; =C2=A0 184 | =C2=A0 WINADVAPI LONG WINAPI RegEnumKeyExW(HKE=
Y hKey,DWORD<br>&gt; &gt; dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD l=
pReserved,LPWSTR<br>&gt; &gt; lpClass,LPDWORD lpcchClass,PFILETIME lpftLast=
WriteTime);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>&gt; &gt; ~~~~~~~^~~~~~<br>&gt=
; &gt; ../net/tap-win32.c:247:13: error: passing argument 2 of &#39;RegOpen=
KeyExW&#39;<br>&gt; &gt; from incompatible pointer type [-Werror=3Dincompat=
ible-pointer-types]<br>&gt; &gt; =C2=A0 247 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 unit_string,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>&gt;<br>&g=
t; I&#39;m not sure fixing all these warnings would produce a<br>&gt; maint=
ainable code base. I&#39;d rather disable these 2 warning<br>&gt; classes o=
n Windows.<br>I agree with that, seems QEMU currently are calling ANSI api =
all the time, better not change that,<div>=C2=A0so globally define

-DUNICODE -D_UNICODE is not a option<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000d954f505af5eff65--

