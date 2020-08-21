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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC635C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9889220732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfJNYDos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9889220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95L5-0000yX-T5
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k94lO-0006jy-9B
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:59:14 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1k94lM-0005zq-0J
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:59:13 -0400
Received: by mail-oi1-x22a.google.com with SMTP id b22so1163373oic.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NjWYxee1WCHoh7I7bm6NTa6dIaKOD/3vK/x5Ma4rYY8=;
 b=IfJNYDosr6JrnlEpZqLVNQnVR4jyZHGb2ChMg9tYI68UbmBmMxshZVidQ1rEJhLK3y
 9sJkKypqF4ERRYJcu66c3qaSerbEJ7CmX4xzFajxHnj9KeZmR0EAhgbF72YUhtAvamq1
 uFwkSejcmTr27cbqOmt6aR3QEfZjj5CK+BOJJKRyic9veP9TP6euMSiJquczU09mFvAR
 2t+zQP+Db5yX19kuC/2bst6HzzSzI1/Nnhw8PYZXISiZfGmn3c6Ur7z/prWGzIUcZ0as
 nTgR/Z2tJfwssc/jhi5d2UMQe/6dbMGLnCv7Fts4NJlShsVsbZ9OZgcbijwCrO6vKPGJ
 4gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NjWYxee1WCHoh7I7bm6NTa6dIaKOD/3vK/x5Ma4rYY8=;
 b=tHgwuWcKKma6hT81k0pJD98id9p//zWXa/ssVSlw/Jn3+G7mp89XWIzo9ncIl1jDYJ
 fgkK/YHyHczyfRM3fatT2z/tQGt9vI1UkMpn4B6Mn9WDEZPAsYBblzPmMAxYjAtW350z
 8I56aZPoP8skndbUMz1144+snGDNOs/RBj2P7zn2lVIVbo4AYeBnshfMzjB4YJlRiu+u
 iYyhOB19sOoK4Aw5EcBByJ99chCJdSUGkTir2m4QeutC8r+AprQea4pVYCAn37wZd8SG
 Es/ehvMj2RmtQsPaJWfw6NUKa+dlTX153DzPsJlA2OYJwKLQipPvwKN66dnlecn6XKiu
 DCWQ==
X-Gm-Message-State: AOAM531QMZ6FDm9NJ+XgeI8VM9sVp55jSa1EzzbthuzkgUbOvfT3HFOu
 h3yqoMtmclHkj2O8KbFRJ8vLJRzfTvO4dsL+/wc=
X-Google-Smtp-Source: ABdhPJzbACuQhehBVBVkXZdoAZ76YEbiQhaCZFxJuoC1BhddVqw3HCSrLoIhvOZF8XgDhLCDPJB4jhW8DPR4jWaozwI=
X-Received: by 2002:aca:aa13:: with SMTP id t19mr1343393oie.59.1598007550718; 
 Fri, 21 Aug 2020 03:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
In-Reply-To: <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 21 Aug 2020 12:58:58 +0200
Message-ID: <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068b6d105ad6120d3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oi1-x22a.google.com
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

--00000000000068b6d105ad6120d3
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 21, 2020 at 8:15 AM Howard Spoelstra <hsp.cat7@gmail.com> wrote:

>
>
> On Wed, Aug 19, 2020 at 11:32 PM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
>
>> The following changes since commit
>> d0ed6a69d399ae193959225cdeaa9382746c91cc:
>>
>>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:
>>
>>
>> Hi,
>
> I attempted to cross compile Qemu for Windows from the meson branch today
> using a Fedora 32 VM and using MSYS2 .
>
> In both cases I compiled using:
>  ./configure --cross-prefix=x86_64-w64-mingw32- --target-list=ppc-softmmu
> --enable-gtk --enable-sdl
>
> For the builds to run on Windows I normally copy the pc-bios folder and
> the required dlls (from \msys64\mingw64\bin for the MSYS2 build and from
> /usr/x86_64-w64-mingw32/sys-root/mingw/bin for the Fedora based build).
> This has always worked in the past.
>
> As noticed earlier in discussion with Paolo, with MSYS2 there appears to
> be a difference in how grep works on Linux and Windows. Using grep 3.1 as
> provided by MSYS2, the file config-all-devices.mak file stays empty.
>
> On Fedora the compilation process completed successfully. However, the
> binary crashes. This is the backtrace I could get:
>
> (gdb) attach 11528
> Attaching to process 11528
> [New Thread 11528.0x218]
> [New Thread 11528.0x3380]
> [New Thread 11528.0xf80]
> Reading symbols from C:\qemu-debugging\gdb.exe...(no debugging symbols
> found)...
> done.
> 0x00007ffb9ef0f8b1 in ntdll!DbgBreakPoint ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> (gdb) thread apply all bt full
>
> Thread 3 (Thread 11528.0xf80):
> #0  0x00007ffb9ef0f8b1 in ntdll!DbgBreakPoint ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #1  0x00007ffb9ef3c90e in ntdll!DbgUiRemoteBreakin ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #2  0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
>    from C:\WINDOWS\System32\kernel32.dll
> No symbol table info available.
> #3  0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #4  0x0000000000000000 in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>
> Thread 2 (Thread 11528.0x3380):
> #0  0x00007ffb9ef0c914 in ntdll!ZwWaitForMultipleObjects ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #1  0x00007ffb9c658910 in WaitForMultipleObjectsEx ()
>    from C:\WINDOWS\System32\KernelBase.dll
> ---Type <return> to continue, or q <return> to quit---
> No symbol table info available.
> #2  0x00007ffb9c65880e in WaitForMultipleObjects ()
>    from C:\WINDOWS\System32\KernelBase.dll
> No symbol table info available.
> #3  0x00000000004291a5 in ?? ()
> No symbol table info available.
> #4  0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
>    from C:\WINDOWS\System32\kernel32.dll
> No symbol table info available.
> #5  0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #6  0x0000000000000000 in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
>
> Thread 1 (Thread 11528.0x218):
> #0  0x00007ffb9ef0c914 in ntdll!ZwWaitForMultipleObjects ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #1  0x00007ffb9c658910 in WaitForMultipleObjectsEx ()
>    from C:\WINDOWS\System32\KernelBase.dll
> No symbol table info available.
> #2  0x00007ffb9c65880e in WaitForMultipleObjects ()
> ---Type <return> to continue, or q <return> to quit---
>    from C:\WINDOWS\System32\KernelBase.dll
> No symbol table info available.
> #3  0x0000000000483e9c in ?? ()
> No symbol table info available.
> #4  0x0000000000551049 in ?? ()
> No symbol table info available.
> #5  0x0000000000550498 in ?? ()
> No symbol table info available.
> #6  0x00000000005504fd in ?? ()
> No symbol table info available.
> #7  0x0000000000551b63 in ?? ()
> No symbol table info available.
> #8  0x00000000005489d7 in ?? ()
> No symbol table info available.
> #9  0x0000000000549421 in ?? ()
> No symbol table info available.
> #10 0x0000000000545e0b in ?? ()
> No symbol table info available.
> #11 0x000000000054a922 in ?? ()
> No symbol table info available.
> #12 0x0000000000545e0b in ?? ()
> No symbol table info available.
> #13 0x000000000054a94d in ?? ()
> No symbol table info available.
> ---Type <return> to continue, or q <return> to quit---
> #14 0x00000000004017e5 in ?? ()
> No symbol table info available.
> #15 0x0000000000401472 in ?? ()
> No symbol table info available.
> #16 0x000000000040117c in ?? ()
> No symbol table info available.
> #17 0x00007ffb9dbe6fd4 in KERNEL32!BaseThreadInitThunk ()
>    from C:\WINDOWS\System32\kernel32.dll
> No symbol table info available.
> #18 0x00007ffb9eebcec1 in ntdll!RtlUserThreadStart ()
>    from C:\WINDOWS\SYSTEM32\ntdll.dll
> No symbol table info available.
> #19 0x0000000000000000 in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> (gdb)
>
>
I investigated a bit further and saw:
ldd in Fedora tells me the executable is "not a dynamic executable".

Meson seems to default to try a static build and enable pie, whereas a
normal build would require --static to enable that and have pie=no

Best,
Howard

--00000000000068b6d105ad6120d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 21, 2020 at 8:15 AM Howar=
d Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com">hsp.cat7@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 19, 2020 at 11:32 PM Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzin=
i@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">The following changes since commit d0ed6a69d399ae193959225cdeaa=
9382746c91cc:<br>
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
db)</div></div><br></div></blockquote><div><br></div><div>I investigated a =
bit further and saw:</div><div>
<div>ldd in Fedora tells me the executable is &quot;not a dynamic executabl=
e&quot;.<br><br></div><div>Meson seems to default to try a static build and=
 enable pie, whereas a normal build would require --static to enable that a=
nd have pie=3Dno</div>

</div><div><br></div><div>Best,<br></div><div>Howard<br></div></div></div>

--00000000000068b6d105ad6120d3--

