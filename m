Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EC120936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTbDoSRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EC120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFGO-00050B-UV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIFAa-00070B-BT; Tue, 15 Sep 2020 13:55:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIFAY-0008PG-BM; Tue, 15 Sep 2020 13:55:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so351188wmi.3;
 Tue, 15 Sep 2020 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ahSm927qcGYmnDMY+3ZCaDzSZ3WFnaHyBp87O7S8Ljc=;
 b=mTbDoSRow17UeFkLjB9TZ03hzJOZgBOL8kaJjA6d8dQvjTpNGLZ9oAXr3inXrOULkj
 SxHixVepdGl6yGl0XGOMr4+uqlFgUhQuBCytdBOBHYoNpzM8wOuC/r+Oi1BctVC0DTiH
 UeiWS6QBcZkYzISDeVrhez6FqNjz0oIf112fQuMHJM14QRMGnodxLjRqnmEBeAG8yReG
 Z+dphI1vHJw0YVgX8S/YlZCWSQ6TCEnnIlu+Ub8aA4CeFzCcf6wV5mLbgZM3gp2DlJWt
 KE5pFJp1tKEmwnVlqYZQnTzo97M4P+raaa7Wc8UmzdZ6voT6bMIxUTHIo5ts7hEwhODP
 AG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ahSm927qcGYmnDMY+3ZCaDzSZ3WFnaHyBp87O7S8Ljc=;
 b=sbGu/K3rv8eRS6zhV0Uz1K/KZtFW298VrHYkhQilvHUAoH6Houe7CNFNKtNIjaT+Dq
 wblZbq+Jd5hJLlVImjFNhFkTMgfSSdPchALyHLAFZR8VbM+FiLKQ4TnKhOE92q5+vc0/
 zCQu6lm+FGh0F0AS8PsuJD7TKwkHSkrbR8op5tj7DU7ViooB/S+QwbR3N/711pkMRyrm
 yFp47niUL9BiS+pe7iDBpyaEFnw3bGq709VSaLRH8H98tRRbnzbUMaot4v0ZcODYQI1E
 9xlrUgOYBD/CYIm+6mM/nt84iAoYhJG6YreMJq5l8XuHHXOFtErOWtM9hM5GU0v01rF7
 dnTw==
X-Gm-Message-State: AOAM530HXezvnN2O9DztA/DeUfY2963IyE3CVj2vFNeSivazbpMxfeqg
 KdJulXculGAhCgXrbGCGYLg=
X-Google-Smtp-Source: ABdhPJw/424Edf/xHNLPdSlpNc6gNhk40QDpIn7rWZQy5oXZZV6tEsvi7lc6RYLDMSpASCfJCsKsgQ==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr522237wmd.7.1600192503939;
 Tue, 15 Sep 2020 10:55:03 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h184sm533851wmh.41.2020.09.15.10.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:55:03 -0700 (PDT)
Subject: Re: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
To: luoyonggang@gmail.com
References: <20200915163343.1100-1-luoyonggang@gmail.com>
 <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
 <CAE2XoE8OmSSnzzUivS0jNQu=QEe8c_gPasfksoihdYhO6f4CYg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba164474-7cb0-1f8f-ef01-2529954a1df9@amsat.org>
Date: Tue, 15 Sep 2020 19:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8OmSSnzzUivS0jNQu=QEe8c_gPasfksoihdYhO6f4CYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 7:41 PM, 罗勇刚(Yonggang Luo) wrote:
> On Wed, Sep 16, 2020 at 12:41 AM Philippe Mathieu-Daudé
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>>
>> On 9/15/20 6:33 PM, Yonggang Luo wrote:
>> > error message:
>> > "cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi"
> "-Itrace" "-Iui" "-Iui/shader" "-IC:/CI-Tools/msys64/mingw64/include"
> "-IC:/CI-Tools/msys64/mingw64/include/glib-2.0"
> "-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/include"
> "-fdiagnostics-color=auto" "-pipe" "-Wall" "-Winvalid-pch" "-Werror"
> "-std=gnu99" "-g" "-m64" "-mcx16" "-D_GNU_SOURCE"
> "-D_FILE_OFFSET_BITS=64" "-D_LARGEFILE_SOURCE" "-Wstrict-prototypes"
> "-Wredundant-decls" "-Wundef" "-Wwrite-strings" "-Wmissing-prototypes"
> "-fno-strict-aliasing" "-fno-common" "-fwrapv" "-Wold-style-declaration"
> "-Wold-style-definition" "-Wtype-limits" "-Wformat-security"
> "-Wformat-y2k" "-Winit-self" "-Wignored-qualifiers" "-Wempty-body"
> "-Wnested-externs" "-Wendif-labels" "-Wexpansion-to-defined"
> "-Wno-missing-include-dirs" "-Wno-shift-negative-value" "-Wno-psabi"
> "-fstack-protector-strong" "-iquote" "/c/work/xemu/qemu/tcg/i386"
> "-iquote" "." "-iquote" "/c/work/xemu/qemu" "-iquote"
> "/c/work/xemu/qemu/accel/tcg" "-iquote" "/c/work/xemu/qemu/include"
> "-iquote" "/c/work/xemu/qemu/disas/libvixl" "-pthread" "-mms-bitfields"
> -MD -MQ qga/qemu-ga.exe.p/commands-win32.c.obj -MF
> "qga/qemu-ga.exe.p/commands-win32.c.obj.d" -o
> qga/qemu-ga.exe.p/commands-win32.c.obj "-c" ../qga/commands-win32.c -MP
>> > ../qga/commands-win32.c:62:24: error: redundant redeclaration of
> 'CM_Get_DevNode_PropertyW' [-Werror=redundant-decls]
>> >    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>> > In file included from ../qga/commands-win32.c:26:
>> >
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26:
> note: previous declaration of 'CM_Get_DevNode_PropertyW' was here
>> >   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST
> dnDevInst, const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType,
> PBYTE PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
>> >       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
>> > cc1.exe: all warnings being treated as errors
>> > make: [Makefile.ninja:5143：qga/qemu-ga.exe.p/commands-win32.c.obj]
> 错误 1 (已忽略）
>> >
>> > This error comes from qemu configure didn't add predefined macro
> -DUNICODE -D_UNICODE in QEMU_CFLAGS,
>> > and these too macro are standard config for win32 if using windows
> wide api.
>> >
>> > in cfgmgr32.h
>> >   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,
> const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE
> PropertyBuffer, PULONG PropertyBufferSize, ULONG ulFlags);
>> > #ifdef UNICODE
>> > #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
>> > #endif
>> >
>> > macro CM_Get_DevNode_Property defined only when UNICODE are defined.
>> > and in win32, UNICODE and _UNICODE should be defined at the same time
>> >
>> > #endif
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> <mailto:luoyonggang@gmail.com>>
>> > ---
>> >  configure | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/configure b/configure
>> > index 9f141891ea..f5d661af4a 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -812,6 +812,7 @@ MINGW32*)
>> >    mingw32="yes"
>> >    hax="yes"
>> >    whpx=""
>> > +  QEMU_CFLAGS="-DUNICODE -D_UNICODE $QEMU_CFLAGS"
>>
>> What about declaring them in include/qemu/osdep.h
>> instead?
> That's a good idea.
> But more compiling error warns me that the windows version of qemu are
> not in a good situation.

:)

> On Win32, all API should call the wide version so that support for
> Unicode properly.
> But obviously the currently qemu didn't do that
> 
> ```
[...]
> ../util/qemu-sockets.c: In function 'socket_sockaddr_to_address_inet':
> C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s'
> expects argument of type 'char *', but argument 6 has type 'WCHAR *'
> {aka 'short unsigned int *'} [-Werror=format=]
>   319 |                         (fmt), ## __VA_ARGS__)
>       |                         ^~~~~
> ../util/qemu-sockets.c:1235:9: note: in expansion of macro 'error_setg'
>  1235 |         error_setg(errp, "Cannot format numeric socket address: %s",
>       |         ^~~~~~~~~~
> In file included from ../io/dns-resolver.c:26:
> ../io/dns-resolver.c: In function 'qio_dns_resolver_lookup_sync_inet':
> C:/work/xemu/qemu/include/qapi/error.h:319:25: error: format '%s'
> expects argument of type 'char *', but argument 8 has type 'WCHAR *'
> {aka 'short unsigned int *'} [-Werror=format=]
>   319 |                         (fmt), ## __VA_ARGS__)
>       |                         ^~~~~
> ../io/dns-resolver.c:93:9: note: in expansion of macro 'error_setg'
>    93 |         error_setg(errp, "address resolution failed for %s:%s: %s",
>       |         ^~~~~~~~~~
> cc1.exe: all warnings being treated as errors
> make: [Makefile.ninja:756：io/libio.fa.p/dns-resolver.c.obj] 错误 1 (已
> 忽略）
> cc1.exe: all warnings being treated as errors
> make: [Makefile.ninja:697：libqemuutil.a.p/util_qemu-sockets.c.obj] 错误
> 1 (已忽略）
> Linking static target io/libio.fa
> C:\CI-Tools\msys64\mingw64\bin\ar.exe: io/libio.fa.p/dns-resolver.c.obj:
> No such file or directory
> make: [Makefile.ninja:764：io/libio.fa] 错误 1 (已忽略）
> ../net/tap-win32.c: In function 'is_tap_win32_dev':
> ../net/tap-win32.c:62:21: error: passing argument 2 of 'RegOpenKeyExW'
> from incompatible pointer type [-Werror=incompatible-pointer-types]
>    62 | #define ADAPTER_KEY
> "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
>       |                    
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                     |
>       |                     const char *
> ../net/tap-win32.c:62:21: note: in definition of macro 'ADAPTER_KEY'
>    62 | #define ADAPTER_KEY
> "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
>       |                    
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
>                  from
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
>                  from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
>                  from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../net/tap-win32.c:29:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:195:57:
> note: expected 'LPCWSTR' {aka 'const short unsigned int *'} but argument
> is of type 'const char *'
>   195 |   WINADVAPI LONG WINAPI RegOpenKeyExW(HKEY hKey,LPCWSTR
> lpSubKey,DWORD ulOptions,REGSAM samDesired,PHKEY phkResult);
>       |                                                 ~~~~~~~~^~~~~~~~
> ../net/tap-win32.c:229:13: error: passing argument 3 of 'RegEnumKeyExW'
> from incompatible pointer type [-Werror=incompatible-pointer-types]
>   229 |             enum_name,
>       |             ^~~~~~~~~
>       |             |
>       |             char *
> In file included from
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/windows.h:76,
>                  from
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winsock2.h:23,
>                  from C:/work/xemu/qemu/include/sysemu/os-win32.h:29,
>                  from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../net/tap-win32.c:29:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/winreg.h:184:70:
> note: expected 'LPWSTR' {aka 'short unsigned int *'} but argument is of
> type 'char *'
>   184 |   WINADVAPI LONG WINAPI RegEnumKeyExW(HKEY hKey,DWORD
> dwIndex,LPWSTR lpName,LPDWORD lpcchName,LPDWORD lpReserved,LPWSTR
> lpClass,LPDWORD lpcchClass,PFILETIME lpftLastWriteTime);
>       |                                                              
> ~~~~~~~^~~~~~
> ../net/tap-win32.c:247:13: error: passing argument 2 of 'RegOpenKeyExW'
> from incompatible pointer type [-Werror=incompatible-pointer-types]
>   247 |             unit_string,
>       |             ^~~~~~~~~~~
>       |             |
>       |             char *

I'm not sure fixing all these warnings would produce a
maintainable code base. I'd rather disable these 2 warning
classes on Windows.

