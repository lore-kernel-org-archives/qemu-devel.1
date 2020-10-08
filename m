Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597C920708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0R4VWLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597C920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcMM-0001Qm-EN
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcKo-0000Ev-5F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:16:23 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:44024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQcKm-0004bt-Gi
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:16:17 -0400
Received: by mail-lj1-x22e.google.com with SMTP id d24so4160216ljg.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=jVTZq4A07kvILFnntiT0f/3LXA+658yxSwJS7qK701U=;
 b=S0R4VWLrWs2LRmqWxDZNeC3e8+rxwwnwD7GHJh5zao1oUN2tejN25hCH3D823G2E2A
 J4M1eftGodHtoeHgL/buPKV5HJsgJadPRlGeHt3ScmKyT0G1yLVRVLkoL1qXgbKPI3OU
 kMhmMClkfc5X8WxhmO/U6lRzpgtv9b2/YjH63alhd0JZe3G2YgUXX0CyxRX+XHrKhv92
 uCvziTigcdf78Ic0+J5QIRvm7W4VcCInatL4yW7IqmfhAB2tQtqAmJYC741idCqfSh/n
 Nkm5P/7lnm80a4QH4HxCoyvEiMxLMKfpvY5kM8xH6gm4GDiOfws+c3EFVtFuX7OXTfUK
 jVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=jVTZq4A07kvILFnntiT0f/3LXA+658yxSwJS7qK701U=;
 b=DZnDRVd1Ywxsx5Xw8eA8+cm8e130+OvVDPOg4Otd7duUTDGOVUbIF6Zw9TXszi94V4
 UTp/rM5YZS8eEbhfmb0uTejNJCVlaPU8gOfBAEnbenx84oawvATNSWoJF4AfckvO6YfC
 Zq327BELP8vObbYtIEc9pmBtvXtEOL9yNF6hK8C3pil7pngKXeFqEskqaAoCs0M4Ix6T
 tW0CXPp130pXFELvLb3Kx/lpHtu5uRcvRiOBxXJO87Kmw/IQ8oSqqNmqIscs7epgqiaZ
 7/sJb8bsS6Q3+PjXcvXRVbQ6jHIhCqWmdivgcqnu2uraQeS4WZ1gp0q07gv8qIddcpLb
 Pzkg==
X-Gm-Message-State: AOAM533zQftOhOzG1YVex+l8MH2dbL87nCczP403uMiFEOkfzKyjUb0x
 eFt8l8LCUZp4AmMso571jy2ptZ4ig8v6jxIg8r4=
X-Google-Smtp-Source: ABdhPJzujSW5R3LqJ+xcmIyN75OJYqi+48T0qytPlQUWNOfBuXpJZm8LzBAESJluQo2ZosOq9u75GK1p1SB8BT/GHhA=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr701174lji.242.1602188174682; 
 Thu, 08 Oct 2020 13:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_2hL5yJr6BSF+1cQTWBkegL_N1S7AEjx41kNzuS3XfPg@mail.gmail.com>
 <539ea297-2709-5747-efa8-30495fb76320@redhat.com>
In-Reply-To: <539ea297-2709-5747-efa8-30495fb76320@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 04:16:02 +0800
Message-ID: <CAE2XoE-rE94Ee0=M-UF8uBFO96J0w0kMiT8WX+7xtzYMd6UdeA@mail.gmail.com>
Subject: Re:
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000003ed7c05b12e811d"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22e.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000003ed7c05b12e811d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh, I've fixed it and patch are sent.

On Fri, Oct 9, 2020 at 3:24 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/10/20 20:30, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > The text files are in tests/qapi-schema.
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> > "tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x =3D chr 13;
> > s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
> > tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
> > tests/qapi-schema/doc-good.txt.nocr >
> > tests/qapi-schema/doc-good.txt.nocr.stamp; fi
> > syntax error at -e line 1, near "=3D"
> > Execution of -e aborted due to compilation errors.
> > make: *** [Makefile.ninja:2555=EF=BC=9Atests/qapi-schema/doc-
> > good.txt.nocr.stamp] =E9=94=99=E8=AF=AF 255
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> > "qemu-version.h" "--" "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/scripts/qemu-version.py" "C:/work/xemu/qemu" ""
> > "5.1.50" && if test -e qemu-version.h; then printf '%s\n' qemu-version.=
h
> >> qemu-version.h.stamp; fi
> > "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> > "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> > "tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x =3D chr 13;
> > s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
> > tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
> > tests/qapi-schema/doc-good.txt.nocr >
> > tests/qapi-schema/doc-good.txt.nocr.stamp; fi
> > syntax error at -e line 1, near "=3D"
> > Execution of -e aborted due to compilation errors.
> > make: *** [Makefile.ninja:2555=EF=BC=9Atests/qapi-schema/doc-
> > good.txt.nocr.stamp] =E9=94=99=E8=AF=AF 255
>
> I think I know what's going on, but it's easiest to just switch to
> Ninja.  I'll post patches next week.
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000003ed7c05b12e811d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh, I&#39;ve fixed it and patch are sent.<br><br>On Fri, O=
ct 9, 2020 at 3:24 AM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.c=
om">pbonzini@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt; On 08/10/20 20:30, =
=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &gt;<br>&gt; &gt;<=
br>&gt; &gt; The text files are in tests/qapi-schema.<br>&gt; &gt; &quot;C:=
/CI-Tools/msys64/mingw64/bin/python3.exe&quot;<br>&gt; &gt; &quot;C:/work/x=
emu/qemu/meson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;=
--capture&quot;<br>&gt; &gt; &quot;tests/qapi-schema/doc-good.txt.nocr&quot=
; &quot;--&quot; &quot;perl&quot; &quot;-pe&quot; &quot;$x =3D chr 13;<br>&=
gt; &gt; s/$x$//&quot; &quot;tests/qapi-schema/doc-good.txt&quot; &amp;&amp=
; if test -e<br>&gt; &gt; tests/qapi-schema/doc-good.txt.nocr; then printf =
&#39;%s\n&#39;<br>&gt; &gt; tests/qapi-schema/doc-good.txt.nocr &gt;<br>&gt=
; &gt; tests/qapi-schema/doc-good.txt.nocr.stamp; fi<br>&gt; &gt; syntax er=
ror at -e line 1, near &quot;=3D&quot;<br>&gt; &gt; Execution of -e aborted=
 due to compilation errors.<br>&gt; &gt; make: *** [Makefile.ninja:2555=EF=
=BC=9Atests/qapi-schema/doc-<br>&gt; &gt; good.txt.nocr.stamp] =E9=94=99=E8=
=AF=AF 255<br>&gt; &gt; &quot;C:/CI-Tools/msys64/mingw64/bin/python3.exe&qu=
ot;<br>&gt; &gt; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--inter=
nal&quot; &quot;exe&quot; &quot;--capture&quot;<br>&gt; &gt; &quot;qemu-ver=
sion.h&quot; &quot;--&quot; &quot;C:/CI-Tools/msys64/mingw64/bin/python3.ex=
e&quot;<br>&gt; &gt; &quot;C:/work/xemu/qemu/scripts/qemu-version.py&quot; =
&quot;C:/work/xemu/qemu&quot; &quot;&quot;<br>&gt; &gt; &quot;5.1.50&quot; =
&amp;&amp; if test -e qemu-version.h; then printf &#39;%s\n&#39; qemu-versi=
on.h<br>&gt; &gt;&gt; qemu-version.h.stamp; fi<br>&gt; &gt; &quot;C:/CI-Too=
ls/msys64/mingw64/bin/python3.exe&quot;<br>&gt; &gt; &quot;C:/work/xemu/qem=
u/meson/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--captu=
re&quot;<br>&gt; &gt; &quot;tests/qapi-schema/doc-good.txt.nocr&quot; &quot=
;--&quot; &quot;perl&quot; &quot;-pe&quot; &quot;$x =3D chr 13;<br>&gt; &gt=
; s/$x$//&quot; &quot;tests/qapi-schema/doc-good.txt&quot; &amp;&amp; if te=
st -e<br>&gt; &gt; tests/qapi-schema/doc-good.txt.nocr; then printf &#39;%s=
\n&#39;<br>&gt; &gt; tests/qapi-schema/doc-good.txt.nocr &gt;<br>&gt; &gt; =
tests/qapi-schema/doc-good.txt.nocr.stamp; fi<br>&gt; &gt; syntax error at =
-e line 1, near &quot;=3D&quot;<br>&gt; &gt; Execution of -e aborted due to=
 compilation errors.<br>&gt; &gt; make: *** [Makefile.ninja:2555=EF=BC=9Ate=
sts/qapi-schema/doc-<br>&gt; &gt; good.txt.nocr.stamp] =E9=94=99=E8=AF=AF 2=
55<br>&gt;<br>&gt; I think I know what&#39;s going on, but it&#39;s easiest=
 to just switch to<br>&gt; Ninja.=C2=A0 I&#39;ll post patches next week.<br=
>&gt;<br>&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--00000000000003ed7c05b12e811d--

