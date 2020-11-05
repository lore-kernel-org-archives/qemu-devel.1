Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D5C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A1020704
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A1020704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWrE-00076G-Nc
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 23:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqP-0005aO-1b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:38248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqM-0000DK-D9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaWqK-00032I-14
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EA4042E8055
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 04:25:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 04:17:23 -0000
From: Launchpad Bug Tracker <1708442@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asmetanin eblake janitor th-huth
X-Launchpad-Bug-Reporter: Andrey Smetanin (asmetanin)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
Message-Id: <160454984324.10129.14811414527449815254.malone@loganberry.canonical.com>
Subject: [Bug 1708442] Re: Crash(assert) during reading image from http url
 through qemu-nbd
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: c30ee16b24e9c365419320d575cd529e09198914
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1708442 <1708442@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708442

Title:
  Crash(assert) during reading  image from http url through qemu-nbd

Status in QEMU:
  Expired

Bug description:
  Description:
  During reading image from nbd device mounted by qemu-nbd server with url =
backend I/O error happens
  "blk_update_request: I/O error, dev nbd0, sector 42117" dmesg. After some=
 investigation I found that qemu-nbd server aborts in aio_co_enter() assert=
 in util/async.c:468.

  Steps to reproduce:

  1) sudo go run qemu-nbd-bug-report/qemu-nbd-bug.go (see qemu-nbd-bug-
  report.tar.gz)

  or try directly

  1) qemu-nbd -c /dev/nbd0 -r -v --aio=3Dnative -f qcow2 json:{"file.driver=
":"http","file.url":"http://localhost:9666/image","file.readahead":3276800
  2) try read whole nbd device while error "blk_update_request: I/O error, =
dev nbd0, sector 42117" appears in dmesg

  Versions:

  1) qemu built from sources(/configure --target-list=3Dx86_64-softmmu --di=
sable-user --enable-curl --enable-linux-aio --enable-virtfs --enable-debug =
--disable-pie
  , top commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28):

  qemu-nbd -v
  qemu-nbd 2.9.90 (v2.10.0-rc0-67-g5619c17)

  2) libcurl(built from sources, top commit
  1767adf4399bb3be29121435e1bb1cc2bc05f7bf):

  curl -V
  curl 7.55.0-DEV (Linux) libcurl/7.55.0-DEV OpenSSL/1.0.2g zlib/1.2.8

  Backtrace:
  (gdb) bt
  #0  0x00007f7131426428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:54
  #1  0x00007f713142802a in __GI_abort () at abort.c:89
  #2  0x00007f713141ebd7 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x54c924 "self !=3D co",
  =C2=A0=C2=A0=C2=A0=C2=A0file=3Dfile@entry=3D0x54c871 "util/async.c", line=
=3Dline@entry=3D468,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x54c980 <__PRETTY_FU=
NCTION__.24766> "aio_co_enter") at assert.c:92
  #3  0x00007f713141ec82 in __GI___assert_fail (assertion=3D0x54c924 "self =
!=3D co", file=3D0x54c871 "util/async.c", line=3D468,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3D0x54c980 <__PRETTY_FUNCTION__.24766> "=
aio_co_enter") at assert.c:101
  #4  0x00000000004fe6a2 in aio_co_enter (ctx=3D0xf0ddb0, co=3D0xf14650) at=
 util/async.c:468
  #5  0x00000000004fe637 in aio_co_wake (co=3D0xf14650) at util/async.c:456
  #6  0x0000000000495c8a in curl_read_cb (ptr=3D0xf566d9, size=3D1, nmemb=
=3D16135, opaque=3D0xf1cb90) at block/curl.c:275
  #7  0x00007f713242ac24 in Curl_client_chop_write () from /usr/lib/x86_64-=
linux-gnu/libcurl.so
  #8  0x00007f713242ae03 in Curl_client_write () from /usr/lib/x86_64-linux=
-gnu/libcurl.so
  #9  0x00007f713244e1cf in readwrite_data () from /usr/lib/x86_64-linux-gn=
u/libcurl.so
  #10 0x00007f713244eb6f in Curl_readwrite () from /usr/lib/x86_64-linux-gn=
u/libcurl.so
  #11 0x00007f713245c1bb in multi_runsingle () from /usr/lib/x86_64-linux-g=
nu/libcurl.so
  #12 0x00007f713245d819 in multi_socket () from /usr/lib/x86_64-linux-gnu/=
libcurl.so
  #13 0x00007f713245e067 in curl_multi_socket_action () from /usr/lib/x86_6=
4-linux-gnu/libcurl.so
  #14 0x0000000000497555 in curl_setup_preadv (bs=3D0xf16820, acb=3D0x7f712=
d379860) at block/curl.c:918
  #15 0x00000000004975fb in curl_co_preadv (bs=3D0xf16820, offset=3D6556160=
, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/curl.c:935
  #16 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf16820, offset=3D655=
6160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:836
  #17 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1be20, req=3D0x=
7f712d379a60, offset=3D6556160, bytes=3D512, align=3D1,
  =C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:1=
086
  #18 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1be20, offset=3D6556=
160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:1180
  #19 0x0000000000437498 in qcow2_co_preadv (bs=3D0xf0fdc0, offset=3D215639=
04, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/qcow2.c:1812
  #20 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf0fdc0, offset=3D215=
63904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:836
  #21 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1c0d0, req=3D0x=
7f712d379d30, offset=3D21563904, bytes=3D512, align=3D1,
  =C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379e80, flags=3D0) at block/io.c:1=
086
  #22 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1c0d0, offset=3D2156=
3904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:1180
  #23 0x00000000004645ad in blk_co_preadv (blk=3D0xf1be90, offset=3D2156390=
4, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/block-backend.c:991
  #24 0x00000000004646fa in blk_read_entry (opaque=3D0x7f712d379ea0) at blo=
ck/block-backend.c:1038
  #25 0x000000000046481c in blk_prw (blk=3D0xf1be90, offset=3D21563904,
  ---Type <return> to continue, or q <return> to quit---
  =C2=A0=C2=A0=C2=A0=C2=A0buf=3D0xf7f000 "2,NV\241t!\ti\312\vp\364\017Kl*\3=
54\021\a\177\021\260\b\027\212\347\027\004\322\nG\340b\\\306pG\332\313\060\=
341;\002\360\063L\240\027T \211\341\305\022=D0=90E\230\356D=C7=AE}\211\bx\0=
16\a\b\313\350\316\064.\017\372\032-R\376z\261\263\350|cQ<\016S_L\340A\221\=
366~L#\001+\271\204\065~\327\023\027I\211\343\361\276zT$4\336\273=CB=8F\353=
=CA=AA\234\016_Z|TMk\"\370\002\363~\334\332.\a\375\265m=D3=8C{/%\304=D6=8E\=
374sF<E\371\031o&\202\217\226\276>I\356\302\375F\340\332\324\021\202\232>\0=
26\261\233\303tv\023\304\006\243\037\062B=CF=8F\b\324rs\360'"..., bytes=3D5=
12, co_entry=3D0x4646aa <blk_read_entry>, flags=3D0) at block/block-backend=
.c:1074
  #26 0x0000000000464f81 in blk_pread (blk=3D0xf1be90, offset=3D21563904, b=
uf=3D0xf7f000, count=3D512) at block/block-backend.c:1227
  #27 0x00000000004906cb in nbd_trip (opaque=3D0xf5a940) at nbd/server.c:13=
80
  #28 0x000000000051c0a5 in coroutine_trampoline (i0=3D15812176, i1=3D0) at=
 util/coroutine-ucontext.c:79
  #29 0x00007f713143b5d0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #30 0x00007f712d47a770 in ?? ()
  #31 0x0000000000000000 in ?? ()
  Backtrace stopped: Cannot access memory at address 0x7f712d37a000

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708442/+subscriptions

