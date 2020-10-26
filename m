Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC66C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4723920720
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWsdzkbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4723920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7pJ-0000dQ-2B
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX7iJ-00038r-EB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:59:27 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX7iG-0005kJ-IR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:59:27 -0400
Received: by mail-lj1-x242.google.com with SMTP id m20so11452606ljj.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8x+LHT39X5snWgd/p4SdR4bi1nm9tkg0nS8lugJkQWY=;
 b=uWsdzkbkqA2Ew/2aa/WF1ghhr7VsW/9GkXQez29mE5lOSpkjALvF4Yozerm3PHSq+h
 W4BRusfH3IVZCQRpbYXR2R+N6V1/QurxyWB3/621VMrsY2nPLdHW83F9muUC81pTKn22
 hqY4G9iBVzoYXGK4ogMDJaqoOxR6x8Ao4Jv6+Ooqa6BF9dt/Gp1mVZriU2KKgls8jkEd
 9PplZBhlHvGIiiUTc+2uF1DktgdZ0fy7ko8QXZPAFbIC8eXUmOiMdkaEqk9MsotrEHDe
 GDN4igyh6MBUv/8Bp03S1eq3J/yw1Oy/1iBkHquFktjSDYeYGMH+ruzzYuu+cNquCZ9z
 ByRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8x+LHT39X5snWgd/p4SdR4bi1nm9tkg0nS8lugJkQWY=;
 b=KxNQJa/5+w+FOPVf3aE4gWFaxGmYOECC16CP7/zdJFSM9MMLd3+zV/BLXGSKPvNpIS
 NQdzvX5UtdaFspAE4AQzC/r5ZDXFNbSIJ8Wqy4xsG6JL0FuEvMibFx9QG2Dli2G5t509
 4kJSi0HajGhdHoA0Ed2z1m5D6mr2ElbsGWxpCpjr//luCr2DMFNm0G2rbbDY+Wl5uAc/
 IUJxpm+0HOeLt2S2KTXIfgrmXwOp/4jOnskHfy/vjvSiZtYeZgSOLXCP6khrwoxi/ilR
 SG3PloZEZhmMbI7lPcgKP+i5cSNkTB5ymaeXevD73Q0Sou+LEbBObUWmEJe5/iTYZNK/
 UMEw==
X-Gm-Message-State: AOAM5336rQizsmuQeT8ZqPkIjN3xJ6p4Qw7YHNlsBqZSI4Okton9MK6g
 x9/wPskZ9u8TcEaL9vhaOkhdyhvc6sPhi9oq+q4=
X-Google-Smtp-Source: ABdhPJzaik0lAvslIzz2vWvZaJHyUaP52cLqwCfMGCo9VKmJRwH6EFAdyIJm17cJgNmgPlJ0Hqg+i0n8s79HxHtCfdg=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr7189786lji.242.1603738762206; 
 Mon, 26 Oct 2020 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201026135131.3006712-1-pbonzini@redhat.com>
 <CAFEAcA-WscaYcpooMQ0F2Etc+Rzf5M=Bb-b9Dw7pGsaaO8Od=g@mail.gmail.com>
In-Reply-To: <CAFEAcA-WscaYcpooMQ0F2Etc+Rzf5M=Bb-b9Dw7pGsaaO8Od=g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2020 02:59:10 +0800
Message-ID: <CAE2XoE9AvG-G70Rm5S=q+Xz3C2_VVGdL6DHXme=ZFPU+OOwQng@mail.gmail.com>
Subject: Re: [PULL 00/17] Build system changes and misc fixes for QEMU 5.2
 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003be07f05b297878d"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003be07f05b297878d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This pull request confused me, the windows msys2 build time slow down from
40min to more than one hour.

On Tue, Oct 27, 2020 at 1:54 AM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Mon, 26 Oct 2020 at 14:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
> >
> >   Merge remote-tracking branch
'remotes/kraxel/tags/modules-20201022-pull-request' into staging
(2020-10-22 12:33:21 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 8b0e484c8bf82e07bb0439bff04e248c63cdc86a=
:
> >
> >   machine: move SMP initialization from vl.c (2020-10-26 07:08:40 -0400=
)
> >
> > ----------------------------------------------------------------
> > * fix --disable-tcg builds (Claudio)
> > * Fixes for macOS --enable-modules build and OpenBSD curses/iconv
detection (myself)
> > * Start preparing for meson 0.56 (myself)
> > * Move directory configuration to meson (myself)
> > * Start untangling qemu_init (myself)
> > * Windows fixes (Sunil)
> > * Remove -no-kbm (Thomas)
> >
> > ----------------------------------------------------------------
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
> for any user-visible changes.
>
> -- PMM
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003be07f05b297878d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This pull request confused me, the windows msys2 build tim=
e slow down from 40min to more than one hour.<br><br>On Tue, Oct 27, 2020 a=
t 1:54 AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pet=
er.maydell@linaro.org</a>&gt; wrote:<br>&gt;<br>&gt; On Mon, 26 Oct 2020 at=
 14:04, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@r=
edhat.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; The following changes si=
nce commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:<br>&gt; &gt;<br>&gt; &=
gt; =C2=A0 Merge remote-tracking branch &#39;remotes/kraxel/tags/modules-20=
201022-pull-request&#39; into staging (2020-10-22 12:33:21 +0100)<br>&gt; &=
gt;<br>&gt; &gt; are available in the Git repository at:<br>&gt; &gt;<br>&g=
t; &gt; =C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git">https://gitl=
ab.com/bonzini/qemu.git</a> tags/for-upstream<br>&gt; &gt;<br>&gt; &gt; for=
 you to fetch changes up to 8b0e484c8bf82e07bb0439bff04e248c63cdc86a:<br>&g=
t; &gt;<br>&gt; &gt; =C2=A0 machine: move SMP initialization from vl.c (202=
0-10-26 07:08:40 -0400)<br>&gt; &gt;<br>&gt; &gt; -------------------------=
---------------------------------------<br>&gt; &gt; * fix --disable-tcg bu=
ilds (Claudio)<br>&gt; &gt; * Fixes for macOS --enable-modules build and Op=
enBSD curses/iconv detection (myself)<br>&gt; &gt; * Start preparing for me=
son 0.56 (myself)<br>&gt; &gt; * Move directory configuration to meson (mys=
elf)<br>&gt; &gt; * Start untangling qemu_init (myself)<br>&gt; &gt; * Wind=
ows fixes (Sunil)<br>&gt; &gt; * Remove -no-kbm (Thomas)<br>&gt; &gt;<br>&g=
t; &gt; ----------------------------------------------------------------<br=
>&gt;<br>&gt;<br>&gt; Applied, thanks.<br>&gt;<br>&gt; Please update the ch=
angelog at <a href=3D"https://wiki.qemu.org/ChangeLog/5.2">https://wiki.qem=
u.org/ChangeLog/5.2</a><br>&gt; for any user-visible changes.<br>&gt;<br>&g=
t; -- PMM<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000003be07f05b297878d--

