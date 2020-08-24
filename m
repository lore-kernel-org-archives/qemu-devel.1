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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C30C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853C62067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrT4AMvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853C62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJRP-000859-TQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJQf-0007CX-3E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:50:57 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:43657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAJQd-0000mB-8x
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:50:56 -0400
Received: by mail-lj1-x231.google.com with SMTP id v12so11254455ljc.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=UhGBC68iSKrBQfMoheyfE3im3aT/zJq4GMm8C+u7h7Q=;
 b=mrT4AMvEsH6nNqslfdoox0KxMdyu0tMQwIUh0ZEw97pc+M74F1QmlAeaAMBZ5B0OYm
 ydJoFav1UN/jk5Qu8DVHWvKOsQfM/zPIL9/lXIFX8poyIUi9Xa9hubZdZaV37AAQH75y
 026DrLqlUoc8mLmj6YtzMMZuvVWiUcrIghLKYV0H3en97UlwFcONVPLm7D1VgOqlRt6g
 kdw6/z9PkdKcVaXz2VLCZSoVD4dfdvy81sbWd2RUGOXjK5y7IsF+X4NvtZdhQJ0D/2n8
 MAIgtNXsBBb7czIlfeCBEqO/U4U7Vt6knHcl0wDu0JkXYaff25A4hxPoJRxW/UV+BRLu
 vWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=UhGBC68iSKrBQfMoheyfE3im3aT/zJq4GMm8C+u7h7Q=;
 b=HNpKVKuOqokqjRfccCazFwfL1NMDD4b8hSsIEo8/kZGbbXXLnLysQNDECPU4R5EtJl
 P7SgTwzLofI5Gi9htU83o98CFE4eXK7JDYxkQdL3NySKsNPDBH53vrAQF5s65kOAv1T6
 HdZh2zyx8n/JOYTdfHlX8DhxF1fjxrZCw645LAj7z0Nhj9pVMRRoyMulTXXciUbXZ2Mk
 YKAmHtdTOOX0m7ZH5vjnR+fMdvmTt/z3tY94pDPCqrcpEgnXOIS+aKROqSw/rCKN1KNA
 TmuM3tKsJuZtHU8NqjHMP27WU+kEO/aZKkgOj/VhIv3Ue44TIS8iorW/Gq8LI5rYrtQR
 buiA==
X-Gm-Message-State: AOAM532vrZSJ3X2BsN+D3ShPgQfciCOz8Uf9XrPGWAA0Fz+bvyAmnCo5
 +Lrd9ObzrkGnQobSEh4FXfbWwdp7irBELapnhkOeE1NG6VYZiA==
X-Google-Smtp-Source: ABdhPJz1JXh2Q8hZCtPbO0okTyQURXPsb6JQTzQSGRcsi7gW0MLb09OyJmSJh7oQbK+F0ml4pArvH4WuSBDPS3U/eGI=
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr3091425lji.300.1598302250639; 
 Mon, 24 Aug 2020 13:50:50 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2020 04:50:39 +0800
Message-ID: <CAE2XoE-bye0NfiXdLCRfOTrzFKmcT4HwYKrWO63pZyMbRNrJXQ@mail.gmail.com>
Subject: msys2/mingw meson building fixes
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e4a7ab05ada5bdb0"
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

--000000000000e4a7ab05ada5bdb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

--000000000000e4a7ab05ada5bdb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve create a pull request for fixes python ninja dete=
ction and usage on msys2/mingw<div>at=C2=A0

<a href=3D"https://github.com/mesonbuild/meson/pull/7637">https://github.co=
m/mesonbuild/meson/pull/7637</a>=C2=A0</div><div>=C2=A0<br></div><div><div>=
<div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo<br></div></div></div></div>

--000000000000e4a7ab05ada5bdb0--

