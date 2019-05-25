Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52AC07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 21:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6832075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 21:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6832075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46464 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUe1u-0003E4-5m
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 17:16:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUe10-0002u9-Qa
	for qemu-devel@nongnu.org; Sat, 25 May 2019 17:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUe0w-0001zo-VI
	for qemu-devel@nongnu.org; Sat, 25 May 2019 17:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hUe0w-0001xU-Az
	for qemu-devel@nongnu.org; Sat, 25 May 2019 17:15:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hUe0s-0000LD-GI
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 21:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 737A02E80C8
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 21:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 May 2019 21:08:08 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc64
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ivmn
X-Launchpad-Bug-Reporter: Ivan Warren (ivmn)
X-Launchpad-Bug-Modifier: Ivan Warren (ivmn)
References: <155831074982.26912.13291059176555697592.malonedeb@soybean.canonical.com>
Message-Id: <155881848856.8711.2443134354991635308.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c57c2c008f475541813b1fbb64cc5693e318186a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829682] Re: QEMU PPC SYSTEM regression - 3.1.0
 and GIT - Fail to boot AIX
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Ivan Warren via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Bug 1829682 <1829682@bugs.launchpad.net>
Cc: Ivan Warren <ivan@vmfacility.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Got gdb for ppc64 to work and connect to qemu... Here is what I am
getting when doing a "info all-registers"

r0             0x0      0
r1             0xf1000816b0036890       17365889056675948688
r2             0x32b5d20        53173536
r3             0x3380000        54001664
r4             0x2dc3838        47986744
r5             0xf1000816b0036cf0       17365889056675949808
r6             0xf00000002ff47600       17293822569907254784
r7             0x1007   4103
r8             0x1000   4096
r9             0x0      0
r10            0x0      0
r11            0x424d2061       1112350817
r12            0x3282600        52962816
r13            0x25933f0        39400432
r14            0x2743408        41169928
r15            0x3380000        54001664
r16            0xf1000816b0036d00       17365889056675949824
r17            0x36000  221184
r18            0x2004324        33571620
r19            0xf10008008012c000       17365888961382367232
r20            0xf10008008      64692977672
r21            0x0      0
r22            0x2dc3708        47986440
r23            0xf10008008012bff8       17365888961382367224
r24            0x0      0
r25            0x34e0   13536
r26            0x0      0
r27            0x1      1
r28            0x0      0
r29            0x2743408        41169928
r30            0x2079498        34051224
r31            0x25933f0        39400432
f0             0        (raw 0x0000000000000000)
f1             0        (raw 0x0000000000000000)
f2             0        (raw 0x0000000000000000)
f3             0        (raw 0x0000000000000000)
f4             0        (raw 0x0000000000000000)
f5             0        (raw 0x0000000000000000)
f6             0        (raw 0x0000000000000000)
f7             0        (raw 0x0000000000000000)
f8             0        (raw 0x0000000000000000)
f9             0        (raw 0x0000000000000000)
f10            0        (raw 0x0000000000000000)
f11            0        (raw 0x0000000000000000)
f12            0        (raw 0x0000000000000000)
f13            0        (raw 0x0000000000000000)
f14            0        (raw 0x0000000000000000)
f15            0        (raw 0x0000000000000000)
f16            0        (raw 0x0000000000000000)
f17            0        (raw 0x0000000000000000)
f18            0        (raw 0x0000000000000000)
f19            0        (raw 0x0000000000000000)
f20            0        (raw 0x0000000000000000)
f21            0        (raw 0x0000000000000000)
f22            0        (raw 0x0000000000000000)
f23            0        (raw 0x0000000000000000)
f24            0        (raw 0x0000000000000000)
f25            0        (raw 0x0000000000000000)
f26            0        (raw 0x0000000000000000)
f27            0        (raw 0x0000000000000000)
f28            0        (raw 0x0000000000000000)
f29            0        (raw 0x0000000000000000)
f30            0        (raw 0x0000000000000000)
f31            0        (raw 0x0000000000000000)
pc             0x8f418  0x8f418
msr            0x8000000000001032       9223372036854779954
cr             0x22422280       574759552
lr             0x234e38 0x234e38
ctr            0x256b20 2452256
xer            0x10     16
fpscr          0x0      0
vr0            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr1            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr2            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr3            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr4            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr5            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr6            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr7            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr8            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr9            {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr10           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr11           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr12           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr13           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr14           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr15           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr16           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr17           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr18           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr19           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr20           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr21           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr22           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr23           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr24           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr25           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr26           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr27           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr28           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr29           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr30           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vr31           {uint128 =3D 0x00000000000000000000000000000000, v4_float =
=3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, 0x0, 0x0}, v8_int16 =3D {=
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =3D {0x0 <repeats 16 time=
s>}}
vscr           0x10000  65536
vrsave         0x0      0
xer            0x0      0
lr             0x0      0
ctr            0x0      0
uamr           0x0      0
spr_dscr       0x0      0
dsisr          0x40000000       1073741824
dar            0xf10008008012c000       -1080855112327184384
decr           0x0      0
srr0           0xad0088 11337864
srr1           0x8000000000001032       -9223372036854771662
spr_cfar       0x0      0
amr            0x0      0
acop           0x0      0
pid            0x0      0
iamr           0x0      0
tfhar          0x0      0
tfiar          0x0      0
texasr         0x0      0
texasru        0x0      0
spr_uctrl      0x0      0
tidr           0x0      0
spr_ctrl       0x1      1
fscr           0x0      0
uamor          0x0      0
pspb           0x0      0
dawr           0x0      0
rpr            0x103070f1f3f    1112514961215
ciabr          0x0      0
dawrx          0x0      0
hfscr          0x0      0
vrsave         0x0      0
usprg3         0x0      0
tbl            0x0      0
tbu            0x0      0
sprg0          0x3380000        54001664
sprg1          0xf1000816b0036d00       -1080855017033601792
sprg2          0x2e22280        48374400
sprg3          0x100000000      4294967296
ear            0x0      0
tbl            0x0      0
tbu            0x0      0
pvr            0x4e1200 5116416
hsprg0         0x0      0
hsprg1         0x0      0
hdsisr         0x0      0
hdar           0x0      0
spurr          0x0      0
purr           0x0      0
hdec           0x0      0
rmor           0x0      0
hrmor          0x0      0
hsrr0          0x0      0
hsrr1          0x0      0
mmcrh          0x0      0
tfmr           0x0      0
lpcr           0x403f008        67366920
lpidr          0x0      0
hmer           0x0      0
hmeer          0x0      0
pcr            0x0      0
amor           0xffffffffffffffff       -1
tir            0x0      0
ptcr           0x0      0
usier          0x0      0
ummcr2         0x0      0
ummcra         0x0      0
upmc1          0x0      0
upmc2          0x0      0
upmc3          0x0      0
upmc4          0x0      0
upmc5          0x0      0
upmc6          0x0      0
ummcr0         0x0      0
usiar          0x0      0
usdar          0x0      0
ummcr1         0x0      0
sier           0x0      0
mmcr2          0x0      0
mmcra          0x0      0
pmc1           0x0      0
pmc2           0x0      0
pmc3           0x0      0
pmc4           0x0      0
pmc5           0x0      0
pmc6           0x0      0
mmcr0          0x0      0
siar           0x0      0
sdar           0x0      0
mmcr1          0x0      0
bescrs         0x0      0
bescrsu        0x0      0
bescrr         0x0      0
bescrru        0x0      0
ebbhr          0x0      0
ebbrr          0x0      0
bescr          0x0      0
tar            0x0      0
ic             0x0      0
vtb            0x0      0
mmcrc          0x0      0
psscr          0x0      0
tacr           0x0      0
tcscr          0x0      0
csigr          0x0      0
spmc1          0x0      0
spmc2          0x0      0
mmcrs          0x0      0
wort           0x0      0
ppr            0x0      0
tscr           0x0      0
hid0           0x0      0
pir            0x0      0
dl0            0E-6176  (raw 0x00000000000000000000000000000000)
dl1            0E-6176  (raw 0x00000000000000000000000000000000)
dl2            0E-6176  (raw 0x00000000000000000000000000000000)
dl3            0E-6176  (raw 0x00000000000000000000000000000000)
dl4            0E-6176  (raw 0x00000000000000000000000000000000)
dl5            0E-6176  (raw 0x00000000000000000000000000000000)
dl6            0E-6176  (raw 0x00000000000000000000000000000000)
dl7            0E-6176  (raw 0x00000000000000000000000000000000)
dl8            0E-6176  (raw 0x00000000000000000000000000000000)
dl9            0E-6176  (raw 0x00000000000000000000000000000000)
dl10           0E-6176  (raw 0x00000000000000000000000000000000)
dl11           0E-6176  (raw 0x00000000000000000000000000000000)
dl12           0E-6176  (raw 0x00000000000000000000000000000000)
dl13           0E-6176  (raw 0x00000000000000000000000000000000)
dl14           0E-6176  (raw 0x00000000000000000000000000000000)
dl15           0E-6176  (raw 0x00000000000000000000000000000000)
vs0            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs1            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs2            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs3            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs4            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs5            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs6            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs7            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int1
    0x0 <repeats 16 times>}}
vs8            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs9            {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs10           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs11           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs12           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs13           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs14           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs15           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs16           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs17           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs18           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs19           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs20           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs21           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs22           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs23           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs24           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs25           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs26           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs27           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs28           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs29           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs30           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs31           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs32           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs33           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs34           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs35           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs36           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs37           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs38           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs39           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs40           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs41           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs42           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs43           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs44           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs45           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs46           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs47           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs48           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs49           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs50           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs51           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs52           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs53           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs54           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs55           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs56           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs57           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs58           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs59           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs60           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs61           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs62           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
vs63           {uint128 =3D 0x00000000000000000000000000000000, v2_double =
=3D {0x0, 0x0}, v4_float =3D {0x0, 0x0, 0x0, 0x0}, v4_int32 =3D {0x0, 0x0, =
0x0, 0x0}, v8_int16 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, v16_int8 =
=3D {
    0x0 <repeats 16 times>}}
f32            0        (raw 0x0000000000000000)
f33            0        (raw 0x0000000000000000)
f34            0        (raw 0x0000000000000000)
f35            0        (raw 0x0000000000000000)
f36            0        (raw 0x0000000000000000)
f37            0        (raw 0x0000000000000000)
f38            0        (raw 0x0000000000000000)
f39            0        (raw 0x0000000000000000)
f40            0        (raw 0x0000000000000000)
f41            0        (raw 0x0000000000000000)
f42            0        (raw 0x0000000000000000)
f43            0        (raw 0x0000000000000000)
f44            0        (raw 0x0000000000000000)
f45            0        (raw 0x0000000000000000)
f46            0        (raw 0x0000000000000000)
f47            0        (raw 0x0000000000000000)
f48            0        (raw 0x0000000000000000)
f49            0        (raw 0x0000000000000000)
f50            0        (raw 0x0000000000000000)
f51            0        (raw 0x0000000000000000)
f52            0        (raw 0x0000000000000000)
f53            0        (raw 0x0000000000000000)
f54            0        (raw 0x0000000000000000)
f55            0        (raw 0x0000000000000000)
f56            0        (raw 0x0000000000000000)
f57            0        (raw 0x0000000000000000)
f58            0        (raw 0x0000000000000000)
f59            0        (raw 0x0000000000000000)
f60            0        (raw 0x0000000000000000)
f61            0        (raw 0x0000000000000000)
f62            0        (raw 0x0000000000000000)
f63            0        (raw 0x0000000000000000)

(gdb) where
#0  0x000000000008f418 in ?? ()
#1  0x0000000000234e38 in ?? ()
#2  0x0000000000234e38 in ?? ()
(gdb) x 0x000000000008f418
0x8f418:        0x80061830
(gdb) x/i 0x000000000008f418
=3D> 0x8f418:     lwz     r0,6192(r6)
(gdb)
(gdb) x 0xf00000002ff47600
0xf00000002ff47600:     Cannot access memory at address 0xf00000002ff47600
(gdb)
(gdb) x 0xf00000002ff48e30 (r6+0x1830)
   0xf00000002ff48e30:  Cannot access memory at address 0xf00000002ff48e30
(gdb)

*************************

Note again, this works under 3.1.0

--Ivan

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829682

Title:
  QEMU PPC SYSTEM regression - 3.1.0 and GIT - Fail to boot AIX

Status in QEMU:
  New

Bug description:
  Built from source on a debian system

  Linux db08 4.9.0-8-amd64 #1 SMP Debian 4.9.130-2 (2018-10-27) x86_64 GNU/=
Linux
  gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)

  Last git commit (from queued gdibson repository)

  starting AIX 7.2 TL 2 SP 2 with the following : (the install was done
  under qemu 3.1.0)

  qemu-system-ppc64 -M pseries \
      -cpu power7 \
      -cdrom AIX_v7.2_Install_7200-02-02-1806_DVD_1_of_2_32018.iso \
      -net nic \
      -net tap,ifname=3Dtap2,script=3Dno \
      -drive file=3DDISK1.IMG,if=3Dnone,id=3Ddrive-virtio-disk0 \
      -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virti=
o-disk0 \
      -m 4G \
      -serial stdio \
      -monitor unix:ms,server,nowait \
      -accel tcg \
      -k fr \
      -nographic \
      -prom-env input-device=3D/vdevice/vty@71000000 \
      -prom-env output-device=3D/vdevice/vty@71000000 \
      -prom-env diag-switch?=3Dfalse \
      -prom-env boot-command=3D"boot /pci@800000020000000/scsi@2/disk@10000=
0000000000 -s verbose"

  Yields this :

  =

  ^M
  SLOF^[[0m^[[?25l ********************************************************=
**************^M
  ^[[1mQEMU Starting^M
  ^[[0m Build Date =3D Jan 14 2019 18:00:39^M
   FW Version =3D git-a5b428e1c1eae703^M
   Press "s" to enter Open Firmware.^M^M
  ^M^M
  ^[[0m^[[?25hC0000^MC0100^MC0120^MC0140^MC0200^MC0240^MC0260^MC02E0^MC0300=
^MC0320^MC0340^MC0360^MC0370^MC0380^MC0371^MC0372^MC0373^MC0374^MC03F0^MC04=
00^MC0480^MC04C0^MC04D0^MC0500^MPopulating /vdevice methods^M
  Populating /vdevice/vty@71000000^M
  Populating /vdevice/nvram@71000001^M
  Populating /vdevice/l-lan@71000002^M
  Populating /vdevice/v-scsi@71000003^M
         SCSI: Looking for devices^M
            8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"^M
  C05A0^MPopulating /pci@800000020000000^M
                       00 0000 (D) : 1234 1111    qemu vga^M
                       00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]^M
                       00 1000 (D) : 1af4 1004    virtio [ scsi ]^M
  Populating /pci@800000020000000/scsi@2^M
         SCSI: Looking for devices^M
            100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"^M
  C0600^MC06C0^MC0700^MC0800^MC0880^MC0890^MC08A0^MC08A8^MInstalling QEMU f=
b^M
  ^M
  ^M
  ^M
  C08B0^MScanning USB ^M
    XHCI: Initializing^M
      USB Keyboard ^M
      USB mouse ^M
  C08C0^MC08D0^MNo console specified using screen & keyboard^M
  User selected input-device console: /vdevice/vty@71000000^M
  User selected output-device console: /vdevice/vty@71000000^M
  C08E0^MC08E8^MC08FF^M     ^M
    Welcome to Open Firmware^M
  ^M
    Copyright (c) 2004, 2017 IBM Corporation All rights reserved.^M
    This program and the accompanying materials are made available^M
    under the terms of the BSD License available at^M
    http://www.opensource.org/licenses/bsd-license.php^M
  ^M
  ^M
  Trying to load: -s verbose from: /pci@800000020000000/scsi@2/disk@1000000=
00000000 ...   Successfully loaded^M
  ^M
                          ---> qemu,pseries detected <---^M
  ^M
  ^M
  ^M
  ^M
  ^M
  ^M
  ^M
  -------------------------------------------------------------------------=
------^M
                                  Welcome to AIX.^M
                     boot image timestamp: 05:56:13 04/20/2019^M
          processor count: 1;  memory size: 4096MB;  kernel size: 38426884^M
           boot device: /pci@800000020000000/scsi@2/disk@100000000000000^M
  ^M
  8000FFEC bytes of free memory remain at address 7FFF0014^M
  load address: 0x00004000   aixmon size: 0x000D2C00   boot image size: 0x0=
1A6B430^M
  ^LAIX vm,uuid property contains invalid data^Mload address: 0x00004000   =
aixmon size: 0x000D2C00   boot image size: 0x01A6B430^M
  ^LAIX vm,uuid property contains invalid data^M
  get_ppp return code: 0xFFFFFFFE^M
  ^M
  AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot a=
rgument^M
  The temporary memory region list is at 1 percent capacity.^M
  The temporary IPLCB is at 1 percent capacity.^M
  The IPLCB address is 0x0FFF9000^M
  name                 offset           size^M
  ipl_cb_and_bit_map 00000000 ......00005958^M
  bit_map........... 00000790 ......00000006^M
  ipl_info.......... 000001C8 ......00000024^M
  splpar_info....... 000001EC ......00000048^M
  system_info....... 00000234 ......000000C4^M
  processor_info.... 000002F8 ......00000148^M
  lpar_id_info...... 00000440 ......00000088^M
  dr_proc_info...... 000004C8 ......00000008^M
  dr_mem_info....... 000004D0 ......00000028^M
  lpar_info......... 000004F8 ......00000014^M
  segment page...... 00000518 ......00000028^M
  processor page.... 00000540 ......00000010^M
  res_asso_id....... 00000550 ......00000050^M
  res_asso_group.... 000005A0 ......00000048^M
  asso_ref_pnt...... 000005E8 ......00000010^M
  residual.......... 00000820 ......00005138^M
  fwad_info......... 000005F8 ......00000040^M
  contig mem rsv.... 00000738 ......00000058^M
      region address      region length       attr  label^M
  0   0x0000000000000000  0x000000000FFF7000  0x01  0x01^M
  1   0x000000000FFF7000  0x0000000000002000  0x01  0x03^M
  2   0x000000000FFF9000  0x0000000000006000  0x01  0x02^M
  3   0x000000000FFFF000  0x0000000000000014  0x00  0x05^M
  4   0x000000000FFFF014  0x00000000F0000FEC  0x01  0x01^M
  5   0x0000000100000000  0xFFFFFFFF00000000  0x00  0x07^M
  ----------------------------^M
  ^M
  0000012C bytes of free memory remain at address 00004000^M
  compressed kernel addr: D6C00;  sz: 98CE33;  uncompressed kernel addr:  1=
DB59600^M
           name     source       dest       size   flags^M
   0      .data   1e6f9840    2000000    12bdd20     1^M
   1    basecfg    1b04000    fff5000       15d9     1^M
   2      ramfs     a63a30    efe9000    100b82a     1^M
   3      .text   1db59840      d6c00     ba0000     1^M
   4       .ldr   1f9b7560     c77000      a9523     1^M
   5     symtab   1fe0aaf4     d21000     1f4410     1^M
   6  kern. hdr   1db59600          0        240     1^M
   7       .bss          0    32bdd20    27222e0     2^M
  free space between BSS and RAM filesystem: 09609000^M
  ^M
  entry_point: 0x000D6C28^M
                         kernel debugger setting: enabled^M
  -------------------------------------------------------------------------=
------^M
  ^LStarLED{A20}^M
  Data Storage Interrupt - PROC^M
  .dispatch+000098              lwz    r0,1830(r6)         r0=3D0,1830(r6)=
=3DF00000002FF48E30^M
  KDB(0)>

  (apologies for all the ^M - they are emitted by qemu or AIX - not
  sure)

  Using the same command to boot AIX from 3.1.0 works (no DSI
  Interrupt). - Other problems occur later, but no Kernel interrupt,
  only user space problems - and that's another problem - but one at a
  time !

  --Ivan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829682/+subscriptions

