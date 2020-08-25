Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A589C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EF620639
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRoeVMgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EF620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZ1U-0004BK-Vl
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAZ0u-0003Rl-Ds
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:29:24 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:32979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAZ0s-000518-E0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:29:24 -0400
Received: by mail-lj1-x229.google.com with SMTP id v4so13833325ljd.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=WN+7vQ+8lizECVvyyvUdCqKa3/AdKna2h/PPfAV5hN0=;
 b=aRoeVMgQyQdJupWX1iK6EHn7rxhbzjxZkQhLWuztxyQGXECsW1P4Vt5RGypyxruvI5
 BlZoNgeww3ZjJi3smAEAc5Gr8Doj5VR+v27xcl9385zn/HqryHyldC6ZBUGgQwW2su9L
 OTyjlbqx06ZCVZW5iqT96yvTXsLApN+Zqi2JBhyQVCZpR4m0bU12YbYKEhnOXXNgvr8s
 SLiq6pCaU0hF0EzX0Kw0/Ie+83TeSyytmJ/NE/piKxid955xMH/6zgV6FeUuPBriwdPJ
 SSLArWQ8DJx0dJSysVVGBVT0R7dl2m5aMk1KLDHlRv4Roi8Jw6nHmbkhYVMfw5PHurSE
 zXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WN+7vQ+8lizECVvyyvUdCqKa3/AdKna2h/PPfAV5hN0=;
 b=q6Jo5xyxArdcyYFVMmxyHToIr5tcBbaiK1fPom2svaJt04nFKpMqE/y2HC5jh6Yxzq
 3ABTxYEthzd9sBGOHkGzHbdO/vd4iEQ0Lv0ev5THGE/rIj47nf8rh2WUPFtsUfnwGbpR
 q+7FSJemsvvNj7cbAkXIriGns8gNqbnKYaqV1Rdh0pta594zUcXT37r+3kuiwAMb/w6j
 GSIYUUQPoDvsuVrZswD76Sr9j0WUOhWSJjkiDI8LAC5kZCOZT/6/ippVTbAp8pIRf4JR
 C48k6s8KrhwxbvEnldJGXrbDayJR5On2/hCicXuzJrMTsm4gvQBAGng6rO2n0wVtywI3
 wRCw==
X-Gm-Message-State: AOAM532j/MlHtnJQopuwDIXz9QvrnEVPa5ToSoO3MaUvenueDRcRYzk6
 2fBRfyIP/0U0h6RQS4S9BWCw6QTMJVC/slaFs/c=
X-Google-Smtp-Source: ABdhPJzhji8JnIKVeZzUfFrSvwLSAqxq5p5d+AkhSJhQu9aYwB2R+QgGzguT1z6HsCEGQLeF4kt28dry6GlhhBARVC0=
X-Received: by 2002:a2e:8642:: with SMTP id i2mr5214135ljj.368.1598362160042; 
 Tue, 25 Aug 2020 06:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001649.1811-1-luoyonggang@gmail.com>
 <CAJ+F1CJYsR8Bf2EgaV+pMM_1DGnG-2tvCV-5LsjE6w3hk1-P_g@mail.gmail.com>
In-Reply-To: <CAJ+F1CJYsR8Bf2EgaV+pMM_1DGnG-2tvCV-5LsjE6w3hk1-P_g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 21:29:08 +0800
Message-ID: <CAE2XoE-nr2KKnSQkRFDYD=h9kW6=+G27MpAU7vpXiSW1CwDzxw@mail.gmail.com>
Subject: Re: [PATCH] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c597ce05adb3b011"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x229.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c597ce05adb3b011
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am using gcc 10
```
$ gcc -v
Using built-in specs.
COLLECT_GCC=3DC:\CI-Tools\msys64\mingw64\bin\gcc.exe
COLLECT_LTO_WRAPPER=3DC:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-=
mingw32/10.2.0/lto-wrapper.exe
Target: x86_64-w64-mingw32
Configured with: ../gcc-10.2.0/configure --prefix=3D/mingw64
--with-local-prefix=3D/mingw64/local --build=3Dx86_64-w64-mingw32
--host=3Dx86_64-w64-mingw32 --target=3Dx86_64-w64-mingw32
--with-native-system-header-dir=3D/mingw64/x86_64-w64-mingw32/include
--libexecdir=3D/mingw64/lib --enable-bootstrap --with-arch=3Dx86-64
--with-tune=3Dgeneric --enable-languages=3Dc,lto,c++,fortran,ada,objc,obj-c=
++
--enable-shared --enable-static --enable-libatomic --enable-threads=3Dposix
--enable-graphite --enable-fully-dynamic-string
--enable-libstdcxx-filesystem-ts=3Dyes --enable-libstdcxx-time=3Dyes
--disable-libstdcxx-pch --disable-libstdcxx-debug
--disable-isl-version-check --enable-lto --enable-libgomp
--disable-multilib --enable-checking=3Drelease --disable-rpath
--disable-win32-registry --disable-nls --disable-werror --disable-symvers
--disable-plugin --with-libiconv --with-system-zlib --with-gmp=3D/mingw64
--with-mpfr=3D/mingw64 --with-mpc=3D/mingw64 --with-isl=3D/mingw64
--with-pkgversion=3D'Rev1, Built by MSYS2 project' --with-bugurl=3D
https://github.com/msys2/MINGW-packages/issues --with-gnu-as --with-gnu-ld
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 10.2.0 (Rev1, Built by MSYS2 project)

```

On Tue, Aug 25, 2020 at 6:25 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Tue, Aug 25, 2020 at 4:17 AM <luoyonggang@gmail.com> wrote:
>
>> From: Yonggang Luo <luoyonggang@gmail.com>
>>
>> ---
>>  meson.build | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index df5bf728b5..a3585881e1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
>>    brlapi =3D declare_dependency(link_args:
>> config_host['BRLAPI_LIBS'].split())
>>  endif
>>
>> -sdl =3D dependency('sdl2', required: get_option('sdl'), static:
>> enable_static,
>> -                 include_type: 'system')
>> +sdl =3D dependency('sdl2', required: get_option('sdl'), static:
>> enable_static)
>>  sdl_image =3D not_found
>>  if sdl.found()
>>    # work around 2.0.8 bug
>> --
>> 2.27.0.windows.1
>>
>>
>>
> Which version of gcc are you using?
>
> Paolo, why did you you -isystem includes here? (if it's on purpose, it's
> worth to document it in build-system.rst since it takes sdl as an example
> and doesn't mention this)
>
>
> --
> Marc-Andr=C3=A9 Lureau
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c597ce05adb3b011
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am using gcc 10<div>```</div><div>$ gcc -v<br>Using buil=
t-in specs.<br>COLLECT_GCC=3DC:\CI-Tools\msys64\mingw64\bin\gcc.exe<br>COLL=
ECT_LTO_WRAPPER=3DC:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/lto-wrapper.exe<br>Target: x86_64-w64-mingw32<br>Configured with=
: ../gcc-10.2.0/configure --prefix=3D/mingw64 --with-local-prefix=3D/mingw6=
4/local --build=3Dx86_64-w64-mingw32 --host=3Dx86_64-w64-mingw32 --target=
=3Dx86_64-w64-mingw32 --with-native-system-header-dir=3D/mingw64/x86_64-w64=
-mingw32/include --libexecdir=3D/mingw64/lib --enable-bootstrap --with-arch=
=3Dx86-64 --with-tune=3Dgeneric --enable-languages=3Dc,lto,c++,fortran,ada,=
objc,obj-c++ --enable-shared --enable-static --enable-libatomic --enable-th=
reads=3Dposix --enable-graphite --enable-fully-dynamic-string --enable-libs=
tdcxx-filesystem-ts=3Dyes --enable-libstdcxx-time=3Dyes --disable-libstdcxx=
-pch --disable-libstdcxx-debug --disable-isl-version-check --enable-lto --e=
nable-libgomp --disable-multilib --enable-checking=3Drelease --disable-rpat=
h --disable-win32-registry --disable-nls --disable-werror --disable-symvers=
 --disable-plugin --with-libiconv --with-system-zlib --with-gmp=3D/mingw64 =
--with-mpfr=3D/mingw64 --with-mpc=3D/mingw64 --with-isl=3D/mingw64 --with-p=
kgversion=3D&#39;Rev1, Built by MSYS2 project&#39; --with-bugurl=3D<a href=
=3D"https://github.com/msys2/MINGW-packages/issues">https://github.com/msys=
2/MINGW-packages/issues</a> --with-gnu-as --with-gnu-ld<br>Thread model: po=
six<br>Supported LTO compression algorithms: zlib zstd<br>gcc version 10.2.=
0 (Rev1, Built by MSYS2 project)<br><br></div><div>```</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25,=
 2020 at 6:25 PM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
Hi<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Aug 25, 2020 at 4:17 AM &lt;<a href=3D"mailto:luoyonggang@gma=
il.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Yonggang Luo &lt;<a hr=
ef=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com=
</a>&gt;<br>
<br>
---<br>
=C2=A0meson.build | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index df5bf728b5..a3585881e1 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -224,8 +224,7 @@ if &#39;CONFIG_BRLAPI&#39; in config_host<br>
=C2=A0 =C2=A0brlapi =3D declare_dependency(link_args: config_host[&#39;BRLA=
PI_LIBS&#39;].split())<br>
=C2=A0endif<br>
<br>
-sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#39;), st=
atic: enable_static,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include_type=
: &#39;system&#39;)<br>
+sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#39;), st=
atic: enable_static)<br>
=C2=A0sdl_image =3D not_found<br>
=C2=A0if sdl.found()<br>
=C2=A0 =C2=A0# work around 2.0.8 bug<br>
-- <br>
2.27.0.windows.1<br>
<br>
<br></blockquote><div><br></div><div>Which version of gcc are you using?</d=
iv><div><br></div><div>Paolo, why did you you -isystem includes here? (if i=
t&#39;s on purpose, it&#39;s worth to document it in build-system.rst since=
 it takes sdl as an example and doesn&#39;t mention this)<br></div></div><b=
r clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lureau<br></div=
></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000c597ce05adb3b011--

