Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1731C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530772087E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="tH4IzgtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530772087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituLf-0005BK-Bt
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittSy-0005jT-Gp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittSo-0008PB-1J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:21:12 -0500
Received: from rs224.mailgun.us ([209.61.151.224]:41393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1ittSl-00077y-Aa
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:21:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1579612860; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=NMesIF3NlkrkaAyD39fyCuMY8vAi+oAWR8LCJ70OO2c=;
 b=tH4IzgtBC0YhQ3iai3GbL5ElbBOYKP/teYsKLyhn97QHxB2exgGnYoWUfrVVWkc939iwxyOY
 aZpsdmTOgopbh+V5Kv3p/02esx62Ey5IbzGEET1BfoFIvPn+u1vVJY53R/w4m+NCRRl9zQkU
 0KIVbvp21hBjT0W82zdevSf6PvnNEncK2IJ6jrklpnSCVno+c1ZaPzyKmP/P363CHEiy71dQ
 ieasMgCfuF2ISVtEBNS3st0U+DU1nIlctnLQWAFMJD9qHfsHqVKFuDySmJxhGv0JRQvPTp4W
 nW5cOSVXQPH/AVEKODWI5RxlU6Y+5gwPZdDDiaSRbqwUtO0PsXS7ww==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mxa.mailgun.org with ESMTP id 5e26fab6.7f9863f12930-smtp-out-n01;
 Tue, 21 Jan 2020 13:20:54 -0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id w1so2745864ljh.5;
 Tue, 21 Jan 2020 05:20:53 -0800 (PST)
X-Gm-Message-State: APjAAAXgTxjqr4AIiFxxuNvMlPXh0eV/SzlzhtbYU3w8PASRCkhfbGwZ
 IxFssvWzvexp0q9Ua96aUdMadhwJmofgdk7E5dk=
X-Google-Smtp-Source: APXvYqw50RTnlNKVGGlu1voUclggCGNtG26Y88uUxoF7TsMKzOfug/y6Qnys2RgLAUiHQOs8G5HekOSym8LPyG6uyjc=
X-Received: by 2002:a2e:7505:: with SMTP id q5mr16685653ljc.7.1579612852456;
 Tue, 21 Jan 2020 05:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20190703190715.5328-1-jonathan@fintelia.io>
 <156220784052.21218.15000022918303678126@c4a48874b076>
In-Reply-To: <156220784052.21218.15000022918303678126@c4a48874b076>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Tue, 21 Jan 2020 08:20:26 -0500
X-Gmail-Original-Message-ID: <CANnJOVEosG_aUcSkS8v8foptEmCpuXQ=apwSawrRB+fs48NaoA@mail.gmail.com>
Message-ID: <CANnJOVEosG_aUcSkS8v8foptEmCpuXQ=apwSawrRB+fs48NaoA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Disallow WFI instruction from
 U-mode
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f412e9059ca646c2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f412e9059ca646c2
Content-Type: text/plain; charset="UTF-8"

I don't think this was ever merged?

On Wed, Jul 3, 2019 at 10:37 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20190703190715.5328-1-jonathan@fintelia.io/
>
>
>
> Hi,
>
> This series failed the asan build test. Please find the testing commands
> and
> their output below. If you have Docker installed, you can probably
> reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14
> NETWORK=1
> === TEST SCRIPT END ===
>
> PASS 1 fdc-test /x86_64/fdc/cmos
> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
> PASS 3 fdc-test /x86_64/fdc/read_without_media
> ==7862==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 fdc-test /x86_64/fdc/media_change
> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
> PASS 6 fdc-test /x86_64/fdc/relative_seek
> ---
> PASS 32 test-opts-visitor /visitor/opts/range/beyond
> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-coroutine -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-coroutine"
> ==7913==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==7913==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffea51ee000; bottom 0x7fcaef4f8000; size: 0x0033b5cf6000
> (222093598720)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-coroutine /basic/no-dangling-access
> ---
> PASS 11 test-aio /aio/event/wait
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> ==7929==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 14 test-aio /aio/timer/schedule
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/ide-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="ide-test"
> PASS 28 test-aio /aio-gsource/timer/schedule
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-aio-multithread"
> ==7938==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==7942==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> PASS 1 ide-test /x86_64/ide/identify
> ==7959==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 test-aio-multithread /aio/multi/schedule
> PASS 2 ide-test /x86_64/ide/flush
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> ==7970==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
> ==7981==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 ide-test /x86_64/ide/bmdma/trim
> ==7987==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> PASS 5 ide-test /x86_64/ide/bmdma/short_prdt
> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
> ==7998==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 ide-test /x86_64/ide/bmdma/one_sector_short_prdt
> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
> ==8009==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-throttle -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-throttle"
> ==8016==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-throttle /throttle/leak_bucket
> PASS 2 test-throttle /throttle/compute_wait
> PASS 3 test-throttle /throttle/init
> ---
> PASS 15 test-throttle /throttle/config/iops_size
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-thread-pool -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-thread-pool"
> PASS 7 ide-test /x86_64/ide/bmdma/long_prdt
> ==8022==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-thread-pool /thread-pool/submit
> PASS 2 test-thread-pool /thread-pool/submit-aio
> PASS 3 test-thread-pool /thread-pool/submit-co
> PASS 4 test-thread-pool /thread-pool/submit-many
> ==8024==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8024==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffd539ab000; bottom 0x7f7e855fe000; size: 0x007ece3ad000
> (544625840128)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 8 ide-test /x86_64/ide/bmdma/no_busmaster
> PASS 5 test-thread-pool /thread-pool/cancel
> PASS 9 ide-test /x86_64/ide/flush/nodev
> ==8100==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 10 ide-test /x86_64/ide/flush/empty_drive
> PASS 6 test-thread-pool /thread-pool/cancel-async
> ==8106==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-hbitmap -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-hbitmap"
> PASS 1 test-hbitmap /hbitmap/granularity
> PASS 2 test-hbitmap /hbitmap/size/0
> ---
> PASS 4 test-hbitmap /hbitmap/iter/empty
> PASS 11 ide-test /x86_64/ide/flush/retry_pci
> PASS 5 test-hbitmap /hbitmap/iter/partial
> ==8117==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 test-hbitmap /hbitmap/iter/granularity
> PASS 7 test-hbitmap /hbitmap/iter/iter_and_reset
> PASS 8 test-hbitmap /hbitmap/get/all
> ---
> PASS 14 test-hbitmap /hbitmap/set/twice
> PASS 15 test-hbitmap /hbitmap/set/overlap
> PASS 16 test-hbitmap /hbitmap/reset/empty
> ==8123==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 17 test-hbitmap /hbitmap/reset/general
> PASS 13 ide-test /x86_64/ide/cdrom/pio
> PASS 18 test-hbitmap /hbitmap/reset/all
> ---
> PASS 28 test-hbitmap /hbitmap/truncate/shrink/medium
> PASS 29 test-hbitmap /hbitmap/truncate/shrink/large
> PASS 30 test-hbitmap /hbitmap/meta/zero
> ==8129==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 14 ide-test /x86_64/ide/cdrom/pio_large
> ==8135==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 15 ide-test /x86_64/ide/cdrom/dma
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/ahci-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="ahci-test"
> PASS 31 test-hbitmap /hbitmap/meta/one
> PASS 32 test-hbitmap /hbitmap/meta/byte
> PASS 33 test-hbitmap /hbitmap/meta/word
> ==8149==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 ahci-test /x86_64/ahci/sanity
> PASS 34 test-hbitmap /hbitmap/meta/sector
> PASS 35 test-hbitmap /hbitmap/serialize/align
> ==8155==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> ==8161==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 36 test-hbitmap /hbitmap/serialize/basic
> PASS 37 test-hbitmap /hbitmap/serialize/part
> PASS 38 test-hbitmap /hbitmap/serialize/zeroes
> ---
> PASS 43 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-drain -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-bdrv-drain"
> PASS 3 ahci-test /x86_64/ahci/pci_enable
> ==8169==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-bdrv-drain /bdrv-drain/nested
> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
> ---
> PASS 23 test-bdrv-drain /bdrv-drain/blockjob/drain_subtree
> PASS 24 test-bdrv-drain /bdrv-drain/blockjob/error/drain_all
> PASS 25 test-bdrv-drain /bdrv-drain/blockjob/error/drain
> ==8171==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 26 test-bdrv-drain /bdrv-drain/blockjob/error/drain_subtree
> PASS 27 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain_all
> PASS 28 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain
> ---
> PASS 38 test-bdrv-drain /bdrv-drain/detach/driver_cb
> PASS 39 test-bdrv-drain /bdrv-drain/attach/drain
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-graph-mod -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-bdrv-graph-mod"
> ==8215==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 ahci-test /x86_64/ahci/hba_spec
> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-blockjob"
> ==8221==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob /blockjob/ids
> PASS 2 test-blockjob /blockjob/cancel/created
> PASS 3 test-blockjob /blockjob/cancel/running
> ==8219==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 test-blockjob /blockjob/cancel/paused
> PASS 5 test-blockjob /blockjob/cancel/ready
> PASS 6 test-blockjob /blockjob/cancel/standby
> PASS 7 test-blockjob /blockjob/cancel/pending
> PASS 8 test-blockjob /blockjob/cancel/concluded
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob-txn -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-blockjob-txn"
> ==8231==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob-txn /single/success
> PASS 2 test-blockjob-txn /single/failure
> PASS 3 test-blockjob-txn /single/cancel
> ---
> PASS 7 test-blockjob-txn /pair/fail-cancel-race
> PASS 5 ahci-test /x86_64/ahci/hba_enable
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-backend -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-block-backend"
> ==8237==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-block-backend /block-backend/drain_aio_error
> PASS 2 test-block-backend /block-backend/drain_all_aio_error
> ==8235==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-iothread -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-block-iothread"
> ==8247==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-block-iothread /sync-op/pread
> PASS 2 test-block-iothread /sync-op/pwrite
> PASS 3 test-block-iothread /sync-op/load_vmstate
> ---
> PASS 16 test-block-iothread /propagate/mirror
> PASS 6 ahci-test /x86_64/ahci/identify
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-image-locking -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-image-locking"
> ==8269==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-image-locking /image-locking/basic
> PASS 2 test-image-locking /image-locking/set-perm-abort
> ==8267==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-x86-cpuid -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-x86-cpuid"
> PASS 1 test-x86-cpuid /cpuid/topology/basic
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-xbzrle -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-xbzrle"
> ---
> PASS 3 test-xbzrle /xbzrle/encode_decode_unchanged
> PASS 4 test-xbzrle /xbzrle/encode_decode_1_byte
> PASS 5 test-xbzrle /xbzrle/encode_decode_overflow
> ==8285==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 test-xbzrle /xbzrle/encode_decode
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-vmstate -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-vmstate"
> PASS 1 test-vmstate /vmstate/tmp_struct
> ---
> PASS 9 test-int128 /int128/int128_gt
> PASS 10 test-int128 /int128/int128_rshift
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/rcutorture -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="rcutorture"
> ==8313==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8313==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffc6c940000; bottom 0x7f6224bfe000; size: 0x009a47d42000
> (662630047744)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 rcutorture /rcu/torture/1reader
> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
> ==8346==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 rcutorture /rcu/torture/10readers
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-list -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-rcu-list"
> ==8346==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7fff8706d000; bottom 0x7f38de3fe000; size: 0x00c6a8c6f000
> (853235134464)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
> ==8359==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-rcu-list /rcu/qlist/single-threaded
> ==8359==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffd909ac000; bottom 0x7f7a81bfe000; size: 0x00830edae000
> (562889940992)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
> PASS 2 test-rcu-list /rcu/qlist/short-few
> ==8371==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8371==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffc4e8db000; bottom 0x7f6dc61fe000; size: 0x008e886dd000
> (612174254080)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
> ==8398==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8398==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffecf140000; bottom 0x7fb9bd7fe000; size: 0x004511942000
> (296647663616)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 3 test-rcu-list /rcu/qlist/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-simpleq -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-rcu-simpleq"
> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
> ==8411==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded
> ==8411==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe90d23000; bottom 0x7f7d0f5fe000; size: 0x008181725000
> (556222533632)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
> PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few
> ==8423==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8423==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffc5891a000; bottom 0x7f14ded24000; size: 0x00e779bf6000
> (994180030464)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
> ==8450==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8450==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7fff839f1000; bottom 0x7f0c10ffe000; size: 0x00f3729f3000
> (1045600088064)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-tailq -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-rcu-tailq"
> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
> ==8463==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
> ==8463==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffcde472000; bottom 0x7fb7b677c000; size: 0x004527cf6000
> (297020645376)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
> ==8496==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qdist -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-qdist"
> ==8502==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-qdist /qdist/none
> PASS 2 test-qdist /qdist/pr
> PASS 3 test-qdist /qdist/single/empty
> ---
> PASS 8 test-qdist /qdist/binning/shrink
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qht -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-qht"
> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
> ==8517==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
> ==8523==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8523==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffc92234000; bottom 0x7f2d413fe000; size: 0x00cf50e36000
> (890415308800)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
> ==8529==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8529==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe9ceaf000; bottom 0x7f2408bfe000; size: 0x00da942b1000
> (938788720640)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
> ==8535==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8535==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffdbaa3a000; bottom 0x7fadd47fe000; size: 0x004fe623c000
> (343163518976)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
> ==8541==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8541==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe3fc80000; bottom 0x7f5d5f5fe000; size: 0x00a0e0682000
> (690959687680)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
> ==8547==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8547==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffcdaf8b000; bottom 0x7f03e41fe000; size: 0x00f8f6d8d000
> (1069293293568)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
> ==8553==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8553==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffff7a41000; bottom 0x7fad853fe000; size: 0x005272643000
> (354106486784)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
> ==8559==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8559==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7fff219ce000; bottom 0x7f9e96124000; size: 0x00608b8aa000
> (414657978368)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
> ==8565==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==8565==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe154da000; bottom 0x7fce2f7fe000; size: 0x002fe5cdc000
> (205718929408)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low
> ==8571==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-qht /qht/mode/default
> ==8571==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffd0d93e000; bottom 0x7ff88157c000; size: 0x00048c3c2000
> (19532619776)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 2 test-qht /qht/mode/resize
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qht-par -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-qht-par"
> PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high
> ==8587==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s
> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
> ==8600==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bitops -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-bitops"
> PASS 1 test-bitops /bitops/sextract32
> ---
> PASS 1 check-qom-interface /qom/interface/direct_impl
> PASS 2 check-qom-interface /qom/interface/intermediate_impl
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/check-qom-proplist -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="check-qom-proplist"
> ==8622==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 check-qom-proplist /qom/proplist/createlist
> PASS 2 check-qom-proplist /qom/proplist/createv
> PASS 3 check-qom-proplist /qom/proplist/createcmdline
> ---
> PASS 3 test-write-threshold /write-threshold/multi-set-get
> PASS 4 test-write-threshold /write-threshold/not-trigger
> PASS 5 test-write-threshold /write-threshold/trigger
> ==8654==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-hash -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-crypto-hash"
> PASS 1 test-crypto-hash /crypto/hash/iov
> PASS 2 test-crypto-hash /crypto/hash/alloc
> ---
> PASS 15 test-crypto-secret /crypto/secret/crypt/missingiv
> PASS 16 test-crypto-secret /crypto/secret/crypt/badiv
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-tlscredsx509 -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-crypto-tlscredsx509"
> ==8678==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver
> PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient
> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
> PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1
> ==8690==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
> PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2
> ==8696==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
> ==8702==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3
> PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1
> PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2
> ---
> PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1
> PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2
> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
> ==8708==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
> PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3
> PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4
> ==8714==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5
> PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6
> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
> ==8720==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7
> PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1
> PASS 17 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver2
> ---
> PASS 33 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive2
> PASS 34 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive3
> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
> ==8726==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 35 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain1
> PASS 36 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain2
> PASS 37 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingca
> ---
> PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-tlssession -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-crypto-tlssession"
> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
> ==8737==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
> ==8743==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk
> PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca
> PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca
> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
> ==8749==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1
> PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2
> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
> PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3
> ==8755==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4
> PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5
> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
> PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6
> PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1
> ==8761==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2
> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
> ==8767==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3
> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
> ==8773==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4
> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
> ==8779==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5
> PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6
> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
> ==8785==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-qga"
> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
> ---
> PASS 8 test-qga /qga/get-memory-block-info
> PASS 9 test-qga /qga/get-memory-blocks
> PASS 10 test-qga /qga/file-ops
> ==8797==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 11 test-qga /qga/file-write-read
> PASS 12 test-qga /qga/get-time
> PASS 13 test-qga /qga/id
> ---
> PASS 19 test-qga /qga/config
> PASS 20 test-qga /qga/guest-exec
> PASS 21 test-qga /qga/guest-exec-invalid
> ==8805==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
> ==8818==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 22 test-qga /qga/guest-get-osinfo
> PASS 23 test-qga /qga/guest-get-host-name
> PASS 24 test-qga /qga/guest-get-timezone
> ---
> PASS 7 test-util-sockets /socket/fd-pass/num/bad
> PASS 8 test-util-sockets /socket/fd-pass/num/nocli
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-authz-simple -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-authz-simple"
> ==8841==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-authz-simple /authz/simple
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-authz-list -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-authz-list"
> PASS 1 test-authz-list /auth/list/complex
> ---
> PASS 4 test-io-channel-file /io/channel/pipe/sync
> PASS 5 test-io-channel-file /io/channel/pipe/async
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-io-channel-tls -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-io-channel-tls"
> ==8910==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-io-channel-tls /qio/channel/tls/basic
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-io-channel-command -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-io-channel-command"
> PASS 1 test-io-channel-command /io/channel/command/fifo/sync
> ---
> PASS 3 test-base64 /util/base64/not-nul-terminated
> PASS 4 test-base64 /util/base64/invalid-chars
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-pbkdf -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-crypto-pbkdf"
> ==8943==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1
> PASS 2 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter2
> PASS 3 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1200a
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-block -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-crypto-block"
> PASS 1 test-crypto-block /crypto/block/qcow
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-logging -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-logging"
> ==8975==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-logging /logging/parse_range
> PASS 2 test-logging /logging/parse_path
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-replication -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-replication"
> ==8990==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-replication /replication/primary/read
> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
> PASS 2 test-replication /replication/primary/write
> ==8995==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 test-replication /replication/primary/start
> PASS 4 test-replication /replication/primary/stop
> PASS 5 test-replication /replication/primary/do_checkpoint
> PASS 6 test-replication /replication/primary/get_error_all
> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
> ==9001==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 7 test-replication /replication/secondary/read
> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
> ==9007==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 8 test-replication /replication/secondary/write
> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
> ==9013==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 61 ahci-test /x86_64/ahci/flush/simple
> ==8990==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe50cfb000; bottom 0x7fc4228fc000; size: 0x003a2e3ff000
> (249884045312)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> ==9019==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 9 test-replication /replication/secondary/start
> PASS 62 ahci-test /x86_64/ahci/flush/retry
> ==9043==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9048==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 10 test-replication /replication/secondary/stop
> PASS 63 ahci-test /x86_64/ahci/flush/migrate
> ==9057==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 11 test-replication /replication/secondary/do_checkpoint
> ==9062==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 12 test-replication /replication/secondary/get_error_all
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bufferiszero -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-bufferiszero"
> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
> ==9076==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9081==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
> ==9090==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9095==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
> ==9104==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9109==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
> ==9118==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9123==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
> ==9132==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
> ==9137==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
> ==9143==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
> ==9149==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
> ==9155==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> ==9155==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffe44ee2000; bottom 0x7fc156f74000; size: 0x003cedf6e000
> (261690417152)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
> ==9161==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/hd-geo-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="hd-geo-test"
> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
> ==9175==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
> ==9181==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
> ==9187==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-bufferiszero /cutils/bufferiszero
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-uuid -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-uuid"
> PASS 1 test-uuid /uuid/is_null
> ---
> PASS 1 test-qapi-util /qapi/util/qapi_enum_parse
> PASS 2 test-qapi-util /qapi/util/parse_qapi_name
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qgraph -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-qgraph"
> ==9201==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-qgraph /qgraph/init_nop
> PASS 2 test-qgraph /qgraph/test_machine
> PASS 3 test-qgraph /qgraph/test_contains
> ---
> PASS 22 test-qgraph /qgraph/test_test_in_path
> PASS 23 test-qgraph /qgraph/test_double_edge
> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
> ==9216==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
> ==9222==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
> ==9228==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
> ==9234==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
> ==9239==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/boot-order-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="boot-order-test"
> PASS 1 boot-order-test /x86_64/boot-order/pc
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9307==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 bios-tables-test /x86_64/acpi/piix4
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9313==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 bios-tables-test /x86_64/acpi/q35
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9319==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 bios-tables-test /x86_64/acpi/piix4/bridge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9325==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9331==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 5 bios-tables-test /x86_64/acpi/piix4/cpuhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9338==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 bios-tables-test /x86_64/acpi/piix4/memhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9344==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 7 bios-tables-test /x86_64/acpi/piix4/numamem
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9350==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 8 bios-tables-test /x86_64/acpi/piix4/dimmpxm
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9359==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 9 bios-tables-test /x86_64/acpi/q35/bridge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9365==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 10 bios-tables-test /x86_64/acpi/q35/mmio64
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9371==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 11 bios-tables-test /x86_64/acpi/q35/ipmi
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9377==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 12 bios-tables-test /x86_64/acpi/q35/cpuhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9384==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 13 bios-tables-test /x86_64/acpi/q35/memhp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9390==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 14 bios-tables-test /x86_64/acpi/q35/numamem
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9396==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 15 bios-tables-test /x86_64/acpi/q35/dimmpxm
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/boot-serial-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="boot-serial-test"
> PASS 1 boot-serial-test /x86_64/boot-serial/isapc
> ---
> PASS 1 i440fx-test /x86_64/i440fx/defaults
> PASS 2 i440fx-test /x86_64/i440fx/pam
> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
> ==9480==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/fw_cfg-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="fw_cfg-test"
> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/drive_del-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="drive_del-test"
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> ==9568==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/wdt_ib700-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="wdt_ib700-test"
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
> ==9763==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/usb-hcd-xhci-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="usb-hcd-xhci-test"
> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
> ==9772==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/cpu-plug-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="cpu-plug-test"
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9878==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9884==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9890==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/tpm-crb-swtpm-test -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="tpm-crb-swtpm-test"
> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in
> PATH or missing --tpm2 support
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==9995==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10000==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 3 migration-test /x86_64/migration/fd_proto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10008==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10013==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 4 migration-test /x86_64/migration/postcopy/unix
> PASS 5 migration-test /x86_64/migration/postcopy/recovery
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10043==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10048==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 6 migration-test /x86_64/migration/precopy/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10057==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10062==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 7 migration-test /x86_64/migration/precopy/tcp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10071==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> ==10076==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 8 migration-test /x86_64/migration/xbzrle/unix
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/test-x86-cpuid-compat -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-x86-cpuid-compat"
> PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus
> ---
> PASS 6 numa-test /x86_64/numa/pc/dynamic/cpu
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img
> tests/qmp-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="qmp-test"
> PASS 1 qmp-test /x86_64/qmp/protocol
> ==10405==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 qmp-test /x86_64/qmp/oob
> PASS 3 qmp-test /x86_64/qmp/preconfig
> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
> ---
> PASS 5 device-introspect-test /x86_64/device/introspect/abstract-interfaces
>
> =================================================================
> ==10653==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x563b8efcbb6e in calloc
> (/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64+0x19f9b6e)
> ---
>
> SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
> /tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate
> QEMU process but encountered exit status 1
> ERROR - too few tests run (expected 6, got 5)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:896:
> check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>
>
> The full log is available at
>
> http://patchew.org/logs/20190703190715.5328-1-jonathan@fintelia.io/testing.asan/?type=message
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--000000000000f412e9059ca646c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t think this was ever merged?<br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, =
2019 at 10:37 PM &lt;<a href=3D"mailto:no-reply@patchew.org">no-reply@patch=
ew.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Patchew URL: <a href=3D"https://patchew.org/QEMU/20190703190715.5328-=
1-jonathan@fintelia.io/" rel=3D"noreferrer" target=3D"_blank">https://patch=
ew.org/QEMU/20190703190715.5328-1-jonathan@fintelia.io/</a><br>
<br>
<br>
<br>
Hi,<br>
<br>
This series failed the asan build test. Please find the testing commands an=
d<br>
their output below. If you have Docker installed, you can probably reproduc=
e it<br>
locally.<br>
<br>
=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
#!/bin/bash<br>
make docker-image-fedora V=3D1 NETWORK=3D1<br>
time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NETW=
ORK=3D1<br>
=3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
<br>
PASS 1 fdc-test /x86_64/fdc/cmos<br>
PASS 2 fdc-test /x86_64/fdc/no_media_on_start<br>
PASS 3 fdc-test /x86_64/fdc/read_without_media<br>
=3D=3D7862=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 fdc-test /x86_64/fdc/media_change<br>
PASS 5 fdc-test /x86_64/fdc/sense_interrupt<br>
PASS 6 fdc-test /x86_64/fdc/relative_seek<br>
---<br>
PASS 32 test-opts-visitor /visitor/opts/range/beyond<br>
PASS 33 test-opts-visitor /visitor/opts/dict/unvisited<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-coroutine -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-coroutine&quot; <br>
=3D=3D7913=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7913=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffea51ee000; bottom 0x7fcaef4f8000; size: 0x0033b5cf6000 (2=
22093598720)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-coroutine /basic/no-dangling-access<br>
---<br>
PASS 11 test-aio /aio/event/wait<br>
PASS 12 test-aio /aio/event/flush<br>
PASS 13 test-aio /aio/event/wait/no-flush-cb<br>
=3D=3D7929=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 test-aio /aio/timer/schedule<br>
PASS 15 test-aio /aio/coroutine/queue-chaining<br>
PASS 16 test-aio /aio-gsource/flush<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/ide-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;ide-test&quot; <br>
PASS 28 test-aio /aio-gsource/timer/schedule<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-aio-multithread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a =
href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driv=
er.pl</a> --test-name=3D&quot;test-aio-multithread&quot; <br>
=3D=3D7938=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7942=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-aio-multithread /aio/multi/lifecycle<br>
PASS 1 ide-test /x86_64/ide/identify<br>
=3D=3D7959=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 test-aio-multithread /aio/multi/schedule<br>
PASS 2 ide-test /x86_64/ide/flush<br>
PASS 3 test-aio-multithread /aio/multi/mutex/contended<br>
=3D=3D7970=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 ide-test /x86_64/ide/bmdma/simple_rw<br>
=3D=3D7981=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 ide-test /x86_64/ide/bmdma/trim<br>
=3D=3D7987=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 test-aio-multithread /aio/multi/mutex/handoff<br>
PASS 5 ide-test /x86_64/ide/bmdma/short_prdt<br>
PASS 5 test-aio-multithread /aio/multi/mutex/mcs<br>
=3D=3D7998=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 ide-test /x86_64/ide/bmdma/one_sector_short_prdt<br>
PASS 6 test-aio-multithread /aio/multi/mutex/pthread<br>
=3D=3D8009=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-throttle -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-throttle&quot; <br>
=3D=3D8016=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-throttle /throttle/leak_bucket<br>
PASS 2 test-throttle /throttle/compute_wait<br>
PASS 3 test-throttle /throttle/init<br>
---<br>
PASS 15 test-throttle /throttle/config/iops_size<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-thread-pool -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-thread-pool&quot; <br>
PASS 7 ide-test /x86_64/ide/bmdma/long_prdt<br>
=3D=3D8022=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-thread-pool /thread-pool/submit<br>
PASS 2 test-thread-pool /thread-pool/submit-aio<br>
PASS 3 test-thread-pool /thread-pool/submit-co<br>
PASS 4 test-thread-pool /thread-pool/submit-many<br>
=3D=3D8024=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8024=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffd539ab000; bottom 0x7f7e855fe000; size: 0x007ece3ad000 (5=
44625840128)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 8 ide-test /x86_64/ide/bmdma/no_busmaster<br>
PASS 5 test-thread-pool /thread-pool/cancel<br>
PASS 9 ide-test /x86_64/ide/flush/nodev<br>
=3D=3D8100=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 ide-test /x86_64/ide/flush/empty_drive<br>
PASS 6 test-thread-pool /thread-pool/cancel-async<br>
=3D=3D8106=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-hbitmap -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-hbitmap&quot; <br>
PASS 1 test-hbitmap /hbitmap/granularity<br>
PASS 2 test-hbitmap /hbitmap/size/0<br>
---<br>
PASS 4 test-hbitmap /hbitmap/iter/empty<br>
PASS 11 ide-test /x86_64/ide/flush/retry_pci<br>
PASS 5 test-hbitmap /hbitmap/iter/partial<br>
=3D=3D8117=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 test-hbitmap /hbitmap/iter/granularity<br>
PASS 7 test-hbitmap /hbitmap/iter/iter_and_reset<br>
PASS 8 test-hbitmap /hbitmap/get/all<br>
---<br>
PASS 14 test-hbitmap /hbitmap/set/twice<br>
PASS 15 test-hbitmap /hbitmap/set/overlap<br>
PASS 16 test-hbitmap /hbitmap/reset/empty<br>
=3D=3D8123=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 17 test-hbitmap /hbitmap/reset/general<br>
PASS 13 ide-test /x86_64/ide/cdrom/pio<br>
PASS 18 test-hbitmap /hbitmap/reset/all<br>
---<br>
PASS 28 test-hbitmap /hbitmap/truncate/shrink/medium<br>
PASS 29 test-hbitmap /hbitmap/truncate/shrink/large<br>
PASS 30 test-hbitmap /hbitmap/meta/zero<br>
=3D=3D8129=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 ide-test /x86_64/ide/cdrom/pio_large<br>
=3D=3D8135=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 ide-test /x86_64/ide/cdrom/dma<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/ahci-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;ahci-test&quot; <br>
PASS 31 test-hbitmap /hbitmap/meta/one<br>
PASS 32 test-hbitmap /hbitmap/meta/byte<br>
PASS 33 test-hbitmap /hbitmap/meta/word<br>
=3D=3D8149=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 ahci-test /x86_64/ahci/sanity<br>
PASS 34 test-hbitmap /hbitmap/meta/sector<br>
PASS 35 test-hbitmap /hbitmap/serialize/align<br>
=3D=3D8155=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 ahci-test /x86_64/ahci/pci_spec<br>
=3D=3D8161=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 36 test-hbitmap /hbitmap/serialize/basic<br>
PASS 37 test-hbitmap /hbitmap/serialize/part<br>
PASS 38 test-hbitmap /hbitmap/serialize/zeroes<br>
---<br>
PASS 43 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bdrv-drain -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-bdrv-drain&quot; <br>
PASS 3 ahci-test /x86_64/ahci/pci_enable<br>
=3D=3D8169=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bdrv-drain /bdrv-drain/nested<br>
PASS 2 test-bdrv-drain /bdrv-drain/multiparent<br>
PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context<br>
---<br>
PASS 23 test-bdrv-drain /bdrv-drain/blockjob/drain_subtree<br>
PASS 24 test-bdrv-drain /bdrv-drain/blockjob/error/drain_all<br>
PASS 25 test-bdrv-drain /bdrv-drain/blockjob/error/drain<br>
=3D=3D8171=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 26 test-bdrv-drain /bdrv-drain/blockjob/error/drain_subtree<br>
PASS 27 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain_all<br>
PASS 28 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain<br>
---<br>
PASS 38 test-bdrv-drain /bdrv-drain/detach/driver_cb<br>
PASS 39 test-bdrv-drain /bdrv-drain/attach/drain<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bdrv-graph-mod -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-bdrv-graph-mod&quot; <br>
=3D=3D8215=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 ahci-test /x86_64/ahci/hba_spec<br>
PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree<br>
PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-blockjob -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-blockjob&quot; <br>
=3D=3D8221=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-blockjob /blockjob/ids<br>
PASS 2 test-blockjob /blockjob/cancel/created<br>
PASS 3 test-blockjob /blockjob/cancel/running<br>
=3D=3D8219=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 test-blockjob /blockjob/cancel/paused<br>
PASS 5 test-blockjob /blockjob/cancel/ready<br>
PASS 6 test-blockjob /blockjob/cancel/standby<br>
PASS 7 test-blockjob /blockjob/cancel/pending<br>
PASS 8 test-blockjob /blockjob/cancel/concluded<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-blockjob-txn -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-blockjob-txn&quot; <br>
=3D=3D8231=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-blockjob-txn /single/success<br>
PASS 2 test-blockjob-txn /single/failure<br>
PASS 3 test-blockjob-txn /single/cancel<br>
---<br>
PASS 7 test-blockjob-txn /pair/fail-cancel-race<br>
PASS 5 ahci-test /x86_64/ahci/hba_enable<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-block-backend -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-block-backend&quot; <br>
=3D=3D8237=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-block-backend /block-backend/drain_aio_error<br>
PASS 2 test-block-backend /block-backend/drain_all_aio_error<br>
=3D=3D8235=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-block-iothread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-block-iothread&quot; <br>
=3D=3D8247=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-block-iothread /sync-op/pread<br>
PASS 2 test-block-iothread /sync-op/pwrite<br>
PASS 3 test-block-iothread /sync-op/load_vmstate<br>
---<br>
PASS 16 test-block-iothread /propagate/mirror<br>
PASS 6 ahci-test /x86_64/ahci/identify<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-image-locking -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-image-locking&quot; <br>
=3D=3D8269=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-image-locking /image-locking/basic<br>
PASS 2 test-image-locking /image-locking/set-perm-abort<br>
=3D=3D8267=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-x86-cpuid -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-x86-cpuid&quot; <br>
PASS 1 test-x86-cpuid /cpuid/topology/basic<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-xbzrle -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"h=
ttp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a>=
 --test-name=3D&quot;test-xbzrle&quot; <br>
---<br>
PASS 3 test-xbzrle /xbzrle/encode_decode_unchanged<br>
PASS 4 test-xbzrle /xbzrle/encode_decode_1_byte<br>
PASS 5 test-xbzrle /xbzrle/encode_decode_overflow<br>
=3D=3D8285=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 test-xbzrle /xbzrle/encode_decode<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-vmstate -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-vmstate&quot; <br>
PASS 1 test-vmstate /vmstate/tmp_struct<br>
---<br>
PASS 9 test-int128 /int128/int128_gt<br>
PASS 10 test-int128 /int128/int128_rshift<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/rcutorture -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"ht=
tp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> =
--test-name=3D&quot;rcutorture&quot; <br>
=3D=3D8313=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8313=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc6c940000; bottom 0x7f6224bfe000; size: 0x009a47d42000 (6=
62630047744)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 rcutorture /rcu/torture/1reader<br>
PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero<br>
=3D=3D8346=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 rcutorture /rcu/torture/10readers<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-list -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-rcu-list&quot; <br>
=3D=3D8346=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff8706d000; bottom 0x7f38de3fe000; size: 0x00c6a8c6f000 (8=
53235134464)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low<br>
=3D=3D8359=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-rcu-list /rcu/qlist/single-threaded<br>
=3D=3D8359=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffd909ac000; bottom 0x7f7a81bfe000; size: 0x00830edae000 (5=
62889940992)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high<br>
PASS 2 test-rcu-list /rcu/qlist/short-few<br>
=3D=3D8371=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8371=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc4e8db000; bottom 0x7f6dc61fe000; size: 0x008e886dd000 (6=
12174254080)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero<br>
=3D=3D8398=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8398=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffecf140000; bottom 0x7fb9bd7fe000; size: 0x004511942000 (2=
96647663616)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 3 test-rcu-list /rcu/qlist/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-simpleq -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-rcu-simpleq&quot; <br>
PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low<br>
=3D=3D8411=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded<br>
=3D=3D8411=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe90d23000; bottom 0x7f7d0f5fe000; size: 0x008181725000 (5=
56222533632)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high<br>
PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few<br>
=3D=3D8423=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8423=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc5891a000; bottom 0x7f14ded24000; size: 0x00e779bf6000 (9=
94180030464)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero<br>
=3D=3D8450=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8450=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff839f1000; bottom 0x7f0c10ffe000; size: 0x00f3729f3000 (1=
045600088064)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-tailq -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-rcu-tailq&quot; <br>
PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low<br>
=3D=3D8463=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded<br>
=3D=3D8463=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffcde472000; bottom 0x7fb7b677c000; size: 0x004527cf6000 (2=
97020645376)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 2 test-rcu-tailq /rcu/qtailq/short-few<br>
PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high<br>
=3D=3D8496=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero<br>
PASS 3 test-rcu-tailq /rcu/qtailq/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qdist -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"ht=
tp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> =
--test-name=3D&quot;test-qdist&quot; <br>
=3D=3D8502=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-qdist /qdist/none<br>
PASS 2 test-qdist /qdist/pr<br>
PASS 3 test-qdist /qdist/single/empty<br>
---<br>
PASS 8 test-qdist /qdist/binning/shrink<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qht -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"http=
://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> --=
test-name=3D&quot;test-qht&quot; <br>
PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low<br>
=3D=3D8517=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high<br>
=3D=3D8523=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8523=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc92234000; bottom 0x7f2d413fe000; size: 0x00cf50e36000 (8=
90415308800)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero<br>
=3D=3D8529=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8529=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe9ceaf000; bottom 0x7f2408bfe000; size: 0x00da942b1000 (9=
38788720640)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low<br>
=3D=3D8535=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8535=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffdbaa3a000; bottom 0x7fadd47fe000; size: 0x004fe623c000 (3=
43163518976)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high<br>
=3D=3D8541=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8541=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe3fc80000; bottom 0x7f5d5f5fe000; size: 0x00a0e0682000 (6=
90959687680)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero<br>
=3D=3D8547=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8547=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffcdaf8b000; bottom 0x7f03e41fe000; size: 0x00f8f6d8d000 (1=
069293293568)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low<br>
=3D=3D8553=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8553=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffff7a41000; bottom 0x7fad853fe000; size: 0x005272643000 (3=
54106486784)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high<br>
=3D=3D8559=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8559=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff219ce000; bottom 0x7f9e96124000; size: 0x00608b8aa000 (4=
14657978368)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero<br>
=3D=3D8565=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D8565=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe154da000; bottom 0x7fce2f7fe000; size: 0x002fe5cdc000 (2=
05718929408)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low<br>
=3D=3D8571=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-qht /qht/mode/default<br>
=3D=3D8571=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffd0d93e000; bottom 0x7ff88157c000; size: 0x00048c3c2000 (1=
9532619776)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 2 test-qht /qht/mode/resize<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qht-par -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-qht-par&quot; <br>
PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high<br>
=3D=3D8587=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s<br>
PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero<br>
=3D=3D8600=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bitops -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"h=
ttp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a>=
 --test-name=3D&quot;test-bitops&quot; <br>
PASS 1 test-bitops /bitops/sextract32<br>
---<br>
PASS 1 check-qom-interface /qom/interface/direct_impl<br>
PASS 2 check-qom-interface /qom/interface/intermediate_impl<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/check-qom-proplist -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;check-qom-proplist&quot; <br>
=3D=3D8622=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 check-qom-proplist /qom/proplist/createlist<br>
PASS 2 check-qom-proplist /qom/proplist/createv<br>
PASS 3 check-qom-proplist /qom/proplist/createcmdline<br>
---<br>
PASS 3 test-write-threshold /write-threshold/multi-set-get<br>
PASS 4 test-write-threshold /write-threshold/not-trigger<br>
PASS 5 test-write-threshold /write-threshold/trigger<br>
=3D=3D8654=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-hash -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-crypto-hash&quot; <br>
PASS 1 test-crypto-hash /crypto/hash/iov<br>
PASS 2 test-crypto-hash /crypto/hash/alloc<br>
---<br>
PASS 15 test-crypto-secret /crypto/secret/crypt/missingiv<br>
PASS 16 test-crypto-secret /crypto/secret/crypt/badiv<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-tlscredsx509 -m=3Dquick -k --tap &lt; /dev/null | ./scripts=
/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-=
driver.pl</a> --test-name=3D&quot;test-crypto-tlscredsx509&quot; <br>
=3D=3D8678=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver<br>
PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient<br>
PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry<br>
PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1<br>
=3D=3D8690=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero<br>
PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2<br>
=3D=3D8696=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low<br>
=3D=3D8702=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3<br>
PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1<br>
PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2<br>
---<br>
PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1<br>
PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2<br>
PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high<br>
=3D=3D8708=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero<br>
PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3<br>
PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4<br>
=3D=3D8714=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5<br>
PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6<br>
PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low<br>
=3D=3D8720=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7<br>
PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1<br>
PASS 17 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver2<br>
---<br>
PASS 33 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive2<br>
PASS 34 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive3<br>
PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high<br>
=3D=3D8726=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 35 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain1<br>
PASS 36 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain2<br>
PASS 37 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingca<br>
---<br>
PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-tlssession -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<=
a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dr=
iver.pl</a> --test-name=3D&quot;test-crypto-tlssession&quot; <br>
PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero<br>
=3D=3D8737=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low<br>
=3D=3D8743=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk<br>
PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca<br>
PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca<br>
PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high<br>
=3D=3D8749=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1<br>
PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2<br>
PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero<br>
PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3<br>
=3D=3D8755=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4<br>
PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5<br>
PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low<br>
PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6<br>
PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1<br>
=3D=3D8761=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2<br>
PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high<br>
=3D=3D8767=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3<br>
PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero<br>
=3D=3D8773=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4<br>
PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low<br>
=3D=3D8779=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5<br>
PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6<br>
PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high<br>
=3D=3D8785=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qga -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"http=
://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> --=
test-name=3D&quot;test-qga&quot; <br>
PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero<br>
---<br>
PASS 8 test-qga /qga/get-memory-block-info<br>
PASS 9 test-qga /qga/get-memory-blocks<br>
PASS 10 test-qga /qga/file-ops<br>
=3D=3D8797=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 test-qga /qga/file-write-read<br>
PASS 12 test-qga /qga/get-time<br>
PASS 13 test-qga /qga/id<br>
---<br>
PASS 19 test-qga /qga/config<br>
PASS 20 test-qga /qga/guest-exec<br>
PASS 21 test-qga /qga/guest-exec-invalid<br>
=3D=3D8805=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high<br>
=3D=3D8818=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 22 test-qga /qga/guest-get-osinfo<br>
PASS 23 test-qga /qga/guest-get-host-name<br>
PASS 24 test-qga /qga/guest-get-timezone<br>
---<br>
PASS 7 test-util-sockets /socket/fd-pass/num/bad<br>
PASS 8 test-util-sockets /socket/fd-pass/num/nocli<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-authz-simple -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-authz-simple&quot; <br>
=3D=3D8841=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-authz-simple /authz/simple<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-authz-list -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-authz-list&quot; <br>
PASS 1 test-authz-list /auth/list/complex<br>
---<br>
PASS 4 test-io-channel-file /io/channel/pipe/sync<br>
PASS 5 test-io-channel-file /io/channel/pipe/async<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-io-channel-tls -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-io-channel-tls&quot; <br>
=3D=3D8910=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-io-channel-tls /qio/channel/tls/basic<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-io-channel-command -m=3Dquick -k --tap &lt; /dev/null | ./scripts/=
<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-d=
river.pl</a> --test-name=3D&quot;test-io-channel-command&quot; <br>
PASS 1 test-io-channel-command /io/channel/command/fifo/sync<br>
---<br>
PASS 3 test-base64 /util/base64/not-nul-terminated<br>
PASS 4 test-base64 /util/base64/invalid-chars<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-pbkdf -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-crypto-pbkdf&quot; <br>
=3D=3D8943=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1<br>
PASS 2 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter2<br>
PASS 3 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1200a<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-block -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-crypto-block&quot; <br>
PASS 1 test-crypto-block /crypto/block/qcow<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-logging -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-logging&quot; <br>
=3D=3D8975=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-logging /logging/parse_range<br>
PASS 2 test-logging /logging/parse_path<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-replication -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-replication&quot; <br>
=3D=3D8990=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-replication /replication/primary/read<br>
PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low<br>
PASS 2 test-replication /replication/primary/write<br>
=3D=3D8995=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 test-replication /replication/primary/start<br>
PASS 4 test-replication /replication/primary/stop<br>
PASS 5 test-replication /replication/primary/do_checkpoint<br>
PASS 6 test-replication /replication/primary/get_error_all<br>
PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high<br>
=3D=3D9001=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 test-replication /replication/secondary/read<br>
PASS 59 ahci-test /x86_64/ahci/io/ncq/simple<br>
=3D=3D9007=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 test-replication /replication/secondary/write<br>
PASS 60 ahci-test /x86_64/ahci/io/ncq/retry<br>
=3D=3D9013=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 61 ahci-test /x86_64/ahci/flush/simple<br>
=3D=3D8990=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe50cfb000; bottom 0x7fc4228fc000; size: 0x003a2e3ff000 (2=
49884045312)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
=3D=3D9019=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 test-replication /replication/secondary/start<br>
PASS 62 ahci-test /x86_64/ahci/flush/retry<br>
=3D=3D9043=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9048=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 test-replication /replication/secondary/stop<br>
PASS 63 ahci-test /x86_64/ahci/flush/migrate<br>
=3D=3D9057=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 test-replication /replication/secondary/do_checkpoint<br>
=3D=3D9062=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 test-replication /replication/secondary/get_error_all<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bufferiszero -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-bufferiszero&quot; <br>
PASS 64 ahci-test /x86_64/ahci/migrate/sanity<br>
=3D=3D9076=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9081=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple<br>
=3D=3D9090=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9095=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted<br>
=3D=3D9104=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9109=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple<br>
=3D=3D9118=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9123=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted<br>
=3D=3D9132=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 69 ahci-test /x86_64/ahci/cdrom/eject<br>
=3D=3D9137=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single<br>
=3D=3D9143=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi<br>
=3D=3D9149=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single<br>
=3D=3D9155=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D9155=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe44ee2000; bottom 0x7fc156f74000; size: 0x003cedf6e000 (2=
61690417152)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi<br>
=3D=3D9161=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/hd-geo-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;hd-geo-test&quot; <br>
PASS 1 hd-geo-test /x86_64/hd-geo/ide/none<br>
=3D=3D9175=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0<br>
=3D=3D9181=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank<br>
=3D=3D9187=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bufferiszero /cutils/bufferiszero<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-uuid -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"htt=
p://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> -=
-test-name=3D&quot;test-uuid&quot; <br>
PASS 1 test-uuid /uuid/is_null<br>
---<br>
PASS 1 test-qapi-util /qapi/util/qapi_enum_parse<br>
PASS 2 test-qapi-util /qapi/util/parse_qapi_name<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qgraph -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"h=
ttp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a>=
 --test-name=3D&quot;test-qgraph&quot; <br>
=3D=3D9201=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-qgraph /qgraph/init_nop<br>
PASS 2 test-qgraph /qgraph/test_machine<br>
PASS 3 test-qgraph /qgraph/test_contains<br>
---<br>
PASS 22 test-qgraph /qgraph/test_test_in_path<br>
PASS 23 test-qgraph /qgraph/test_double_edge<br>
PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs<br>
=3D=3D9216=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank<br>
=3D=3D9222=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba<br>
=3D=3D9228=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs<br>
=3D=3D9234=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs<br>
=3D=3D9239=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/boot-order-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a =
href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driv=
er.pl</a> --test-name=3D&quot;boot-order-test&quot; <br>
PASS 1 boot-order-test /x86_64/boot-order/pc<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9307=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 bios-tables-test /x86_64/acpi/piix4<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9313=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 bios-tables-test /x86_64/acpi/q35<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9319=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 bios-tables-test /x86_64/acpi/piix4/bridge<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9325=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9331=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 bios-tables-test /x86_64/acpi/piix4/cpuhp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9338=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 bios-tables-test /x86_64/acpi/piix4/memhp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9344=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 bios-tables-test /x86_64/acpi/piix4/numamem<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9350=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 bios-tables-test /x86_64/acpi/piix4/dimmpxm<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9359=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 bios-tables-test /x86_64/acpi/q35/bridge<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9365=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 bios-tables-test /x86_64/acpi/q35/mmio64<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9371=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 bios-tables-test /x86_64/acpi/q35/ipmi<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9377=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 bios-tables-test /x86_64/acpi/q35/cpuhp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9384=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 bios-tables-test /x86_64/acpi/q35/memhp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9390=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 bios-tables-test /x86_64/acpi/q35/numamem<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9396=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 bios-tables-test /x86_64/acpi/q35/dimmpxm<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/boot-serial-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a=
 href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dri=
ver.pl</a> --test-name=3D&quot;boot-serial-test&quot; <br>
PASS 1 boot-serial-test /x86_64/boot-serial/isapc<br>
---<br>
PASS 1 i440fx-test /x86_64/i440fx/defaults<br>
PASS 2 i440fx-test /x86_64/i440fx/pam<br>
PASS 3 i440fx-test /x86_64/i440fx/firmware/bios<br>
=3D=3D9480=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/fw_cfg-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;fw_cfg-test&quot; <br>
PASS 1 fw_cfg-test /x86_64/fw_cfg/signature<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/drive_del-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;drive_del-test&quot; <br>
PASS 1 drive_del-test /x86_64/drive_del/without-dev<br>
PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add<br>
=3D=3D9568=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/wdt_ib700-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;wdt_ib700-test&quot; <br>
PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause<br>
---<br>
PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init<br>
PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1<br>
PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug<br>
=3D=3D9763=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/usb-hcd-xhci-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<=
a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dr=
iver.pl</a> --test-name=3D&quot;usb-hcd-xhci-test&quot; <br>
PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init<br>
PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug<br>
=3D=3D9772=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas<br>
PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/cpu-plug-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;cpu-plug-test&quot; <br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9878=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9884=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9890=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/tpm-crb-swtpm-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/=
<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-d=
river.pl</a> --test-name=3D&quot;tpm-crb-swtpm-test&quot; <br>
SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in PA=
TH or missing --tpm2 support<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D9995=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10000=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 3 migration-test /x86_64/migration/fd_proto<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10008=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10013=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 4 migration-test /x86_64/migration/postcopy/unix<br>
PASS 5 migration-test /x86_64/migration/postcopy/recovery<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10043=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10048=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 6 migration-test /x86_64/migration/precopy/unix<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10057=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10062=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 7 migration-test /x86_64/migration/precopy/tcp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10071=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: failed to initialize KVM: No such file or directory<br>
qemu-system-x86_64: Back to tcg accelerator<br>
=3D=3D10076=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 8 migration-test /x86_64/migration/xbzrle/unix<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/test-x86-cpuid-compat -m=3Dquick -k --tap &lt; /dev/null | ./scrip=
ts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">ta=
p-driver.pl</a> --test-name=3D&quot;test-x86-cpuid-compat&quot; <br>
PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus<br>
---<br>
PASS 6 numa-test /x86_64/numa/pc/dynamic/cpu<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qmp-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;qmp-test&quot; <br>
PASS 1 qmp-test /x86_64/qmp/protocol<br>
=3D=3D10405=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapco=
ntext functions and may produce false positives in some cases!<br>
PASS 2 qmp-test /x86_64/qmp/oob<br>
PASS 3 qmp-test /x86_64/qmp/preconfig<br>
PASS 4 qmp-test /x86_64/qmp/missing-any-arg<br>
---<br>
PASS 5 device-introspect-test /x86_64/device/introspect/abstract-interfaces=
<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=3D=3D10653=3D=3DERROR: LeakSanitizer: detected memory leaks<br>
<br>
Direct leak of 32 byte(s) in 1 object(s) allocated from:<br>
=C2=A0 =C2=A0 #0 0x563b8efcbb6e in calloc (/tmp/qemu-test/build/x86_64-soft=
mmu/qemu-system-x86_64+0x19f9b6e)<br>
---<br>
<br>
SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).<br>
/tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate QEM=
U process but encountered exit status 1<br>
ERROR - too few tests run (expected 6, got 5)<br>
make: *** [/tmp/qemu-test/src/tests/Makefile.include:896: check-qtest-x86_6=
4] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
Traceback (most recent call last):<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20190703190715.5328-1-jonathan@fintelia.=
io/testing.asan/?type=3Dmessage" rel=3D"noreferrer" target=3D"_blank">http:=
//patchew.org/logs/20190703190715.5328-1-jonathan@fintelia.io/testing.asan/=
?type=3Dmessage</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div>

--000000000000f412e9059ca646c2--

