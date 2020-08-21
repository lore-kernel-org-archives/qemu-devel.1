Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D0EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 06:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141E22075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 06:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXqkMCcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141E22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k90LS-0007Dc-CN
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 02:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k90Kk-0006km-1S
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 02:15:26 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k90Kh-0006iL-6l
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 02:15:25 -0400
Received: by mail-ot1-x332.google.com with SMTP id v6so756938ota.13
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W4sfaqShJJhthMbXAPw8EwSXCrlOcQdqo1dp65MY7sk=;
 b=AXqkMCcIfkFE2ogPs0TYGCJatsb91CCik+LdPqE5mkzBZDft0EADqyQoTafhzfF/ml
 Si5dnVU5TIuqNSsvbojCUIXXQJ35kn3A8q7nBQzxPc94XoSSXWwfGfR+tyieCSX2CzW6
 aAJKsedUG+FKWAN61j+9HaI4HAF9rwzn6PeQlmx2YjdTkeEt5rd2dzGb9euJwr6XMjAV
 H+jVW0oehYPg5JlH2yjerd6cIq9y4NauxXhHPFfMY++oamow6knzxSHeN9KSl0rVLiUS
 u9mj80G6HAkYaW61unit2/LsmaAyaPDhDCLeAdL/zItSfo7iL0EOcVDdQG+GoSJzu6mP
 +Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W4sfaqShJJhthMbXAPw8EwSXCrlOcQdqo1dp65MY7sk=;
 b=TAkL/7Gz8gJNCXkK1hdxq4fQN+znc1/5TgW9e79SMssakkEwhhjkTybZ0mi5S2911C
 5B8bNTJ/MCd5ZVDJYsAmTSiX5dpdvPf8Fi+KXY7pyGEt3dKFXT7IrNaazKbsLfizF3wW
 2n99Nh2Mryi7V8ccI27+DK8jnL7oSO3zpp7Q1v6uXXb+ioMAiFS+I9LYl8+GsyO/i339
 682zymO1dXABA1dtayXthcpy8TZBT+MmzQlA3bVSd8Wy50/kNk8ubXIaljPdSSl5ES+8
 SSaLwBMtJ+HQNm90NBqrOyIvrvf0BMLrBD2FJpfdxjoGpk2MOieEThbwCvEJba+DAR7y
 PY7w==
X-Gm-Message-State: AOAM530X6VvkYEVvwHckO/lgJOUnvdCoF7rPWyFA+zn/3B8b1c7vcQJ1
 X3dfEXR0tunfwvC52clWS1LCd6w9EDdL2/xdEcw=
X-Google-Smtp-Source: ABdhPJyadJsdQVhKtrx3B/RX1jTMQa5Uzvxdk4bYMBqJPPlIN2m60Mhmu0ekQWmEDL1UguD9921Yc+BgLBEXVIx7+Mk=
X-Received: by 2002:a9d:7e8f:: with SMTP id m15mr881691otp.173.1597990521350; 
 Thu, 20 Aug 2020 23:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
In-Reply-To: <20200819213203.17876-1-pbonzini@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 21 Aug 2020 08:15:09 +0200
Message-ID: <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000612ea705ad5d2968"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000612ea705ad5d2968
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 19, 2020 at 11:32 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> The following changes since commit
> d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:
>
>
> Hi,

I attempted to cross compile Qemu for Windows from the meson branch today
using a Fedora 32 VM and using MSYS2 .

In both cases I compiled using:
 ./configure --cross-prefix=x86_64-w64-mingw32- --target-list=ppc-softmmu
--enable-gtk --enable-sdl

For the builds to run on Windows I normally copy the pc-bios folder and the
required dlls (from \msys64\mingw64\bin for the MSYS2 build and from
/usr/x86_64-w64-mingw32/sys-root/mingw/bin for the Fedora based build).
This has always worked in the past.

As noticed earlier in discussion with Paolo, with MSYS2 there appears to be
a difference in how grep works on Linux and Windows. Using grep 3.1 as
provided by MSYS2, the file config-all-devices.mak file stays empty.

On Fedora the compilation process completed successfully. However, the
binary crashes. This is the backtrace I could get:

(gdb) attach 11528
Attaching to process 11528
[New Thread 11528.0x218]
[New Thread 11528.0x3380]
[New Thread 11528.0xf80]
Reading symbols from C:\qemu-debugging\gdb.exe...(no debugging symbols
found)...
done.
0x00007ffb9ef0f8b1 in ntdll!DbgBreakPoint ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
(gdb) thread apply all bt full

Thread 3 (Thread 11528.0xf80):
#0  0x00007ffb9ef0f8b1 in ntdll!DbgBreakPoint ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#1  0x00007ffb9ef3c90e in ntdll!DbgUiRemoteBreakin ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#2  0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
   from C:\WINDOWS\System32\kernel32.dll
No symbol table info available.
#3  0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#4  0x0000000000000000 in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 2 (Thread 11528.0x3380):
#0  0x00007ffb9ef0c914 in ntdll!ZwWaitForMultipleObjects ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#1  0x00007ffb9c658910 in WaitForMultipleObjectsEx ()
   from C:\WINDOWS\System32\KernelBase.dll
---Type <return> to continue, or q <return> to quit---
No symbol table info available.
#2  0x00007ffb9c65880e in WaitForMultipleObjects ()
   from C:\WINDOWS\System32\KernelBase.dll
No symbol table info available.
#3  0x00000000004291a5 in ?? ()
No symbol table info available.
#4  0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
   from C:\WINDOWS\System32\kernel32.dll
No symbol table info available.
#5  0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#6  0x0000000000000000 in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 1 (Thread 11528.0x218):
#0  0x00007ffb9ef0c914 in ntdll!ZwWaitForMultipleObjects ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#1  0x00007ffb9c658910 in WaitForMultipleObjectsEx ()
   from C:\WINDOWS\System32\KernelBase.dll
No symbol table info available.
#2  0x00007ffb9c65880e in WaitForMultipleObjects ()
---Type <return> to continue, or q <return> to quit---
   from C:\WINDOWS\System32\KernelBase.dll
No symbol table info available.
#3  0x0000000000483e9c in ?? ()
No symbol table info available.
#4  0x0000000000551049 in ?? ()
No symbol table info available.
#5  0x0000000000550498 in ?? ()
No symbol table info available.
#6  0x00000000005504fd in ?? ()
No symbol table info available.
#7  0x0000000000551b63 in ?? ()
No symbol table info available.
#8  0x00000000005489d7 in ?? ()
No symbol table info available.
#9  0x0000000000549421 in ?? ()
No symbol table info available.
#10 0x0000000000545e0b in ?? ()
No symbol table info available.
#11 0x000000000054a922 in ?? ()
No symbol table info available.
#12 0x0000000000545e0b in ?? ()
No symbol table info available.
#13 0x000000000054a94d in ?? ()
No symbol table info available.
---Type <return> to continue, or q <return> to quit---
#14 0x00000000004017e5 in ?? ()
No symbol table info available.
#15 0x0000000000401472 in ?? ()
No symbol table info available.
#16 0x000000000040117c in ?? ()
No symbol table info available.
#17 0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
   from C:\WINDOWS\System32\kernel32.dll
No symbol table info available.
#18 0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
   from C:\WINDOWS\SYSTEM32\ntdll.dll
No symbol table info available.
#19 0x0000000000000000 in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb)

Best,
Howard

--000000000000612ea705ad5d2968
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 19, 2020 at 11:32 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbon=
zini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">The following changes since commit d0ed6a69d399ae193959225cd=
eaa9382746c91cc:<br>
<br>
=C2=A0 Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"noreferrer" t=
arget=3D"_blank">https://gitlab.com/bonzini/qemu.git</a> tags/for-upstream<=
br>
<br>
for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:<br=
>
<br><br></blockquote><div>Hi,</div><div><br></div><div>I attempted to cross=
 compile Qemu for Windows from the meson branch today using a Fedora 32 VM =
and using MSYS2 .<br></div><div><br></div><div>In both cases I compiled usi=
ng:</div><div>=C2=A0./configure --cross-prefix=3Dx86_64-w64-mingw32- --targ=
et-list=3Dppc-softmmu --enable-gtk --enable-sdl<br></div><div><br></div><di=
v>For the builds to run on Windows I normally copy the pc-bios folder and t=
he required dlls (from \msys64\mingw64\bin for the MSYS2 build and from /us=
r/x86_64-w64-mingw32/sys-root/mingw/bin for the Fedora based build).<br></d=
iv><div>This has always worked in the past.<br></div><div><br></div><div>As=
 noticed earlier in discussion with Paolo, with MSYS2 there appears to be a=
 difference in how grep works on Linux and Windows. Using grep 3.1 as provi=
ded by MSYS2, the file config-all-devices.mak file stays empty.</div><div><=
br></div><div>On Fedora the compilation process completed successfully. How=
ever, the binary crashes. This is the backtrace I could get:<br></div><div>=
<br></div><div>(gdb) attach 11528<br>Attaching to process 11528<br>[New Thr=
ead 11528.0x218]<br>[New Thread 11528.0x3380]<br>[New Thread 11528.0xf80]<b=
r>Reading symbols from C:\qemu-debugging\gdb.exe...(no debugging symbols fo=
und)...<br>done.<br>0x00007ffb9ef0f8b1 in ntdll!DbgBreakPoint ()<br>=C2=A0 =
=C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>(gdb) thread apply all bt full<=
br><br>Thread 3 (Thread 11528.0xf80):<br>#0 =C2=A00x00007ffb9ef0f8b1 in ntd=
ll!DbgBreakPoint ()<br>=C2=A0 =C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>N=
o symbol table info available.<br>#1 =C2=A00x00007ffb9ef3c90e in ntdll!DbgU=
iRemoteBreakin ()<br>=C2=A0 =C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>No =
symbol table info available.<br>#2 =C2=A00x00007ffb9dbe6fd4 in KERNEL32!Bas=
eThreadInitThunk ()<br>=C2=A0 =C2=A0from C:\WINDOWS\System32\kernel32.dll<b=
r>No symbol table info available.<br>#3 =C2=A00x00007ffb9eebcec1 in ntdll!R=
tlUserThreadStart ()<br>=C2=A0 =C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>=
No symbol table info available.<br>#4 =C2=A00x0000000000000000 in ?? ()<br>=
No symbol table info available.<br>Backtrace stopped: previous frame inner =
to this frame (corrupt stack?)<br><br>Thread 2 (Thread 11528.0x3380):<br>#0=
 =C2=A00x00007ffb9ef0c914 in ntdll!ZwWaitForMultipleObjects ()<br>=C2=A0 =
=C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>No symbol table info available.=
<br>#1 =C2=A00x00007ffb9c658910 in WaitForMultipleObjectsEx ()<br>=C2=A0 =
=C2=A0from C:\WINDOWS\System32\KernelBase.dll<br>---Type &lt;return&gt; to =
continue, or q &lt;return&gt; to quit---<br>No symbol table info available.=
<br>#2 =C2=A00x00007ffb9c65880e in WaitForMultipleObjects ()<br>=C2=A0 =C2=
=A0from C:\WINDOWS\System32\KernelBase.dll<br>No symbol table info availabl=
e.<br>#3 =C2=A00x00000000004291a5 in ?? ()<br>No symbol table info availabl=
e.<br>#4 =C2=A00x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()<br>=C2=
=A0 =C2=A0from C:\WINDOWS\System32\kernel32.dll<br>No symbol table info ava=
ilable.<br>#5 =C2=A00x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()<br>=
=C2=A0 =C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>No symbol table info ava=
ilable.<br>#6 =C2=A00x0000000000000000 in ?? ()<br>No symbol table info ava=
ilable.<br>Backtrace stopped: previous frame inner to this frame (corrupt s=
tack?)<br><br>Thread 1 (Thread 11528.0x218):<br>#0 =C2=A00x00007ffb9ef0c914=
 in ntdll!ZwWaitForMultipleObjects ()<br>=C2=A0 =C2=A0from C:\WINDOWS\SYSTE=
M32\ntdll.dll<br>No symbol table info available.<br>#1 =C2=A00x00007ffb9c65=
8910 in WaitForMultipleObjectsEx ()<br>=C2=A0 =C2=A0from C:\WINDOWS\System3=
2\KernelBase.dll<br>No symbol table info available.<br>#2 =C2=A00x00007ffb9=
c65880e in WaitForMultipleObjects ()<br>---Type &lt;return&gt; to continue,=
 or q &lt;return&gt; to quit---<br>=C2=A0 =C2=A0from C:\WINDOWS\System32\Ke=
rnelBase.dll<br>No symbol table info available.<br>#3 =C2=A00x0000000000483=
e9c in ?? ()<br>No symbol table info available.<br>#4 =C2=A00x0000000000551=
049 in ?? ()<br>No symbol table info available.<br>#5 =C2=A00x0000000000550=
498 in ?? ()<br>No symbol table info available.<br>#6 =C2=A00x0000000000550=
4fd in ?? ()<br>No symbol table info available.<br>#7 =C2=A00x0000000000551=
b63 in ?? ()<br>No symbol table info available.<br>#8 =C2=A00x0000000000548=
9d7 in ?? ()<br>No symbol table info available.<br>#9 =C2=A00x0000000000549=
421 in ?? ()<br>No symbol table info available.<br>#10 0x0000000000545e0b i=
n ?? ()<br>No symbol table info available.<br>#11 0x000000000054a922 in ?? =
()<br>No symbol table info available.<br>#12 0x0000000000545e0b in ?? ()<br=
>No symbol table info available.<br>#13 0x000000000054a94d in ?? ()<br>No s=
ymbol table info available.<br>---Type &lt;return&gt; to continue, or q &lt=
;return&gt; to quit---<br>#14 0x00000000004017e5 in ?? ()<br>No symbol tabl=
e info available.<br>#15 0x0000000000401472 in ?? ()<br>No symbol table inf=
o available.<br>#16 0x000000000040117c in ?? ()<br>No symbol table info ava=
ilable.<br>#17 0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()<br>=C2=
=A0 =C2=A0from C:\WINDOWS\System32\kernel32.dll<br>No symbol table info ava=
ilable.<br>#18 0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()<br>=C2=A0 =
=C2=A0from C:\WINDOWS\SYSTEM32\ntdll.dll<br>No symbol table info available.=
<br>#19 0x0000000000000000 in ?? ()<br>No symbol table info available.<br>B=
acktrace stopped: previous frame inner to this frame (corrupt stack?)<br>(g=
db)</div></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quo=
te">Best,</div><div class=3D"gmail_quote">Howard<br></div></div>

--000000000000612ea705ad5d2968--

