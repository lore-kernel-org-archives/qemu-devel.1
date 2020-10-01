Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6047C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1020739
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dcomp-ufs-br.20150623.gappssmtp.com header.i=@dcomp-ufs-br.20150623.gappssmtp.com header.b="iwdGP1m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1020739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dcomp.ufs.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5GU-0006Ba-8T
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kO3Bb-00048D-GM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:20:11 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:34235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kO3BZ-0002WD-30
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:20:11 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id o20so1737005ook.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dcomp-ufs-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=xRpi/SLAOr5/jfyMH0LPVLexqnJ/F0iFg0GDKdiDpWs=;
 b=iwdGP1m+DFUfROSsQtXcYZrYfRp0QIC4xiOOTVnOi4EhASGL55tq/XNKb+QAlyNwBb
 vjd9dRFvQp4sqqyugqXD0tAJ83mKz3Ghg+EJCLr7xnrE3TFRJTsTLD8i3JwIjr8jArEX
 AJt94iqTXnjF8W3uBzKU9dWyrTgmODV6AhYYMfosck4lQe6zEwEgzuIH6+pnoI1CXQee
 qkvLuQd5Hh3DD+Vn0fpl2Lve7PSrt86ez9w7R5TaBxoweGDVsW9d/QnY2h10MM4uIXMu
 vNopsfeMUJLGJVJy0QT+NIGrY1Mc0hPpcDYbuZnG8Lyo+Fz94b4VnU3vTwPstnhZsLz0
 UdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xRpi/SLAOr5/jfyMH0LPVLexqnJ/F0iFg0GDKdiDpWs=;
 b=IGjqfX1A8JuysVpGbu+j6iE772M/5eZnjO780HmNs6zI0DsntAcUNFOxB2PpZWF9Rw
 TP1VcMdcOq2svVNEXty1PLH58pOC/9q0qqCjxFm/BOtPLb0+pENMkIF5VP0hd6d0D7oR
 0qi2l+waMH9XI1cjSxTBavplv2qKZKTzj+20+Y6hJEqYNoG17LQWZUtKgjFfDlTWPGrj
 7P/gEK4ZUOxuKnAiMWNmg/Lni/PKcxyedUAJO3IZE6uI/KuqQXfkWt9UVVe+sCZHnTQz
 TdCedzUWlA+cXjrF3QmB3Cb3QxVWPWHeGJrhzWrQv+G4JTr3GqVXIpujWH4LUcAWo3ZC
 ms2Q==
X-Gm-Message-State: AOAM533VbnobIOZdQZJ6/DNFfPg8EtccF8d6WkzPm53l18+bamQR43bz
 TajNJ3YBKxY2C3pzKOdEX63ff2H+r6yrtPdkmnmRVYOO
X-Google-Smtp-Source: ABdhPJxLZA1F+vHxfU4bgY3dK+3bVGvu4y7l5II9IsxKq9CBt7dgZAolJxaXWutq6kuMtuUELoeSSrN4XQd/avyDpIc=
X-Received: by 2002:a4a:b30d:: with SMTP id m13mr6459830ooo.50.1601576407420; 
 Thu, 01 Oct 2020 11:20:07 -0700 (PDT)
MIME-Version: 1.0
From: Bruno Prado <bruno@dcomp.ufs.br>
Date: Thu, 1 Oct 2020 15:19:31 -0300
Message-ID: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
Subject: ARM semihosting issue
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d8546e05b0a0106f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=bruno.otavio@gmail.com; helo=mail-oo1-xc2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Oct 2020 16:32:00 -0400
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

--000000000000d8546e05b0a0106f
Content-Type: text/plain; charset="UTF-8"

Hi,

I was able to use stdout, stderr for output and files for both input and
output in qemu-system-arm, but stdin is not working (always returns -1 from
syscall). I found no information and have already checked the code for
possible hints.

I am on Arch Linux LTS + QEMU 5.1.0.

Thanks,
----
Bruno Prado

--000000000000d8546e05b0a0106f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I was able to use stdout, stderr fo=
r output and files for both input and output in qemu-system-arm, but stdin =
is not working (always returns -1 from syscall). I found no information and=
 have already checked the code for possible hints.</div><div><br></div><div=
>I am on Arch Linux LTS=C2=A0+ QEMU 5.1.0.</div><div><br></div><div>Thanks,=
<br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smar=
tmail=3D"gmail_signature">----<br>Bruno Prado</div></div></div></div>

--000000000000d8546e05b0a0106f--

