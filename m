Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF421C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E84E208A9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9IoLZZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E84E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBweV-00038h-Rd
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBwdz-0002iZ-Px
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 04:55:27 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:45517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBwdy-00050L-Cc
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 04:55:27 -0400
Received: by mail-lj1-x232.google.com with SMTP id w25so1386835ljo.12
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=cdIDYMvu+LteGbeaRYXFj2zEQQFZ3VWpO1Ye4Kx4o9Y=;
 b=u9IoLZZeilg/VHpg9YRK/vqjgRBLZ/RCL14KRCYVsXJHmzOpYeZrEDIkfw8o7cJwe/
 drsboHGjQhg8sH6KPq3St8E9EL6Dk2evl6SNQW5FjdHc8SiDq4qNjROZA524OsUzNaFo
 oSJ8NJWOLHwMbQ/y1n8Jxyc00x1zN3GFQeduOfwkMD6kVIrFKDMlYgEUX1kxgKxVpXPb
 Uk48LoDFzlFNcAPzJGH33Tu3zkaSL65grN7LbQQcFsT5Q+KrMtsXZUeDrw5LC8o7LxTX
 wsXXjCNXa+1fF99L+m8w3SSKKZPjLsPbQOF62wEoYtAJC4Wts11pJ83M8PN1l7aegQsL
 +zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=cdIDYMvu+LteGbeaRYXFj2zEQQFZ3VWpO1Ye4Kx4o9Y=;
 b=nA0LxQJIz3Ir2UuL9O6lbviX7R7PlA3OtdKwxd1boAfScMFYdXcMXXpdbdOLMzBdaP
 XG124SZgc9ZkV8n7GloZIhmJ8w2Qw/Z8V1VletMyLuayIqgRqJFqaNhx9Q7u2COeMZXw
 AAT67P/a1syWoxkh6z96IXv2dwPw9F6OI/Vo/jyKnsIf7dZ5AylQIB4R1Q2S6TYd8zLN
 VMoO/9Cliiz8a2Rw/4Q3uu/uYZWtvp1eSV5cDDtOVR3Ik95p4VTDz5FpBX7+eb/uFXVd
 ZgD9qjTGTCRkkC31XPWzdZ/6R3cr4x4+5eTu7BprOWx3bj5ZWnyMXIt5G5tiihLXBGvF
 Twag==
X-Gm-Message-State: AOAM5337ne6qG+nUmegy3oCVB4Ot0PXpVxFMJiTKnrbJ0HsAlpUNw2rp
 7I2HKR5LIMYxX+9fwncpsitVUxbEJdqyU6kn9Hg7spr0qtkTYc/h
X-Google-Smtp-Source: ABdhPJyurbaDjvFh1epVvM8AngUe+F1Eg9mwMpTejgJqo8QkyzgjQwyI4kYUsWsgXehGhG1UujlCQg2mcywYI9yaP3E=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr1235042ljg.447.1598691323879; 
 Sat, 29 Aug 2020 01:55:23 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 29 Aug 2020 16:55:12 +0800
Message-ID: <CAE2XoE9YT=qn8dd4TfRnMoGnFY6LxH3TagrBirFxf8GbSvW9DQ@mail.gmail.com>
Subject: on msys2, the generated qemu-version.h seems not valid
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000077240905ae00542f"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000077240905ae00542f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#define QEMU_PKGVERSION ""
#define QEMU_FULL_VERSION "5.1.50"


        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
what's echo "" for in qemu-version.sh
--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000077240905ae00542f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div style=3D"color:rgb(212,212,212=
);background-color:rgb(30,30,30);font-family:Consolas,&quot;Courier New&quo=
t;,monospace;font-size:15px;line-height:20px;white-space:pre"><div><span st=
yle=3D"color:rgb(197,134,192)">#define</span><span style=3D"color:rgb(86,15=
6,214)">=C2=A0</span><span style=3D"color:rgb(86,156,214)">QEMU_PKGVERSION<=
/span><span style=3D"color:rgb(86,156,214)">=C2=A0</span><span style=3D"col=
or:rgb(206,145,120)">&quot;&quot;</span></div><div><span style=3D"color:rgb=
(197,134,192)">#define</span><span style=3D"color:rgb(86,156,214)">=C2=A0</=
span><span style=3D"color:rgb(86,156,214)">QEMU_FULL_VERSION</span><span st=
yle=3D"color:rgb(86,156,214)">=C2=A0</span><span style=3D"color:rgb(206,145=
,120)">&quot;5.1.50&quot;</span></div><br></div></div><div><br></div><div><=
div style=3D"color:rgb(212,212,212);background-color:rgb(30,30,30);font-fam=
ily:Consolas,&quot;Courier New&quot;,monospace;font-size:15px;line-height:2=
0px;white-space:pre"><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p=
kgversion=3D<span style=3D"color:rgb(206,145,120)">$(git=C2=A0describe=C2=
=A0--match=C2=A0&#39;v*&#39;=C2=A0--dirty=C2=A0</span>|<span style=3D"color=
:rgb(206,145,120)">=C2=A0</span><span style=3D"color:rgb(220,220,170)">echo=
</span><span style=3D"color:rgb(206,145,120)">=C2=A0&quot;&quot;)</span></d=
iv><div></div></div></div><div>what&#39;s echo &quot;&quot; for in=C2=A0qem=
u-version.sh</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000077240905ae00542f--

