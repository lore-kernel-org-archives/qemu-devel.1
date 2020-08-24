Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0534E2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzT0sgYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0534E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJUb-0001lJ-6v
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJTm-0001K8-RM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:54:10 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:40437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJTk-00012S-0U
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:54:10 -0400
Received: by mail-lj1-x231.google.com with SMTP id 185so11282345ljj.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to; bh=MKYylX0YU4vJBNkk6q8Z2SAo4fQrbUepArFTIgHjXaY=;
 b=HzT0sgYUxscKBCBHLERpNINMsuournAPo4C+1LpdVuYugEmH+55K3y5H25rYrsWCLe
 icS8NyBh1XwpyFVOC+EdOgeyjSXfVuUPLIPOSOCXgWZi1BQzD1RW69aePybhCLs3HmLO
 N84tGf6fo0RUuoF0T/uS6hVkpIKbNLsJkKsy5E/GfSpJbGozbYpcDl304vmgdRjPJqAY
 4X0bRrjZCCdxyRQZjV8mrdByxfrh8T0/qG2IYrzalC9PnHjyQSwnCoAVckpOas9/oPF9
 h4Hvo1/YFtMiunOAILzlJAWM7Mwdd5QuzsSub+TVI8Ii2abGYH3FM51wFziVVMvFdmxQ
 I0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to;
 bh=MKYylX0YU4vJBNkk6q8Z2SAo4fQrbUepArFTIgHjXaY=;
 b=WRBHiDG3fK6+6jmg6Hvsg8x6c4YTegC0RpcfKsCuljtAEOyNY/PV9SYkQy35+Ar+7t
 4LQutcmPx2udJnqJuJM4KR8oJb/00pkqDqtJGZArgHQS0BfpL3jPZ1V8Hq75Ig/Z/6DB
 bYK7KFF8CbASWpjmAfV6NDwcp9+hL4z0qgVfDpgg2Vz7HMTJNUEhA0zJFcpciZK3B54/
 Br6+xAb00/V2WUmqalaFhJZ4k26771NFK1cCB2yHIf+YWAnbBQj807b8LYjdTspU+B2W
 Z8jwe8fp6F3tJthmcAw9Sxrv2MOUfiMr0B+teO6btV5PjPVe3VwUIA/esiNmWn1QrRty
 pi6Q==
X-Gm-Message-State: AOAM530PijYMdvE0rYS/x1Mty8v6wyFr/Uy+bL6imIunt+faJwqQMDvM
 jspT4/UWaR/p8OW61l6V1wS731QskJQpwTqK8Sk=
X-Google-Smtp-Source: ABdhPJx+F953c/0jzmMKFu0KMG+8ghpF01SFKeKsV8kuTsQ1yv1MCaCX+f5WI9kxUskgvEo4DsecricPx8hcz9tATp8=
X-Received: by 2002:a2e:8689:: with SMTP id l9mr3622098lji.467.1598302445887; 
 Mon, 24 Aug 2020 13:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-bye0NfiXdLCRfOTrzFKmcT4HwYKrWO63pZyMbRNrJXQ@mail.gmail.com>
In-Reply-To: <CAE2XoE-bye0NfiXdLCRfOTrzFKmcT4HwYKrWO63pZyMbRNrJXQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 04:53:55 +0800
Message-ID: <CAE2XoE8z9tijAdaovHNZ+XWLE8tBdFqbTS-v5hWshUP4bVaW0w@mail.gmail.com>
Subject: Fwd: msys2/mingw meson building fixes
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-level <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 onzini@gnu.org
Content-Type: multipart/alternative; boundary="00000000000087e7ea05ada5c9b4"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x231.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000087e7ea05ada5c9b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com>
Date: Tue, Aug 25, 2020 at 4:50 AM
Subject: msys2/mingw meson building fixes
To: qemu-level <qemu-devel@nongnu.org>


I've create a pull request for fixes python ninja detection and usage on
msys2/mingw
at  https://github.com/mesonbuild/meson/pull/7637


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000087e7ea05ada5c9b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>From: <strong cla=
ss=3D"gmail_sendername" dir=3D"auto">=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang L=
uo)</strong> <span dir=3D"auto">&lt;<a href=3D"mailto:luoyonggang@gmail.com=
">luoyonggang@gmail.com</a>&gt;</span><br>Date: Tue, Aug 25, 2020 at 4:50 A=
M<br>Subject: msys2/mingw meson building fixes<br>To: qemu-level &lt;<a hre=
f=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;<br></div><=
br><br><div dir=3D"ltr">I&#39;ve create a pull request for fixes python nin=
ja detection and usage on msys2/mingw<div>at=C2=A0

<a href=3D"https://github.com/mesonbuild/meson/pull/7637" target=3D"_blank"=
>https://github.com/mesonbuild/meson/pull/7637</a>=C2=A0</div><div>=C2=A0<b=
r></div><div><div><div><br></div>-- <br><div dir=3D"ltr" data-smartmail=3D"=
gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=
=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerel=
y,<br>Yonggang Luo<br></div></div></div></div>
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000087e7ea05ada5c9b4--

