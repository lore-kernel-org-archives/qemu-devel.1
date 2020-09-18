Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65372C43466
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EF9235FA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAmDs71c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EF9235FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGPp-0006MT-JP
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kJGOo-0005mu-RE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:26:02 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:38226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kJGOm-00028l-I2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:26:02 -0400
Received: by mail-ej1-x62b.google.com with SMTP id i22so8122204eja.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=nUjycm4YWbaYGbBMx/i8bMMu0mnTF+sfmJsXtnRmGEc=;
 b=NAmDs71crVgvZ1greND7PAPX6Qu0bz3B/gOV+nAa4SDSZzM1rbwpMs1ksOG1JK7mks
 ff/BW4ZvNzWa1RQt50wHO/UNMQLJoZ1WU3v1jDEKu1hMhjrrluqgL5xxuCeJhDOTo38r
 xAvckkS/O2Vgr8LBXdaDtHJSSmTi7tU9AABgO1uzn9WEFgSynXyKhz/0XgztDAyxCOuJ
 jPtEvGcV5ZCWeN2o3TRpsaFjXmG7rC6+Hc8oxnMeKXmO5X1ZCFcKcx8yhMWi/5+NyMbb
 o2WIXBeJ1QlxwHnz2OGBZetfCy8V9XfY0k4o4wDdSJE8C77z99zbwag7i0UJClkTXbw2
 mmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=nUjycm4YWbaYGbBMx/i8bMMu0mnTF+sfmJsXtnRmGEc=;
 b=Zhv3fplBfov4e4jgD2E5yOEp3al1YZZx5LLurWKqpGB/q9Ul8TmVQG5uQondyQ4Xel
 gdA8MRep1/6w1OHfXxNeWFzFPB93znwGdCZPhbKFJFS/KFAX8N8DGCylKe3+4zrwUZx9
 EC/tHwMOdQBna3zfOPItCYDDs8lrM5O1s4+S0ntgbZEyh6oLeM22sEyS2mkeaVKpF9tn
 kLtgrr9mg815p76hjrG0jw61pi61oOreYTTxehbJTlfo5IAOh8Qc1qUVIrfGrZXMH/si
 J32vz3pbAWL5fW2YT+uoz/51L79T9caxdin2f3UQrPibH+CpRQDyFCcSEUYDiMTF+A+B
 9/aA==
X-Gm-Message-State: AOAM533QJQ1uXMOO72+rFenh1Zy0c8dDWgFG/kRzyeXpiqcQPjLlK+6P
 f4k5/IveROSPGsALQ7Gpmbj0w9Sn5Wk7q+s7u2QTVIt4YpnFLA==
X-Google-Smtp-Source: ABdhPJzx7a45XzfuN9ivxO/pCvXuk1sow+WIPwSE9FKbQ7ZK9BnShMUrjaIO0mZRQUdG8s3UL6P6CX8KzjE8HHyJjog=
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr35387741ejb.527.1600435556911; 
 Fri, 18 Sep 2020 06:25:56 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Sep 2020 17:25:45 +0400
Message-ID: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
Subject: Deprecating --enable-gprof?
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000db10b505af967045"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62b.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000db10b505af967045
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

configure has --enable-gprof since its creation, but is it actually being
used, or is it sporadic enough that we could deprecate it?

I have some reason to believe that it's not used much:
- --enable-gprof only enables -p, which is prof (not gprof!)
- nowadays there are better profiling tools, such as perf

Should we fix it to use gprof instead? Or does anyone actually care about
it?

It is problematic as the flag is passed to meson globally
(add_project_arguments), but some targets may not support it. I have
pending patches for pc-bios/* roms. And we can't remove the flag for those
easily (not as easily as if it was supported by meson, like coverage)

I would propose to deprecate it on the configure options. A user can always
override the cflags manually to provide -p option if he really needs it.
Alternatively, I could work on getting support in meson (
https://github.com/mesonbuild/meson/issues/3659), but this would bump our
meson dependency more.

What do you think?

--=20
Marc-Andr=C3=A9 Lureau

--000000000000db10b505af967045
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div>configure has --enable-gp=
rof since its creation, but is it actually being used, or is it sporadic en=
ough that we could deprecate it?</div><div><br></div><div>I have some reaso=
n to believe that it&#39;s not used much:</div><div>- --enable-gprof only e=
nables -p, which is prof (not gprof!)</div><div>- nowadays there are better=
 profiling tools, such as perf<br></div><div><br></div><div><div>Should we =
fix it to use gprof instead? Or does anyone actually care about it?<br></di=
v><div><br></div><div>It is problematic as the flag is passed to meson glob=
ally (add_project_arguments), but some targets may not support it. I have p=
ending patches for pc-bios/* roms. And we can&#39;t remove the flag for tho=
se easily (not as easily as if it was supported by meson, like coverage)</d=
iv><div><br></div><div>I would propose to deprecate it on the configure opt=
ions. A user can always override the cflags manually to provide -p option i=
f he really needs it. Alternatively, I could work on getting support in mes=
on (<a href=3D"https://github.com/mesonbuild/meson/issues/3659">https://git=
hub.com/mesonbuild/meson/issues/3659</a>), but this would bump our meson de=
pendency more.</div><div><br></div><div>What do you think?<br></div><br>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature">Marc-Andr=C3=A9 Lureau<br></div></div></div>

--000000000000db10b505af967045--

