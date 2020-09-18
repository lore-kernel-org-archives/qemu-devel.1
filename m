Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D207C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF8220872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdflC47f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF8220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJKs-0008No-M4
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIy2-0002Xa-RU; Fri, 18 Sep 2020 12:10:36 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIy0-0003gi-L7; Fri, 18 Sep 2020 12:10:34 -0400
Received: by mail-lj1-x242.google.com with SMTP id b19so5524185lji.11;
 Fri, 18 Sep 2020 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=vkSAzfcNZzpzQTPyneasZVlyRDJqjgu5obu7LlNouFU=;
 b=XdflC47fLi7vrMXnMmxqSLRIzgtWF4kBMoevc9in7Jm1Ys0UWW9LfNZzuKscSWz37N
 ti+x0SR0cV97araAM38NwbIJsDgfTUnhtV+I1UjzoWEwoE9oVZIioAL7mVtlIQWCDWMW
 GT8jN4haVqm9zcFuBNUN+lr6a+TkS/i63jTNW9bPqaQgRki0TmVLwAwHLCnV8H4NTBNJ
 Lrcshce9uqYJYWNZ3xvnJx5W1896zF4tGDPffzz5Dhu4M4gMygyoayi8fj+lLbzAlDgq
 7b3noCveS33L5ekV9gfSrpE/mRA6TOkl2Xxc1c1t0V2lWQOX9c3hSvw6AKg8jwTpEa17
 AUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=vkSAzfcNZzpzQTPyneasZVlyRDJqjgu5obu7LlNouFU=;
 b=ovp3y7CQVeBhy1WrowMC2LfLxfCDwqGePz2nqAusQb+S66iSBUVd+MDLROuGbkWp11
 PVtGkxQBc6a5cuOQ0prGaAyqb7rQcRgc09rCMqFGvsTyBK5hGGc9wxrLGyHuYzn3G/5E
 R6y9hJlYDtJwXnwJiyeYp+cHIviXS9lEYaZsHYFYVaIleS+e9rznnbw//p5dMIhg/1PD
 uiWm0+0jBSRHhRZsPHOA7sui65nKNrE5PFr0U/7pbzuFN3D8BKpYDUCefHtR4/r8xjX3
 V2JdAwUpKpag9TqB8i+boj0aw4LxfWUZcoVQCzL0AYSmyQ2z70hTBHY9VyWHMdyOY1Zl
 cGSw==
X-Gm-Message-State: AOAM532s07n+B96IpP+sWuPTtzoXR5SRhduoQDR8vP3s1DjVRxLeWu22
 vZPOiQVInPYL14i+jHL8x/93RADRjwEoSKAISPmkdMU2iTHJmQ==
X-Google-Smtp-Source: ABdhPJyIiqlNiOWmj9l2HB+JOcWt+T+c0lJlh3r2YjhrGuaA5DcpdfSUqaSZ2cgoTbb296tJRAfZ//QD9rGwUGpzY9k=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr13123188ljj.447.1600445428942; 
 Fri, 18 Sep 2020 09:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200918160250.1141-1-luoyonggang@gmail.com>
In-Reply-To: <20200918160250.1141-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 19 Sep 2020 00:10:17 +0800
Message-ID: <CAE2XoE9Vf3Zixv6Ds0BmO9O5EWWjPbG-0EkP0BEbPikuCc4SVg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Fixes curses on msys2/mingw
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000464d7a05af98bdbc"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000464d7a05af98bdbc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bonzini, help to look at this, I convert curses and it's depends iconv
to meson

On Sat, Sep 19, 2020 at 12:03 AM Yonggang Luo <luoyonggang@gmail.com> wrote=
:
>
> And also convert related configure script to meson.
>
> Yonggang Luo (4):
>   curses: Fixes compiler error that complain don't have langinfo.h on
>     msys2/mingw
>   curses: Fixes curses compiling errors.
>   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE
>     are defined on msys2/mingw
>   configure: Fixes ncursesw detection under msys2/mingw by convert them
>     to meson
>
>  configure                 | 155 ++------------------------------------
>  include/sysemu/os-win32.h |   4 +-
>  meson.build               |  80 +++++++++++++++++---
>  meson_options.txt         |   4 +
>  ui/curses.c               |  14 ++--
>  ui/meson.build            |   2 +-
>  util/oslib-win32.c        |   4 +-
>  7 files changed, 91 insertions(+), 172 deletions(-)
>
> --
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000464d7a05af98bdbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bonzini, help to look at this, I convert curses and it&=
#39;s depends=C2=A0iconv to meson<div><br>On Sat, Sep 19, 2020 at 12:03 AM =
Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail=
.com</a>&gt; wrote:<br>&gt;<br>&gt; And also convert related configure scri=
pt to meson.<br>&gt;<br>&gt; Yonggang Luo (4):<br>&gt; =C2=A0 curses: Fixes=
 compiler error that complain don&#39;t have langinfo.h on<br>&gt; =C2=A0 =
=C2=A0 msys2/mingw<br>&gt; =C2=A0 curses: Fixes curses compiling errors.<br=
>&gt; =C2=A0 win32: Simplify gmtime_r detection not depends on if =C2=A0_PO=
SIX_C_SOURCE<br>&gt; =C2=A0 =C2=A0 are defined on msys2/mingw<br>&gt; =C2=
=A0 configure: Fixes ncursesw detection under msys2/mingw by convert them<b=
r>&gt; =C2=A0 =C2=A0 to meson<br>&gt;<br>&gt; =C2=A0configure =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 155 ++------------------------=
------------<br>&gt; =C2=A0include/sysemu/os-win32.h | =C2=A0 4 +-<br>&gt; =
=C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
80 +++++++++++++++++---<br>&gt; =C2=A0meson_options.txt =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 4 +<br>&gt; =C2=A0ui/curses.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A014 ++--<br>&gt; =C2=A0ui/meson.build =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 2 +-<br>&gt; =C2=A0util/osli=
b-win32.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 4 +-<br>&gt; =C2=A07 files ch=
anged, 91 insertions(+), 172 deletions(-)<br>&gt;<br>&gt; --<br>&gt; 2.28.0=
.windows.1<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000464d7a05af98bdbc--

