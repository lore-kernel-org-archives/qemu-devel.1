Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4442AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87E1221F0
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqYFzUht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E1221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1Hp-0001g7-TI
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <programmingkidx@gmail.com>)
 id 1kG1Gj-0000g5-QT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:40:18 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <programmingkidx@gmail.com>)
 id 1kG1Gg-0006fb-VE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:40:17 -0400
Received: by mail-qk1-x743.google.com with SMTP id q5so2648760qkc.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=29ww3SGKNAPBtw+lpOKTs8Xle8QIiG+DG/Q1ycL357I=;
 b=IqYFzUhtHmQeEwieQzDH8+smVoewUH2wDy8PYNJDK2hHJCM7cIFlHM+L5GK/KXINsl
 ontP8i3CP3LfqNfYuA7/x0738owJif39b6y6I/+YHesexC/LpWrljnbERmvxZ0fx0lHe
 PKNZ1Wo9aaNEgiMCbtq7H0tUJzJPXd0mwJvOa2IhsnrH9spjGR/9iWaSia/6fwR4aZVP
 5ogBiY+kxSXgcSGABo0oX8sVkT+mVZre3IkdJQtMCt1ayGhs7enKOAfuwF5uruiogfNc
 CeHYUmYFp9YJy4LPpL1XIm29ZNHh1+s7RAFy7kvKmiCldovqJbmixFuM24X/m7fiH1LS
 IBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=29ww3SGKNAPBtw+lpOKTs8Xle8QIiG+DG/Q1ycL357I=;
 b=LolofNym3mCwbEeTKkeAMaKPgLpShXrWBa1jLVTwXg3k8rhEM1x7C25xhgyoswu1G/
 KOWSKqdaP4s8TNuqEV0Iu92OCk2Ogc6TuQroCU+y1NHxQw3uWiu7BRRiKcn19BBqkz+B
 R86HTNSo871gQ0wdD41XGuNr5KSLOod/omCVmC8WGej3OYCrWla5jXmJaGaVr5rDDB+E
 GDYMx/hNm8LSZMq73YMeo8ClxhnmhoXwOqncrY9z7mspc8Og535AwdjcivageT4/kbK7
 hZ/6UYSJAk2MWA/IfJQQ2ovNwYCibO7gBbzMmrG+Q+ygebX7eSrECWz8Hmc3+GysuHba
 7spg==
X-Gm-Message-State: AOAM5317t3EsnqKTgcfZWwcasK7hNdvHPhUusniP+lmlG1pL4vUY+UMG
 qr0P0wAoHTzNKhjfz8t/yHyaEjJwPco=
X-Google-Smtp-Source: ABdhPJwf9HFNA3QCYzWHiB2FISTD/4yWNL+rOrx1G/OtcKGsRgY/4RVb44f3gbY7nC8QoerCROFveQ==
X-Received: by 2002:a37:ed5:: with SMTP id 204mr3271478qko.405.1599662413407; 
 Wed, 09 Sep 2020 07:40:13 -0700 (PDT)
Received: from [192.168.0.10] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id r42sm3278612qtk.29.2020.09.09.07.40.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 07:40:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <2764135.D4k31Gy3CM@silver>
Date: Wed, 9 Sep 2020 10:40:10 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <74E8EC93-53B3-4A72-B3BD-6C1702B4DB5B@gmail.com>
References: <2764135.D4k31Gy3CM@silver>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3273)
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=programmingkidx@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Sep 9, 2020, at 8:56 AM, Christian Schoenebeck =
<qemu_oss@crudebyte.com> wrote:
>=20
> I've recently been thinking about how feasible a stripped down Xcode =
project=20
> for QEMU would be, i.e. you just get the QEMU sources, click on=20
> qemu.xcodeproj, Cmd + B, done. No extra installation, no configure, =
nothing.
>=20
> I've done this before for gtk(mm), which you might know, depends on =
approx. 24=20
> individual libraries (glib, jpeg, png, pixman, atk, gdk, cairo, =
pixman,=20
> graphene, sigcpp, ... gtk, gtkmm) that you would usually all need to =
download=20
> and
>=20
> 	./configure && make & make install
>=20
> each individually on macOS. Or right, you could alternatively "just =
install"=20
> them from Homebrew, MacPorts, Fink. But no matter which solution you =
choose,=20
> it easily ends up in a mess (conflicts, misbehaviours) on macOS to =
install=20
> libs and apps globally. And I think that's the problem why there are =
currently=20
> relatively little contribution for QEMU coming from devs on macOS. =
Because you=20
> don't want to install things globally on a macOS system, it's simply =
not=20
> working well there as it does with Linux distros.
>=20
> And the other thing is: I've tested the waters with Apple and filed a =
QEMU=20
> related macOS bug with them. The response was like expected; they =
basically=20
> said 'if there's no Xcode project, then we don't investigate it'.
>=20
> The question is, and I don't have the big picture of QEMU yet to judge =
that,=20
> how much is auto generated for QEMU i.e. with custom scripts that =
would=20
> probably destroy this plan? There are these trace calls that are auto=20=

> generated, is there more like the TCG part for instance?
>=20
> What I could imagine: a hand crafted Xcode project as a starting =
point, and if =20
> that works out, switching to auto generating that Xcode project from =
the Meson=20
> inftrastructure to avoid multiplication of maintenance effort.
>=20
> Best regards,
> Christian Schoenebeck
>=20

I think the solution to this problem is to switch over the CMake =
(https://en.wikipedia.org/wiki/CMake). It is a build system that lets =
you specify how you want to build software. There are many targets =
available including 'make' and an Xcode project file.=

