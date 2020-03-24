Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214FB206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mngtThy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214FB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjia-0008Q6-Af
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alia.mk345@gmail.com>) id 1jGgYp-0002s1-I2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alia.mk345@gmail.com>) id 1jGgYn-0006J2-HG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:13:27 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:34683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alia.mk345@gmail.com>)
 id 1jGgYn-0006IJ-9G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:13:25 -0400
Received: by mail-ed1-x531.google.com with SMTP id i24so20074549eds.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=AmjP5FeI1Me5y1Lbr0uS3oNCTYzFG2rgjTcNdGd76os=;
 b=mngtThy7TKdDEdOZD6gPiDN1pijZ78I864kuELlM3S5d83tiSgOUC32Tm74T177x0N
 723y4F73aSnfmg2inljVkF8DRaRTmF3EmfdlRIU0UxbDPvYgVjbeVV/7FMWYhs7/vfVL
 JQgPSfoEVjah5dqS5gvezMDu2J96cp1KSumZLW4aOaQ8f0HGKfe9ncCeSFuIycq7rgEh
 wdxkvbAYZNyI6QZwi4N2FwZiA3at0uRlCaAWHc2gdfLvpXagGgc92YeqOZKSu54eQEkn
 6Y0tf/72mqHZAMa47IUvw5bU+eRjtIQfkC31ffEtcVUdTcu7D8rHmGoKQk1VjI6MhOP/
 GfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=AmjP5FeI1Me5y1Lbr0uS3oNCTYzFG2rgjTcNdGd76os=;
 b=lVKBk+BmyYrgEuBrk9Ebc/9e9boHtb/cZXPsBY2DrwY7ENHWALCcBPvE/g8WdmUJPO
 MKc5Z1Etmzx3Wr4qFe8icF6tcWltuBruIaLfFmbB6sfh2gxZhuXRCgLAJXEtrGNKV6hs
 Kju/SzbWSgmWdSVV19639W9nqV6ehobwug+vYtMuun5zYKHlQtNF/ztj37UsmQEJRnOb
 UH73t83HEgH5N+oJTkWPMycbZqIb0nqN+QGXIzn9ZzdNInGVDiD+0kRJ4G7mgQU26gF9
 w/3dRpKk3i+Sxw0Bwp6sdN3/ol2Z0JEduCYXbYbUnkzVqryB7o0N90bOFL9aLy2Y+s6b
 ML/A==
X-Gm-Message-State: ANhLgQ3SNjYm8RXkqCOpACPgAosEwBhrGYamh3EKjFO5SGarCF+Nh4/R
 lqULdpUm3Lw/4HmyiYXOuktHteQVHvAhO90HFC/tBK9V/j0=
X-Google-Smtp-Source: ADFU+vtrqgxyF4zdJRrsPwF4v9ikKyq7JozSrYFbedcnVIOCT+zdtWEPseM8XNClgp0MA4z5vLF9K2SWEiNWrLKtOS4=
X-Received: by 2002:aa7:c607:: with SMTP id h7mr9295850edq.73.1585044803016;
 Tue, 24 Mar 2020 03:13:23 -0700 (PDT)
MIME-Version: 1.0
From: Chained Up <alia.mk345@gmail.com>
Date: Tue, 24 Mar 2020 12:13:03 +0200
Message-ID: <CAEwvOcF7==uOdEJoQpNh1-wE44nJqWJLFP93yK0dHEUA38EXKQ@mail.gmail.com>
Subject: Help
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006fda0b05a19700a4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::531
X-Mailman-Approved-At: Tue, 24 Mar 2020 09:34:06 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006fda0b05a19700a4
Content-Type: text/plain; charset="UTF-8"

Please can some explain what should i do here?
 Prepare import-libraries using Borland's implib program.  The ".lib"
    files that it uses are a different format than the import libraries
    distributed with GnuWin2.  From Lynx's source directory run bcblibs

Environment:
    At this point, the bin-directory for the compiler and for the GnuWin32
    libraries should be in your path.

Building:
    From Lynx's source directory
cd src\chrtrans
makew32 clean
makew32
cd ..\..
makew32 clean
makew32

--0000000000006fda0b05a19700a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please can some explain what should i do here?</div>=
=C2=A0Prepare import-libraries using Borland&#39;s implib program.=C2=A0 Th=
e &quot;.lib&quot;<br>=C2=A0 =C2=A0 files that it uses are a different form=
at than the import libraries<br>=C2=A0 =C2=A0 distributed with GnuWin2.=C2=
=A0 From Lynx&#39;s source directory run bcblibs<br><br>Environment:<br>=C2=
=A0 =C2=A0 At this point, the bin-directory for the compiler and for the Gn=
uWin32<br>=C2=A0 =C2=A0 libraries should be in your path.<br><br>Building:<=
br>=C2=A0 =C2=A0 From Lynx&#39;s source directory<br>	cd src\chrtrans<br>	m=
akew32 clean<br>	makew32<br>	cd ..\..<br>	makew32 clean<br>	makew32<br></di=
v>

--0000000000006fda0b05a19700a4--

