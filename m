Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 22:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECDF2077B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 22:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZXGUGkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECDF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipg8i-0003eZ-Ie
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 17:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipg86-0003EV-Uu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipg85-0005E1-Nx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:18:14 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipg85-00056w-Gr
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:18:13 -0500
Received: by mail-ot1-x330.google.com with SMTP id 19so45095otz.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=AFxZSxC6B9fBq/uURPhnwyKLKe/dqbnxMvmg8c5ZdP0=;
 b=LZXGUGkGSOpoFulrSw4eOIPkFd+Par0KKGM/iQF+hhSpJRdTpCVLoowFl7TcheO+40
 KPX0RYeTF40Wx2597h8twnrPG7DUz7kF+nZdUzBPKG8YRfjMxwp4mTzKTtR0zGlMxh6C
 nxdwAfSGoRQS9M5JzctXPMBmlSUwLAiDhnOyKm2YaGgU9SVGeFlGeMzaktzQ2us2i+AE
 GE/fJNkGHQhDBkUntEat9XGAfVwkfHQfVA4C1f/jcYHXcN6noADlIuQvbfFDObvxn9Wz
 46ceWxdENVUbPFAkqDbAnQe677RhsFZ05uE/A/IEVrr6swaiorQpQ1FGBiomq75adwSs
 ah0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=AFxZSxC6B9fBq/uURPhnwyKLKe/dqbnxMvmg8c5ZdP0=;
 b=CZ9RfRuG6Ir8SMIbr8g/qA47fZRKwo1gYw41mbVwW3dF2Ou1LjzDILzIBtt4GQk15G
 6/4TFiPoY/zSlCudWy+asX3NZjBAtBpMG3AS49eF5seoU4hZoiInpSRbHdWodURAylFu
 ZbgACvQtMRgBQUHOA7Imx4LPD6/l9i6RNpS33tEJYRREK5blnw3Y/d36qQOBxQGngPTh
 hCMoBGCOOiPhlnmD619wjCGCu5mOGdtm8JcibnBxkrXGiLLrHT8togbHBGAg3snaPNvv
 Q/taLs/Tc6IeYzKOgMZrYSvXHXYDd0GuXvNf4bbW98FKQIBLDnMs08PKMoLlDhVFBhlD
 V4SA==
X-Gm-Message-State: APjAAAXL/hkE4j8wI7p7bp+gp5cw2oZyroTT0c7TmeGu74BYMo2/Z2o9
 hzi7cWoux5rn5ddaH8PoXQM/3QONH/d+iG+tyxOiKA==
X-Google-Smtp-Source: APXvYqxo+8SOyymVtd8X/s5mqphIyR2GIlBNefzkqDoUnYj8whMOuDMi5mVtDhax++YdXVQIEGKDTLe6ewKL3LOfXJo=
X-Received: by 2002:a9d:5e93:: with SMTP id f19mr70121otl.121.1578608292134;
 Thu, 09 Jan 2020 14:18:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 14:18:11 -0800 (PST)
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 23:18:11 +0100
Message-ID: <CAL1e-=hubhT9DDN9Co=CafNz=3vSUtfDF=ukshOGjU7=a9BbXA@mail.gmail.com>
Subject: version 3.2 is missing from QEMU download page
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007e0345059bbc62f7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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

--0000000000007e0345059bbc62f7
Content-Type: text/plain; charset="UTF-8"

Hi all,

For some reason, QEMU download page

https://download.qemu.org

seems to contain tarballs of all QEMU versions/releases, except 3.2 and its
follow-ups. This broke up some scripts that rely on presence of all
versions on that page.

I don't know who is in charge of QEMU download page, but I would like to
ask anyone with this power to fix the absence of 3.2, if possible.

Thanks in advance,
Aleksandar

--0000000000007e0345059bbc62f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,<div><br></div><div>For some reason, QEMU download page</div><div><b=
r></div><div><a href=3D"https://download.qemu.org">https://download.qemu.or=
g</a><br></div><div><br></div><div>seems to contain tarballs of all QEMU ve=
rsions/releases, except 3.2 and its follow-ups. This broke up some scripts =
that rely on presence of all versions on that page.</div><div><br></div><di=
v>I don&#39;t know who is in charge of QEMU download page, but I would like=
 to ask anyone with this power to fix the absence of 3.2, if possible.</div=
><div><br></div><div>Thanks in advance,</div><div>Aleksandar</div>

--0000000000007e0345059bbc62f7--

