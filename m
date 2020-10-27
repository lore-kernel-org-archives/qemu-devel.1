Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A74C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C682072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bn7A9pgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C682072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXVYD-00020J-DY
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 16:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.schulz@gmx.de>)
 id 1kXVV6-0001NB-S2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 16:23:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:51097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.schulz@gmx.de>)
 id 1kXVV4-0004Du-VU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 16:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1603830200;
 bh=X592XYqYS3heXdMvTq/wp8UVSbIHHQ2mUy+CI36zdd0=;
 h=X-UI-Sender-Class:From:Subject:Date:To;
 b=bn7A9pgij1WA4hKvgbnWn3gohYd6qD7l8BqCzy/Xfr/abXmrDRtvTYOJbsRne9AhB
 +w+HjVJKIKZfxiQtsYbPhawvOVgti2qzxjWDON49fD+VVe8iuyKS4vlL9kn0Y2PVyq
 qOg70r74X5trDeEeD0Uo6dAMAMuyzIatK+TZFXM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.104] ([79.219.12.202]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1kZlbr2tYm-00FPCx for
 <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:23:20 +0100
From: Michal Schulz <michal.schulz@gmx.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: QEMU and kvm on big.LITTLE aarch64
Message-Id: <F25EAD5D-59A9-44D0-A3B3-455A725BCA14@gmx.de>
Date: Tue, 27 Oct 2020 21:23:18 +0100
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Provags-ID: V03:K1:BCPBMU0ykbsl3qeu+89eNsb2Ovca2rRyFvwkNEIx6KsncWgQKiW
 x0+RLqsW3Z2YL2fanYUcv8BAe3Z1m+bNKV1FiBqRHq+wX1savTIvGqLH6bfQjpTRlxaTrYY
 l0U9HNBnNjvDCxqK0NDK15ZfNYXnGJfF1fLrDN7+Nskm1ocr4tvIcf5FeE3qUk9ZfjlZq2x
 3fj0rXtTviPM7+vwuTlRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+LBuS3k1J+0=:qC3LWGbrw138yk/VgXIZ5b
 8Hm/IJfjAxgfUcGjROn33SAzVtj5+dsiiBYs0nCPZQRxeiU1tGy9zdywugMtw4v/bK/k36i4m
 qR8Zj+q1/Cm3MvW9tkWXn6jvKOnSE90FGnMjlfhhaFXX85j6BE2u+EusQERDGS5Jv9VFdIBWI
 rNQ+SmOTm9TnmgwIO3GzVC+AppSEQXFVVdrgXOBbgsIT446Cuy2Oh25nKaiQitJt5tdAZOJjA
 ilecU9jCpQCYDkXh1Jq8ozS0iBvZ6M8JQxHxLpdYFgt97zZZ7AL4Hm3Opvz5deorjbIGe+0kH
 6h+D+089PrZVl3WOSc9+3E8mLC52OzKAeiRlD87vhgaIOK2s+rpEyHAxvW4FGJQXgjgAVHL8K
 kMiKencM+a4SG6ld+4EAvK84hXOAmfzA42qS+AnlaQzkH6vhyu59/VpVJ9nGujHPGyu4YulP4
 dZdr0DURS7uyDeROItQyEMfgvgvs6LrdMOR+9MgZXiZ6oU+U+BEwQGTNM0h+ETb4/rfoPzjL6
 PrRC52OqV/BvKtsk3rAVzNA3YtM1WPt+Q4dxLCVsvGlfe/z4/XWwgwWJ2DJB+LnpAEup1nXbu
 Jjpkyvh0tIKhljlQSWCWdXWGuk+XpLfABuXTRSOEkhcjOGQCHZC4717eNPDH6tSdMjBHfngY3
 r3Kigfd/Oo8goA4pjjJ3Lh4Q+EH5IJ5H/zyIupyiw8wgytdXwl/oAjo8irZZufdRgcCHFsk7y
 +4BwdO3G5feWRWLmh7adG1oq5O8aex/HfG1XT+D0LV7sQQL8REfVxSqmEXQ7l+xBpvg5ab4Ob
 tVIA4mR3r7nd9NjhiZqVz9LrJIZ71TsEzVsHc3GV+tdLuHbMxjgOBzmoWRFJC6J31QTBblutJ
 /VCE6E9XwpAheFFwZxFA==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=michal.schulz@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 16:23:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dear Qemu friends!

I have been using qemu for years for low-level development of software =
(bare metal for raspberrypi or operating systems such as AROS for x86, =
x86-64, ppc). Since I am busy with my new project - a JIT translator of =
M68k running on bare metal aarch64 machines, I=E2=80=99ve started to use =
qemu-system-aarch64 heavily, especially with raspi3 emulated machine.

Recently I have attempted to to run qemu-system-aarch64, version 5.1.0, =
on an aarch64 machine. It is Pinebook Pro with RK3399 big.LITTLE SOC, =
running Manjaro linux, kernel version 5.9.1-3. When using tcg everything =
works just fine, but as slow as I would expect it. In order to give it =
some speed I=E2=80=99ve attempted to enable kvm there. Unfortunately, =
all I get is following:

# qemu-system-aarch64 -M raspi3 -enable kvm
qmeu-system-aarch64: /build/qemu/src/qemu-5.1.0/exec.c:850: =
cpu_address_space_init: Assertion `aside =3D=3D 0 || !kvm_enabled()` =
failed.

Of course, KVM is enabled in linux kernel. Please note that use of '-cpu =
host' parameter does not change anything. Also, attempt to define the =
CPU affinity for qemu using taskset tool has no influence on this =
behaviour.

Therefore a question - is it possible to use kvm on aarch64 with =
big.LITTLE architecture? Or is tcg my only possible solution there?

with best regards
Michal Schulz

--=20
Michal Schulz





