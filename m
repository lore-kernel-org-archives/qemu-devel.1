Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34769C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FAC21789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FAC21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLcn-0003o0-4y
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKLbD-0002tC-Gq
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:11:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:52490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKLb5-00087f-Kh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 09:11:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kKLb2-0005mX-Kr
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 13:11:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 98BC62E80DC
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 13:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2020 12:59:44 -0000
From: Stefan Hajnoczi <1895471@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ameynarkhede stefanha
X-Launchpad-Bug-Reporter: Amey Narkhede (ameynarkhede)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <160002337216.747.16078826830052525094.malonedeb@chaenomeles.canonical.com>
Message-Id: <160069318448.14183.17353672468451830444.malone@gac.canonical.com>
Subject: [Bug 1895471] Re: compilation error with clang in util/async.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: cf1143f04b44b692d34fa2a76469fd5d91b64f8b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:41:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1895471 <1895471@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mailing list discussion about how to fix this:
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg07392.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895471

Title:
  compilation error with clang in util/async.c

Status in QEMU:
  New

Bug description:
  configured with ` CC=3Dclang CXX=3Dclang++ ../configure --target-
  list=3Dx86_64-softmmu --enable-kvm --enable-curl --enable-debug
  --enable-jemalloc --enable-fuzzing --enable-sdl` and after make I get
  the following error related to c11 atomics. I'm using clang because
  I'm experimenting with fuzzer

  [glitz@archlinux /code/qemu/build]$ ninja -j5
  [479/2290] Compiling C object libqemuutil.a.p/util_async.c.o
  FAILED: libqemuutil.a.p/util_async.c.o
  clang -Ilibqemuutil.a.p -I. -I.. -Iqapi -Itrace -Iui -Iui/shader -I/usr/i=
nclude/p11-kit-1 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr=
/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -Ilinux-=
headers -Xclang -fcolor-diagnostics -pipe -Wall -Winvalid-pch -Werror -std=
=3Dgnu99 -g -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE=
_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmis=
sing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wold-style-defini=
tion -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qua=
lifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined=
 -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-v=
alue -Wno-string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-=
limit-compare -fstack-protector-strong -fsanitize=3Dfuzzer-no-link -iquote =
/code/qemu/tcg/i386 -isystem /code/qemu/linux-headers -iquote . -iquote /co=
de/qemu -iquote /code/qemu/accel/tcg -iquote /code/qemu/include -iquote /co=
de/qemu/disas/libvixl -pthread -fPIC -MD -MQ libqemuutil.a.p/util_async.c.o=
 -MF libqemuutil.a.p/util_async.c.o.d -o libqemuutil.a.p/util_async.c.o -c =
../util/async.c
  ../util/async.c:79:17: error: address argument to atomic operation must b=
e a pointer to _Atomic type ('unsigned int *' invalid)
      old_flags =3D atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
                  ^               ~~~~~~~~~~
  /usr/lib/clang/10.0.1/include/stdatomic.h:138:42: note: expanded from mac=
ro 'atomic_fetch_or'
  #define atomic_fetch_or(object, operand) __c11_atomic_fetch_or(object, op=
erand, __ATOMIC_SEQ_CST)
                                           ^                     ~~~~~~
  ../util/async.c:105:14: error: address argument to atomic operation must =
be a pointer to _Atomic type ('unsigned int *' invalid)
      *flags =3D atomic_fetch_and(&bh->flags,
               ^                ~~~~~~~~~~
  /usr/lib/clang/10.0.1/include/stdatomic.h:144:43: note: expanded from mac=
ro 'atomic_fetch_and'
  #define atomic_fetch_and(object, operand) __c11_atomic_fetch_and(object, =
operand, __ATOMIC_SEQ_CST)
                                            ^                      ~~~~~~
  2 errors generated.
  [483/2290] Compiling C object libqemuutil.a.p/util_qemu-error.c.o
  ninja: build stopped: subcommand failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895471/+subscriptions

