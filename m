Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 19:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76C0207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 19:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76C0207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je1cO-0001vZ-0E
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1je1bV-0001Q2-4E
 for qemu-devel@nongnu.org; Wed, 27 May 2020 15:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:50400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1je1bT-0008NK-TM
 for qemu-devel@nongnu.org; Wed, 27 May 2020 15:20:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1je1bR-0005Fz-NO
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 19:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ACD752E80E7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 19:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2020 19:13:34 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1881004@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <159060681483.5838.13632051970488338647.malonedeb@wampee.canonical.com>
Subject: [Bug 1881004] [NEW] fpu/softfloat.c: error: bitwise negation of a
 boolean expression
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5997e36a9f6bc032ea0896b07ad794f9f8d95384
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 15:20:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1881004 <1881004@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Last time I built QEMU was on commit d5c75ec500d96f1d93447f990cd5a4ef5ba27f=
ae,
I just pulled to fea8f3ed739536fca027cf56af7f5576f37ef9cd and now get:
 =

  CC      lm32-softmmu/fpu/softfloat.o
fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
    absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            !
fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
        absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNearestE=
ven );
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !
fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
        absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & roundNearestEven);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !
fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
    zSig &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            !
fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
    zSig &=3D ~ ( ( ( roundBits ^ 0x200 ) =3D=3D 0 ) & roundNearestEven );
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            !
fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
                    ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundNearest=
Even );
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
                    !
fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
            zSig0 &=3D ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundNear=
estEven );
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
                     !
fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; d=
id you mean logical negation? [-Werror,-Wbool-operation]
        zSig1 &=3D ~ ( ( zSig2 + zSig2 =3D=3D 0 ) & roundNearestEven );
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !
8 errors generated.

$ clang -v
clang version 10.0.0-4ubuntu1 =

Target: aarch64-unknown-linux-gnu

$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04 LTS
Release:        20.04
Codename:       focal

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881004

Title:
  fpu/softfloat.c: error: bitwise negation of a boolean expression

Status in QEMU:
  New

Bug description:
  Last time I built QEMU was on commit d5c75ec500d96f1d93447f990cd5a4ef5ba2=
7fae,
  I just pulled to fea8f3ed739536fca027cf56af7f5576f37ef9cd and now get:
   =

    CC      lm32-softmmu/fpu/softfloat.o
  fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
      absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              !
  fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
          absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNeares=
tEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                   !
  fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
          absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & roundNearestEven);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                   !
  fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
      zSig &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              !
  fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
      zSig &=3D ~ ( ( ( roundBits ^ 0x200 ) =3D=3D 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              !
  fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
                      ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundNeare=
stEven );
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
                      !
  fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
              zSig0 &=3D ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundNe=
arestEven );
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
                       !
  fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
          zSig1 &=3D ~ ( ( zSig2 + zSig2 =3D=3D 0 ) & roundNearestEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                   !
  8 errors generated.

  $ clang -v
  clang version 10.0.0-4ubuntu1 =

  Target: aarch64-unknown-linux-gnu

  $ lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 20.04 LTS
  Release:        20.04
  Codename:       focal

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881004/+subscriptions

