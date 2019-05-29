Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1843CC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A469F22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A469F22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVz68-0006iU-T5
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:58:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVz4b-00061x-KV
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVz4V-0007yb-Uf
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hVz4H-0007hE-NG; Wed, 29 May 2019 09:56:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C06AD9C158;
	Wed, 29 May 2019 13:56:25 +0000 (UTC)
Received: from [10.10.122.88] (ovpn-122-88.rdu2.redhat.com [10.10.122.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81C8464026;
	Wed, 29 May 2019 13:56:21 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <155909126563.6497.18001981791168067724@ce79690b2cb9>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <fb436e4c-1b0f-8e3d-a36f-5a08130e54dd@redhat.com>
Date: Wed, 29 May 2019 09:56:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155909126563.6497.18001981791168067724@ce79690b2cb9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 29 May 2019 13:56:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/28/19 8:54 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190528235842.29453-1-jsnow@redh=
at.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing command=
s and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20

Hm, I don't understand this output too well; is this truly related to my
patches? It looks like some noise around aio_notify, if this is the
actual error text that caused the failure:

PASS 19 test-bdrv-drain /bdrv-drain/iothread/drain
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D10624=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
0x612000030e70 at pc 0x558de21c3386 bp 0x7fcb8aeb8000 sp 0x7fcb8aeb7ff8
WRITE of size 1 at 0x612000030e70 thread T15
PASS 1 ahci-test /x86_64/ahci/sanity
=3D=3D10643=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext
functions and may produce false positives in some cases!
    #0 0x558de21c3385 in aio_notify /tmp/qemu-test/src/util/async.c:352:9
    #1 0x558de21c4ffb in qemu_bh_schedule
/tmp/qemu-test/src/util/async.c:168:9
    #2 0x558de21c8202 in aio_co_schedule
/tmp/qemu-test/src/util/async.c:465:5
    #3 0x558de21c84d9 in aio_co_enter /tmp/qemu-test/src/util/async.c:484=
:9
    #4 0x558de21c845d in aio_co_wake /tmp/qemu-test/src/util/async.c:478:=
5
    #5 0x558de1abada4 in co_reenter_bh
/tmp/qemu-test/src/tests/test-bdrv-drain.c:63:5
    #6 0x558de21c3c6a in aio_bh_call /tmp/qemu-test/src/util/async.c:90:5
    #7 0x558de21c4382 in aio_bh_poll /tmp/qemu-test/src/util/async.c:118:=
13
    #8 0x558de21e9ee3 in aio_poll /tmp/qemu-test/src/util/aio-posix.c:729=
:17
    #9 0x558de208d92a in iothread_run
/tmp/qemu-test/src/tests/iothread.c:51:9
    #10 0x558de21fdb12 in qemu_thread_start
/tmp/qemu-test/src/util/qemu-thread-posix.c:502:9
    #11 0x7fcb9d63c58d in start_thread (/lib64/libpthread.so.0+0x858d)
    #12 0x7fcb9d54a682 in __GI___clone (/lib64/libc.so.6+0xfd682)

0x612000030e70 is located 176 bytes inside of 312-byte region
[0x612000030dc0,0x612000030ef8)
freed by thread T0 here:
    #0 0x558de1a6c3a0 in free
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x5193a0)
    #1 0x7fcb9da4fed1 in g_free (/lib64/libglib-2.0.so.0+0x54ed1)

previously allocated by thread T14 here:
    #0 0x558de1a6c9cf in calloc
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x5199cf)
    #1 0x7fcb9da4fe1d in g_malloc0 (/lib64/libglib-2.0.so.0+0x54e1d)

Thread T15 created by T0 here:
    #0 0x558de19c3074 in __interceptor_pthread_create
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x470074)
    #1 0x558de21fd40f in qemu_thread_create
/tmp/qemu-test/src/util/qemu-thread-posix.c:539:11
    #2 0x558de208cfc7 in iothread_new
/tmp/qemu-test/src/tests/iothread.c:75:5
    #3 0x558de1abbdd4 in test_iothread_common
/tmp/qemu-test/src/tests/test-bdrv-drain.c:664:19
    #4 0x558de1ab6c9e in test_iothread_drain_subtree
/tmp/qemu-test/src/tests/test-bdrv-drain.c:771:5
    #5 0x7fcb9da71fc9  (/lib64/libglib-2.0.so.0+0x76fc9)

Thread T14 created by T0 here:
    #0 0x558de19c3074 in __interceptor_pthread_create
(/tmp/qemu-test/build/tests/test-bdrv-drain+0x470074)
    #1 0x558de21fd40f in qemu_thread_create
/tmp/qemu-test/src/util/qemu-thread-posix.c:539:11
    #2 0x558de208cfc7 in iothread_new
/tmp/qemu-test/src/tests/iothread.c:75:5
    #3 0x558de1abbdc8 in test_iothread_common
/tmp/qemu-test/src/tests/test-bdrv-drain.c:663:19
    #4 0x558de1ab6c9e in test_iothread_drain_subtree
/tmp/qemu-test/src/tests/test-bdrv-drain.c:771:5
    #5 0x7fcb9da71fc9  (/lib64/libglib-2.0.so.0+0x76fc9)

SUMMARY: AddressSanitizer: heap-use-after-free
/tmp/qemu-test/src/util/async.c:352:9 in aio_notify
Shadow bytes around the buggy address:
  0x0c247fffe170: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c247fffe180: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c247fffe190: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c247fffe1a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c247fffe1b0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
=3D>0x0c247fffe1c0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd[fd]fd
  0x0c247fffe1d0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c247fffe1e0: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c247fffe1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c247fffe200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa fa
  0x0c247fffe210: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D10624=3D=3DABORTING
ERROR - too few tests run (expected 39, got 19)
make: *** [/tmp/qemu-test/src/tests/Makefile.include:889: check-unit]
Error 1
make: *** Waiting for unfinished jobs....

> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 =
NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> PASS 3 endianness-test /x86_64/endianness/combine/pc
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tes=
ts/test-coroutine -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-coroutine"=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/fdc-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"fdc-test"=20
> =3D=3D10394=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 1 test-coroutine /basic/no-dangling-access
> PASS 2 test-coroutine /basic/lifecycle
> PASS 3 test-coroutine /basic/yield
> =3D=3D10394=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffe0e2b1000; bottom 0x7f0537af8000; size: 0x00f8d67b=
9000 (1068750311424)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 4 test-coroutine /basic/nesting
> ---
> PASS 1 fdc-test /x86_64/fdc/cmos
> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
> PASS 3 fdc-test /x86_64/fdc/read_without_media
> =3D=3D10399=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 fdc-test /x86_64/fdc/media_change
> PASS 1 test-iov /basic/iov/from-to-buf
> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
> ---
> PASS 11 test-aio /aio/event/wait
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> =3D=3D10417=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 14 test-aio /aio/timer/schedule
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> ---
> PASS 28 test-aio /aio-gsource/timer/schedule
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tes=
ts/test-aio-multithread -m=3Dquick -k --tap < /dev/null | ./scripts/tap-d=
river.pl --test-name=3D"test-aio-multithread"=20
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> =3D=3D10423=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 2 test-aio-multithread /aio/multi/schedule
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> PASS 12 fdc-test /x86_64/fdc/read_no_dma_19
> PASS 13 fdc-test /x86_64/fdc/fuzz-registers
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/ide-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"ide-test"=20
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> =3D=3D10451=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 1 ide-test /x86_64/ide/identify
> =3D=3D10462=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
> PASS 2 ide-test /x86_64/ide/flush
> =3D=3D10473=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tes=
ts/test-throttle -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"test-throttle"=20
> PASS 1 test-throttle /throttle/leak_bucket
> ---
> PASS 6 test-throttle /throttle/detach_attach
> PASS 7 test-throttle /throttle/config_functions
> PASS 8 test-throttle /throttle/accounting
> =3D=3D10481=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 9 test-throttle /throttle/groups
> PASS 10 test-throttle /throttle/config/enabled
> PASS 11 test-throttle /throttle/config/conflicting
> ---
> PASS 1 test-thread-pool /thread-pool/submit
> PASS 2 test-thread-pool /thread-pool/submit-aio
> PASS 3 test-thread-pool /thread-pool/submit-co
> =3D=3D10488=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 test-thread-pool /thread-pool/submit-many
> =3D=3D10485=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 ide-test /x86_64/ide/bmdma/trim
> =3D=3D10539=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 ide-test /x86_64/ide/bmdma/short_prdt
> =3D=3D10546=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 test-thread-pool /thread-pool/cancel
> PASS 6 ide-test /x86_64/ide/bmdma/one_sector_short_prdt
> =3D=3D10552=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 7 ide-test /x86_64/ide/bmdma/long_prdt
> =3D=3D10558=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10558=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffd8c683000; bottom 0x7f81b4746000; size: 0x007bd7f3=
d000 (531904057344)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 6 test-thread-pool /thread-pool/cancel-async
> ---
> PASS 12 test-hbitmap /hbitmap/set/two-elem
> PASS 13 test-hbitmap /hbitmap/set/general
> PASS 14 test-hbitmap /hbitmap/set/twice
> =3D=3D10574=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 15 test-hbitmap /hbitmap/set/overlap
> PASS 16 test-hbitmap /hbitmap/reset/empty
> PASS 10 ide-test /x86_64/ide/flush/empty_drive
> PASS 17 test-hbitmap /hbitmap/reset/general
> =3D=3D10579=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 18 test-hbitmap /hbitmap/reset/all
> PASS 19 test-hbitmap /hbitmap/truncate/nop
> PASS 20 test-hbitmap /hbitmap/truncate/grow/negligible
> ---
> PASS 29 test-hbitmap /hbitmap/truncate/shrink/large
> PASS 30 test-hbitmap /hbitmap/meta/zero
> PASS 11 ide-test /x86_64/ide/flush/retry_pci
> =3D=3D10585=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 12 ide-test /x86_64/ide/flush/retry_isa
> =3D=3D10591=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 13 ide-test /x86_64/ide/cdrom/pio
> =3D=3D10597=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 14 ide-test /x86_64/ide/cdrom/pio_large
> =3D=3D10603=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 31 test-hbitmap /hbitmap/meta/one
> PASS 32 test-hbitmap /hbitmap/meta/byte
> PASS 33 test-hbitmap /hbitmap/meta/word
> ---
> PASS 41 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_0
> PASS 42 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_1
> PASS 43 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
> =3D=3D10617=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tes=
ts/test-bdrv-drain -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"test-bdrv-drain"=20
> =3D=3D10624=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 1 test-bdrv-drain /bdrv-drain/nested
> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
> ---
> PASS 18 test-bdrv-drain /bdrv-drain/iothread/drain_all
> PASS 19 test-bdrv-drain /bdrv-drain/iothread/drain
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D10624=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x612000030e70 at pc 0x558de21c3386 bp 0x7fcb8aeb8000 sp 0x7fcb8aeb7ff8
> WRITE of size 1 at 0x612000030e70 thread T15
> PASS 1 ahci-test /x86_64/ahci/sanity
> =3D=3D10643=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
>     #0 0x558de21c3385 in aio_notify /tmp/qemu-test/src/util/async.c:352=
:9
>     #1 0x558de21c4ffb in qemu_bh_schedule /tmp/qemu-test/src/util/async=
.c:168:9
>     #2 0x558de21c8202 in aio_co_schedule /tmp/qemu-test/src/util/async.=
c:465:5
> ---
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> =3D=3D10624=3D=3DABORTING
> ERROR - too few tests run (expected 39, got 19)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:889: check-unit] E=
rror 1
> make: *** Waiting for unfinished jobs....
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> =3D=3D10649=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 ahci-test /x86_64/ahci/pci_enable
> =3D=3D10655=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 ahci-test /x86_64/ahci/hba_spec
> =3D=3D10661=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 ahci-test /x86_64/ahci/hba_enable
> =3D=3D10667=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 6 ahci-test /x86_64/ahci/identify
> =3D=3D10673=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 7 ahci-test /x86_64/ahci/max
> =3D=3D10679=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 8 ahci-test /x86_64/ahci/reset
> =3D=3D10685=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10685=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffefa8da000; bottom 0x7f80491fe000; size: 0x007eb16d=
c000 (544142639104)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
> =3D=3D10691=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10691=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffd7d207000; bottom 0x7f6915ffe000; size: 0x00946720=
9000 (637385347072)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
> =3D=3D10697=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10697=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffd8cfa0000; bottom 0x7efbdbffe000; size: 0x0101b0fa=
2000 (1106775777280)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
> =3D=3D10703=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10703=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffc34322000; bottom 0x7f42729fe000; size: 0x00b9c192=
4000 (797816537088)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
> =3D=3D10709=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10709=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fffecab3000; bottom 0x7f3e2d1fe000; size: 0x00c1bf8b=
5000 (832142266368)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
> =3D=3D10715=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10715=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffd87d56000; bottom 0x7f1b88bfe000; size: 0x00e1ff15=
8000 (970647240704)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
> =3D=3D10721=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10721=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffd6ae21000; bottom 0x7fe9395fe000; size: 0x00143182=
3000 (86729961472)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
> =3D=3D10727=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10727=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffe500fa000; bottom 0x7fed11f7c000; size: 0x00113e17=
e000 (74056196096)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
> =3D=3D10733=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10733=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fff2ca88000; bottom 0x7f7bb477c000; size: 0x00837830=
c000 (564657176576)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
> =3D=3D10739=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
> =3D=3D10745=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
> =3D=3D10751=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
> =3D=3D10757=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10757=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fff161d0000; bottom 0x7f3cac1fe000; size: 0x00c269fd=
2000 (835001851904)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
> =3D=3D10763=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10763=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffed9405000; bottom 0x7fd8ec5fe000; size: 0x0025ece0=
7000 (162887921664)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
> =3D=3D10769=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10769=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fff2bdc5000; bottom 0x7f39d41fe000; size: 0x00c557bc=
7000 (847580524544)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
> =3D=3D10775=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10775=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffff35d5000; bottom 0x7f869e1fe000; size: 0x0079553d=
7000 (521121132544)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
> =3D=3D10781=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10781=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fffaa76f000; bottom 0x7f62f7ffe000; size: 0x009cb277=
1000 (673009045504)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
> =3D=3D10787=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10787=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffe16878000; bottom 0x7fb9063fe000; size: 0x00451047=
a000 (296625872896)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
> =3D=3D10793=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10793=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fffc8111000; bottom 0x7f36227fe000; size: 0x00c9a591=
3000 (866066182144)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
> =3D=3D10799=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10799=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffdc81a0000; bottom 0x7f4624bfe000; size: 0x00b7a35a=
2000 (788719607808)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low
> =3D=3D10805=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D10805=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7fff58ed0000; bottom 0x7f9fedd7c000; size: 0x005f6b15=
4000 (409818447872)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high
> =3D=3D10811=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
> =3D=3D10817=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 31 ahci-test /x86_64/ahci/io/pio/lba48/short/low
> =3D=3D10823=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 32 ahci-test /x86_64/ahci/io/pio/lba48/short/high
> =3D=3D10829=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented
> =3D=3D10835=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
> =3D=3D10841=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
> =3D=3D10847=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
> =3D=3D10853=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
> =3D=3D10859=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
> =3D=3D10865=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
> =3D=3D10871=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
> =3D=3D10877=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
> =3D=3D10883=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
> =3D=3D10889=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
> =3D=3D10895=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
> =3D=3D10901=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
> =3D=3D10907=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
> =3D=3D10913=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
> =3D=3D10919=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
> =3D=3D10925=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
> =3D=3D10931=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
> =3D=3D10938=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low
> =3D=3D10944=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
> =3D=3D10950=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero
> =3D=3D10956=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low
> =3D=3D10962=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high
> =3D=3D10968=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero
> =3D=3D10974=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
> =3D=3D10980=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
> =3D=3D10986=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
> =3D=3D10992=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
> =3D=3D10998=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 61 ahci-test /x86_64/ahci/flush/simple
> =3D=3D11004=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 62 ahci-test /x86_64/ahci/flush/retry
> =3D=3D11010=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11015=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 63 ahci-test /x86_64/ahci/flush/migrate
> =3D=3D11024=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11029=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
> =3D=3D11039=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11044=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
> =3D=3D11053=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11058=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
> =3D=3D11067=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11072=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
> =3D=3D11081=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11086=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
> =3D=3D11095=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
> =3D=3D11100=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
> =3D=3D11106=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
> =3D=3D11112=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
> =3D=3D11118=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> =3D=3D11118=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_r=
eturn: stack top: 0x7ffc1f6d7000; bottom 0x7f53eb1fe000; size: 0x00a8344d=
9000 (722432004096)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
> =3D=3D11124=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/hd-geo-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dri=
ver.pl --test-name=3D"hd-geo-test"=20
> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
> =3D=3D11138=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
> =3D=3D11144=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
> =3D=3D11150=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba
> =3D=3D11156=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
> =3D=3D11162=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
> =3D=3D11168=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
> =3D=3D11174=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
> =3D=3D11180=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
> =3D=3D11185=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/boot-order-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap=
-driver.pl --test-name=3D"boot-order-test"=20
> PASS 1 boot-order-test /x86_64/boot-order/pc
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11253=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 1 bios-tables-test /x86_64/acpi/piix4
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11259=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 2 bios-tables-test /x86_64/acpi/q35
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11265=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 bios-tables-test /x86_64/acpi/piix4/bridge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11271=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11277=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 bios-tables-test /x86_64/acpi/piix4/cpuhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11284=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 6 bios-tables-test /x86_64/acpi/piix4/memhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11290=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 7 bios-tables-test /x86_64/acpi/piix4/numamem
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11296=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 8 bios-tables-test /x86_64/acpi/piix4/dimmpxm
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11305=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 9 bios-tables-test /x86_64/acpi/q35/bridge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11311=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 10 bios-tables-test /x86_64/acpi/q35/mmio64
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11317=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 11 bios-tables-test /x86_64/acpi/q35/ipmi
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11323=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 12 bios-tables-test /x86_64/acpi/q35/cpuhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11330=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 13 bios-tables-test /x86_64/acpi/q35/memhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11336=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 14 bios-tables-test /x86_64/acpi/q35/numamem
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11342=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 15 bios-tables-test /x86_64/acpi/q35/dimmpxm
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/boot-serial-test -m=3Dquick -k --tap < /dev/null | ./scripts/ta=
p-driver.pl --test-name=3D"boot-serial-test"=20
> PASS 1 boot-serial-test /x86_64/boot-serial/isapc
> ---
> PASS 1 i440fx-test /x86_64/i440fx/defaults
> PASS 2 i440fx-test /x86_64/i440fx/pam
> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
> =3D=3D11426=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/fw_cfg-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dri=
ver.pl --test-name=3D"fw_cfg-test"=20
> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/drive_del-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"drive_del-test"=20
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> =3D=3D11514=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"wdt_ib700-test"=20
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
> =3D=3D11709=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/usb-hcd-xhci-test -m=3Dquick -k --tap < /dev/null | ./scripts/t=
ap-driver.pl --test-name=3D"usb-hcd-xhci-test"=20
> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
> =3D=3D11718=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/cpu-plug-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-d=
river.pl --test-name=3D"cpu-plug-test"=20
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11824=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11830=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11836=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/tpm-crb-swtpm-test -m=3Dquick -k --tap < /dev/null | ./scripts/=
tap-driver.pl --test-name=3D"tpm-crb-swtpm-test"=20
> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not i=
n PATH or missing --tpm2 support
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11941=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11946=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 3 migration-test /x86_64/migration/postcopy/unix
> PASS 4 migration-test /x86_64/migration/postcopy/recovery
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11976=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11981=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 5 migration-test /x86_64/migration/precopy/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11990=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D11995=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 6 migration-test /x86_64/migration/precopy/tcp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D12004=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> =3D=3D12009=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 7 migration-test /x86_64/migration/xbzrle/unix
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/test-x86-cpuid-compat -m=3Dquick -k --tap < /dev/null | ./scrip=
ts/tap-driver.pl --test-name=3D"test-x86-cpuid-compat"=20
> PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus
> ---
> PASS 6 numa-test /x86_64/numa/pc/dynamic/cpu
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTE=
ST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-=
img tests/qmp-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"qmp-test"=20
> PASS 1 qmp-test /x86_64/qmp/protocol
> =3D=3D12338=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 2 qmp-test /x86_64/qmp/oob
> PASS 3 qmp-test /x86_64/qmp/preconfig
> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
> ---
> PASS 6 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/sdhci-pci/=
sdhci/sdhci-tests/registers
> PASS 7 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tpci200/ip=
ack/ipoctal232/ipoctal232-tests/nop
> PASS 8 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tpci200/pc=
i-device/pci-device-tests/nop
> =3D=3D12747=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 9 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-=
pci/pci-device/pci-device-tests/nop
> PASS 10 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p=
-pci/virtio/virtio-tests/nop
> PASS 11 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p=
-pci/virtio-9p/virtio-9p-tests/config
> ---
> PASS 20 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p=
-pci/virtio-9p/virtio-9p-tests/fs/flush/ignored
> PASS 21 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ba=
lloon-pci/pci-device/pci-device-tests/nop
> PASS 22 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ba=
lloon-pci/virtio/virtio-tests/nop
> =3D=3D12760=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 23 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk/virtio-blk-tests/indirect
> =3D=3D12767=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 24 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk/virtio-blk-tests/config
> =3D=3D12774=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 25 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk/virtio-blk-tests/basic
> =3D=3D12781=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 26 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk/virtio-blk-tests/resize
> =3D=3D12788=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 27 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk-pci-tests/msix
> =3D=3D12795=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 28 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk-pci-tests/idx
> =3D=3D12802=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 29 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk-pci-tests/nxvirtq
> =3D=3D12809=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 30 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-bl=
k-pci/virtio-blk-pci-tests/hotplug
> PASS 31 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ne=
t-pci/virtio-net/virtio-net-tests/basic
> PASS 32 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-ne=
t-pci/virtio-net/virtio-net-tests/rx_stop_cont
> ---
> PASS 40 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rn=
g-pci/pci-device/pci-device-tests/nop
> PASS 41 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rn=
g-pci/virtio/virtio-tests/nop
> PASS 42 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-rn=
g-pci/virtio-rng-pci-tests/hotplug
> =3D=3D12920=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 43 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-sc=
si-pci/pci-device/pci-device-tests/nop
> =3D=3D12926=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 44 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-sc=
si-pci/virtio-scsi/virtio-scsi-tests/hotplug
> =3D=3D12932=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 45 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-sc=
si-pci/virtio-scsi/virtio-scsi-tests/unaligned-write-same
> PASS 46 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-se=
rial-pci/pci-device/pci-device-tests/nop
> PASS 47 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-se=
rial-pci/virtio/virtio-tests/nop
> ---
> PASS 66 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82562/pc=
i-device/pci-device-tests/nop
> PASS 67 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82801/pc=
i-device/pci-device-tests/nop
> PASS 68 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ES1370/pc=
i-device/pci-device-tests/nop
> =3D=3D13070=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 69 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/p=
ci-device/pci-device-tests/nop
> PASS 70 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/m=
egasas-tests/dcmd/pd-get-info/fuzz
> PASS 71 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ne2k_pci/=
pci-device/pci-device-tests/nop
> PASS 72 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/nvme/pci-=
device/pci-device-tests/nop
> =3D=3D13082=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 73 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/nvme/nvme=
-tests/oob-cmb-access
> =3D=3D13088=3D=3DWARNING: ASan doesn't fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!
> PASS 74 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pcnet/pci=
-device/pci-device-tests/nop
> PASS 75 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pci-ohci/=
pci-device/pci-device-tests/nop
> PASS 76 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/pci-ohci/=
pci-ohci-tests/ohci_pci-test-hotplug
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20190528235842.29453-1-jsnow@redhat.com/testing=
.asan/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20

--=20
=E2=80=94js

