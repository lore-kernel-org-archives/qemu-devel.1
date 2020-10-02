Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94101206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrhgcxsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94101206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPLK-0007xl-Q0
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPGE-00021A-Rg; Fri, 02 Oct 2020 13:54:27 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPGC-0005A3-Ti; Fri, 02 Oct 2020 13:54:26 -0400
Received: by mail-lj1-x241.google.com with SMTP id w3so1879450ljo.5;
 Fri, 02 Oct 2020 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=KLzAvA12BDrOuDsq9G64J4ANl6yG66aF1CUdl7U7iys=;
 b=CrhgcxsEsgwH+hN5WbX4l6ogW7qHsbT3YwgMTc069pvHl+iPdhmZwXCBIezogDnXIx
 oWKZACF0s+ksfVpvuD7Mxy48nMmq1oe4xffUSVyz4Nyhl6pSr3O7kHNjPqJUXKbkwCba
 zlGfRwsb6eCyy905LTh8nvWvm3xE7lPmbCfzmsnuqT6C21OtgWDui66ue6dXENYqknhS
 ycORxP1sVr5Wa1hr7l92f1KBWcAVGToChsp/UE95UU2pWmTXs5u83j+lmsqeJCG91Ncl
 JiU0/uNbFXomQNEE+fiMLKx5zQB+oHEidq8lK7zvwR/kmKgS3Ga1ZFbrZU6b63Z4i4yy
 gouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=KLzAvA12BDrOuDsq9G64J4ANl6yG66aF1CUdl7U7iys=;
 b=aILrFhc6n24CI5OR3gOcy6M17Uoi5kG1+7gKD1HBivaP79046dt687q9to47ZTCdMM
 +R4W7SySi6ek/mArgf4vZBHJG1POMcVeIr+cfkoWQgHXuFjOQoKkVvLAHCVtqMncRVaP
 bG+LGhgcXnBKbeUHvwOpRcePba46ecBIub5C4bDCz4iTHQtbhV5nd6mixf6PvHuE+QFQ
 ts1snHATd5nyjo/rWROdrAyV2lv2kCNHFzDmTYGk3d0/uy0mb7yeXBSnE9J7NiwzY6og
 cVCqwrtMK/4hq39hFO9dDmPiDI+06LEPdj6YxjePKL4UuJLIuKMIKQ1LFR7J5ylG7bnq
 LrWQ==
X-Gm-Message-State: AOAM533YjVwul/09IxJlDbmv8xsl2a4FY7o7gnT/62lHpzglR266QD3E
 Vy1ObHnReOcT0cVZmP8ByGbGV0esLhzdLUTSNrw=
X-Google-Smtp-Source: ABdhPJyNEK79fKniIRIGZEkHDSlgyRH2itR6GB7bOeMyfwRCoVEi3heuwBADyC09hBO+FZp0qXjQhAJLdrWZ8g8oXss=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1004882ljj.120.1601661262425; 
 Fri, 02 Oct 2020 10:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
 <20201002153559.GJ2338114@redhat.com>
 <CAE2XoE_z3j+_+Oh1Kn-GSAT4q0_nXnT0sLHMLCw0+r1o0WBJSA@mail.gmail.com>
 <20201002164232.GO2338114@redhat.com>
 <CAE2XoE_+ERRdDgGcisNj0WWMU=rCs49PrikVw6Tk+Ov2TC0+Tw@mail.gmail.com>
 <7998dac5-0bd6-a552-30d4-c567805ad1ed@redhat.com>
In-Reply-To: <7998dac5-0bd6-a552-30d4-c567805ad1ed@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 01:54:11 +0800
Message-ID: <CAE2XoE9OP0Z-xCXEjvAE-rCkusJ+GMypg=YU19ee8G=MKj2RPQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098f43a05b0b3d296"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000098f43a05b0b3d296
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

gotcha
On Sat, Oct 3, 2020 at 1:49 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/10/20 19:47, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Because the configure script change far more complicated than you
> > imgaine. And I post that before
>
> Daniel is literally asking for a two-line change:
>
> diff --git a/configure b/configure
> index fee5faa054..ffd72b571d 100755
> --- a/configure
> +++ b/configure
> @@ -3671,7 +3671,6 @@ if test "$curses" !=3D "no" ; then
>  #include <locale.h>
>  #include <curses.h>
>  #include <wchar.h>
> -#include <langinfo.h>
>  int main(void) {
>    const char *codeset;
>    wchar_t wch =3D L'w';
> @@ -3680,7 +3679,6 @@ int main(void) {
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  codeset =3D nl_langinfo(CODESET);
>    return codeset !=3D 0;
>  }
>  EOF
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

--00000000000098f43a05b0b3d296
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>gotcha<br>On Sat, Oct 3, 2020 at 1:49 AM Paolo Bonzini=
 &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wro=
te:<br>&gt;<br>&gt; On 02/10/20 19:47, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang=
 Luo) wrote:<br>&gt; &gt; Because the configure script change far more comp=
licated than you<br>&gt; &gt; imgaine. And I post that before<br>&gt;<br>&g=
t; Daniel is literally asking for a two-line change:<br>&gt;<br>&gt; diff -=
-git a/configure b/configure<br>&gt; index fee5faa054..ffd72b571d 100755<br=
>&gt; --- a/configure<br>&gt; +++ b/configure<br>&gt; @@ -3671,7 +3671,6 @@=
 if test &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>&gt; =C2=A0#incl=
ude &lt;locale.h&gt;<br>&gt; =C2=A0#include &lt;curses.h&gt;<br>&gt; =C2=A0=
#include &lt;wchar.h&gt;<br>&gt; -#include &lt;langinfo.h&gt;<br>&gt; =C2=
=A0int main(void) {<br>&gt; =C2=A0 =C2=A0const char *codeset;<br>&gt; =C2=
=A0 =C2=A0wchar_t wch =3D L&#39;w&#39;;<br>&gt; @@ -3680,7 +3679,6 @@ int m=
ain(void) {<br>&gt; =C2=A0 =C2=A0addwstr(L&quot;wide chars\n&quot;);<br>&gt=
; =C2=A0 =C2=A0addnwstr(&amp;wch, 1);<br>&gt; =C2=A0 =C2=A0add_wch(WACS_DEG=
REE);<br>&gt; - =C2=A0codeset =3D nl_langinfo(CODESET);<br>&gt; =C2=A0 =C2=
=A0return codeset !=3D 0;<br>&gt; =C2=A0}<br>&gt; =C2=A0EOF<br>&gt;<br>&gt;=
 Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo</div>

--00000000000098f43a05b0b3d296--

