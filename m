Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F69DC04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76207221FC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSS6pHLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76207221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQahu-0001Ba-7A
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 14:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQagQ-0000Z4-15
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:30:30 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:46821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQagO-0000Is-1x
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:30:29 -0400
Received: by mail-lj1-x22a.google.com with SMTP id c21so6796941ljn.13
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=0pW70IpVl910aem2KrNbmk7ncsNMVTVjWFcQNCw0uyg=;
 b=TSS6pHLOH+KNq5UY69+3mgcegvdKmIY+bfG+R/F0N6f92Xw/IUkqu7k03g3OMdiYGP
 uRr5T8iJVQ6pfFgbfASInKxTtiquvHa78/ZsbLlOriOYtw0rpumZxvxk1lW0Mn7a7OFl
 5238JK3oWLKV9pi3WgR/DQwoawjz7qb+3UkgLArVaWmUBSOD0AWGCyoujEjxtGP8mcM2
 lsz2cgaHkAuNZcNj4sLdOuX4yNOof+/T6TghUIqHCOVP326euZRfvvPUf3Gr03cyOf/X
 osi9l4Nzu1rRn9uPEzCCHUi7KmxjC8Rq7y2QBR1ntgb/qTl0P+yznvbWT+E+Bdrjx2+Y
 x2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=0pW70IpVl910aem2KrNbmk7ncsNMVTVjWFcQNCw0uyg=;
 b=U9u0vRucPoYsnrDvDmcwEdqiII066tcX0h6gnIQCUOVNPYbt2LDASHesxMLIQnY59a
 l2U1svHWdU8v7u1LPtluyrZL8KTrAna7w4yQxIbN/0F+3J8xFxO3uBy0NdyAluym/Lm3
 7RZ+0dPb1bjVhoTTLtQQKVktEcScI9FRRPhPcyjWcMjIY0TXsgjIVoQyuvL1dzfoTmiY
 tE+xUx5V4TdyiSyb7ZGTTDoxrfOG0ZVMAZpYC/5AuPogEnEcz7XamCm791E4lV0i5Rbz
 aNUJwW395M+nUkrhL6QTtxt82khnvwOaZpdzGR7Yv/NzTbM9lvT+RO2xBR2Kqm+5JvMJ
 6nYw==
X-Gm-Message-State: AOAM53288Xyco6RsxiAYvYxzgNCdcATRZZFodNz6G8SJNRR+s6tqJxj3
 XHoOVNKxNIH8mS0rZxgoWa5eCciRGTjgjxklyQNi/2wEsr/5gw==
X-Google-Smtp-Source: ABdhPJyeap5Bk/QO4gVP++WSPAHd+qJUo7ObdAypP3y7JfbT8wIIEHHTWCf5fNuEs3iDNLldFOQqFnhyH8NhWbNDJjo=
X-Received: by 2002:a05:651c:1b6:: with SMTP id
 c22mr1627641ljn.447.1602181824730; 
 Thu, 08 Oct 2020 11:30:24 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 02:30:13 +0800
Message-ID: <CAE2XoE_2hL5yJr6BSF+1cQTWBkegL_N1S7AEjx41kNzuS3XfPg@mail.gmail.com>
Subject: 
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000875c1405b12d0680"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
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

--000000000000875c1405b12d0680
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

qapi docs tests building failed on win32

looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
writing output... [100%] doc-good

build succeeded.

The text files are in tests/qapi-schema.
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x =3D chr 13;
s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
tests/qapi-schema/doc-good.txt.nocr >
tests/qapi-schema/doc-good.txt.nocr.stamp; fi
syntax error at -e line 1, near "=3D"
Execution of -e aborted due to compilation errors.
make: *** [Makefile.ninja:2555=EF=BC=9Atests/qapi-schema/doc-good.txt.nocr.=
stamp]
=E9=94=99=E8=AF=AF 255
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"qemu-version.h" "--" "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/scripts/qemu-version.py" "C:/work/xemu/qemu" "" "5.1.50"
&& if test -e qemu-version.h; then printf '%s\n' qemu-version.h >
qemu-version.h.stamp; fi
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x =3D chr 13;
s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
tests/qapi-schema/doc-good.txt.nocr >
tests/qapi-schema/doc-good.txt.nocr.stamp; fi
syntax error at -e line 1, near "=3D"
Execution of -e aborted due to compilation errors.
make: *** [Makefile.ninja:2555=EF=BC=9Atests/qapi-schema/doc-good.txt.nocr.=
stamp]
=E9=94=99=E8=AF=AF 255
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000875c1405b12d0680
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">qapi docs tests building failed on win32<br><br>looking fo=
r now-outdated files... none found<br>pickling environment... done<br>check=
ing consistency... done<br>preparing documents... done<br>writing output...=
 [100%] doc-good<br><br>build succeeded.<br><br>The text files are in tests=
/qapi-schema.<br>&quot;C:/CI-Tools/msys64/mingw64/bin/python3.exe&quot; &qu=
ot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&quot; &quot;exe&=
quot; &quot;--capture&quot; &quot;tests/qapi-schema/doc-good.txt.nocr&quot;=
 &quot;--&quot; &quot;perl&quot; &quot;-pe&quot; &quot;$x =3D chr 13; s/$x$=
//&quot; &quot;tests/qapi-schema/doc-good.txt&quot; &amp;&amp; if test -e t=
ests/qapi-schema/doc-good.txt.nocr; then printf &#39;%s\n&#39; tests/qapi-s=
chema/doc-good.txt.nocr &gt; tests/qapi-schema/doc-good.txt.nocr.stamp; fi<=
br>syntax error at -e line 1, near &quot;=3D&quot;<br>Execution of -e abort=
ed due to compilation errors.<br>make: *** [Makefile.ninja:2555=EF=BC=9Ates=
ts/qapi-schema/doc-good.txt.nocr.stamp] =E9=94=99=E8=AF=AF 255<br>&quot;C:/=
CI-Tools/msys64/mingw64/bin/python3.exe&quot; &quot;C:/work/xemu/qemu/meson=
/meson.py&quot; &quot;--internal&quot; &quot;exe&quot; &quot;--capture&quot=
; &quot;qemu-version.h&quot; &quot;--&quot; &quot;C:/CI-Tools/msys64/mingw6=
4/bin/python3.exe&quot; &quot;C:/work/xemu/qemu/scripts/qemu-version.py&quo=
t; &quot;C:/work/xemu/qemu&quot; &quot;&quot; &quot;5.1.50&quot; &amp;&amp;=
 if test -e qemu-version.h; then printf &#39;%s\n&#39; qemu-version.h &gt; =
qemu-version.h.stamp; fi<br>&quot;C:/CI-Tools/msys64/mingw64/bin/python3.ex=
e&quot; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&quot;=
 &quot;exe&quot; &quot;--capture&quot; &quot;tests/qapi-schema/doc-good.txt=
.nocr&quot; &quot;--&quot; &quot;perl&quot; &quot;-pe&quot; &quot;$x =3D ch=
r 13; s/$x$//&quot; &quot;tests/qapi-schema/doc-good.txt&quot; &amp;&amp; i=
f test -e tests/qapi-schema/doc-good.txt.nocr; then printf &#39;%s\n&#39; t=
ests/qapi-schema/doc-good.txt.nocr &gt; tests/qapi-schema/doc-good.txt.nocr=
.stamp; fi<br>syntax error at -e line 1, near &quot;=3D&quot;<br>Execution =
of -e aborted due to compilation errors.<br>make: *** [Makefile.ninja:2555=
=EF=BC=9Atests/qapi-schema/doc-good.txt.nocr.stamp] =E9=94=99=E8=AF=AF 255<=
br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<=
br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yong=
gang Luo</div>

--000000000000875c1405b12d0680--

