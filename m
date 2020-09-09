Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7877C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9FF2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIuBwKXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9FF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG6RT-0003Tb-7T
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 16:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG6Qv-000303-NY; Wed, 09 Sep 2020 16:11:09 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG6Qu-0002ip-1C; Wed, 09 Sep 2020 16:11:09 -0400
Received: by mail-lf1-x143.google.com with SMTP id z19so2289785lfr.4;
 Wed, 09 Sep 2020 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=JtEwlRuiSVXiAfp8X6ObvObv5y2sPVZLGKuHlnDF/i0=;
 b=mIuBwKXaXEbFywdZyZ2sywyRPKEzBWe4V9DWY5cBzb6aUqudVTok11/FIKyoEAN3yD
 HtO0I6Et6bpm8YdGw+CBtalYADnO5k8Ry6MrMhsFrcsibQcVtDt8hMCg8V6GSKeFWdDU
 p222Rb7esjS64wpo5Cox94Gx7o6P4F7phG6DOZqJEVmNaVN2iSfK6OY1FrNY28aHfZjM
 YzAXm8Kt+lkHuBmKLrWu7+hMLejhicFBm4U8tJCYtLiMZLdMmrZNPZ4dt+NuCagjqNAc
 kTpADPpYp7SErl+7Q4xtPh6xyZdFKDr9bjqERizrPr46wc2AD7Md1CMPfk0MqBTvkyg4
 2stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=JtEwlRuiSVXiAfp8X6ObvObv5y2sPVZLGKuHlnDF/i0=;
 b=W5fyDWNExwSBmcLstjfzcV52BRtvebY94i8m5sU9EVdThG2+H9ZsU3nWlLJjksfJzO
 nEgTlsK8phH1s8Gs3SRqAvbWzH7yDciUQvOngv/gVpHTNzXKS2Tandb57BQeChzeWerU
 8yC6ap0JEyIGyP8FTAKYjhQnFcq4fjtHk3fObAhWmiAwU5BIIBW14YsclruAeH9a55yh
 T8Rq3dj5566ms3UULjnjWQdQKCQdmAsrOKKbdb7VsF40aU8qzDz7I6Hx+flsqqdPmcpg
 jGRcoie3t5Ch6hS8hq73/t9j4CZ1fSkjrLftDsQiOhAqpepUts0OqAz+RCLirqrjINIk
 A4kQ==
X-Gm-Message-State: AOAM530tlG7yJMV50c8hRyv1tTysXzgSiNDZeK7c62oyzHWGsY6UWUH9
 KlghtfB0so5LMw5naipxE5GcCAe6tRSbYz7KvDo=
X-Google-Smtp-Source: ABdhPJzXmaNfNyVPUQ7dKP8OGlJ9sFbABKuG2Cn2WAE9LB3bzbCBB8Vwn1vmDo5IlYv1pPLs9l+z888uU3aoanYnmco=
X-Received: by 2002:a19:102:: with SMTP id 2mr2626580lfb.54.1599682265882;
 Wed, 09 Sep 2020 13:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200909184237.765-1-luoyonggang@gmail.com>
 <20200909184237.765-3-luoyonggang@gmail.com>
 <CABgObfaGzMDC_n5ukJc4y2k9NVvDkYT=Zp6DGycCXRtmXQzJ5g@mail.gmail.com>
In-Reply-To: <CABgObfaGzMDC_n5ukJc4y2k9NVvDkYT=Zp6DGycCXRtmXQzJ5g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 04:10:54 +0800
Message-ID: <CAE2XoE9kA6PTqg-eTHe2jyhrh=RcLAQMmu4WSSBGhbyUJ6Sv1Q@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] meson: guard the minimal meson version to 0.55.1
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000362de405aee70d33"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000362de405aee70d33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 4:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> Il mer 9 set 2020, 20:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto:
>
>> So we can removal usage of unstable-keyval
>>
>
> Isn't it stable only on 0.56.0?
>
> Paolo
>
On Windows, there is following warning:   WARNING: Module unstable-keyval
is now stable, please use the keyval module instead.
NOTE: guest cross-compilers enabled: cc
Using 'PKG_CONFIG_PATH' from environment with value:
'C:\\CI-Tools\\msys64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw6=
4\\share\\pkgconfig'
Using 'PKG_CONFIG_PATH' from environment with value:
'C:\\CI-Tools\\msys64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw6=
4\\share\\pkgconfig'
The Meson build system
Version: 0.55.999
Source dir: C:/work/xemu/qemu
Build dir: C:/work/xemu/qemu/build
Build type: native build
Project name: qemu
Project version: 5.1.50
C compiler for the host machine: cc (gcc 10.2.0 "cc (Rev1, Built by MSYS2
project) 10.2.0")
C linker for the host machine: cc ld.bfd 2.35
Host machine cpu family: x86_64
Host machine cpu: x86_64
WARNING: Module unstable-keyval is now stable, please use the keyval module
instead.
Program sh found: YES

But when I commit this patch to running CI, osx are failing, so there is
problem with this patch, sorry for that. this patch need to be discard

>
>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  meson.build | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 0b1741557d..af34a85bec 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1,14 +1,11 @@
>> -project('qemu', ['c'], meson_version: '>=3D0.55.0',
>> +project('qemu', ['c'], meson_version: '>=3D0.55.1',
>>          default_options: ['warning_level=3D1', 'c_std=3Dgnu99',
>> 'cpp_std=3Dgnu++11',
>>                            'b_colorout=3Dauto'],
>>          version: run_command('head', meson.source_root() /
>> 'VERSION').stdout().strip())
>>
>>  not_found =3D dependency('', required: false)
>> -if meson.version().version_compare('>=3D0.56.0')
>> -  keyval =3D import('keyval')
>> -else
>> -  keyval =3D import('unstable-keyval')
>> -endif
>> +keyval =3D import('keyval')
>> +
>>  ss =3D import('sourceset')
>>
>>  sh =3D find_program('sh')
>> --
>> 2.28.0.windows.1
>>
>>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000362de405aee70d33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 4:08 AM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Il mer 9 set 2020, 20:43 Yonggang Luo &lt;<a href=3D"mailt=
o:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So we =
can removal usage of unstable-keyval<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Isn&#39;t it stable only on 0.56.0?</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div></blockq=
uote><div>On Windows, there is following warning:=C2=A0=C2=A0

WARNING: Module unstable-keyval is now stable, please use the keyval module=
 instead.

</div>NOTE: guest cross-compilers enabled: cc<br>Using &#39;PKG_CONFIG_PATH=
&#39; from environment with value: &#39;C:\\CI-Tools\\msys64\\mingw64\\lib\=
\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfig&#39;<br>Using &#=
39;PKG_CONFIG_PATH&#39; from environment with value: &#39;C:\\CI-Tools\\msy=
s64\\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfi=
g&#39;<br>The Meson build system<br>Version: 0.55.999<br>Source dir: C:/wor=
k/xemu/qemu<br>Build dir: C:/work/xemu/qemu/build<br>Build type: native bui=
ld<br>Project name: qemu<br>Project version: 5.1.50<br>C compiler for the h=
ost machine: cc (gcc 10.2.0 &quot;cc (Rev1, Built by MSYS2 project) 10.2.0&=
quot;)<br>C linker for the host machine: cc ld.bfd 2.35<br>Host machine cpu=
 family: x86_64<br>Host machine cpu: x86_64<br>WARNING: Module unstable-key=
val is now stable, please use the keyval module instead.<br><div>Program sh=
 found: YES=C2=A0</div><div><br></div><div>But when I commit this patch to =
running CI, osx are failing, so there is problem with this patch, sorry for=
 that. this patch need to be discard</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" re=
l=3D"noreferrer" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 9 +++------<br>
=C2=A01 file changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 0b1741557d..af34a85bec 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1,14 +1,11 @@<br>
-project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.0&#=
39;,<br>
+project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.1&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_options: [&#39;warning_level=3D1&=
#39;, &#39;c_std=3Dgnu99&#39;, &#39;cpp_std=3Dgnu++11&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;b_colorout=3Dauto&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version: run_command(&#39;head&#39;, meso=
n.source_root() / &#39;VERSION&#39;).stdout().strip())<br>
<br>
=C2=A0not_found =3D dependency(&#39;&#39;, required: false)<br>
-if meson.version().version_compare(&#39;&gt;=3D0.56.0&#39;)<br>
-=C2=A0 keyval =3D import(&#39;keyval&#39;)<br>
-else<br>
-=C2=A0 keyval =3D import(&#39;unstable-keyval&#39;)<br>
-endif<br>
+keyval =3D import(&#39;keyval&#39;)<br>
+<br>
=C2=A0ss =3D import(&#39;sourceset&#39;)<br>
<br>
=C2=A0sh =3D find_program(&#39;sh&#39;)<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000362de405aee70d33--

