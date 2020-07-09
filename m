Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3822C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD74206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNoGiHTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD74206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYEb-0007IF-SZ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtYCB-00064f-P1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:10:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtYC3-000078-LY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:10:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id b6so2759102wrs.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=kuSk9+DnhNYFBTzGiUPWovMuQVhiElL+GUhOF6F7VeU=;
 b=sNoGiHTTObnC+p7YmrvfHp8grRFlQ4/e20afafG4XYxps6nZIo0pyrayzN1CwXP9BG
 AkcAYkOioTMmlJq86/K2q+zRv0a5gy/mhNfUUTxA+X/Bi1AalHOreNzhtO6C0srVoEco
 KOKbEZn7kwAr8r5f55AWWa44OaDd3ZGwy7ZJF/X87Ams+jpUhF0vhkMM6TfFKI14yV6M
 yUt7LXR+YM5hCTiOTKSIUJammJPv2dIOEga977NdtTL4/fXf2l+qdOnmP2KHjcDqkmBE
 zi2waJ7/UJKeCtjqgyAnWk4E0PF/5TjtfcJWNpE9RuYNEvhcgAV1zrJrAi2sdGlLNcwS
 P4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=kuSk9+DnhNYFBTzGiUPWovMuQVhiElL+GUhOF6F7VeU=;
 b=SpQWh7uZCU5VEMQkIfyRBNvEs/qv2EAj3byAumxukfklt4fiE4Tdu1f19kfBg9JgZw
 ma6KSOJpEA589a9NPUs+yYPHzIf795JLYgaHvJCNbGuACv/hdJhOwwSYHV6A8TsGG0lH
 1mjkYgj8TJXtyTV56nEF68b8C21c2DdGB3gN6S2kP2CHRRpPiT2/zifAcynBhMT1hCkj
 aUDnIvumhTIUdNficclGXwvuSmwGS1HtbjNLOPkJv6L2bXm1b5/6RikLeKJUH06DR+K2
 mZjIKWRHRhGsErXT+mwLeZGBNR99UyQHcgm8jJAUCld/GgdVABVMGSe+1G+AVBKWP0Cv
 vOtw==
X-Gm-Message-State: AOAM530g6HANaXhIglNuwUrztP9f93r5ElQtbkq+rr04MoHEkm7aaFHg
 hbXo0lhR3Zy0Cq0xYTMfZWuN511tObeadop11agBsY/vNOU=
X-Google-Smtp-Source: ABdhPJyQxe4AXhl9OWW1lzHtp5hOi/EfPMxKf6AqfXQSvj5T8FDHq3Iw+2IcjuRw7vhTlLEi1siqVNiL0QQ/iz5H6nI=
X-Received: by 2002:a5d:6202:: with SMTP id y2mr61573136wru.32.1594307432770; 
 Thu, 09 Jul 2020 08:10:32 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Jul 2020 19:10:20 +0400
Message-ID: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
Subject: Is VXHS actually maintained?
To: QEMU <qemu-devel@nongnu.org>, ashmit602@gmail.com
Content-Type: multipart/alternative; boundary="00000000000031731305aa03a04b"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x435.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000031731305aa03a04b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

VXHS block device was added ~3y ago in commit da92c3ff60b (block/vxhs.c:
Add support for a new block device type called "vxhs"), but it doesn't
compile anymore, at least since v5.0 (I haven't checked earlier).

The upstream repository (https://github.com/VeritasHyperScale/libqnio)
hasn't received any update since then.

What should we do about it?

--=20
Marc-Andr=C3=A9 Lureau

--00000000000031731305aa03a04b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>VXHS block device was ad=
ded ~3y ago in commit da92c3ff60b (block/vxhs.c: Add support for a new bloc=
k device type called &quot;vxhs&quot;), but it doesn&#39;t compile anymore,=
 at least since v5.0 (I haven&#39;t checked earlier).</div><div><br></div><=
div>The upstream repository (<a href=3D"https://github.com/VeritasHyperScal=
e/libqnio">https://github.com/VeritasHyperScale/libqnio</a>) hasn&#39;t rec=
eived any update since then.</div><div><br></div><div>What should we do abo=
ut it?<br></div><div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div></=
div>

--00000000000031731305aa03a04b--

