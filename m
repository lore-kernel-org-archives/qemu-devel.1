Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22963C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 20:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC37820707
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uudemOd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC37820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpH8H-00031F-5y
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 16:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mailinh270704@gmail.com>)
 id 1jpH7d-0002Vs-Jg
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 16:08:21 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29]:33346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mailinh270704@gmail.com>)
 id 1jpH7b-0006Q4-5F
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 16:08:21 -0400
Received: by mail-vk1-xa29.google.com with SMTP id r7so2938284vkf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Qh4bNAg0HkKjljiIqIQDwN0JxjodVFNxfymUY2l1YW0=;
 b=uudemOd28uugmQYo6HtjbGpUfMMr5BSLC0MjTuZOBdyCVlwF0EXzjnsgLCDnXmzDYL
 E0a6yeSW+9xhu3H9aY8EbPayCQB5LwnTyig3HhYzysz/dzp5ogbL56wjVxy6re7U7vlJ
 YvCH9nVkwiMFW3Q69aAHEWCWCNYVTcVGhnNE7UXfFrjk69jttY9jrWC+8MqHEtGy6MzH
 QHE1Mf5Hpi2hW5ztBtqrrOT/tVnoRTYwM6PABaEhL9LF1D1mZY7DoC8xO460cV5ZpZOl
 VbkwsAYWYJ3k+x28egS9uWqj7nEkMvjPGqFHuMKYY0o50bF2twpDnCRQYNKOfhKx2tPn
 LzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Qh4bNAg0HkKjljiIqIQDwN0JxjodVFNxfymUY2l1YW0=;
 b=CNxtkGdm2fITeAklTso/PMd3xIeaVu69njUcD1VFmcAxsQ8cW0DD32UfoixZoX6LOZ
 SOgFtp4/nC+x1Fma4V4chpDEqj6XhNOx3xzsyEvxHpIrfsSHthY+wF4jvitGaakUvxaX
 2kE0jjfG9S3g9eBmxQYzZEn24EvmdQTEA18B2XvLm6ACSelLuXqX6uLxnx0CdwmRSsnc
 rCACIDTH0XjXjiYgxJeiWsrlfmFlCP9bnzJeX4JnSF9/UTPxUxPyKkviIt3iEqrHgjGj
 eT/Zohb36eO2L+959ttl2gF1fTn3QOpgBd02ZOzbm1HaG0b6Z4m42AonnH/d/VY3hX5m
 ezmg==
X-Gm-Message-State: AOAM53258JIdTXBamWzjPvQbU4T+MexB5/Rzx3tcYorZQeZ51kH8WPr9
 DgOCXbrIjkO93PeZ512BVryve2aUrAb52IYt78oY2MRC
X-Google-Smtp-Source: ABdhPJwFoJyoJVNh6bcs5GPYsl5NXB5Oi9igRHTpmxr4WFrHssSqGV7V/oiV1OqUaJQxxMYnSMPzVWsRUgk3ek090NU=
X-Received: by 2002:a1f:974d:: with SMTP id z74mr6042564vkd.40.1593288496951; 
 Sat, 27 Jun 2020 13:08:16 -0700 (PDT)
MIME-Version: 1.0
From: nguyen linh mai <mailinh270704@gmail.com>
Date: Sun, 28 Jun 2020 04:08:06 +0800
Message-ID: <CAGiUd1FE2BqRD8i+W61cemz5Kbe8madH4cgbN_-yA5jEkSQS9g@mail.gmail.com>
Subject: How Qemu TCG optimize memory read?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e2b22305a9166247"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=mailinh270704@gmail.com; helo=mail-vk1-xa29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e2b22305a9166247
Content-Type: text/plain; charset="UTF-8"

Hi,

Looking at how Qemu TCG handle "pop rax" instruction on x64, which read
from stack memory, I found that the code in load_helper() in
accel/tcg/cputlb.c is never exercised.

I guess the reason is that TCG try to avoid "trivial" memory access by
optimizing memory read, perhaps by directly reading memory, thus does not
go through this function. But after spending so much time looking at the
code, I cannot find where TCG does this optimization. Any pointer, please?

My motivation is to instrument all memory read, so I want to avoid this
optimization. I can see that Qemu 5 plugin can do this, but I dont see some
information like data size (of reading). So I may hack the plugin code a
bit. Or there is a better solution?

Thanks a lot.
Mai

--000000000000e2b22305a9166247
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>L=
ooking at how Qemu TCG handle &quot;pop rax&quot; instruction on x64, which=
=C2=A0read from stack memory, I found that the code in=C2=A0load_helper() i=
n accel/tcg/cputlb.c is never exercised.=C2=A0</div><div><br></div><div>I g=
uess the reason is that TCG try=C2=A0to avoid &quot;trivial&quot; memory ac=
cess by optimizing memory read, perhaps by directly reading memory, thus do=
es not go through this function. But after spending so much time looking at=
 the code, I cannot find where=C2=A0TCG does this optimization.=C2=A0Any po=
inter, please?</div><div><br></div><div>My motivation is to instrument all =
memory read, so I want to avoid this optimization. I can=C2=A0see that=C2=
=A0Qemu 5 plugin can do this, but I dont see some information like data siz=
e (of reading). So I may=C2=A0hack the plugin code a bit. Or there=C2=A0is=
=C2=A0a better solution?</div><div><br></div><div>Thanks a lot.</div><div>M=
ai</div><div></div></div></div></div>

--000000000000e2b22305a9166247--

