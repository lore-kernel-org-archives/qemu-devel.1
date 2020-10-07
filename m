Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADFDC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859152076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ44sU+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859152076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4fp-0002hz-5s
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ4eL-0001TB-8x; Wed, 07 Oct 2020 04:18:13 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ4eI-0007yL-Hs; Wed, 07 Oct 2020 04:18:12 -0400
Received: by mail-lf1-x143.google.com with SMTP id a7so203968lfk.9;
 Wed, 07 Oct 2020 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=N8V7+E9BHDwSicgFZ53Ky39lYpMAhXUlJyJskHLXTdI=;
 b=uZ44sU+yDuXivyM9+Z0eyVuYo+x3GGs/w5eKEFwlDDhihkMzMfx4bw3t2gWg/ADDCE
 vNQEA1sTbIpIIwqRnDFJmXfWrfMD5T3p6NitG2byByTFfKMhGvAveAItBnoHJQ0IHvxi
 ciBOq71mxZWRtoIJwRFTl08ouKvoQsTCXB8sA2gk3HlAKuV2+ygy1LvpyHLwzpeouW5X
 XmggsDQeaUfbrQep3EzW0Ld1nlgPDhUOHCzjFYgA0AmJIJ+xJSQrY2o8M/WAQmmeAd7n
 KjME5Jj6MkdcvB1Of89FbSZY4bi4YFCv3Xbi8VRJflIlEtUDHl7blZYhhYJLiibg6EDV
 sAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=N8V7+E9BHDwSicgFZ53Ky39lYpMAhXUlJyJskHLXTdI=;
 b=M2aeA+Rq1m/VB+bhU9oRCaCNZyIkTrT8kBuVECjf6fliqOUb5sebVqHCqPBabVkXVk
 chrRFW8O0OeGrugqosnOGitS3ghUCCc+k/z94StIX6GcGPO/7352xl35Ph0Ms9946/KC
 YwNXDc8JHcRG1EjzQd+nD7B0Xj9zR6WWe+mphVW5xheXApUdFXI2X1607ubGQF/Mnovg
 05NxvGPAL07oG3vB6qYIyqFoV6Eyfack2WO6ntM9OVQRsDnctcKSdV+TSUWSmyt7dNYX
 cWkUM6GT3qBJAnrGg0JRplyzxZJKisyK8+hFJ6/mljBwiEq/fnGKAFJo4k/D9PTwdfRL
 oRVg==
X-Gm-Message-State: AOAM530z+W+oUhsHbFrdgv/DCuSEFH9AvDAYI2sBCzJAdx9Hf2g5lsJ3
 kyHSekwWCZMv/nsBJ2sbWIJ1j9YHEM3tGu60tSI=
X-Google-Smtp-Source: ABdhPJw0UzeTEi4GubPaivGh/xjP0lFklifuqNGIDN69eos8ggxDq6wNw66slqGuyRsPmCM8/afcOGq8HTDr4i16RxM=
X-Received: by 2002:ac2:54ab:: with SMTP id w11mr524035lfk.50.1602058688074;
 Wed, 07 Oct 2020 01:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201007024135.1885-1-luoyonggang@gmail.com>
 <20201007024135.1885-2-luoyonggang@gmail.com>
 <e437f0ed-20a9-c370-8c87-ceb845513805@redhat.com>
In-Reply-To: <e437f0ed-20a9-c370-8c87-ceb845513805@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2020 16:17:57 +0800
Message-ID: <CAE2XoE9RyMFpLNWP+o13o7NOFXJAChR8Mf4QbF7ON3XRXEbkKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docker: Add win32/msys2/mingw64 docker
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000318c005b1105b0f"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000318c005b1105b0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2020 at 2:43 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/10/2020 04.41, Yonggang Luo wrote:
> > This docker is used to preparing a msys2/mingw with basic software
installed.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/docker/dockerfiles/msys2.docker | 57 +++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/msys2.docker
> >
> > diff --git a/tests/docker/dockerfiles/msys2.docker
b/tests/docker/dockerfiles/msys2.docker
> > new file mode 100644
> > index 0000000000..ce1404cbb8
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles/msys2.docker
> > @@ -0,0 +1,57 @@
> > +FROM mcr.microsoft.com/windows/servercore:2004
> > +RUN cmd /S /C powershell -NoLogo -NoProfile -Command netsh interface
ipv4 show interfaces ; netsh interface ipv4 set subinterface 18 mtu=3D1460
store=3Dpersistent ; netsh interface ipv4 show interfaces ;
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
;
> > +RUN choco install -y --no-progress git 7zip
> > +RUN cmd /S /C powershell -NoLogo -NoProfile -Command Remove-Item
C:\ProgramData\chocolatey\logs -Force -Recurse ; Remove-Item
C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse
> > +RUN mkdir C:\tools
> > +RUN bitsadmin /transfer msys_download /dynamic /download /priority
FOREGROUND
https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2=
-base-x86_64-20200903.sfx.exe
C:\tools\base.exe
> > +RUN cd /d C:\tools && base.exe -y
> > +RUN cmd /S /C powershell -NoLogo -NoProfile -Command "((Get-Content
-path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace
'--refresh-keys', '--version') | Set-Content -Path
C:\tools\msys64\etc\\post-install\\07-pacman-key.post"
> > +RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i
's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
> > +RUN C:\tools\msys64\usr\bin\bash.exe -lc "echo $MSYSTEM" >nul 2>&1
> > +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server =3D
http:\/\/repo.msys2.org\/msys\/.arch\///g' /etc/pacman.d/mirrorlist.msys"
> > +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server =3D
http:\/\/repo.msys2.org\/mingw\/i686\///g' /etc/pacman.d/mirrorlist.mingw32=
"
> > +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server =3D
http:\/\/repo.msys2.org\/mingw\/x86_64\///g'
/etc/pacman.d/mirrorlist.mingw64"
> > +RUN C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/'
/etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//
mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
> > +RUN C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
> > +RUN echo Y | C:\tools\msys64\usr\bin\pacman.exe -Suu --noconfirm
--needed
> > +RUN taskkill /F /FI "MODULES eq msys-2.0.dll"
> > +RUN tasklist
> > +RUN C:\tools\msys64\usr\bin\bash.exe -lc "pacman.exe --noconfirm -S
--needed \
> > +base-devel \
>
> base-devel pulls in a lot of stuff that we do not really need
(automake...),
> can you please replace it with the packages that are really required? See=
:
OK
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html
>
>  Thanks,
>   Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000318c005b1105b0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Oct 7, 2020 at 2:43 PM Thomas Huth &lt;<a =
href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<br=
>&gt; On 07/10/2020 04.41, Yonggang Luo wrote:<br>&gt; &gt; This docker is =
used to preparing a msys2/mingw with basic software installed.<br>&gt; &gt;=
<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang=
@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=
=A0tests/docker/dockerfiles/msys2.docker | 57 +++++++++++++++++++++++++++<b=
r>&gt; &gt; =C2=A01 file changed, 57 insertions(+)<br>&gt; &gt; =C2=A0creat=
e mode 100644 tests/docker/dockerfiles/msys2.docker<br>&gt; &gt;<br>&gt; &g=
t; diff --git a/tests/docker/dockerfiles/msys2.docker b/tests/docker/docker=
files/msys2.docker<br>&gt; &gt; new file mode 100644<br>&gt; &gt; index 000=
0000000..ce1404cbb8<br>&gt; &gt; --- /dev/null<br>&gt; &gt; +++ b/tests/doc=
ker/dockerfiles/msys2.docker<br>&gt; &gt; @@ -0,0 +1,57 @@<br>&gt; &gt; +FR=
OM <a href=3D"http://mcr.microsoft.com/windows/servercore:2004">mcr.microso=
ft.com/windows/servercore:2004</a><br>&gt; &gt; +RUN cmd /S /C powershell -=
NoLogo -NoProfile -Command netsh interface ipv4 show interfaces ; netsh int=
erface ipv4 set subinterface 18 mtu=3D1460 store=3Dpersistent ; netsh inter=
face ipv4 show interfaces ; Set-ExecutionPolicy Bypass -Scope Process -Forc=
e; iex ((New-Object System.Net.WebClient).DownloadString(&#39;<a href=3D"ht=
tps://chocolatey.org/install.ps1&#39;">https://chocolatey.org/install.ps1&#=
39;</a>)) ;<br>&gt; &gt; +RUN choco install -y --no-progress git 7zip<br>&g=
t; &gt; +RUN cmd /S /C powershell -NoLogo -NoProfile -Command Remove-Item C=
:\ProgramData\chocolatey\logs -Force -Recurse ; Remove-Item C:\Users\Contai=
nerAdministrator\AppData\Local\Temp -Force -Recurse<br>&gt; &gt; +RUN mkdir=
 C:\tools<br>&gt; &gt; +RUN bitsadmin /transfer msys_download /dynamic /dow=
nload /priority FOREGROUND <a href=3D"https://github.com/msys2/msys2-instal=
ler/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe">https:=
//github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-=
x86_64-20200903.sfx.exe</a> C:\tools\base.exe<br>&gt; &gt; +RUN cd /d C:\to=
ols &amp;&amp; base.exe -y<br>&gt; &gt; +RUN cmd /S /C powershell -NoLogo -=
NoProfile -Command &quot;((Get-Content -path C:\tools\msys64\etc\\post-inst=
all\\<a href=3D"http://07-pacman-key.post">07-pacman-key.post</a> -Raw) -re=
place &#39;--refresh-keys&#39;, &#39;--version&#39;) | Set-Content -Path C:=
\tools\msys64\etc\\post-install\\<a href=3D"http://07-pacman-key.post">07-p=
acman-key.post</a>&quot;<br>&gt; &gt; +RUN C:\tools\msys64\usr\bin\bash.exe=
 -lc &quot;sed -i &#39;s/^CheckSpace/#CheckSpace/g&#39; /etc/pacman.conf&qu=
ot;<br>&gt; &gt; +RUN C:\tools\msys64\usr\bin\bash.exe -lc &quot;echo $MSYS=
TEM&quot; &gt;nul 2&gt;&amp;1<br>&gt; &gt; +# RUN C:\tools\msys64\usr\bin\b=
ash.exe -lc &quot;sed -i &#39;s/Server =3D http:\/\/<a href=3D"http://repo.=
msys2.org">repo.msys2.org</a>\/msys\/.arch\///g&#39; /etc/pacman.d/mirrorli=
st.msys&quot;<br>&gt; &gt; +# RUN C:\tools\msys64\usr\bin\bash.exe -lc &quo=
t;sed -i &#39;s/Server =3D http:\/\/<a href=3D"http://repo.msys2.org">repo.=
msys2.org</a>\/mingw\/i686\///g&#39; /etc/pacman.d/mirrorlist.mingw32&quot;=
<br>&gt; &gt; +# RUN C:\tools\msys64\usr\bin\bash.exe -lc &quot;sed -i &#39=
;s/Server =3D http:\/\/<a href=3D"http://repo.msys2.org">repo.msys2.org</a>=
\/mingw\/x86_64\///g&#39; /etc/pacman.d/mirrorlist.mingw64&quot;<br>&gt; &g=
t; +RUN C:\tools\msys64\usr\bin\bash.exe -lc &quot;grep -rl &#39;<a href=3D=
"http://repo.msys2.org/">repo.msys2.org/</a>&#39; /etc/pacman.d/mirrorlist.=
* | xargs sed -i &#39;s/<a href=3D"http://repo.msys2.org">repo.msys2.org</a=
>\//<a href=3D"http://mirrors.tuna.tsinghua.edu.cn">mirrors.tuna.tsinghua.e=
du.cn</a>\/msys2\//g&#39;&quot;<br>&gt; &gt; +RUN C:\tools\msys64\usr\bin\p=
acman.exe --noconfirm -Sy<br>&gt; &gt; +RUN echo Y | C:\tools\msys64\usr\bi=
n\pacman.exe -Suu --noconfirm --needed<br>&gt; &gt; +RUN taskkill /F /FI &q=
uot;MODULES eq msys-2.0.dll&quot;<br>&gt; &gt; +RUN tasklist<br>&gt; &gt; +=
RUN C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman.exe --noconfirm -S --=
needed \<br>&gt; &gt; +base-devel \<br>&gt;<br>&gt; base-devel pulls in a l=
ot of stuff that we do not really need (automake...),<br>&gt; can you pleas=
e replace it with the packages that are really required? See:<div>OK<br>&gt=
;<br>&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-10/=
msg00072.html">https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg000=
72.html</a><br>&gt;<br>&gt; =C2=A0Thanks,<br>&gt; =C2=A0 Thomas<br>&gt;<br>=
<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo</div></div>

--0000000000000318c005b1105b0f--

