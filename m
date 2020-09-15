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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8453DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8726C206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEhc0hFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8726C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF7c-0000xL-Jx
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEy1-0004tY-N9; Tue, 15 Sep 2020 13:42:10 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:32879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIExt-0006Vo-9J; Tue, 15 Sep 2020 13:42:09 -0400
Received: by mail-lf1-x144.google.com with SMTP id x77so4048936lfa.0;
 Tue, 15 Sep 2020 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=BBkV6e2AhCX8PgJIAx9K2czFFSg3LycpBAn/e8LFbPY=;
 b=OEhc0hFb2P15GHRARH9FzvgK1qty9FcpyJQFmetVK0hG++9OMoOb55GqkZaFzc9YAn
 ZILLFSuUczTEGGeDJdSD8x7f5TjyER9sF/kRTSjzCKMaVmbBqExHZlfFsuEhVrOGdPfx
 LDD+jJeM3PXPOrCtgT63973r+GB8TTkBn67m/ARb3w9/nhetqwF+4qR5THiV/43hxsy0
 v4t3IqY+V3I8ogM4McpJli7yRL2OoaVLeleu1irzMyqvs7AAQBJSjgVU9xJpTSGt5jue
 h70I6D/bkhRxRFQ/P4vBFaOowJMsid5xJxOSInwuYX25QfAxMevUKnVM/nKGycWHf5+Q
 cuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=BBkV6e2AhCX8PgJIAx9K2czFFSg3LycpBAn/e8LFbPY=;
 b=NMkMvtjKZ+NPftnOVKIig6VDDJuVRPbvv2zFp0sG8iTNP5J0qnhsS6DYarXDPd4x7g
 xReDjJIatzsMIky1LIyOmB/Tcuwk2tv5fARsMMRZ/HrdXl7u3dNcYcerFexbpxSxqZGe
 uhJD0WS/qdv07V72JsZY+3/S0+AulYko61Hd6A2uj24pVvXQ/0FWU9xpalvtXL+G5wMX
 w7GY4yhxD4vJFs9D7X/1icvvfQhXrLWo2IEyv6PD/y9zlO+TsHnYQYHhXqZJPGEkA3FR
 Bwnav36CnnYxF0CdCF/1G15nNNT+2dix2xBKlmcTCXZFXcrUQRB6WXRksLeNTFZYIrFM
 0SaA==
X-Gm-Message-State: AOAM530x7Htq6eeWrLNYIcJ/rhQF0DDWlxVEnDCQhvKnHAxUXLXtwX0D
 Qygga1vc8OqbgP3beb35VKJm9/pOUYJENulzlQ4=
X-Google-Smtp-Source: ABdhPJw0V3B1Atbqx5PeqP65N2UtvP3KVcKASI4firVZK9nuudYfxGPlz0A5v5FZIiYf2EAxrzyngEq3pQmELOC0bSQ=
X-Received: by 2002:a19:560a:: with SMTP id k10mr5854243lfb.599.1600191717046; 
 Tue, 15 Sep 2020 10:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200915163343.1100-1-luoyonggang@gmail.com>
 <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
In-Reply-To: <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 01:41:33 +0800
Message-ID: <CAE2XoE8OmSSnzzUivS0jNQu=QEe8c_gPasfksoihdYhO6f4CYg@mail.gmail.com>
Subject: Re: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ddfe0c05af5daa2e"
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ddfe0c05af5daa2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 12:41 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:
>
> On 9/15/20 6:33 PM, Yonggang Luo wrote:
> > error message:
> > "cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi" "-Itrace"
"-Iui" "-Iui/shader" "-IC:/CI-Tools/msys64/mingw64/include"
"-IC:/CI-Tools/msys64/mingw64/include/glib-2.0"
"-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/include"
"-fdiagnostics-color=3Dauto" "-pipe" "-Wall" "-Winvalid-pch" "-Werror"
"-std=3Dgnu99" "-g" "-m64" "-mcx16" "-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=3D=
64"
"-D_LARGEFILE_SOURCE" "-Wstrict-prototypes" "-Wredundant-decls" "-Wundef"
"-Wwrite-strings" "-Wmissing-prototypes" "-fno-strict-aliasing"
"-fno-common" "-fwrapv" "-Wold-style-declaration" "-Wold-style-definition"
"-Wtype-limits" "-Wformat-security" "-Wformat-y2k" "-Winit-self"
"-Wignored-qualifiers" "-Wempty-body" "-Wnested-externs" "-Wendif-labels"
"-Wexpansion-to-defined" "-Wno-missing-include-dirs"
"-Wno-shift-negative-value" "-Wno-psabi" "-fstack-protector-strong"
"-iquote" "/c/work/xemu/qemu/tcg/i386" "-iquote" "." "-iquote"
"/c/work/xemu/qemu" "-iquote" "/c/work/xemu/qemu/accel/tcg" "-iquote"
"/c/work/xemu/qemu/include" "-iquote" "/c/work/xemu/qemu/disas/libvixl"
"-pthread" "-mms-bitfields" -MD -MQ qga/qemu-ga.exe.p/commands-win32.c.obj
-MF "qga/qemu-ga.exe.p/commands-win32.c.obj.d" -o
qga/qemu-ga.exe.p/commands-win32.c.obj "-c" ../qga/commands-win32.c -MP
> > ../qga/commands-win32.c:62:24: error: redundant redeclaration of
'CM_Get_DevNode_PropertyW' [-Werror=3Dredundant-decls]
> >    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ../qga/commands-win32.c:26:
> >
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26:
note: previous declaration of 'CM_Get_DevNode_PropertyW' was here
> >   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST
dnDevInst, const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
> >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
> > cc1.exe: all warnings being treated as errors
> > make: [Makefile.ninja:5143=EF=BC=9Aqga/qemu-ga.exe.p/commands-win32.c.o=
bj] =E9=94=99=E8=AF=AF 1
(=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
> >
> > This error comes from qemu configure didn't add predefined macro
-DUNICODE -D_UNICODE in QEMU_CFLAGS,
> > and these too macro are standard config for win32 if using windows wide
api.
> >
> > in cfgmgr32.h
> >   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,
const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
> > #ifdef UNICODE
> > #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> > #endif
> >
> > macro CM_Get_DevNode_Property defined only when UNICODE are defined.
> > and in win32, UNICODE and _UNICODE should be defined at the same time
> >
> > #endif
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  configure | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/configure b/configure
> > index 9f141891ea..f5d661af4a 100755
> > --- a/configure
> > +++ b/configure
> > @@ -812,6 +812,7 @@ MINGW32*)
> >    mingw32=3D"yes"
> >    hax=3D"yes"
> >    whpx=3D""
> > +  QEMU_CFLAGS=3D"-DUNICODE -D_UNICODE $QEMU_CFLAGS"
>
> What about declaring them in include/qemu/osdep.h
> instead?
That's a good idea.
But more compiling error warns me that the windows version of qemu are not
in a good situation.
On Win32, all API should call the wide version so that support for Unicode
properly.
But obviously the currently qemu didn't do that

```

Compiling C object qga/qemu-ga.exe.p/commands-win32.c.obj
In file included from ../util/qemu-sockets.c:27:
../util/qemu-sockets.c: In function 'inet_listen_saddr':
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 8 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../util/qemu-sockets.c:274:9: note: in expansion of macro 'error_setg'
  274 |         error_setg(errp, "address resolution failed for %s:%s: %s",
      |         ^~~~~~~~~~
../util/qemu-sockets.c: In function 'inet_parse_connect_saddr':
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 8 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../util/qemu-sockets.c:429:9: note: in expansion of macro 'error_setg'
  429 |         error_setg(errp, "address resolution failed for %s:%s: %s",
      |         ^~~~~~~~~~
../util/qemu-sockets.c: In function 'inet_dgram_saddr':
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 8 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../util/qemu-sockets.c:518:9: note: in expansion of macro 'error_setg'
  518 |         error_setg(errp, "address resolution failed for %s:%s: %s",
addr, port,
      |         ^~~~~~~~~~
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 8 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../util/qemu-sockets.c:544:9: note: in expansion of macro 'error_setg'
  544 |         error_setg(errp, "address resolution failed for %s:%s: %s",
addr, port,
      |         ^~~~~~~~~~
../util/qemu-sockets.c: In function 'socket_sockaddr_to_address_inet':
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 6 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../util/qemu-sockets.c:1235:9: note: in expansion of macro 'error_setg'
 1235 |         error_setg(errp, "Cannot format numeric socket address: %s"=
,
      |         ^~~~~~~~~~
In file included from ../io/dns-resolver.c:26:
../io/dns-resolver.c: In function 'qio_dns_resolver_lookup_sync_inet':
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 8 has type 'WCHAR *' {aka 'short
unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../io/dns-resolver.c:93:9: note: in expansion of macro 'error_setg'
   93 |         error_setg(errp, "address resolution failed for %s:%s: %s",
      |         ^~~~~~~~~~
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:756=EF=BC=9Aio/libio.fa.p/dns-resolver.c.obj] =E9=94=
=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:697=EF=BC=9Alibqemuutil.a.p/util_qemu-sockets.c.obj] =
=E9=94=99=E8=AF=AF 1
(=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
Linking static target io/libio.fa
C:\CI-Tools\msys64\mingw64\bin\ar.exe: io/libio.fa.p/dns-resolver.c.obj: No
such file or directory
make: [Makefile.ninja:764=EF=BC=9Aio/libio.fa] =E9=94=99=E8=AF=AF 1 (=E5=B7=
=B2=E5=BF=BD=E7=95=A5=EF=BC=89
../net/tap-win32.c: In function 'is_tap_win32_dev':
../net/tap-win32.c:62:21: error: passing argument 2 of 'RegOpenKeyExW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   62 | #define ADAPTER_KEY
"SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002B=
E10318}"
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
      |                     |
      |                     const char *
../net/tap-win32.c:62:21: note: in definition of macro 'ADAPTER_KEY'
   62 | #define ADAPTER_KEY
"SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002B=
E10318}"
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
      |                                                 ~~~~~~~~^~~~~~~~
../net/tap-win32.c:229:13: error: passing argument 3 of 'RegEnumKeyExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  229 |             enum_name,
      |             ^~~~~~~~~
      |             |
      |             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:184:70:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  184 |   WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey,DWORD
dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR
lpClass,LPDWORD lpcchClass,PFILETIME lpftLastWriteTime);
      |
~~~~~~~^~~~~~
../net/tap-win32.c:247:13: error: passing argument 2 of 'RegOpenKeyExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  247 |             unit_string,
      |             ^~~~~~~~~~~
      |             |
      |             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
      |                                                 ~~~~~~~~^~~~~~~~
../net/tap-win32.c:258:17: error: passing argument 2 of 'RegQueryValueExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  258 |                 component_id_string,
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 |
      |                 char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:203:60:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  203 |   WINADVAPI LONG WINAPI RegQueryValueExW(HKEY hKey,LPCWSTR
lpValueName,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPDWORD
lpcbData);
      |
 ~~~~~~~~^~~~~~~~~~~
../net/tap-win32.c:268:21: error: passing argument 2 of 'RegQueryValueExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  268 |                     net_cfg_instance_id_string,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                     |
      |                     char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:203:60:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  203 |   WINADVAPI LONG WINAPI RegQueryValueExW(HKEY hKey,LPCWSTR
lpValueName,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPDWORD
lpcbData);
      |
 ~~~~~~~~^~~~~~~~~~~
../net/tap-win32.c: In function 'get_device_guid':
../net/tap-win32.c:64:33: error: passing argument 2 of 'RegOpenKeyExW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   64 | #define NETWORK_CONNECTIONS_KEY
"SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-0800=
2BE10318}"
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
      |                                 |
      |                                 const char *
../net/tap-win32.c:64:33: note: in definition of macro
'NETWORK_CONNECTIONS_KEY'
   64 | #define NETWORK_CONNECTIONS_KEY
"SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-0800=
2BE10318}"
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
      |                                                 ~~~~~~~~^~~~~~~~
../net/tap-win32.c:328:13: error: passing argument 3 of 'RegEnumKeyExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  328 |             enum_name,
      |             ^~~~~~~~~
      |             |
      |             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:184:70:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  184 |   WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey,DWORD
dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR
lpClass,LPDWORD lpcchClass,PFILETIME lpftLastWriteTime);
      |
~~~~~~~^~~~~~
../net/tap-win32.c:348:13: error: passing argument 2 of 'RegOpenKeyExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  348 |             connection_string,
      |             ^~~~~~~~~~~~~~~~~
      |             |
      |             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
      |                                                 ~~~~~~~~^~~~~~~~
../net/tap-win32.c:357:17: error: passing argument 2 of 'RegQueryValueExW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  357 |                 name_string,
      |                 ^~~~~~~~~~~
      |                 |
      |                 const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:203:60:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  203 |   WINADVAPI LONG WINAPI RegQueryValueExW(HKEY hKey,LPCWSTR
lpValueName,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPDWORD
lpcbData);
      |
 ~~~~~~~~^~~~~~~~~~~
../net/tap-win32.c: In function 'tap_win32_open':
../net/tap-win32.c:626:9: error: passing argument 1 of 'CreateFileW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  626 |         device_path,
      |         ^~~~~~~~~~~
      |         |
      |         char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../net/tap-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../chardev/char-win.c: In function 'win_chr_serial_init':
../chardev/char-win.c:96:26: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   96 |     s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, =
0,
NULL,
      |                          ^~~~~~~~
      |                          |
      |                          const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../chardev/char-win.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../chardev/char-win.c:111:26: error: passing argument 1 of
'GetDefaultCommConfigW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  111 |     GetDefaultCommConfig(filename, &comcfg, &size);
      |                          ^~~~~~~~
      |                          |
      |                          const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../chardev/char-win.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:2394:60:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
 2394 |   WINBASEAPI WINBOOL WINAPI GetDefaultCommConfigW (LPCWSTR
lpszName, LPCOMMCONFIG lpCC, LPDWORD lpdwSize);
      |                                                    ~~~~~~~~^~~~~~~~
../chardev/char-win.c:113:22: error: passing argument 1 of
'CommConfigDialogW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  113 |     CommConfigDialog(filename, NULL, &comcfg);
      |                      ^~~~~~~~
      |                      |
      |                      const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../chardev/char-win.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:2392:56:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
 2392 |   WINBASEAPI WINBOOL WINAPI CommConfigDialogW (LPCWSTR lpszName,
HWND hWnd, LPCOMMCONFIG lpCC);
      |                                                ~~~~~~~~^~~~~~~~
cc1.exe: all warnings being treated as errors
cc1.exe: all warnings being treated as errors
../chardev/char-file.c: In function 'qmp_chardev_open_file':
../chardev/char-file.c:63:26: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   63 |     out =3D CreateFile(file->out, accessmode, FILE_SHARE_READ, NULL=
,
flags,
      |                      ~~~~^~~~~
      |                          |
      |                          char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../chardev/char-file.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../block.c: In function 'get_tmp_filename':
../block.c:757:35: error: passing argument 2 of 'GetTempPathW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  757 |     return (GetTempPath(MAX_PATH, temp_dir)
      |                                   ^~~~~~~~
      |                                   |
      |                                   char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:188:69:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  188 |   WINBASEAPI DWORD WINAPI GetTempPathW (DWORD nBufferLength, LPWSTR
lpBuffer);
      |
 ~~~~~~~^~~~~~~~
../block.c:758:32: error: passing argument 1 of 'GetTempFileNameW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  758 |             && GetTempFileName(temp_dir, "qem", 0, filename)
      |                                ^~~~~~~~
      |                                |
      |                                char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:127:52:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  127 |   WINBASEAPI UINT WINAPI GetTempFileNameW (LPCWSTR lpPathName,
LPCWSTR lpPrefixString, UINT uUnique, LPWSTR lpTempFileName);
      |                                            ~~~~~~~~^~~~~~~~~~
../block.c:758:42: error: passing argument 2 of 'GetTempFileNameW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  758 |             && GetTempFileName(temp_dir, "qem", 0, filename)
      |                                          ^~~~~
      |                                          |
      |                                          const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:127:72:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  127 |   WINBASEAPI UINT WINAPI GetTempFileNameW (LPCWSTR lpPathName,
LPCWSTR lpPrefixString, UINT uUnique, LPWSTR lpTempFileName);
      |
 ~~~~~~~~^~~~~~~~~~~~~~
../block.c:758:52: error: passing argument 4 of 'GetTempFileNameW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  758 |             && GetTempFileName(temp_dir, "qem", 0, filename)
      |                                                    ^~~~~~~~
      |                                                    |
      |                                                    char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:127:109:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  127 |   WINBASEAPI UINT WINAPI GetTempFileNameW (LPCWSTR lpPathName,
LPCWSTR lpPrefixString, UINT uUnique, LPWSTR lpTempFileName);
      |
                                 ~~~~~~~^~~~~~~~~~~~~~
../chardev/char-pipe.c: In function 'win_chr_pipe_init':
../chardev/char-pipe.c:66:31: error: passing argument 1 of
'CreateNamedPipeW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   66 |     s->file =3D CreateNamedPipe(openname,
      |                               ^~~~~~~~
      |                               |
      |                               char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:26,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../chardev/char-pipe.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/namedpipeapi.h:28:54:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   28 |   WINBASEAPI HANDLE WINAPI CreateNamedPipeW (LPCWSTR lpName, DWORD
dwOpenMode, DWORD dwPipeMode, DWORD nMaxInstances, DWORD nOutBufferSize,
DWORD nInBufferSize, DWORD nDefaultTimeOut, LPSECURITY_ATTRIBUTES
lpSecurityAttributes);
      |                                              ~~~~~~~~^~~~~~
../qga/service-win32.c: In function 'printf_win_error':
../qga/service-win32.c:28:9: error: passing argument 5 of 'FormatMessageW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   28 |         (char *)&message, 0,
      |         ^~~~~~~~~~~~~~~~
      |         |
      |         char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/service-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:1366:122:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
 1366 |   WINBASEAPI DWORD WINAPI FormatMessageW (DWORD dwFlags, LPCVOID
lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD
nSize, va_list *Arguments);
      |
                                              ~~~~~~~^~~~~~~~
../qga/service-win32.c: In function 'ga_install_service':
../qga/service-win32.c:107:34: error: initialization of 'WCHAR *' {aka
'short unsigned int *'} from incompatible pointer type 'char *'
[-Werror=3Dincompatible-pointer-types]
  107 |     SERVICE_DESCRIPTION desc =3D { (char *)QGA_SERVICE_DESCRIPTION =
};
      |                                  ^
../qga/service-win32.c:107:34: note: (near initialization for
'desc.lpDescription')
../qga/service-win32.c:118:43: error: passing argument 1 of
'win_escape_arg' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  118 |                            win_escape_arg(module_fname, esc));
      |                                           ^~~~~~~~~~~~
      |                                           |
      |                                           TCHAR * {aka short
unsigned int *}
../qga/service-win32.c:42:47: note: expected 'const char *' but argument is
of type 'TCHAR *' {aka 'short unsigned int *'}
   42 | static const char *win_escape_arg(const char *to_escape, GString
*buffer)
      |                                   ~~~~~~~~~~~~^~~~~~~~~
In file included from ../qga/service-win32.c:15:
C:/work/xemu/qemu/qga/service-win32.h:20:34: error: passing argument 2 of
'CreateServiceW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   20 | #define QGA_SERVICE_NAME         "qemu-ga"
      |                                  ^~~~~~~~~
      |                                  |
      |                                  const char *
../qga/service-win32.c:140:38: note: in expansion of macro
'QGA_SERVICE_NAME'
  140 |     service =3D CreateService(manager, QGA_SERVICE_NAME,
QGA_SERVICE_DISPLAY_NAME,
      |                                      ^~~~~~~~~~~~~~~~
make: [Makefile.ninja:767=EF=BC=9Achardev/libchardev.fa.p/char-win.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/service-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:289:74:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  289 |   WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE
hSCManager,LPCWSTR lpServiceName,LPCWSTR lpDisplayName,DWORD
dwDesiredAccess,DWORD dwServiceType,DWORD dwStartType,DWORD
dwErrorControl,LPCWSTR lpBinaryPathName,LPCWSTR lpLoadOrderGroup,LPDWORD
lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpServiceStartName,LPCWSTR
lpPassword);
      |
 ~~~~~~~~^~~~~~~~~~~~~
In file included from ../qga/service-win32.c:15:
C:/work/xemu/qemu/qga/service-win32.h:19:34: error: passing argument 3 of
'CreateServiceW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   19 | #define QGA_SERVICE_DISPLAY_NAME "QEMU Guest Agent"
      |                                  ^~~~~~~~~~~~~~~~~~
      |                                  |
      |                                  const char *
../qga/service-win32.c:140:56: note: in expansion of macro
'QGA_SERVICE_DISPLAY_NAME'
  140 |     service =3D CreateService(manager, QGA_SERVICE_NAME,
QGA_SERVICE_DISPLAY_NAME,
      |
 ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/service-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:289:96:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  289 |   WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE
hSCManager,LPCWSTR lpServiceName,LPCWSTR lpDisplayName,DWORD
dwDesiredAccess,DWORD dwServiceType,DWORD dwStartType,DWORD
dwErrorControl,LPCWSTR lpBinaryPathName,LPCWSTR lpLoadOrderGroup,LPDWORD
lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpServiceStartName,LPCWSTR
lpPassword);
      |
                   ~~~~~~~~^~~~~~~~~~~~~
../qga/service-win32.c:142:38: error: passing argument 8 of
'CreateServiceW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  142 |         SERVICE_ERROR_NORMAL, cmdline->str, NULL, NULL, NULL, NULL,
NULL);
      |                               ~~~~~~~^~~~~
      |                                      |
      |                                      gchar * {aka char *}
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/service-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:289:199:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'gchar *' {aka 'char *'}
  289 |   WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE
hSCManager,LPCWSTR lpServiceName,LPCWSTR lpDisplayName,DWORD
dwDesiredAccess,DWORD dwServiceType,DWORD dwStartType,DWORD
dwErrorControl,LPCWSTR lpBinaryPathName,LPCWSTR lpLoadOrderGroup,LPDWORD
lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpServiceStartName,LPCWSTR
lpPassword);
      |

                                              ~~~~~~~~^~~~~~~~~~~~~~~~
In file included from ../qga/service-win32.c:15:
../qga/service-win32.c: In function 'ga_uninstall_service':
C:/work/xemu/qemu/qga/service-win32.h:20:34: error: passing argument 2 of
'OpenServiceW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   20 | #define QGA_SERVICE_NAME         "qemu-ga"
      |                                  ^~~~~~~~~
      |                                  |
      |                                  const char *
../qga/service-win32.c:173:36: note: in expansion of macro
'QGA_SERVICE_NAME'
  173 |     service =3D OpenService(manager, QGA_SERVICE_NAME, DELETE);
      |                                    ^~~~~~~~~~~~~~~~
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/service-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:306:72:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  306 |   WINADVAPI SC_HANDLE WINAPI OpenServiceW(SC_HANDLE
hSCManager,LPCWSTR lpServiceName,DWORD dwDesiredAccess);
      |
 ~~~~~~~~^~~~~~~~~~~~~
../qga/channel-win32.c: In function 'ga_channel_open':
../qga/channel-win32.c:301:28: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  301 |     c->handle =3D CreateFile(newpath, GENERIC_READ | GENERIC_WRITE,
0, NULL,
      |                            ^~~~~~~
      |                            |
      |                            gchar * {aka char *}
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/channel-win32.c:1:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'gchar *' {aka 'char *'}
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
make: [Makefile.ninja:952=EF=BC=9Alibcommon.fa.p/net_tap-win32.c.obj] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
cc1.exe: all warnings being treated as errors
cc1.exe: all warnings being treated as errors
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:773=EF=BC=9Achardev/libchardev.fa.p/char-file.c.obj] =
=E9=94=99=E8=AF=AF 1
(=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
../block/file-win32.c: In function 'raw_probe_alignment':
../block/file-win32.c:250:27: error: passing argument 1 of
'GetDiskFreeSpaceW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  250 |         GetDiskFreeSpace(s->drive_path, &sectorsPerCluster,
      |                          ~^~~~~~~~~~~~
      |                           |
      |                           char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:74:56:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   74 |   WINBASEAPI WINBOOL WINAPI GetDiskFreeSpaceW (LPCWSTR
lpRootPathName, LPDWORD lpSectorsPerCluster, LPDWORD lpBytesPerSector,
LPDWORD lpNumberOfFreeClusters, LPDWORD lpTotalNumberOfClusters);
      |
 ~~~~~~~~^~~~~~~~~~~~~~
cc1.exe: all warnings being treated as errors
../block/file-win32.c: In function 'raw_open':
../block/file-win32.c:390:39: error: passing argument 2 of
'GetCurrentDirectoryW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  390 |         GetCurrentDirectory(MAX_PATH, buf);
      |                                       ^~~
      |                                       |
      |                                       char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:28,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/processenv.h:23:77:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
   23 |   WINBASEAPI DWORD WINAPI GetCurrentDirectoryW (DWORD
nBufferLength, LPWSTR lpBuffer);
      |
 ~~~~~~~^~~~~~~~
../block/file-win32.c:394:27: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  394 |     s->hfile =3D CreateFile(filename, access_flags,
      |                           ^~~~~~~~
      |                           |
      |                           const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../block/file-win32.c: In function 'raw_getlength':
../block/file-win32.c:540:34: error: passing argument 1 of
'GetDiskFreeSpaceExW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  540 |         if (!GetDiskFreeSpaceEx(s->drive_path, &available, &total,
&total_free))
      |                                 ~^~~~~~~~~~~~
      |                                  |
      |                                  char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:174:58:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  174 |   WINBASEAPI WINBOOL WINAPI GetDiskFreeSpaceExW (LPCWSTR
lpDirectoryName, PULARGE_INTEGER lpFreeBytesAvailableToCaller,
PULARGE_INTEGER lpTotalNumberOfBytes, PULARGE_INTEGER
lpTotalNumberOfFreeBytes);
      |
 ~~~~~~~~^~~~~~~~~~~~~~~
make: [Makefile.ninja:1428=EF=BC=9Aqga/qemu-ga.exe.p/service-win32.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
../block/file-win32.c: In function 'raw_get_allocated_file_size':
../block/file-win32.c:566:59: error: passing argument 1 of
'GetModuleHandleW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  566 |         (get_compressed_t)
GetProcAddress(GetModuleHandle("kernel32"),
      |                                                           ^~~~~~~~~=
~
      |                                                           |
      |                                                           const
char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:140:53=
:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  140 | WINBASEAPI HMODULE WINAPI GetModuleHandleW (LPCWSTR lpModuleName);
      |                                             ~~~~~~~~^~~~~~~~~~~~
make: [Makefile.ninja:777=EF=BC=9Achardev/libchardev.fa.p/char-pipe.c.obj] =
=E9=94=99=E8=AF=AF 1
(=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
../block/file-win32.c: In function 'find_cdrom':
../block/file-win32.c:684:44: error: passing argument 2 of
'GetLogicalDriveStringsW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  684 |     GetLogicalDriveStrings(sizeof(drives), drives);
      |                                            ^~~~~~
      |                                            |
      |                                            char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:90:80:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
   90 |   WINBASEAPI DWORD WINAPI GetLogicalDriveStringsW (DWORD
nBufferLength, LPWSTR lpBuffer);
      |
    ~~~~~~~^~~~~~~~
../block/file-win32.c:686:29: error: passing argument 1 of 'GetDriveTypeW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  686 |         type =3D GetDriveType(pdrv);
      |                             ^~~~
      |                             |
      |                             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:76:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   76 |   WINBASEAPI UINT WINAPI GetDriveTypeW (LPCWSTR lpRootPathName);
      |                                         ~~~~~~~~^~~~~~~~~~~~~~
../block/file-win32.c:693:25: error: passing argument 1 of 'lstrlenW' from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  693 |         pdrv +=3D lstrlen(pdrv) + 1;
      |                         ^~~~
      |                         |
      |                         char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:1430:43:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
 1430 |   WINBASEAPI int WINAPI lstrlenW (LPCWSTR lpString);
      |                                   ~~~~~~~~^~~~~~~~
../block/file-win32.c: In function 'find_device_type':
../block/file-win32.c:709:30: error: passing argument 1 of 'GetDriveTypeW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  709 |         type =3D GetDriveType(s->drive_path);
      |                             ~^~~~~~~~~~~~
      |                              |
      |                              char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:76:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   76 |   WINBASEAPI UINT WINAPI GetDriveTypeW (LPCWSTR lpRootPathName);
      |                                         ~~~~~~~~^~~~~~~~~~~~~~
../block/file-win32.c: In function 'hdev_open':
../block/file-win32.c:799:27: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  799 |     s->hfile =3D CreateFile(filename, access_flags,
      |                           ^~~~~~~~
      |                           |
      |                           const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../block/file-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../qga/vss-win32.c: In function 'call_vss_provider_func':
../qga/vss-win32.c:38:23: error: passing argument 5 of 'FormatMessageW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   38 |                       (char *)&msg, 0, NULL);
      |                       ^~~~~~~~~~~~
      |                       |
      |                       char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/vss-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:1366:122:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
 1366 |   WINBASEAPI DWORD WINAPI FormatMessageW (DWORD dwFlags, LPCVOID
lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD
nSize, va_list *Arguments);
      |
                                              ~~~~~~~^~~~~~~~
../qga/vss-win32.c: In function 'vss_init':
../qga/vss-win32.c:90:23: error: passing argument 5 of 'FormatMessageW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   90 |                       (char *)&msg, 0, NULL);
      |                       ^~~~~~~~~~~~
      |                       |
      |                       char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/vss-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:1366:122:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
 1366 |   WINBASEAPI DWORD WINAPI FormatMessageW (DWORD dwFlags, LPCVOID
lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD
nSize, va_list *Arguments);
      |
                                              ~~~~~~~^~~~~~~~
In file included from C:/work/xemu/qemu/qga/vss-win32.h:16,
                 from ../qga/main.c:39:
../qga/main.c: In function 'quit_handler':
C:/work/xemu/qemu/qga/vss-win32/vss-handles.h:12:28: error: passing
argument 3 of 'OpenEventW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   12 | #define EVENT_NAME_TIMEOUT "Global\\QGAVSSEvent-timeout"
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            const char *
../qga/main.c:160:60: note: in expansion of macro 'EVENT_NAME_TIMEOUT'
  160 |         hEventTimeout =3D OpenEvent(EVENT_ALL_ACCESS, FALSE,
EVENT_NAME_TIMEOUT);
      |
 ^~~~~~~~~~~~~~~~~~
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:35,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/main.c:14:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/synchapi.h:55:95:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   55 |   WINBASEAPI HANDLE WINAPI OpenEventW (DWORD dwDesiredAccess,
WINBOOL bInheritHandle, LPCWSTR lpName);
      |
                  ~~~~~~~~^~~~~~
In file included from ../qga/main.c:38:
../qga/main.c: In function 'service_main':
C:/work/xemu/qemu/qga/service-win32.h:20:34: error: passing argument 1 of
'RegisterServiceCtrlHandlerExW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   20 | #define QGA_SERVICE_NAME         "qemu-ga"
      |                                  ^~~~~~~~~
      |                                  |
      |                                  const char *
../qga/main.c:719:59: note: in expansion of macro 'QGA_SERVICE_NAME'
  719 |     service->status_handle =3D
RegisterServiceCtrlHandlerEx(QGA_SERVICE_NAME,
      |
^~~~~~~~~~~~~~~~
cc1.exe: all warnings being treated as errors
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/main.c:14:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:319:80:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  319 |   WINADVAPI SERVICE_STATUS_HANDLE WINAPI
RegisterServiceCtrlHandlerExW(LPCWSTR lpServiceName,LPHANDLER_FUNCTION_EX
lpHandlerProc,LPVOID lpContext);
      |
   ~~~~~~~~^~~~~~~~~~~~~
../qga/main.c: In function 'main':
../qga/main.c:1542:15: error: initialization of 'WCHAR *' {aka 'short
unsigned int *'} from incompatible pointer type 'char *'
[-Werror=3Dincompatible-pointer-types]
 1542 |             { (char *)QGA_SERVICE_NAME, service_main }, { NULL,
NULL } };
      |               ^
../qga/main.c:1542:15: note: (near initialization for
'service_table[0].lpServiceName')
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:1430=EF=BC=9Aqga/qemu-ga.exe.p/vss-win32.c.obj] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
make: [Makefile.ninja:1427=EF=BC=9Aqga/qemu-ga.exe.p/channel-win32.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
make: [Makefile.ninja:896=EF=BC=9Alibblock.fa.p/block_file-win32.c.obj] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
Linking static target chardev/libchardev.fa
C:\CI-Tools\msys64\mingw64\bin\ar.exe:
chardev/libchardev.fa.p/char-win.c.obj: No such file or directory
make: [Makefile.ninja:780=EF=BC=9Achardev/libchardev.fa] =E9=94=99=E8=AF=AF=
 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:1429=EF=BC=9Aqga/qemu-ga.exe.p/main.c.obj] =E9=94=99=
=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:882=EF=BC=9Alibblock.fa.p/block.c.obj] =E9=94=99=E8=
=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
../util/oslib-win32.c: In function 'qemu_get_local_state_pathname':
../util/oslib-win32.c:289:58: error: passing argument 5 of
'SHGetFolderPathW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  289 |                              /* SHGFP_TYPE_CURRENT */ 0, base_path)=
;
      |                                                          ^~~~~~~~~
      |                                                          |
      |                                                          char *
In file included from ../util/oslib-win32.c:44:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/shlobj.h:39:92: note:
expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of type
'char *'
   39 |   SHFOLDERAPI SHGetFolderPathW (HWND hwnd, int csidl, HANDLE
hToken, DWORD dwFlags, LPWSTR pszPath);
      |
                ~~~~~~~^~~~~~~
../util/oslib-win32.c: In function 'qemu_init_exec_dir':
../util/oslib-win32.c:327:35: error: passing argument 2 of
'GetModuleFileNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  327 |     len =3D GetModuleFileName(NULL, buf, sizeof(buf) - 1);
      |                                   ^~~
      |                                   |
      |                                   char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../util/oslib-win32.c:33:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:153:71=
:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  153 |   WINBASEAPI DWORD WINAPI GetModuleFileNameW (HMODULE hModule,
LPWSTR lpFilename, DWORD nSize);
      |
 ~~~~~~~^~~~~~~~~~
../util/oslib-win32.c: In function 'qemu_write_pidfile':
../util/oslib-win32.c:801:23: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  801 |     file =3D CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ,
NULL,
      |                       ^~~~~~~~
      |                       |
      |                       const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../util/oslib-win32.c:33:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../qga/commands-win32.c: In function 'acquire_privilege':
../qga/commands-win32.c:285:41: error: passing argument 2 of
'LookupPrivilegeValueW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  285 |         if (!LookupPrivilegeValue(NULL, name,
&priv.Privileges[0].Luid)) {
      |                                         ^~~~
      |                                         |
      |                                         const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:2519:81:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
 2519 |   WINADVAPI WINBOOL WINAPI LookupPrivilegeValueW (LPCWSTR
lpSystemName, LPCWSTR lpName, PLUID lpLuid);
      |
    ~~~~~~~~^~~~~~
../qga/commands-win32.c: In function 'qmp_guest_shutdown':
../qga/commands-win32.c:343:23: error: passing argument 1 of
'acquire_privilege' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  343 |     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
      |                       ^~~~~~~~~~~~~~~~
      |                       |
      |                       const short unsigned int *
../qga/commands-win32.c:276:43: note: expected 'const char *' but argument
is of type 'const short unsigned int *'
  276 | static void acquire_privilege(const char *name, Error **errp)
      |                               ~~~~~~~~~~~~^~~~
../qga/commands-win32.c: In function 'get_pci_info':
../qga/commands-win32.c:600:48: error: passing argument 3 of
'SetupDiGetDeviceInstanceIdW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  600 |                                                parent_dev_id, size,
&size)) {
      |                                                ^~~~~~~~~~~~~
      |                                                |
      |                                                char *
In file included from ../qga/commands-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/setupapi.h:1562:119:
note: expected 'PWSTR' {aka 'short unsigned int *'} but argument is of type
'char *'
 1562 |   WINSETUPAPI WINBOOL WINAPI SetupDiGetDeviceInstanceIdW(HDEVINFO
DeviceInfoSet,PSP_DEVINFO_DATA DeviceInfoData,PWSTR DeviceInstanceId,DWORD
DeviceInstanceIdSize,PDWORD RequiredSize);
      |
                                            ~~~~~~^~~~~~~~~~~~~~~~
../qga/commands-win32.c:615:47: error: passing argument 2 of
'CM_Locate_DevNodeW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  615 |             cr =3D CM_Locate_DevInst(&dev_inst, parent_dev_id, 0);
      |                                               ^~~~~~~~~~~~~
      |                                               |
      |                                               char *
In file included from ../qga/commands-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:887:77:
note: expected 'DEVINSTID_W' {aka 'short unsigned int *'} but argument is
of type 'char *'
  887 |   CMAPI CONFIGRET WINAPI CM_Locate_DevNodeW(PDEVINST
pdnDevInst,DEVINSTID_W pDeviceID,ULONG ulFlags);
      |
~~~~~~~~~~~~^~~~~~~~~
../qga/commands-win32.c:644:52: error: passing argument 2 of
'CM_Get_Device_IDW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  644 |             cr =3D CM_Get_Device_ID(parent_dev_inst, parent_dev_id,
dev_id_size,
      |                                                    ^~~~~~~~~~~~~
      |                                                    |
      |                                                    char *
In file included from ../qga/commands-win32.c:29:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:811:69:
note: expected 'PWCHAR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  811 |   CMAPI CONFIGRET WINAPI CM_Get_Device_IDW(DEVINST dnDevInst,PWCHAR
Buffer,ULONG BufferLen,ULONG ulFlags);
      |
 ~~~~~~~^~~~~~
../qga/commands-win32.c:657:65: error: passing argument 2 of
'SetupDiGetClassDevsW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  657 |             SetupDiGetClassDevs(&GUID_DEVINTERFACE_STORAGEPORT,
parent_dev_id,
      |
^~~~~~~~~~~~~
      |                                                                 |
      |
char *
In file included from ../qga/commands-win32.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/setupapi.h:1637:81:
note: expected 'PCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
 1637 |   WINSETUPAPI HDEVINFO WINAPI SetupDiGetClassDevsW(CONST GUID
*ClassGuid,PCWSTR Enumerator,HWND hwndParent,DWORD Flags);
      |
     ~~~~~~~^~~~~~~~~~
../qga/commands-win32.c: In function 'get_single_disk_info':
../qga/commands-win32.c:822:29: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  822 |     disk_h =3D CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL,
OPEN_EXISTING,
      |                         ~~~~^~~~~
      |                             |
      |                             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../qga/commands-win32.c: In function 'build_guest_disk_info':
../qga/commands-win32.c:891:24: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  891 |     vol_h =3D CreateFile(name, 0, FILE_SHARE_READ, NULL,
OPEN_EXISTING,
      |                        ^~~~
      |                        |
      |                        char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../qga/commands-win32.c: In function 'build_guest_fsinfo':
../qga/commands-win32.c:1003:37: error: passing argument 1 of
'GetVolumePathNamesForVolumeNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1003 |     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0,
&info_size);
      |                                     ^~~~
      |                                     |
      |                                     char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:98:71:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   98 |   WINBASEAPI WINBOOL WINAPI GetVolumePathNamesForVolumeNameW
(LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, DWORD cchBufferLength,
PDWORD lpcchReturnLength);
      |
~~~~~~~~^~~~~~~~~~~~~~
../qga/commands-win32.c:1003:43: error: passing argument 2 of
'GetVolumePathNamesForVolumeNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1003 |     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0,
&info_size);
      |                                           ^~~~~~~~~~
      |                                           |
      |                                           CHAR * {aka char *}
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:98:93:
note: expected 'LPWCH' {aka 'short unsigned int *'} but argument is of type
'CHAR *' {aka 'char *'}
   98 |   WINBASEAPI WINBOOL WINAPI GetVolumePathNamesForVolumeNameW
(LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, DWORD cchBufferLength,
PDWORD lpcchReturnLength);
      |
                  ~~~~~~^~~~~~~~~~~~~~~~~~~
../qga/commands-win32.c:1010:42: error: passing argument 1 of
'GetVolumePathNamesForVolumeNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1010 |     if (!GetVolumePathNamesForVolumeName(guid, mnt_point, info_size=
,
      |                                          ^~~~
      |                                          |
      |                                          char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:98:71:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   98 |   WINBASEAPI WINBOOL WINAPI GetVolumePathNamesForVolumeNameW
(LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, DWORD cchBufferLength,
PDWORD lpcchReturnLength);
      |
~~~~~~~~^~~~~~~~~~~~~~
../qga/commands-win32.c:1010:48: error: passing argument 2 of
'GetVolumePathNamesForVolumeNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1010 |     if (!GetVolumePathNamesForVolumeName(guid, mnt_point, info_size=
,
      |                                                ^~~~~~~~~
      |                                                |
      |                                                char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:98:93:
note: expected 'LPWCH' {aka 'short unsigned int *'} but argument is of type
'char *'
   98 |   WINBASEAPI WINBOOL WINAPI GetVolumePathNamesForVolumeNameW
(LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, DWORD cchBufferLength,
PDWORD lpcchReturnLength);
      |
                  ~~~~~~^~~~~~~~~~~~~~~~~~~
../qga/commands-win32.c:1016:35: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 1016 |     hLocalDiskHandle =3D CreateFile(guid, 0 , 0, NULL, OPEN_EXISTIN=
G,
      |                                   ^~~~
      |                                   |
      |                                   char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
../qga/commands-win32.c:1045:34: error: passing argument 1 of
'GetDiskFreeSpaceExW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1045 |         if (GetDiskFreeSpaceEx(fs->mountpoint,
      |                                ~~^~~~~~~~~~~~
      |                                  |
      |                                  char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:174:58:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'char *'
  174 |   WINBASEAPI WINBOOL WINAPI GetDiskFreeSpaceExW (LPCWSTR
lpDirectoryName, PULARGE_INTEGER lpFreeBytesAvailableToCaller,
PULARGE_INTEGER lpTotalNumberOfBytes, PULARGE_INTEGER
lpTotalNumberOfFreeBytes);
      |
 ~~~~~~~~^~~~~~~~~~~~~~~
../qga/commands-win32.c: In function 'qmp_guest_get_fsinfo':
../qga/commands-win32.c:1070:29: error: passing argument 1 of
'FindFirstVolumeW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1070 |     vol_h =3D FindFirstVolume(guid, sizeof(guid));
      |                             ^~~~
      |                             |
      |                             char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:58:53:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
   58 |   WINBASEAPI HANDLE WINAPI FindFirstVolumeW (LPWSTR lpszVolumeName,
DWORD cchBufferLength);
      |                                              ~~~~~~~^~~~~~~~~~~~~~
../qga/commands-win32.c:1089:36: error: passing argument 2 of
'FindNextVolumeW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1089 |     } while (FindNextVolume(vol_h, guid, sizeof(guid)));
      |                                    ^~~~
      |                                    |
      |                                    char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:60:73:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
   60 |   WINBASEAPI WINBOOL WINAPI FindNextVolumeW (HANDLE hFindVolume,
LPWSTR lpszVolumeName, DWORD cchBufferLength);
      |
 ~~~~~~~^~~~~~~~~~~~~~
../qga/commands-win32.c: In function 'qmp_guest_suspend_disk':
../qga/commands-win32.c:1372:23: error: passing argument 1 of
'acquire_privilege' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1372 |     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
      |                       ^~~~~~~~~~~~~~~~
      |                       |
      |                       const short unsigned int *
../qga/commands-win32.c:276:43: note: expected 'const char *' but argument
is of type 'const short unsigned int *'
  276 | static void acquire_privilege(const char *name, Error **errp)
      |                               ~~~~~~~~~~~~^~~~
../qga/commands-win32.c: In function 'qmp_guest_suspend_ram':
../qga/commands-win32.c:1395:23: error: passing argument 1 of
'acquire_privilege' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1395 |     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
      |                       ^~~~~~~~~~~~~~~~
      |                       |
      |                       const short unsigned int *
../qga/commands-win32.c:276:43: note: expected 'const char *' but argument
is of type 'const short unsigned int *'
  276 | static void acquire_privilege(const char *name, Error **errp)
      |                               ~~~~~~~~~~~~^~~~
../qga/commands-win32.c: In function 'guest_addr_to_str':
../qga/commands-win32.c:1459:34: error: passing argument 4 of
'WSAAddressToStringW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1459 |                                  addr_str,
      |                                  ^~~~~~~~
      |                                  |
      |                                  char *
In file included from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:1086:141:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
 1086 |   WINSOCK_API_LINKAGE INT WSAAPI WSAAddressToStringW(LPSOCKADDR
lpsaAddress,DWORD dwAddressLength,LPWSAPROTOCOL_INFOW lpProtocolInfo,LPWSTR
lpszAddressString,LPDWORD lpdwAddressStringLength);
      |

 ~~~~~~~^~~~~~~~~~~~~~~~~
../qga/commands-win32.c: In function 'guest_get_network_stats':
../qga/commands-win32.c:1509:42: error: passing argument 1 of
'GetModuleHandleW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1509 |         HMODULE module =3D GetModuleHandle("iphlpapi");
      |                                          ^~~~~~~~~~
      |                                          |
      |                                          const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:140:53=
:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  140 | WINBASEAPI HMODULE WINAPI GetModuleHandleW (LPCWSTR lpModuleName);
      |                                             ~~~~~~~~^~~~~~~~~~~~
../qga/commands-win32.c: In function 'qmp_guest_set_time':
../qga/commands-win32.c:1686:24: error: passing argument 1 of 'strerror_s'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 1686 |             strerror_s((LPTSTR) & msg_buffer, 0, errno);
      |                        ^~~~~~~~~~~~~~~~~~~~~
      |                        |
      |                        WCHAR * {aka short unsigned int *}
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/string.h:190,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:87,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/sec_api/string_s.h:26=
:44:
note: expected 'char *' but argument is of type 'WCHAR *' {aka 'short
unsigned int *'}
   26 |   _SECIMP errno_t __cdecl strerror_s(char *_Buf,size_t
_SizeInBytes,int _ErrNum);
      |                                      ~~~~~~^~~~
In file included from ../qga/commands-win32.c:39:
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 6 has type 'const WCHAR *' {aka
'const short unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../qga/commands-win32.c:1687:13: note: in expansion of macro 'error_setg'
 1687 |             error_setg(errp, "system(...) failed: %s",
(LPCTSTR)msg_buffer);
      |             ^~~~~~~~~~
C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s' expects
argument of type 'char *', but argument 7 has type 'const WCHAR *' {aka
'const short unsigned int *'} [-Werror=3Dformat=3D]
  319 |                         (fmt), ## __VA_ARGS__)
      |                         ^~~~~
../qga/commands-win32.c:1702:21: note: in expansion of macro 'error_setg'
 1702 |                     error_setg(errp, "w32tm failed with error
(0x%lx): %s", hr,
      |                     ^~~~~~~~~~
cc1.exe: all warnings being treated as errors
../qga/commands-win32.c:1731:23: error: passing argument 1 of
'acquire_privilege' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 1731 |     acquire_privilege(SE_SYSTEMTIME_NAME, &local_err);
      |                       ^~~~~~~~~~~~~~~~~~
      |                       |
      |                       const short unsigned int *
../qga/commands-win32.c:276:43: note: expected 'const char *' but argument
is of type 'const short unsigned int *'
  276 | static void acquire_privilege(const char *name, Error **errp)
      |                               ~~~~~~~~~~~~^~~~
../qga/commands-win32.c: In function 'ga_get_win_version':
../qga/commands-win32.c:2119:38: error: passing argument 1 of
'GetModuleHandleW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 2119 |     HMODULE module =3D GetModuleHandle("ntdll");
      |                                      ^~~~~~~
      |                                      |
      |                                      const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../qga/commands-win32.c:13:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:140:53=
:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
  140 | WINBASEAPI HMODULE WINAPI GetModuleHandleW (LPCWSTR lpModuleName);
      |                                             ~~~~~~~~^~~~~~~~~~~~
make: [Makefile.ninja:648=EF=BC=9Alibqemuutil.a.p/util_oslib-win32.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89
Linking static target libqemuutil.a

make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/cap=
stone=E2=80=9D
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"qemu-version.h" "--" "sh" "C:/work/xemu/qemu/scripts/qemu-version.sh"
"C:/work/xemu/qemu" "" "5.1.50" && if test -e qemu-version.h; then printf
'%s\n' qemu-version.h > qemu-version.h.stamp; fi
"cc" "-Ilibqemuutil.a.p" "-I." "-I.." "-Iqapi" "-Itrace" "-Iui"
"-Iui/shader" "-IC:/CI-Tools/msys64/mingw64/include"
"-IC:/CI-Tools/msys64/mingw64/include/glib-2.0"
"-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/include"
"-IC:/CI-Tools/msys64/mingw64/include/p11-kit-1" "-fdiagnostics-color=3Daut=
o"
"-pipe" "-Wall" "-Winvalid-pch" "-Werror" "-std=3Dgnu99" "-g" "-m64" "-mcx1=
6"
"-DUNICODE" "-D_UNICODE" "-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=3D64"
"-D_LARGEFILE_SOURCE" "-Wstrict-prototypes" "-Wredundant-decls" "-Wundef"
"-Wwrite-strings" "-Wmissing-prototypes" "-fno-strict-aliasing"
"-fno-common" "-fwrapv" "-Wold-style-declaration" "-Wold-style-definition"
"-Wtype-limits" "-Wformat-security" "-Wformat-y2k" "-Winit-self"
"-Wignored-qualifiers" "-Wempty-body" "-Wnested-externs" "-Wendif-labels"
"-Wexpansion-to-defined" "-Wno-missing-include-dirs"
"-Wno-shift-negative-value" "-Wno-psabi" "-fstack-protector-strong"
"-iquote" "/c/work/xemu/qemu/tcg/i386" "-iquote" "." "-iquote"
"/c/work/xemu/qemu" "-iquote" "/c/work/xemu/qemu/accel/tcg" "-iquote"
"/c/work/xemu/qemu/include" "-iquote" "/c/work/xemu/qemu/disas/libvixl"
"-pthread" "-mms-bitfields" "-mms-bitfields" -MD -MQ
libqemuutil.a.p/util_oslib-win32.c.obj -MF
"libqemuutil.a.p/util_oslib-win32.c.obj.d" -o
libqemuutil.a.p/util_oslib-win32.c.obj "-c" ../util/oslib-win32.c -MP
../util/oslib-win32.c: In function 'qemu_get_local_state_pathname':
../util/oslib-win32.c:289:58: error: passing argument 5 of
'SHGetFolderPathW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  289 |                              /* SHGFP_TYPE_CURRENT */ 0, base_path)=
;
      |                                                          ^~~~~~~~~
      |                                                          |
      |                                                          char *
In file included from ../util/oslib-win32.c:44:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/shlobj.h:39:92: note:
expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of type
'char *'
   39 |   SHFOLDERAPI SHGetFolderPathW (HWND hwnd, int csidl, HANDLE
hToken, DWORD dwFlags, LPWSTR pszPath);
      |
                ~~~~~~~^~~~~~~
../util/oslib-win32.c: In function 'qemu_init_exec_dir':
../util/oslib-win32.c:327:35: error: passing argument 2 of
'GetModuleFileNameW' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  327 |     len =3D GetModuleFileName(NULL, buf, sizeof(buf) - 1);
      |                                   ^~~
      |                                   |
      |                                   char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../util/oslib-win32.c:33:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:153:71=
:
note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
type 'char *'
  153 |   WINBASEAPI DWORD WINAPI GetModuleFileNameW (HMODULE hModule,
LPWSTR lpFilename, DWORD nSize);
      |
 ~~~~~~~^~~~~~~~~~
../util/oslib-win32.c: In function 'qemu_write_pidfile':
../util/oslib-win32.c:801:23: error: passing argument 1 of 'CreateFileW'
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  801 |     file =3D CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ,
NULL,
      |                       ^~~~~~~~
      |                       |
      |                       const char *
In file included from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,
                 from
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
                 from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../util/oslib-win32.c:33:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49:
note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument is
of type 'const char *'
   64 |   WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD
dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES
lpSecurityAttributes, DWORD dwCreationDisposition, DWORD
dwFlagsAndAttributes, HANDLE hTemplateFile);
      |                                         ~~~~~~~~^~~~~~~~~~
cc1.exe: all warnings being treated as errors
make: *** [Makefile.ninja:648=EF=BC=9Alibqemuutil.a.p/util_oslib-win32.c.ob=
j] =E9=94=99=E8=AF=AF 1
```



>
> -- >8 --
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 412962d91a2..cd5cedc0b21 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -74,6 +74,12 @@ extern int daemon(int, int);
>  /* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later)
*/
>  #ifdef __MINGW32__
>  #define __USE_MINGW_ANSI_STDIO 1
> +#ifndef UNICODE
> +#define UNICODE
> +#endif
> +#ifndef _UNICODE
> +#define _UNICODE
> +#endif
>  #endif
>
>  #include <stdarg.h>
> ---
>
> >    vhost_user=3D"no"
> >    audio_possible_drivers=3D"dsound sdl"
> >    if check_include dsound.h; then
> >
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ddfe0c05af5daa2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 12:41 AM Philippe Mathieu-=
Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On 9/15/20 6:33 PM, Yonggang Luo wrote:<br>&gt; &=
gt; error message:<br>&gt; &gt; &quot;cc&quot; &quot;-Iqga/qemu-ga.exe.p&qu=
ot; &quot;-Iqga&quot; &quot;-I../qga&quot; &quot;-I.&quot; &quot;-Iqapi&quo=
t; &quot;-Itrace&quot; &quot;-Iui&quot; &quot;-Iui/shader&quot; &quot;-IC:/=
CI-Tools/msys64/mingw64/include&quot; &quot;-IC:/CI-Tools/msys64/mingw64/in=
clude/glib-2.0&quot; &quot;-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/includ=
e&quot; &quot;-fdiagnostics-color=3Dauto&quot; &quot;-pipe&quot; &quot;-Wal=
l&quot; &quot;-Winvalid-pch&quot; &quot;-Werror&quot; &quot;-std=3Dgnu99&qu=
ot; &quot;-g&quot; &quot;-m64&quot; &quot;-mcx16&quot; &quot;-D_GNU_SOURCE&=
quot; &quot;-D_FILE_OFFSET_BITS=3D64&quot; &quot;-D_LARGEFILE_SOURCE&quot; =
&quot;-Wstrict-prototypes&quot; &quot;-Wredundant-decls&quot; &quot;-Wundef=
&quot; &quot;-Wwrite-strings&quot; &quot;-Wmissing-prototypes&quot; &quot;-=
fno-strict-aliasing&quot; &quot;-fno-common&quot; &quot;-fwrapv&quot; &quot=
;-Wold-style-declaration&quot; &quot;-Wold-style-definition&quot; &quot;-Wt=
ype-limits&quot; &quot;-Wformat-security&quot; &quot;-Wformat-y2k&quot; &qu=
ot;-Winit-self&quot; &quot;-Wignored-qualifiers&quot; &quot;-Wempty-body&qu=
ot; &quot;-Wnested-externs&quot; &quot;-Wendif-labels&quot; &quot;-Wexpansi=
on-to-defined&quot; &quot;-Wno-missing-include-dirs&quot; &quot;-Wno-shift-=
negative-value&quot; &quot;-Wno-psabi&quot; &quot;-fstack-protector-strong&=
quot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu/tcg/i386&quot; &quot;-iqu=
ote&quot; &quot;.&quot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu&quot; &=
quot;-iquote&quot; &quot;/c/work/xemu/qemu/accel/tcg&quot; &quot;-iquote&qu=
ot; &quot;/c/work/xemu/qemu/include&quot; &quot;-iquote&quot; &quot;/c/work=
/xemu/qemu/disas/libvixl&quot; &quot;-pthread&quot; &quot;-mms-bitfields&qu=
ot; -MD -MQ qga/qemu-ga.exe.p/commands-win32.c.obj -MF &quot;qga/qemu-ga.ex=
e.p/commands-win32.c.obj.d&quot; -o qga/qemu-ga.exe.p/commands-win32.c.obj =
&quot;-c&quot; ../qga/commands-win32.c -MP<br>&gt; &gt; ../qga/commands-win=
32.c:62:24: error: redundant redeclaration of &#39;CM_Get_DevNode_PropertyW=
&#39; [-Werror=3Dredundant-decls]<br>&gt; &gt; =C2=A0 =C2=A062 | CMAPI CONF=
IGRET WINAPI CM_Get_DevNode_PropertyW(<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~<br>&gt; &gt; In file included from ../qg=
a/commands-win32.c:26:<br>&gt; &gt; C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/cfgmgr32.h:840:26: note: previous declaration of &#39;CM_Get=
_DevNode_PropertyW&#39; was here<br>&gt; &gt; =C2=A0 840 | =C2=A0 CMAPI CON=
FIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst, const DEVPROPKEY =
*PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyBuffer, PULONG Prope=
rtyBufferSize, ULONG ulFlags);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~<br>&gt; &gt; cc1.exe: all warnings being=
 treated as errors<br>&gt; &gt; make: [Makefile.ninja:5143=EF=BC=9Aqga/qemu=
-ga.exe.p/commands-win32.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=
=95=A5=EF=BC=89<br>&gt; &gt;<br>&gt; &gt; This error comes from qemu config=
ure didn&#39;t add predefined macro -DUNICODE -D_UNICODE in QEMU_CFLAGS,<br=
>&gt; &gt; and these too macro are standard config for win32 if using windo=
ws wide api.<br>&gt; &gt;<br>&gt; &gt; in cfgmgr32.h<br>&gt; &gt; =C2=A0 CM=
API CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst, const DEVP=
ROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyBuffer, PULON=
G PropertyBufferSize, ULONG ulFlags);<br>&gt; &gt; #ifdef UNICODE<br>&gt; &=
gt; #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW<br>&gt; &gt; #=
endif<br>&gt; &gt;<br>&gt; &gt; macro CM_Get_DevNode_Property defined only =
when UNICODE are defined.<br>&gt; &gt; and in win32, UNICODE and _UNICODE s=
hould be defined at the same time<br>&gt; &gt;<br>&gt; &gt; #endif<br>&gt; =
&gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyong=
gang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt;=
 =C2=A0configure | 1 +<br>&gt; &gt; =C2=A01 file changed, 1 insertion(+)<br=
>&gt; &gt;<br>&gt; &gt; diff --git a/configure b/configure<br>&gt; &gt; ind=
ex 9f141891ea..f5d661af4a 100755<br>&gt; &gt; --- a/configure<br>&gt; &gt; =
+++ b/configure<br>&gt; &gt; @@ -812,6 +812,7 @@ MINGW32*)<br>&gt; &gt; =C2=
=A0 =C2=A0mingw32=3D&quot;yes&quot;<br>&gt; &gt; =C2=A0 =C2=A0hax=3D&quot;y=
es&quot;<br>&gt; &gt; =C2=A0 =C2=A0whpx=3D&quot;&quot;<br>&gt; &gt; + =C2=
=A0QEMU_CFLAGS=3D&quot;-DUNICODE -D_UNICODE $QEMU_CFLAGS&quot;<br>&gt;<br>&=
gt; What about declaring them in include/qemu/osdep.h<br>&gt; instead?<div>=
That&#39;s a good idea.</div><div>But more compiling error warns me that th=
e windows version of qemu are not in a good situation.</div><div>On Win32, =
all API should call the wide version so that support for Unicode properly.<=
/div><div>But obviously the currently qemu didn&#39;t do that</div><div></d=
iv><div><br></div><div>```</div><div><br></div><div>Compiling C object qga/=
qemu-ga.exe.p/commands-win32.c.obj<br>In file included from ../util/qemu-so=
ckets.c:27:<br>../util/qemu-sockets.c: In function &#39;inet_listen_saddr&#=
39;:<br>C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format &#39;%=
s&#39; expects argument of type &#39;char *&#39;, but argument 8 has type &=
#39;WCHAR *&#39; {aka &#39;short unsigned int *&#39;} [-Werror=3Dformat=3D]=
<br>=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~<br>../util/qemu-sockets.c:274:9: note: in expansion of mac=
ro &#39;error_setg&#39;<br>=C2=A0 274 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_s=
etg(errp, &quot;address resolution failed for %s:%s: %s&quot;,<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>../util/qemu-sock=
ets.c: In function &#39;inet_parse_connect_saddr&#39;:<br>C:/work/xemu/qemu=
/include/qapi/error.h:319:25: error: format &#39;%s&#39; expects argument o=
f type &#39;char *&#39;, but argument 8 has type &#39;WCHAR *&#39; {aka &#3=
9;short unsigned int *&#39;} [-Werror=3Dformat=3D]<br>=C2=A0 319 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (fmt), ## __VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~<br>../=
util/qemu-sockets.c:429:9: note: in expansion of macro &#39;error_setg&#39;=
<br>=C2=A0 429 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;address=
 resolution failed for %s:%s: %s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>../util/qemu-sockets.c: In function &#39=
;inet_dgram_saddr&#39;:<br>C:/work/xemu/qemu/include/qapi/error.h:319:25: e=
rror: format &#39;%s&#39; expects argument of type &#39;char *&#39;, but ar=
gument 8 has type &#39;WCHAR *&#39; {aka &#39;short unsigned int *&#39;} [-=
Werror=3Dformat=3D]<br>=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~<br>../util/qemu-sockets.c:518:9: note: i=
n expansion of macro &#39;error_setg&#39;<br>=C2=A0 518 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_setg(errp, &quot;address resolution failed for %s:%s: %s&q=
uot;, addr, port,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~=
~~~~~~~<br>C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format &#3=
9;%s&#39; expects argument of type &#39;char *&#39;, but argument 8 has typ=
e &#39;WCHAR *&#39; {aka &#39;short unsigned int *&#39;} [-Werror=3Dformat=
=3D]<br>=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ^~~~~<br>../util/qemu-sockets.c:544:9: note: in expansion of=
 macro &#39;error_setg&#39;<br>=C2=A0 544 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
or_setg(errp, &quot;address resolution failed for %s:%s: %s&quot;, addr, po=
rt,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>../=
util/qemu-sockets.c: In function &#39;socket_sockaddr_to_address_inet&#39;:=
<br>C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format &#39;%s&#3=
9; expects argument of type &#39;char *&#39;, but argument 6 has type &#39;=
WCHAR *&#39; {aka &#39;short unsigned int *&#39;} [-Werror=3Dformat=3D]<br>=
=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~<br>../util/qemu-sockets.c:1235:9: note: in expansion of macro =
&#39;error_setg&#39;<br>=C2=A01235 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg=
(errp, &quot;Cannot format numeric socket address: %s&quot;,<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>In file included fro=
m ../io/dns-resolver.c:26:<br>../io/dns-resolver.c: In function &#39;qio_dn=
s_resolver_lookup_sync_inet&#39;:<br>C:/work/xemu/qemu/include/qapi/error.h=
:319:25: error: format &#39;%s&#39; expects argument of type &#39;char *&#3=
9;, but argument 8 has type &#39;WCHAR *&#39; {aka &#39;short unsigned int =
*&#39;} [-Werror=3Dformat=3D]<br>=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS=
__)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~<br>../io/dns-resolver.c:93:9: =
note: in expansion of macro &#39;error_setg&#39;<br>=C2=A0 =C2=A093 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;address resolution failed f=
or %s:%s: %s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
~~~~~~~~~<br>cc1.exe: all warnings being treated as errors<br>make: [Makefi=
le.ninja:756=EF=BC=9Aio/libio.fa.p/dns-resolver.c.obj] =E9=94=99=E8=AF=AF 1=
 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>cc1.exe: all warnings being treat=
ed as errors<br>make: [Makefile.ninja:697=EF=BC=9Alibqemuutil.a.p/util_qemu=
-sockets.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<=
br>Linking static target io/libio.fa<br>C:\CI-Tools\msys64\mingw64\bin\ar.e=
xe: io/libio.fa.p/dns-resolver.c.obj: No such file or directory<br>make: [M=
akefile.ninja:764=EF=BC=9Aio/libio.fa] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=
=BF=BD=E7=95=A5=EF=BC=89<br>../net/tap-win32.c: In function &#39;is_tap_win=
32_dev&#39;:<br>../net/tap-win32.c:62:21: error: passing argument 2 of &#39=
;RegOpenKeyExW&#39; from incompatible pointer type [-Werror=3Dincompatible-=
pointer-types]<br>=C2=A0 =C2=A062 | #define ADAPTER_KEY &quot;SYSTEM\\Curre=
ntControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}&quot;<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *<br>../net/tap-win32.c:62:21: note: in definition of macro &#3=
9;ADAPTER_KEY&#39;<br>=C2=A0 =C2=A062 | #define ADAPTER_KEY &quot;SYSTEM\\C=
urrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}&qu=
ot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>In file included from C:/CI-Tools/msys=
64/mingw64/x86_64-w64-mingw32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x=
86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win=
32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-=
Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57: note: expe=
cted &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argum=
ent is of type &#39;const char *&#39;<br>=C2=A0 195 | =C2=A0 WINADVAPI LONG=
 WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR lpSubKey,DWORD ulOptions,REGSAM sam=
Desired,PHKEY phkResult);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~~~^~~~~~~~<br>../net/tap-win32.c:229:13: error: passing argument 3 of =
&#39;RegEnumKeyExW&#39; from incompatible pointer type [-Werror=3Dincompati=
ble-pointer-types]<br>=C2=A0 229 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enum_name,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw=
64/x86_64-w64-mingw32/include/winreg.h:184:70: note: expected &#39;LPWSTR&#=
39; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;char =
*&#39;<br>=C2=A0 184 | =C2=A0 WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey=
,DWORD dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR lp=
Class,LPDWORD lpcchClass,PFILETIME lpftLastWriteTime);<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~~^~~~~~<br>../net/tap-win32.c:247:13: error: passing argument 2 of &#3=
9;RegOpenKeyExW&#39; from incompatible pointer type [-Werror=3Dincompatible=
-pointer-types]<br>=C2=A0 247 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
nit_string,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw=
32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/=
xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys6=
4/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57: note: expected &#39;L=
PCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is of t=
ype &#39;char *&#39;<br>=C2=A0 195 | =C2=A0 WINADVAPI LONG WINAPI RegOpenKe=
yExW(HKEY hKey,LPCWSTR lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phk=
Result);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~<br=
>../net/tap-win32.c:258:17: error: passing argument 2 of &#39;RegQueryValue=
ExW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-typ=
es]<br>=C2=A0 258 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 component_id_string,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>=
In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h=
:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/o=
sdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-min=
gw32/include/winreg.h:203:60: note: expected &#39;LPCWSTR&#39; {aka &#39;co=
nst short unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=
=C2=A0 203 | =C2=A0 WINADVAPI LONG WINAPI RegQueryValueExW(HKEY hKey,LPCWST=
R lpValueName,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPDWORD lpcbD=
ata);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^=
~~~~~~~~~~<br>../net/tap-win32.c:268:21: error: passing argument 2 of &#39;=
RegQueryValueExW&#39; from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]<br>=C2=A0 268 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 net_cfg_instance_id_string,<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-ming=
w32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/inc=
lude/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/x86_=
64-w64-mingw32/include/winreg.h:203:60: note: expected &#39;LPCWSTR&#39; {a=
ka &#39;const short unsigned int *&#39;} but argument is of type &#39;char =
*&#39;<br>=C2=A0 203 | =C2=A0 WINADVAPI LONG WINAPI RegQueryValueExW(HKEY h=
Key,LPCWSTR lpValueName,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPD=
WORD lpcbData);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0~~~~~~~~^~~~~~~~~~~<br>../net/tap-win32.c: In function &#39;get_device_g=
uid&#39;:<br>../net/tap-win32.c:64:33: error: passing argument 2 of &#39;Re=
gOpenKeyExW&#39; from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]<br>=C2=A0 =C2=A064 | #define NETWORK_CONNECTIONS_KEY &quot;SYST=
EM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08002BE10=
318}&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*<br>../net/tap-win32.c:64:33: note: in definition of macro &#39;NETWORK_CO=
NNECTIONS_KEY&#39;<br>=C2=A0 =C2=A064 | #define NETWORK_CONNECTIONS_KEY &qu=
ot;SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08=
002BE10318}&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~<br>In file included from C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw=
32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/=
xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys6=
4/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57: note: expected &#39;L=
PCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is of t=
ype &#39;const char *&#39;<br>=C2=A0 195 | =C2=A0 WINADVAPI LONG WINAPI Reg=
OpenKeyExW(HKEY hKey,LPCWSTR lpSubKey,DWORD ulOptions,REGSAM samDesired,PHK=
EY phkResult);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~=
~<br>../net/tap-win32.c:328:13: error: passing argument 3 of &#39;RegEnumKe=
yExW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-ty=
pes]<br>=C2=A0 328 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum_name,<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~=
~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>=
In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h=
:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/o=
sdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-min=
gw32/include/winreg.h:184:70: note: expected &#39;LPWSTR&#39; {aka &#39;sho=
rt unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =
184 | =C2=A0 WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey,DWORD dwIndex,LP=
WSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR lpClass,LPDWORD lpc=
chClass,PFILETIME lpftLastWriteTime);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~<b=
r>../net/tap-win32.c:348:13: error: passing argument 2 of &#39;RegOpenKeyEx=
W&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-types=
]<br>=C2=A0 348 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 connection_stri=
ng,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~=
~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/windows.h:76,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/incl=
ude/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qe=
mu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw=
64/x86_64-w64-mingw32/include/winreg.h:195:57: note: expected &#39;LPCWSTR&=
#39; {aka &#39;const short unsigned int *&#39;} but argument is of type &#3=
9;char *&#39;<br>=C2=A0 195 | =C2=A0 WINADVAPI LONG WINAPI RegOpenKeyExW(HK=
EY hKey,LPCWSTR lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult)=
;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~<br>../net=
/tap-win32.c:357:17: error: passing argument 2 of &#39;RegQueryValueExW&#39=
; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=
=C2=A0 357 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name_s=
tring,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *<br>In file inclu=
ded from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/=
CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../net/=
tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/wi=
nreg.h:203:60: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsig=
ned int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 20=
3 | =C2=A0 WINADVAPI LONG WINAPI RegQueryValueExW(HKEY hKey,LPCWSTR lpValue=
Name,LPDWORD lpReserved,LPDWORD lpType,LPBYTE lpData,LPDWORD lpcbData);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~~<=
br>../net/tap-win32.c: In function &#39;tap_win32_open&#39;:<br>../net/tap-=
win32.c:626:9: error: passing argument 1 of &#39;CreateFileW&#39; from inco=
mpatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 626 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_path,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 char =
*<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/in=
clude/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/window=
s.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fr=
om C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/=
xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:=
119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
../net/tap-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/fileapi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39;const shor=
t unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =
=C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName,=
 DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurity=
Attributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HANDLE=
 hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>../chardev/char-wi=
n.c: In function &#39;win_chr_serial_init&#39;:<br>../chardev/char-win.c:96=
:26: error: passing argument 1 of &#39;CreateFileW&#39; from incompatible p=
ointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 =C2=A096 | =C2=
=A0 =C2=A0 s-&gt;file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE=
, 0, NULL,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/incl=
ude/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsoc=
k2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qe=
mu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from ../chardev/char-win.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w=
64-mingw32/include/fileapi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &=
#39;const short unsigned int *&#39;} but argument is of type &#39;const cha=
r *&#39;<br>=C2=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (=
LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_AT=
TRIBUTES lpSecurityAttributes, DWORD dwCreationDisposition, DWORD dwFlagsAn=
dAttributes, HANDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>=
../chardev/char-win.c:111:26: error: passing argument 1 of &#39;GetDefaultC=
ommConfigW&#39; from incompatible pointer type [-Werror=3Dincompatible-poin=
ter-types]<br>=C2=A0 111 | =C2=A0 =C2=A0 GetDefaultCommConfig(filename, &am=
p;comcfg, &amp;size);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *<br>In file included from C:/CI-Tools/msys64/mingw64/=
x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work=
/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../chardev/char-win.c:25:<br>C:/CI-Tools/ms=
ys64/mingw64/x86_64-w64-mingw32/include/winbase.h:2394:60: note: expected &=
#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is=
 of type &#39;const char *&#39;<br>=C2=A02394 | =C2=A0 WINBASEAPI WINBOOL W=
INAPI GetDefaultCommConfigW (LPCWSTR lpszName, LPCOMMCONFIG lpCC, LPDWORD l=
pdwSize);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~=
~~^~~~~~~~<br>../chardev/char-win.c:113:22: error: passing argument 1 of &#=
39;CommConfigDialogW&#39; from incompatible pointer type [-Werror=3Dincompa=
tible-pointer-types]<br>=C2=A0 113 | =C2=A0 =C2=A0 CommConfigDialog(filenam=
e, NULL, &amp;comcfg);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>In file includ=
ed from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/C=
I-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qe=
mu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../char=
dev/char-win.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/winbase.h:2392:56: note: expected &#39;LPCWSTR&#39; {aka &#39;const short =
unsigned int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=
=A02392 | =C2=A0 WINBASEAPI WINBOOL WINAPI CommConfigDialogW (LPCWSTR lpszN=
ame, HWND hWnd, LPCOMMCONFIG lpCC);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0~~~~~~~~^~~~~~~~<br>cc1.exe: all warnings being treated as errors<br>=
cc1.exe: all warnings being treated as errors<br>../chardev/char-file.c: In=
 function &#39;qmp_chardev_open_file&#39;:<br>../chardev/char-file.c:63:26:=
 error: passing argument 1 of &#39;CreateFileW&#39; from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 =C2=A063 | =C2=A0 =
=C2=A0 out =3D CreateFile(file-&gt;out, accessmode, FILE_SHARE_READ, NULL, =
flags,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~^~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file i=
ncluded from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.=
h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/incl=
ude/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../chardev/cha=
r-file.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/filea=
pi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned=
 int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A064 | =
=C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD dwDe=
siredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurityAttributes,=
 DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HANDLE hTemplateF=
ile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>../block.c: In function &#39=
;get_tmp_filename&#39;:<br>../block.c:757:35: error: passing argument 2 of =
&#39;GetTempPathW&#39; from incompatible pointer type [-Werror=3Dincompatib=
le-pointer-types]<br>=C2=A0 757 | =C2=A0 =C2=A0 return (GetTempPath(MAX_PAT=
H, temp_dir)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw6=
4/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../block.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/fileapi.h:188:69: note: expected &#39;LPWSTR&#39; {ak=
a &#39;short unsigned int *&#39;} but argument is of type &#39;char *&#39;<=
br>=C2=A0 188 | =C2=A0 WINBASEAPI DWORD WINAPI GetTempPathW (DWORD nBufferL=
ength, LPWSTR lpBuffer);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~^~~~~~~~<br>../block.c:=
758:32: error: passing argument 1 of &#39;GetTempFileNameW&#39; from incomp=
atible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 758 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; GetTempFileName(temp_d=
ir, &quot;qem&quot;, 0, filename)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *<br>In file included from C:/CI-Tools/msys64/mingw64=
/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../block.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/fileapi.h:127:52: note: expected &#39;LPCWSTR&#39; {a=
ka &#39;const short unsigned int *&#39;} but argument is of type &#39;char =
*&#39;<br>=C2=A0 127 | =C2=A0 WINBASEAPI UINT WINAPI GetTempFileNameW (LPCW=
STR lpPathName, LPCWSTR lpPrefixString, UINT uUnique, LPWSTR lpTempFileName=
);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~<br>../block.c:758:42: =
error: passing argument 2 of &#39;GetTempFileNameW&#39; from incompatible p=
ointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 758 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; GetTempFileName(temp_dir, &qu=
ot;qem&quot;, 0, filename)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>In file included from C:/CI-=
Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64=
/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x8=
6_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win=
32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block.c:25:<br>C:/CI-Tools/ms=
ys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:127:72: note: expected &#=
39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is =
of type &#39;const char *&#39;<br>=C2=A0 127 | =C2=A0 WINBASEAPI UINT WINAP=
I GetTempFileNameW (LPCWSTR lpPathName, LPCWSTR lpPrefixString, UINT uUniqu=
e, LPWSTR lpTempFileName);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~~~=
~~<br>../block.c:758:52: error: passing argument 4 of &#39;GetTempFileNameW=
&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]=
<br>=C2=A0 758 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; GetTe=
mpFileName(temp_dir, &quot;qem&quot;, 0, filename)<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86=
_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-ming=
w32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/inc=
lude/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../block.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/fileapi.h:127:109: note: expected &#39;LPWSTR&#39; {aka &#39=
;short unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=
=A0 127 | =C2=A0 WINBASEAPI UINT WINAPI GetTempFileNameW (LPCWSTR lpPathNam=
e, LPCWSTR lpPrefixString, UINT uUnique, LPWSTR lpTempFileName);<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0~~~~~~~^~~~~~~~~~~~~~<br>../chardev/char-pipe.c: In function &#39;win_ch=
r_pipe_init&#39;:<br>../chardev/char-pipe.c:66:31: error: passing argument =
1 of &#39;CreateNamedPipeW&#39; from incompatible pointer type [-Werror=3Di=
ncompatible-pointer-types]<br>=C2=A0 =C2=A066 | =C2=A0 =C2=A0 s-&gt;file =
=3D CreateNamedPipe(openname,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<b=
r>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/inclu=
de/winbase.h:26,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h=
:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../c=
hardev/char-pipe.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/namedpipeapi.h:28:54: note: expected &#39;LPCWSTR&#39; {aka &#39;const=
 short unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=
=A0 =C2=A028 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateNamedPipeW (LPCWSTR lp=
Name, DWORD dwOpenMode, DWORD dwPipeMode, DWORD nMaxInstances, DWORD nOutBu=
fferSize, DWORD nInBufferSize, DWORD nDefaultTimeOut, LPSECURITY_ATTRIBUTES=
 lpSecurityAttributes);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~=
~<br>../qga/service-win32.c: In function &#39;printf_win_error&#39;:<br>../=
qga/service-win32.c:28:9: error: passing argument 5 of &#39;FormatMessageW&=
#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<=
br>=C2=A0 =C2=A028 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *)&amp;message, 0,<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included from C:/CI-Too=
ls/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mi=
ngw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu=
/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/service-win32.c:13=
:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:1366:1=
22: note: expected &#39;LPWSTR&#39; {aka &#39;short unsigned int *&#39;} bu=
t argument is of type &#39;char *&#39;<br>=C2=A01366 | =C2=A0 WINBASEAPI DW=
ORD WINAPI FormatMessageW (DWORD dwFlags, LPCVOID lpSource, DWORD dwMessage=
Id, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize, va_list *Arguments);<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~~~<br>=
../qga/service-win32.c: In function &#39;ga_install_service&#39;:<br>../qga=
/service-win32.c:107:34: error: initialization of &#39;WCHAR *&#39; {aka &#=
39;short unsigned int *&#39;} from incompatible pointer type &#39;char *&#3=
9; [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 107 | =C2=A0 =C2=A0 SER=
VICE_DESCRIPTION desc =3D { (char *)QGA_SERVICE_DESCRIPTION };<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>../qga/serv=
ice-win32.c:107:34: note: (near initialization for &#39;desc.lpDescription&=
#39;)<br>../qga/service-win32.c:118:43: error: passing argument 1 of &#39;w=
in_escape_arg&#39; from incompatible pointer type [-Werror=3Dincompatible-p=
ointer-types]<br>=C2=A0 118 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0win_escape_arg(module_f=
name, esc));<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCHAR * {aka short unsigned int *}<br>../qg=
a/service-win32.c:42:47: note: expected &#39;const char *&#39; but argument=
 is of type &#39;TCHAR *&#39; {aka &#39;short unsigned int *&#39;}<br>=C2=
=A0 =C2=A042 | static const char *win_escape_arg(const char *to_escape, GSt=
ring *buffer)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ~~~~~~~~~~~~^~~~~~~~~<br>In file included from ../qga/service-wi=
n32.c:15:<br>C:/work/xemu/qemu/qga/service-win32.h:20:34: error: passing ar=
gument 2 of &#39;CreateServiceW&#39; from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]<br>=C2=A0 =C2=A020 | #define QGA_SERVICE_NA=
ME =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qemu-ga&quot;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>../qga/service=
-win32.c:140:38: note: in expansion of macro &#39;QGA_SERVICE_NAME&#39;<br>=
=C2=A0 140 | =C2=A0 =C2=A0 service =3D CreateService(manager, QGA_SERVICE_N=
AME, QGA_SERVICE_DISPLAY_NAME,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~<br>make: [Makefil=
e.ninja:767=EF=BC=9Achardev/libchardev.fa.p/char-win.c.obj] =E9=94=99=E8=AF=
=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>In file included from C:/CI-=
Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msy=
s64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include=
/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/service-win=
32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:=
289:74: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int=
 *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 289 | =C2=
=A0 WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE hSCManager,LPCWSTR =
lpServiceName,LPCWSTR lpDisplayName,DWORD dwDesiredAccess,DWORD dwServiceTy=
pe,DWORD dwStartType,DWORD dwErrorControl,LPCWSTR lpBinaryPathName,LPCWSTR =
lpLoadOrderGroup,LPDWORD lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpService=
StartName,LPCWSTR lpPassword);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^=
~~~~~~~~~~~~<br>In file included from ../qga/service-win32.c:15:<br>C:/work=
/xemu/qemu/qga/service-win32.h:19:34: error: passing argument 3 of &#39;Cre=
ateServiceW&#39; from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]<br>=C2=A0 =C2=A019 | #define QGA_SERVICE_DISPLAY_NAME &quot;QEM=
U Guest Agent&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>../qga/service-win32.c:140:5=
6: note: in expansion of macro &#39;QGA_SERVICE_DISPLAY_NAME&#39;<br>=C2=A0=
 140 | =C2=A0 =C2=A0 service =3D CreateService(manager, QGA_SERVICE_NAME, Q=
GA_SERVICE_DISPLAY_NAME,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~<br>In file included from C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:122,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/incl=
ude/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/service=
-win32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsv=
c.h:289:96: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned=
 int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 289 |=
 =C2=A0 WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE hSCManager,LPCW=
STR lpServiceName,LPCWSTR lpDisplayName,DWORD dwDesiredAccess,DWORD dwServi=
ceType,DWORD dwStartType,DWORD dwErrorControl,LPCWSTR lpBinaryPathName,LPCW=
STR lpLoadOrderGroup,LPDWORD lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpSer=
viceStartName,LPCWSTR lpPassword);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
~~~~~~^~~~~~~~~~~~~<br>../qga/service-win32.c:142:38: error: passing argume=
nt 8 of &#39;CreateServiceW&#39; from incompatible pointer type [-Werror=3D=
incompatible-pointer-types]<br>=C2=A0 142 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 SER=
VICE_ERROR_NORMAL, cmdline-&gt;str, NULL, NULL, NULL, NULL, NULL);<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gchar * {aka char *}<br>In file included from C:/CI-Tools/msys64/=
mingw64/x86_64-w64-mingw32/include/windows.h:122,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x8=
6_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win=
32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/service-win32.c:13:<br>C:=
/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:289:199: note:=
 expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but =
argument is of type &#39;gchar *&#39; {aka &#39;char *&#39;}<br>=C2=A0 289 =
| =C2=A0 WINADVAPI SC_HANDLE WINAPI CreateServiceW(SC_HANDLE hSCManager,LPC=
WSTR lpServiceName,LPCWSTR lpDisplayName,DWORD dwDesiredAccess,DWORD dwServ=
iceType,DWORD dwStartType,DWORD dwErrorControl,LPCWSTR lpBinaryPathName,LPC=
WSTR lpLoadOrderGroup,LPDWORD lpdwTagId,LPCWSTR lpDependencies,LPCWSTR lpSe=
rviceStartName,LPCWSTR lpPassword);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~=
~~~~~~~~~~~~<br>In file included from ../qga/service-win32.c:15:<br>../qga/=
service-win32.c: In function &#39;ga_uninstall_service&#39;:<br>C:/work/xem=
u/qemu/qga/service-win32.h:20:34: error: passing argument 2 of &#39;OpenSer=
viceW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-t=
ypes]<br>=C2=A0 =C2=A020 | #define QGA_SERVICE_NAME =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;qemu-ga&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>../qga/service-win32.c:173:3=
6: note: in expansion of macro &#39;QGA_SERVICE_NAME&#39;<br>=C2=A0 173 | =
=C2=A0 =C2=A0 service =3D OpenService(manager, QGA_SERVICE_NAME, DELETE);<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~~~~~~~~~<br>In file included from C:/CI-Tools/msys64/mingw64/x86=
_64-w64-mingw32/include/windows.h:122,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work=
/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/service-win32.c:13:<br>C:/CI-Tools/m=
sys64/mingw64/x86_64-w64-mingw32/include/winsvc.h:306:72: note: expected &#=
39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is =
of type &#39;const char *&#39;<br>=C2=A0 306 | =C2=A0 WINADVAPI SC_HANDLE W=
INAPI OpenServiceW(SC_HANDLE hSCManager,LPCWSTR lpServiceName,DWORD dwDesir=
edAccess);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~~~~<br>../qga/chann=
el-win32.c: In function &#39;ga_channel_open&#39;:<br>../qga/channel-win32.=
c:301:28: error: passing argument 1 of &#39;CreateFileW&#39; from incompati=
ble pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 301 | =C2=
=A0 =C2=A0 c-&gt;handle =3D CreateFile(newpath, GENERIC_READ | GENERIC_WRIT=
E, 0, NULL,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0gchar * {aka char *}<br>In file included from C:/CI=
-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msy=
s64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw6=
4/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-=
win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/channel-win32.c:1:<br=
>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49: not=
e: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} bu=
t argument is of type &#39;gchar *&#39; {aka &#39;char *&#39;}<br>=C2=A0 =
=C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName,=
 DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurity=
Attributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HANDLE=
 hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>make: [Makefile.ni=
nja:952=EF=BC=9Alibcommon.fa.p/net_tap-win32.c.obj] =E9=94=99=E8=AF=AF 1 (=
=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>cc1.exe: all warnings being treated=
 as errors<br>cc1.exe: all warnings being treated as errors<br>cc1.exe: all=
 warnings being treated as errors<br>make: [Makefile.ninja:773=EF=BC=9Achar=
dev/libchardev.fa.p/char-file.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=
=BD=E7=95=A5=EF=BC=89<br>../block/file-win32.c: In function &#39;raw_probe_=
alignment&#39;:<br>../block/file-win32.c:250:27: error: passing argument 1 =
of &#39;GetDiskFreeSpaceW&#39; from incompatible pointer type [-Werror=3Din=
compatible-pointer-types]<br>=C2=A0 250 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 GetDi=
skFreeSpace(s-&gt;drive_path, &amp;sectorsPerCluster,<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0~^~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included=
 from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-=
Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64=
/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sys=
emu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c=
:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:74:=
56: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#=
39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A074 | =C2=A0 W=
INBASEAPI WINBOOL WINAPI GetDiskFreeSpaceW (LPCWSTR lpRootPathName, LPDWORD=
 lpSectorsPerCluster, LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClust=
ers, LPDWORD lpTotalNumberOfClusters);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0~~~~~~~~^~~~~~~~~~~~~~<br>cc1.exe: all warnings being treated as =
errors<br>../block/file-win32.c: In function &#39;raw_open&#39;:<br>../bloc=
k/file-win32.c:390:39: error: passing argument 2 of &#39;GetCurrentDirector=
yW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-type=
s]<br>=C2=A0 390 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 GetCurrentDirectory(MAX_PATH=
, buf);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included fr=
om C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:28,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-To=
ols/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64=
/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sys=
emu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c=
:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/processenv.h:=
23:77: note: expected &#39;LPWSTR&#39; {aka &#39;short unsigned int *&#39;}=
 but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A023 | =C2=A0 WINBA=
SEAPI DWORD WINAPI GetCurrentDirectoryW (DWORD nBufferLength, LPWSTR lpBuff=
er);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~^~~~~~~~<br>.=
./block/file-win32.c:394:27: error: passing argument 1 of &#39;CreateFileW&=
#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<=
br>=C2=A0 394 | =C2=A0 =C2=A0 s-&gt;hfile =3D CreateFile(filename, access_f=
lags,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-ming=
w32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h=
:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/o=
sdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from ../block/file-win32.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-=
mingw32/include/fileapi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39=
;const short unsigned int *&#39;} but argument is of type &#39;const char *=
&#39;<br>=C2=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPC=
WSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRI=
BUTES lpSecurityAttributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAt=
tributes, HANDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>=
../block/file-win32.c: In function &#39;raw_getlength&#39;:<br>../block/fil=
e-win32.c:540:34: error: passing argument 1 of &#39;GetDiskFreeSpaceExW&#39=
; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=
=C2=A0 540 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!GetDiskFreeSpaceEx(s-&gt;driv=
e_path, &amp;available, &amp;total, &amp;total_free))<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~^~~~~~~~~~~~<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file included=
 from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-=
Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64=
/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sys=
emu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c=
:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:174=
:58: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&=
#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 174 | =C2=A0 WINBA=
SEAPI WINBOOL WINAPI GetDiskFreeSpaceExW (LPCWSTR lpDirectoryName, PULARGE_=
INTEGER lpFreeBytesAvailableToCaller, PULARGE_INTEGER lpTotalNumberOfBytes,=
 PULARGE_INTEGER lpTotalNumberOfFreeBytes);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~~~~~~<br>make: [Makefile.ninja:14=
28=EF=BC=9Aqga/qemu-ga.exe.p/service-win32.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=
=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>../block/file-win32.c: In function &#3=
9;raw_get_allocated_file_size&#39;:<br>../block/file-win32.c:566:59: error:=
 passing argument 1 of &#39;GetModuleHandleW&#39; from incompatible pointer=
 type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 566 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (get_compressed_t) GetProcAddress(GetModuleHandle(&quot;kerne=
l32&quot;),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *<br>In file in=
cluded from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h=
:24,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/incl=
ude/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-=
win32.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloa=
derapi.h:140:53: note: expected &#39;LPCWSTR&#39; {aka &#39;const short uns=
igned int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 =
140 | WINBASEAPI HMODULE WINAPI GetModuleHandleW (LPCWSTR lpModuleName);<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~~~<br>make: [Makefile.nin=
ja:777=EF=BC=9Achardev/libchardev.fa.p/char-pipe.c.obj] =E9=94=99=E8=AF=AF =
1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>../block/file-win32.c: In functi=
on &#39;find_cdrom&#39;:<br>../block/file-win32.c:684:44: error: passing ar=
gument 2 of &#39;GetLogicalDriveStringsW&#39; from incompatible pointer typ=
e [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 684 | =C2=A0 =C2=A0 GetL=
ogicalDriveStrings(sizeof(drives), drives);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch=
ar *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32=
/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/win=
dows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/=
work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osde=
p.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom ../block/file-win32.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-ming=
w32/include/fileapi.h:90:80: note: expected &#39;LPWSTR&#39; {aka &#39;shor=
t unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =
=C2=A090 | =C2=A0 WINBASEAPI DWORD WINAPI GetLogicalDriveStringsW (DWORD nB=
ufferLength, LPWSTR lpBuffer);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ~~~~~~~^~~~~~~~<br>../block/file-win32.c:686:29: error: passi=
ng argument 1 of &#39;GetDriveTypeW&#39; from incompatible pointer type [-W=
error=3Dincompatible-pointer-types]<br>=C2=A0 686 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 type =3D GetDriveType(pdrv);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included from =
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/min=
gw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu=
/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c:25:=
<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:76:49: =
note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;}=
 but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A076 | =C2=A0 WINBA=
SEAPI UINT WINAPI GetDriveTypeW (LPCWSTR lpRootPathName);<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~~~^~~~~~~~~~~~~~<br>../block/file-win32.c:693:25: error: passing argum=
ent 1 of &#39;lstrlenW&#39; from incompatible pointer type [-Werror=3Dincom=
patible-pointer-types]<br>=C2=A0 693 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdrv +=
=3D lstrlen(pdrv) + 1;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In=
 file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/w=
indows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/=
work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osde=
p.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom ../block/file-win32.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-ming=
w32/include/winbase.h:1430:43: note: expected &#39;LPCWSTR&#39; {aka &#39;c=
onst short unsigned int *&#39;} but argument is of type &#39;char *&#39;<br=
>=C2=A01430 | =C2=A0 WINBASEAPI int WINAPI lstrlenW (LPCWSTR lpString);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~=
^~~~~~~~<br>../block/file-win32.c: In function &#39;find_device_type&#39;:<=
br>../block/file-win32.c:709:30: error: passing argument 1 of &#39;GetDrive=
TypeW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-t=
ypes]<br>=C2=A0 709 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D GetDriveType(s-&=
gt;drive_path);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~^~~~~~~=
~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file included fro=
m C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-To=
ols/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64=
/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sys=
emu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c=
:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:76:=
49: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#=
39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A076 | =C2=A0 W=
INBASEAPI UINT WINAPI GetDriveTypeW (LPCWSTR lpRootPathName);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~~~~~~~^~~~~~~~~~~~~~<br>../block/file-win32.c: In function &#39;hdev_=
open&#39;:<br>../block/file-win32.c:799:27: error: passing argument 1 of &#=
39;CreateFileW&#39; from incompatible pointer type [-Werror=3Dincompatible-=
pointer-types]<br>=C2=A0 799 | =C2=A0 =C2=A0 s-&gt;hfile =3D CreateFile(fil=
ename, access_flags,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *<br>In file included from C:/CI-Tools/msys64/mingw64=
/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../block/file-win32.c:25:<br>C:/CI-Tools/msys64/mi=
ngw64/x86_64-w64-mingw32/include/fileapi.h:64:49: note: expected &#39;LPCWS=
TR&#39; {aka &#39;const short unsigned int *&#39;} but argument is of type =
&#39;const char *&#39;<br>=C2=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI=
 CreateFileW (LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,=
 LPSECURITY_ATTRIBUTES lpSecurityAttributes, DWORD dwCreationDisposition, D=
WORD dwFlagsAndAttributes, HANDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~=
^~~~~~~~~~<br>../qga/vss-win32.c: In function &#39;call_vss_provider_func&#=
39;:<br>../qga/vss-win32.c:38:23: error: passing argument 5 of &#39;FormatM=
essageW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer=
-types]<br>=C2=A0 =C2=A038 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *)&amp;msg, 0, NULL);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw=
32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/=
xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/vss-win32.c:13:<br>C:/CI-Tools/msys6=
4/mingw64/x86_64-w64-mingw32/include/winbase.h:1366:122: note: expected &#3=
9;LPWSTR&#39; {aka &#39;short unsigned int *&#39;} but argument is of type =
&#39;char *&#39;<br>=C2=A01366 | =C2=A0 WINBASEAPI DWORD WINAPI FormatMessa=
geW (DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId, DWORD dwLanguageId=
, LPWSTR lpBuffer, DWORD nSize, va_list *Arguments);<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~~~<br>../qga/vss-win32.c: I=
n function &#39;vss_init&#39;:<br>../qga/vss-win32.c:90:23: error: passing =
argument 5 of &#39;FormatMessageW&#39; from incompatible pointer type [-Wer=
ror=3Dincompatible-pointer-types]<br>=C2=A0 =C2=A090 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *)&amp;msg, =
0, NULL);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included from C:/C=
I-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msy=
s64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include=
/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/vss-win32.c=
:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:136=
6:122: note: expected &#39;LPWSTR&#39; {aka &#39;short unsigned int *&#39;}=
 but argument is of type &#39;char *&#39;<br>=C2=A01366 | =C2=A0 WINBASEAPI=
 DWORD WINAPI FormatMessageW (DWORD dwFlags, LPCVOID lpSource, DWORD dwMess=
ageId, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize, va_list *Arguments=
);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~~~=
<br>In file included from C:/work/xemu/qemu/qga/vss-win32.h:16,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/main.c:3=
9:<br>../qga/main.c: In function &#39;quit_handler&#39;:<br>C:/work/xemu/qe=
mu/qga/vss-win32/vss-handles.h:12:28: error: passing argument 3 of &#39;Ope=
nEventW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer=
-types]<br>=C2=A0 =C2=A012 | #define EVENT_NAME_TIMEOUT &quot;Global\\QGAVS=
SEvent-timeout&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>../qga/main=
.c:160:60: note: in expansion of macro &#39;EVENT_NAME_TIMEOUT&#39;<br>=C2=
=A0 160 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 hEventTimeout =3D OpenEvent(EVENT_ALL=
_ACCESS, FALSE, EVENT_NAME_TIMEOUT);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~<br>I=
n file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/=
winbase.h:35,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:=
70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../q=
ga/main.c:14:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/sync=
hapi.h:55:95: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsign=
ed int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 =C2=
=A055 | =C2=A0 WINBASEAPI HANDLE WINAPI OpenEventW (DWORD dwDesiredAccess, =
WINBOOL bInheritHandle, LPCWSTR lpName);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~~~^~~~~~<br>In file included from ../qga/main.c:38:<br>../qga/main.c: =
In function &#39;service_main&#39;:<br>C:/work/xemu/qemu/qga/service-win32.=
h:20:34: error: passing argument 1 of &#39;RegisterServiceCtrlHandlerExW&#3=
9; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br=
>=C2=A0 =C2=A020 | #define QGA_SERVICE_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;qemu-ga&quot;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *<br>../qga/main.c:719:59: note: in expansion o=
f macro &#39;QGA_SERVICE_NAME&#39;<br>=C2=A0 719 | =C2=A0 =C2=A0 service-&g=
t;status_handle =3D RegisterServiceCtrlHandlerEx(QGA_SERVICE_NAME,<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
~~~~~~~~~~~~~~~<br>cc1.exe: all warnings being treated as errors<br>In file=
 included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/window=
s.h:122,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work=
/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:=
119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
../qga/main.c:14:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/=
winsvc.h:319:80: note: expected &#39;LPCWSTR&#39; {aka &#39;const short uns=
igned int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 =
319 | =C2=A0 WINADVAPI SERVICE_STATUS_HANDLE WINAPI RegisterServiceCtrlHand=
lerExW(LPCWSTR lpServiceName,LPHANDLER_FUNCTION_EX lpHandlerProc,LPVOID lpC=
ontext);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^=
~~~~~~~~~~~~<br>../qga/main.c: In function &#39;main&#39;:<br>../qga/main.c=
:1542:15: error: initialization of &#39;WCHAR *&#39; {aka &#39;short unsign=
ed int *&#39;} from incompatible pointer type &#39;char *&#39; [-Werror=3Di=
ncompatible-pointer-types]<br>=C2=A01542 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<=
br>../qga/main.c:1542:15: note: (near initialization for &#39;service_table=
[0].lpServiceName&#39;)<br>cc1.exe: all warnings being treated as errors<br=
>make: [Makefile.ninja:1430=EF=BC=9Aqga/qemu-ga.exe.p/vss-win32.c.obj] =E9=
=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>make: [Makefile.=
ninja:1427=EF=BC=9Aqga/qemu-ga.exe.p/channel-win32.c.obj] =E9=94=99=E8=AF=
=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>make: [Makefile.ninja:896=EF=
=BC=9Alibblock.fa.p/block_file-win32.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=
=E5=BF=BD=E7=95=A5=EF=BC=89<br>Linking static target chardev/libchardev.fa<=
br>C:\CI-Tools\msys64\mingw64\bin\ar.exe: chardev/libchardev.fa.p/char-win.=
c.obj: No such file or directory<br>make: [Makefile.ninja:780=EF=BC=9Achard=
ev/libchardev.fa] =E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=
=89<br>cc1.exe: all warnings being treated as errors<br>make: [Makefile.nin=
ja:1429=EF=BC=9Aqga/qemu-ga.exe.p/main.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=
=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>cc1.exe: all warnings being treated as er=
rors<br>make: [Makefile.ninja:882=EF=BC=9Alibblock.fa.p/block.c.obj] =E9=94=
=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>../util/oslib-win32=
.c: In function &#39;qemu_get_local_state_pathname&#39;:<br>../util/oslib-w=
in32.c:289:58: error: passing argument 5 of &#39;SHGetFolderPathW&#39; from=
 incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0=
 289 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SHGFP_TYPE_CURRENT */ 0, base_path=
);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file included from ../util/o=
slib-win32.c:44:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/s=
hlobj.h:39:92: note: expected &#39;LPWSTR&#39; {aka &#39;short unsigned int=
 *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A039 | =C2=
=A0 SHFOLDERAPI SHGetFolderPathW (HWND hwnd, int csidl, HANDLE hToken, DWOR=
D dwFlags, LPWSTR pszPath);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~~<br>../u=
til/oslib-win32.c: In function &#39;qemu_init_exec_dir&#39;:<br>../util/osl=
ib-win32.c:327:35: error: passing argument 2 of &#39;GetModuleFileNameW&#39=
; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=
=C2=A0 327 | =C2=A0 =C2=A0 len =3D GetModuleFileName(NULL, buf, sizeof(buf)=
 - 1);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/winbase.h:24,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/incl=
ude/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsoc=
k2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qe=
mu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from ../util/oslib-win32.c:33:<br>C:/CI-Tools/msys64/mingw64/x86_64-w=
64-mingw32/include/libloaderapi.h:153:71: note: expected &#39;LPWSTR&#39; {=
aka &#39;short unsigned int *&#39;} but argument is of type &#39;char *&#39=
;<br>=C2=A0 153 | =C2=A0 WINBASEAPI DWORD WINAPI GetModuleFileNameW (HMODUL=
E hModule, LPWSTR lpFilename, DWORD nSize);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
~~~~~^~~~~~~~~~<br>../util/oslib-win32.c: In function &#39;qemu_write_pidfi=
le&#39;:<br>../util/oslib-win32.c:801:23: error: passing argument 1 of &#39=
;CreateFileW&#39; from incompatible pointer type [-Werror=3Dincompatible-po=
inter-types]<br>=C2=A0 801 | =C2=A0 =C2=A0 file =3D CreateFile(filename, GE=
NERIC_WRITE, FILE_SHARE_READ, NULL,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *<br=
>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/includ=
e/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:=
70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../u=
til/oslib-win32.c:33:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/incl=
ude/fileapi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39;const short=
 unsigned int *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=
=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileN=
ame, DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecu=
rityAttributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HA=
NDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>../qga/command=
s-win32.c: In function &#39;acquire_privilege&#39;:<br>../qga/commands-win3=
2.c:285:41: error: passing argument 2 of &#39;LookupPrivilegeValueW&#39; fr=
om incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=
=A0 285 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!LookupPrivilegeValue(NULL, name,=
 &amp;priv.Privileges[0].Luid)) {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *<br>In file included from C:/CI-Tools/msys64/=
mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x8=
6_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win=
32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:2519:81: not=
e: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} bu=
t argument is of type &#39;const char *&#39;<br>=C2=A02519 | =C2=A0 WINADVA=
PI WINBOOL WINAPI LookupPrivilegeValueW (LPCWSTR lpSystemName, LPCWSTR lpNa=
me, PLUID lpLuid);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~~~~~~~^~~~~~<br>../qga/commands-win32.c: In function &#39;qmp_guest_s=
hutdown&#39;:<br>../qga/commands-win32.c:343:23: error: passing argument 1 =
of &#39;acquire_privilege&#39; from incompatible pointer type [-Werror=3Din=
compatible-pointer-types]<br>=C2=A0 343 | =C2=A0 =C2=A0 acquire_privilege(S=
E_SHUTDOWN_NAME, &amp;local_err);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~=
~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const sh=
ort unsigned int *<br>../qga/commands-win32.c:276:43: note: expected &#39;c=
onst char *&#39; but argument is of type &#39;const short unsigned int *&#3=
9;<br>=C2=A0 276 | static void acquire_privilege(const char *name, Error **=
errp)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~=
^~~~<br>../qga/commands-win32.c: In function &#39;get_pci_info&#39;:<br>../=
qga/commands-win32.c:600:48: error: passing argument 3 of &#39;SetupDiGetDe=
viceInstanceIdW&#39; from incompatible pointer type [-Werror=3Dincompatible=
-pointer-types]<br>=C2=A0 600 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent_dev_id, size, &a=
mp;size)) {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0char *<br>In file included from ../qga/commands-win32.c=
:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/setupapi.h:15=
62:119: note: expected &#39;PWSTR&#39; {aka &#39;short unsigned int *&#39;}=
 but argument is of type &#39;char *&#39;<br>=C2=A01562 | =C2=A0 WINSETUPAP=
I WINBOOL WINAPI SetupDiGetDeviceInstanceIdW(HDEVINFO DeviceInfoSet,PSP_DEV=
INFO_DATA DeviceInfoData,PWSTR DeviceInstanceId,DWORD DeviceInstanceIdSize,=
PDWORD RequiredSize);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~=
~^~~~~~~~~~~~~~~~<br>../qga/commands-win32.c:615:47: error: passing argumen=
t 2 of &#39;CM_Locate_DevNodeW&#39; from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]<br>=C2=A0 615 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 cr =3D CM_Locate_DevInst(&amp;dev_inst, parent_dev_id, 0);<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In fi=
le included from ../qga/commands-win32.c:29:<br>C:/CI-Tools/msys64/mingw64/=
x86_64-w64-mingw32/include/cfgmgr32.h:887:77: note: expected &#39;DEVINSTID=
_W&#39; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;c=
har *&#39;<br>=C2=A0 887 | =C2=A0 CMAPI CONFIGRET WINAPI CM_Locate_DevNodeW=
(PDEVINST pdnDevInst,DEVINSTID_W pDeviceID,ULONG ulFlags);<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ~~~~~~~~~~~~^~~~~~~~~<br>../qga/commands-win32.c:644:52: erro=
r: passing argument 2 of &#39;CM_Get_Device_IDW&#39; from incompatible poin=
ter type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 644 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cr =3D CM_Get_Device_ID(parent_dev_inst, pa=
rent_dev_id, dev_id_size,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch=
ar *<br>In file included from ../qga/commands-win32.c:29:<br>C:/CI-Tools/ms=
ys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:811:69: note: expected &=
#39;PWCHAR&#39; {aka &#39;short unsigned int *&#39;} but argument is of typ=
e &#39;char *&#39;<br>=C2=A0 811 | =C2=A0 CMAPI CONFIGRET WINAPI CM_Get_Dev=
ice_IDW(DEVINST dnDevInst,PWCHAR Buffer,ULONG BufferLen,ULONG ulFlags);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0~~~~~~~^~~~~~<br>../qga/commands-win32.c:657:65: error: pa=
ssing argument 2 of &#39;SetupDiGetClassDevsW&#39; from incompatible pointe=
r type [-Werror=3Dincompatible-pointer-types]<br>=C2=A0 657 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SetupDiGetClassDevs(&amp;GUID_DEVINTERFACE_STO=
RAGEPORT, parent_dev_id,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file incl=
uded from ../qga/commands-win32.c:25:<br>C:/CI-Tools/msys64/mingw64/x86_64-=
w64-mingw32/include/setupapi.h:1637:81: note: expected &#39;PCWSTR&#39; {ak=
a &#39;const short unsigned int *&#39;} but argument is of type &#39;char *=
&#39;<br>=C2=A01637 | =C2=A0 WINSETUPAPI HDEVINFO WINAPI SetupDiGetClassDev=
sW(CONST GUID *ClassGuid,PCWSTR Enumerator,HWND hwndParent,DWORD Flags);<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~^~~~~~=
~~~~<br>../qga/commands-win32.c: In function &#39;get_single_disk_info&#39;=
:<br>../qga/commands-win32.c:822:29: error: passing argument 1 of &#39;Crea=
teFileW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer=
-types]<br>=C2=A0 822 | =C2=A0 =C2=A0 disk_h =3D CreateFile(disk-&gt;dev, 0=
, FILE_SHARE_READ, NULL, OPEN_EXISTING,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~~~^~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file included from C:/C=
I-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msy=
s64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw6=
4/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-=
win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<=
br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49: n=
ote: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} =
but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A064 | =C2=A0 WINBAS=
EAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD dwDesiredAccess, =
DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurityAttributes, DWORD dwCrea=
tionDisposition, DWORD dwFlagsAndAttributes, HANDLE hTemplateFile);<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>../qga/commands-win32.c: In function &#39;=
build_guest_disk_info&#39;:<br>../qga/commands-win32.c:891:24: error: passi=
ng argument 1 of &#39;CreateFileW&#39; from incompatible pointer type [-Wer=
ror=3Dincompatible-pointer-types]<br>=C2=A0 891 | =C2=A0 =C2=A0 vol_h =3D C=
reateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *<br>In file included from C:/CI-Tools/msys64/mingw64=
/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/=
mingw64/x86_64-w64-mingw32/include/fileapi.h:64:49: note: expected &#39;LPC=
WSTR&#39; {aka &#39;const short unsigned int *&#39;} but argument is of typ=
e &#39;char *&#39;<br>=C2=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI Cre=
ateFileW (LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode, LPS=
ECURITY_ATTRIBUTES lpSecurityAttributes, DWORD dwCreationDisposition, DWORD=
 dwFlagsAndAttributes, HANDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~=
~~~~~~<br>../qga/commands-win32.c: In function &#39;build_guest_fsinfo&#39;=
:<br>../qga/commands-win32.c:1003:37: error: passing argument 1 of &#39;Get=
VolumePathNamesForVolumeNameW&#39; from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]<br>=C2=A01003 | =C2=A0 =C2=A0 GetVolumePathN=
amesForVolumeName(guid, (LPCH)&amp;mnt, 0, &amp;info_size);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-m=
ingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/incl=
ude/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsoc=
k2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qe=
mu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64=
-w64-mingw32/include/fileapi.h:98:71: note: expected &#39;LPCWSTR&#39; {aka=
 &#39;const short unsigned int *&#39;} but argument is of type &#39;char *&=
#39;<br>=C2=A0 =C2=A098 | =C2=A0 WINBASEAPI WINBOOL WINAPI GetVolumePathNam=
esForVolumeNameW (LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, DWORD =
cchBufferLength, PDWORD lpcchReturnLength);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~=
^~~~~~~~~~~~~~<br>../qga/commands-win32.c:1003:43: error: passing argument =
2 of &#39;GetVolumePathNamesForVolumeNameW&#39; from incompatible pointer t=
ype [-Werror=3Dincompatible-pointer-types]<br>=C2=A01003 | =C2=A0 =C2=A0 Ge=
tVolumePathNamesForVolumeName(guid, (LPCH)&amp;mnt, 0, &amp;info_size);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CHAR * {aka char *}<br>In file included from C:/CI-Tools/msys64/ming=
w64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w=
64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/=
mingw64/x86_64-w64-mingw32/include/fileapi.h:98:93: note: expected &#39;LPW=
CH&#39; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;C=
HAR *&#39; {aka &#39;char *&#39;}<br>=C2=A0 =C2=A098 | =C2=A0 WINBASEAPI WI=
NBOOL WINAPI GetVolumePathNamesForVolumeNameW (LPCWSTR lpszVolumeName, LPWC=
H lpszVolumePathNames, DWORD cchBufferLength, PDWORD lpcchReturnLength);<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~^~~~~~~~~~~~~~~~~~~<br>../qga/command=
s-win32.c:1010:42: error: passing argument 1 of &#39;GetVolumePathNamesForV=
olumeNameW&#39; from incompatible pointer type [-Werror=3Dincompatible-poin=
ter-types]<br>=C2=A01010 | =C2=A0 =C2=A0 if (!GetVolumePathNamesForVolumeNa=
me(guid, mnt_point, info_size,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file included from C:/CI=
-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msy=
s64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw6=
4/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-=
win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<=
br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/fileapi.h:98:71: n=
ote: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int *&#39;} =
but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A098 | =C2=A0 WINBAS=
EAPI WINBOOL WINAPI GetVolumePathNamesForVolumeNameW (LPCWSTR lpszVolumeNam=
e, LPWCH lpszVolumePathNames, DWORD cchBufferLength, PDWORD lpcchReturnLeng=
th);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~~~~~<br>../qga/commands-win32=
.c:1010:48: error: passing argument 2 of &#39;GetVolumePathNamesForVolumeNa=
meW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-typ=
es]<br>=C2=A01010 | =C2=A0 =C2=A0 if (!GetVolumePathNamesForVolumeName(guid=
, mnt_point, info_size,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~=
~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0char *<br>In file included from C:/CI-Tools/msys64/ming=
w64/x86_64-w64-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w=
64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/q=
emu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/=
mingw64/x86_64-w64-mingw32/include/fileapi.h:98:93: note: expected &#39;LPW=
CH&#39; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;c=
har *&#39;<br>=C2=A0 =C2=A098 | =C2=A0 WINBASEAPI WINBOOL WINAPI GetVolumeP=
athNamesForVolumeNameW (LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames, =
DWORD cchBufferLength, PDWORD lpcchReturnLength);<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ~~~~~~^~~~~~~~~~~~~~~~~~~<br>../qga/commands-win32.c:1016:35: error:=
 passing argument 1 of &#39;CreateFileW&#39; from incompatible pointer type=
 [-Werror=3Dincompatible-pointer-types]<br>=C2=A01016 | =C2=A0 =C2=A0 hLoca=
lDiskHandle =3D CreateFile(guid, 0 , 0, NULL, OPEN_EXISTING,<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *<br>In file i=
ncluded from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.=
h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/incl=
ude/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/command=
s-win32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/file=
api.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigne=
d int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A064 |=
 =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpFileName, DWORD dwD=
esiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lpSecurityAttributes=
, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes, HANDLE hTemplate=
File);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>../qga/commands-win32.c:1045=
:34: error: passing argument 1 of &#39;GetDiskFreeSpaceExW&#39; from incomp=
atible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A01045 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetDiskFreeSpaceEx(fs-&gt;mountpoint,<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~^~~~~~~~~~~~<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br=
>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/includ=
e/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:=
70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../q=
ga/commands-win32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/in=
clude/fileapi.h:174:58: note: expected &#39;LPCWSTR&#39; {aka &#39;const sh=
ort unsigned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0=
 174 | =C2=A0 WINBASEAPI WINBOOL WINAPI GetDiskFreeSpaceExW (LPCWSTR lpDire=
ctoryName, PULARGE_INTEGER lpFreeBytesAvailableToCaller, PULARGE_INTEGER lp=
TotalNumberOfBytes, PULARGE_INTEGER lpTotalNumberOfFreeBytes);<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~^~~~~~~~~~~~~~~<br>../qga/=
commands-win32.c: In function &#39;qmp_guest_get_fsinfo&#39;:<br>../qga/com=
mands-win32.c:1070:29: error: passing argument 1 of &#39;FindFirstVolumeW&#=
39; from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<b=
r>=C2=A01070 | =C2=A0 =C2=A0 vol_h =3D FindFirstVolume(guid, sizeof(guid));=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w6=
4-mingw32/include/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/win=
sock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/incl=
ude/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/mingw64=
/x86_64-w64-mingw32/include/fileapi.h:58:53: note: expected &#39;LPWSTR&#39=
; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;char *&=
#39;<br>=C2=A0 =C2=A058 | =C2=A0 WINBASEAPI HANDLE WINAPI FindFirstVolumeW =
(LPWSTR lpszVolumeName, DWORD cchBufferLength);<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0~~~~~~~^~~~~~~~~~~~~~<br>../qga/commands-win32.c:1089:36: erro=
r: passing argument 2 of &#39;FindNextVolumeW&#39; from incompatible pointe=
r type [-Werror=3Dincompatible-pointer-types]<br>=C2=A01089 | =C2=A0 =C2=A0=
 } while (FindNextVolume(vol_h, guid, sizeof(guid)));<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br=
>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/includ=
e/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:=
70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C=
:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xem=
u/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../q=
ga/commands-win32.c:13:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/in=
clude/fileapi.h:60:73: note: expected &#39;LPWSTR&#39; {aka &#39;short unsi=
gned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A06=
0 | =C2=A0 WINBASEAPI WINBOOL WINAPI FindNextVolumeW (HANDLE hFindVolume, L=
PWSTR lpszVolumeName, DWORD cchBufferLength);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0~~~~~~~^~~~~~~~~~~~~~<br>../qga/commands-win32.c: In function &#39;qm=
p_guest_suspend_disk&#39;:<br>../qga/commands-win32.c:1372:23: error: passi=
ng argument 1 of &#39;acquire_privilege&#39; from incompatible pointer type=
 [-Werror=3Dincompatible-pointer-types]<br>=C2=A01372 | =C2=A0 =C2=A0 acqui=
re_privilege(SE_SHUTDOWN_NAME, &amp;local_err);<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const short unsigned int *<br>../qga/commands-win32.c:276:43: note: exp=
ected &#39;const char *&#39; but argument is of type &#39;const short unsig=
ned int *&#39;<br>=C2=A0 276 | static void acquire_privilege(const char *na=
me, Error **errp)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~~~~~~~^~~~<br>../qga/commands-win32.c: In function &#39;qmp_guest_susp=
end_ram&#39;:<br>../qga/commands-win32.c:1395:23: error: passing argument 1=
 of &#39;acquire_privilege&#39; from incompatible pointer type [-Werror=3Di=
ncompatible-pointer-types]<br>=C2=A01395 | =C2=A0 =C2=A0 acquire_privilege(=
SE_SHUTDOWN_NAME, &amp;local_err);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~=
~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const sh=
ort unsigned int *<br>../qga/commands-win32.c:276:43: note: expected &#39;c=
onst char *&#39; but argument is of type &#39;const short unsigned int *&#3=
9;<br>=C2=A0 276 | static void acquire_privilege(const char *name, Error **=
errp)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~=
^~~~<br>../qga/commands-win32.c: In function &#39;guest_addr_to_str&#39;:<b=
r>../qga/commands-win32.c:1459:34: error: passing argument 4 of &#39;WSAAdd=
ressToStringW&#39; from incompatible pointer type [-Werror=3Dincompatible-p=
ointer-types]<br>=C2=A01459 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad=
dr_str,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0char *<br>In file included from C:/work/xemu/qemu/include/sysemu/=
os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:1=
3:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:1086=
:141: note: expected &#39;LPWSTR&#39; {aka &#39;short unsigned int *&#39;} =
but argument is of type &#39;char *&#39;<br>=C2=A01086 | =C2=A0 WINSOCK_API=
_LINKAGE INT WSAAPI WSAAddressToStringW(LPSOCKADDR lpsaAddress,DWORD dwAddr=
essLength,LPWSAPROTOCOL_INFOW lpProtocolInfo,LPWSTR lpszAddressString,LPDWO=
RD lpdwAddressStringLength);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0~~~~~~~^~~~~~~~~~~~~~~~~<br>../qga/commands-win32.c: In function &#39=
;guest_get_network_stats&#39;:<br>../qga/commands-win32.c:1509:42: error: p=
assing argument 1 of &#39;GetModuleHandleW&#39; from incompatible pointer t=
ype [-Werror=3Dincompatible-pointer-types]<br>=C2=A01509 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 HMODULE module =3D GetModuleHandle(&quot;iphlpapi&quot;);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_=
64-w64-mingw32/include/winbase.h:24,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw=
32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/inc=
lude/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/msys64/mingw64=
/x86_64-w64-mingw32/include/libloaderapi.h:140:53: note: expected &#39;LPCW=
STR&#39; {aka &#39;const short unsigned int *&#39;} but argument is of type=
 &#39;const char *&#39;<br>=C2=A0 140 | WINBASEAPI HMODULE WINAPI GetModule=
HandleW (LPCWSTR lpModuleName);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~=
~~~~~~~~<br>../qga/commands-win32.c: In function &#39;qmp_guest_set_time&#3=
9;:<br>../qga/commands-win32.c:1686:24: error: passing argument 1 of &#39;s=
trerror_s&#39; from incompatible pointer type [-Werror=3Dincompatible-point=
er-types]<br>=C2=A01686 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerro=
r_s((LPTSTR) &amp; msg_buffer, 0, errno);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0WCHAR * {aka short unsigned int *}<br>In file included=
 from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/string.h:190,<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/wor=
k/xemu/qemu/include/qemu/osdep.h:87,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:13:<br>C:/CI-Tools/=
msys64/mingw64/x86_64-w64-mingw32/include/sec_api/string_s.h:26:44: note: e=
xpected &#39;char *&#39; but argument is of type &#39;WCHAR *&#39; {aka &#3=
9;short unsigned int *&#39;}<br>=C2=A0 =C2=A026 | =C2=A0 _SECIMP errno_t __=
cdecl strerror_s(char *_Buf,size_t _SizeInBytes,int _ErrNum);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~=
~^~~~<br>In file included from ../qga/commands-win32.c:39:<br>C:/work/xemu/=
qemu/include/qapi/error.h:319:25: error: format &#39;%s&#39; expects argume=
nt of type &#39;char *&#39;, but argument 6 has type &#39;const WCHAR *&#39=
; {aka &#39;const short unsigned int *&#39;} [-Werror=3Dformat=3D]<br>=C2=
=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~<br>../qga/commands-win32.c:1687:13: note: in expansion of macr=
o &#39;error_setg&#39;<br>=C2=A01687 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_setg(errp, &quot;system(...) failed: %s&quot;, (LPCTSTR)msg_bu=
ffer);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
^~~~~~~~~~<br>C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format =
&#39;%s&#39; expects argument of type &#39;char *&#39;, but argument 7 has =
type &#39;const WCHAR *&#39; {aka &#39;const short unsigned int *&#39;} [-W=
error=3Dformat=3D]<br>=C2=A0 319 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (fmt), ## __VA_ARGS__)<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~<br>../qga/commands-win32.c:1702:21: note=
: in expansion of macro &#39;error_setg&#39;<br>=C2=A01702 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &q=
uot;w32tm failed with error (0x%lx): %s&quot;, hr,<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~=
~~~~~~~<br>cc1.exe: all warnings being treated as errors<br>../qga/commands=
-win32.c:1731:23: error: passing argument 1 of &#39;acquire_privilege&#39; =
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=
=C2=A01731 | =C2=A0 =C2=A0 acquire_privilege(SE_SYSTEMTIME_NAME, &amp;local=
_err);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const short unsigned int *<br>../qga=
/commands-win32.c:276:43: note: expected &#39;const char *&#39; but argumen=
t is of type &#39;const short unsigned int *&#39;<br>=C2=A0 276 | static vo=
id acquire_privilege(const char *name, Error **errp)<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~^~~~<br>../qga/commands-win=
32.c: In function &#39;ga_get_win_version&#39;:<br>../qga/commands-win32.c:=
2119:38: error: passing argument 1 of &#39;GetModuleHandleW&#39; from incom=
patible pointer type [-Werror=3Dincompatible-pointer-types]<br>=C2=A02119 |=
 =C2=A0 =C2=A0 HMODULE module =3D GetModuleHandle(&quot;ntdll&quot;);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *<br>In file included from=
 C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winbase.h:24,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools=
/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:70,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/min=
gw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/sysemu=
/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../qga/commands-win32.c:1=
3:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/libloaderapi.h:=
140:53: note: expected &#39;LPCWSTR&#39; {aka &#39;const short unsigned int=
 *&#39;} but argument is of type &#39;const char *&#39;<br>=C2=A0 140 | WIN=
BASEAPI HMODULE WINAPI GetModuleHandleW (LPCWSTR lpModuleName);<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~~~<br>make: [Makefile.ninja:648=EF=
=BC=9Alibqemuutil.a.p/util_oslib-win32.c.obj] =E9=94=99=E8=AF=AF 1 (=E5=B7=
=B2=E5=BF=BD=E7=95=A5=EF=BC=89<br>Linking static target libqemuutil.a<br><b=
r>make[1]: =E7=A6=BB=E5=BC=80=E7=9B=AE=E5=BD=95=E2=80=9C/c/work/xemu/qemu/c=
apstone=E2=80=9D<br>&quot;C:/CI-Tools/msys64/mingw64/bin/python3.exe&quot; =
&quot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&quot; &quot;e=
xe&quot; &quot;--capture&quot; &quot;qemu-version.h&quot; &quot;--&quot; &q=
uot;sh&quot; &quot;C:/work/xemu/qemu/scripts/qemu-version.sh&quot; &quot;C:=
/work/xemu/qemu&quot; &quot;&quot; &quot;5.1.50&quot; &amp;&amp; if test -e=
 qemu-version.h; then printf &#39;%s\n&#39; qemu-version.h &gt; qemu-versio=
n.h.stamp; fi<br>&quot;cc&quot; &quot;-Ilibqemuutil.a.p&quot; &quot;-I.&quo=
t; &quot;-I..&quot; &quot;-Iqapi&quot; &quot;-Itrace&quot; &quot;-Iui&quot;=
 &quot;-Iui/shader&quot; &quot;-IC:/CI-Tools/msys64/mingw64/include&quot; &=
quot;-IC:/CI-Tools/msys64/mingw64/include/glib-2.0&quot; &quot;-IC:/CI-Tool=
s/msys64/mingw64/lib/glib-2.0/include&quot; &quot;-IC:/CI-Tools/msys64/ming=
w64/include/p11-kit-1&quot; &quot;-fdiagnostics-color=3Dauto&quot; &quot;-p=
ipe&quot; &quot;-Wall&quot; &quot;-Winvalid-pch&quot; &quot;-Werror&quot; &=
quot;-std=3Dgnu99&quot; &quot;-g&quot; &quot;-m64&quot; &quot;-mcx16&quot; =
&quot;-DUNICODE&quot; &quot;-D_UNICODE&quot; &quot;-D_GNU_SOURCE&quot; &quo=
t;-D_FILE_OFFSET_BITS=3D64&quot; &quot;-D_LARGEFILE_SOURCE&quot; &quot;-Wst=
rict-prototypes&quot; &quot;-Wredundant-decls&quot; &quot;-Wundef&quot; &qu=
ot;-Wwrite-strings&quot; &quot;-Wmissing-prototypes&quot; &quot;-fno-strict=
-aliasing&quot; &quot;-fno-common&quot; &quot;-fwrapv&quot; &quot;-Wold-sty=
le-declaration&quot; &quot;-Wold-style-definition&quot; &quot;-Wtype-limits=
&quot; &quot;-Wformat-security&quot; &quot;-Wformat-y2k&quot; &quot;-Winit-=
self&quot; &quot;-Wignored-qualifiers&quot; &quot;-Wempty-body&quot; &quot;=
-Wnested-externs&quot; &quot;-Wendif-labels&quot; &quot;-Wexpansion-to-defi=
ned&quot; &quot;-Wno-missing-include-dirs&quot; &quot;-Wno-shift-negative-v=
alue&quot; &quot;-Wno-psabi&quot; &quot;-fstack-protector-strong&quot; &quo=
t;-iquote&quot; &quot;/c/work/xemu/qemu/tcg/i386&quot; &quot;-iquote&quot; =
&quot;.&quot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu&quot; &quot;-iquo=
te&quot; &quot;/c/work/xemu/qemu/accel/tcg&quot; &quot;-iquote&quot; &quot;=
/c/work/xemu/qemu/include&quot; &quot;-iquote&quot; &quot;/c/work/xemu/qemu=
/disas/libvixl&quot; &quot;-pthread&quot; &quot;-mms-bitfields&quot; &quot;=
-mms-bitfields&quot; -MD -MQ libqemuutil.a.p/util_oslib-win32.c.obj -MF &qu=
ot;libqemuutil.a.p/util_oslib-win32.c.obj.d&quot; -o libqemuutil.a.p/util_o=
slib-win32.c.obj &quot;-c&quot; ../util/oslib-win32.c -MP<br>../util/oslib-=
win32.c: In function &#39;qemu_get_local_state_pathname&#39;:<br>../util/os=
lib-win32.c:289:58: error: passing argument 5 of &#39;SHGetFolderPathW&#39;=
 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]<br>=
=C2=A0 289 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SHGFP_TYPE_CURRENT */ 0, base_=
path);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *<br>In file included from ..=
/util/oslib-win32.c:44:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/in=
clude/shlobj.h:39:92: note: expected &#39;LPWSTR&#39; {aka &#39;short unsig=
ned int *&#39;} but argument is of type &#39;char *&#39;<br>=C2=A0 =C2=A039=
 | =C2=A0 SHFOLDERAPI SHGetFolderPathW (HWND hwnd, int csidl, HANDLE hToken=
, DWORD dwFlags, LPWSTR pszPath);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~^~~~~~~<=
br>../util/oslib-win32.c: In function &#39;qemu_init_exec_dir&#39;:<br>../u=
til/oslib-win32.c:327:35: error: passing argument 2 of &#39;GetModuleFileNa=
meW&#39; from incompatible pointer type [-Werror=3Dincompatible-pointer-typ=
es]<br>=C2=A0 327 | =C2=A0 =C2=A0 len =3D GetModuleFileName(NULL, buf, size=
of(buf) - 1);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char *<br>In file included from C:/CI-Tools/msys64/mingw64/x86_6=
4-w64-mingw32/include/winbase.h:24,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw=
32/include/windows.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include=
/winsock2.h:23,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/inc=
lude/qemu/osdep.h:119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from ../util/oslib-win32.c:33:<br>C:/CI-Tools/msys64/mingw64/x=
86_64-w64-mingw32/include/libloaderapi.h:153:71: note: expected &#39;LPWSTR=
&#39; {aka &#39;short unsigned int *&#39;} but argument is of type &#39;cha=
r *&#39;<br>=C2=A0 153 | =C2=A0 WINBASEAPI DWORD WINAPI GetModuleFileNameW =
(HMODULE hModule, LPWSTR lpFilename, DWORD nSize);<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0~~~~~~~^~~~~~~~~~<br>../util/oslib-win32.c: In function &#39;qemu_write_=
pidfile&#39;:<br>../util/oslib-win32.c:801:23: error: passing argument 1 of=
 &#39;CreateFileW&#39; from incompatible pointer type [-Werror=3Dincompatib=
le-pointer-types]<br>=C2=A0 801 | =C2=A0 =C2=A0 file =3D CreateFile(filenam=
e, GENERIC_WRITE, FILE_SHARE_READ, NULL,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~=
~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *=
<br>In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/winbase.h:18,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/window=
s.h:70,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fr=
om C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/=
xemu/qemu/include/sysemu/os-win32.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from C:/work/xemu/qemu/include/qemu/osdep.h:=
119,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
../util/oslib-win32.c:33:<br>C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/=
include/fileapi.h:64:49: note: expected &#39;LPCWSTR&#39; {aka &#39;const s=
hort unsigned int *&#39;} but argument is of type &#39;const char *&#39;<br=
>=C2=A0 =C2=A064 | =C2=A0 WINBASEAPI HANDLE WINAPI CreateFileW (LPCWSTR lpF=
ileName, DWORD dwDesiredAccess, DWORD dwShareMode, LPSECURITY_ATTRIBUTES lp=
SecurityAttributes, DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes=
, HANDLE hTemplateFile);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~^~~~~~~~~~<br>cc1.exe: al=
l warnings being treated as errors<br>make: *** [Makefile.ninja:648=EF=BC=
=9Alibqemuutil.a.p/util_oslib-win32.c.obj] =E9=94=99=E8=AF=AF 1<br></div><d=
iv>```</div><div><br></div><div><br></div><div><br>&gt;<br>&gt; -- &gt;8 --=
<br>&gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>&gt; i=
ndex 412962d91a2..cd5cedc0b21 100644<br>&gt; --- a/include/qemu/osdep.h<br>=
&gt; +++ b/include/qemu/osdep.h<br>&gt; @@ -74,6 +74,12 @@ extern int daemo=
n(int, int);<br>&gt; =C2=A0/* enable C99/POSIX format strings (needs mingw3=
2-runtime 3.15 or later) */<br>&gt; =C2=A0#ifdef __MINGW32__<br>&gt; =C2=A0=
#define __USE_MINGW_ANSI_STDIO 1<br>&gt; +#ifndef UNICODE<br>&gt; +#define =
UNICODE<br>&gt; +#endif<br>&gt; +#ifndef _UNICODE<br>&gt; +#define _UNICODE=
<br>&gt; +#endif<br>&gt; =C2=A0#endif<br>&gt;<br>&gt; =C2=A0#include &lt;st=
darg.h&gt;<br>&gt; ---<br>&gt;<br>&gt; &gt; =C2=A0 =C2=A0vhost_user=3D&quot=
;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0audio_possible_drivers=3D&quot;dsound s=
dl&quot;<br>&gt; &gt; =C2=A0 =C2=A0if check_include dsound.h; then<br>&gt; =
&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000ddfe0c05af5daa2e--

