Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB9DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BAF24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHy6PRiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BAF24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1yj-0000A1-Jm
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 17:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iu1xl-00084Y-09
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iu1xe-0001yw-0q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:25:32 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:34160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iu1xc-0001wz-Eo; Tue, 21 Jan 2020 17:25:25 -0500
Received: by mail-lf1-x142.google.com with SMTP id l18so3710774lfc.1;
 Tue, 21 Jan 2020 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IBXC2XcmvZHTl7ho0I8I3VNxOwleJ9XaM24ZpMcUi4s=;
 b=GHy6PRiOraGvqafYDgxPZdfeBEAMj/+BsIi1wJHRGWA/s/1VgmoR+ogxWR7gsbBiKQ
 B8nbdtEKZMMOvBJqUHw5NTCpBkhiefRr2+fDOiusOfrMAk4UK+7WHsaOLbnwGKHGs+Dg
 tSdVAfkEgLkFo62ZiVA6vVgmmyF/PxoCRQ+jbwjO8pkV9HFJ1x5fkXSfIFmG9nQjzXJ2
 0mVMYnACO4ytPp/Qd3RqUGvzlD/ezMaOOcmR0yunP4M5n1ZVYd4V4NjkxL9qlvz7fhZL
 gecMV1z0YSCZD1pwFIKve+TzTrlMKxYyhjtqTHx/RK9vGbGA5NqpVk/leeElSz86Fm/f
 9nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IBXC2XcmvZHTl7ho0I8I3VNxOwleJ9XaM24ZpMcUi4s=;
 b=HStd6G5uuQw/dT/KKZX5hjUDeQOVwQS+Ru4coUTYWtkZI4Put7Ra2n2P/0jiTnl+eB
 KdjPhplslREBdCSxUVdnbg4BfnWvZDpm+iiSecsxe0F/ZatlB9TcwMqfsWp07weZc2N6
 TopF4wxh/AgHYAyYNJwnfu36f2mJXFEiKSCghQLK+iKydLIec0ixWOoXm41rus0moc9T
 /qZ54swRN05ZLgH+0N7AabY2aJTYdN7WiEZDeWohxWigsT6TXorrXJmWsqMrl6dTS6YA
 C005ZPKkPL3peZ3GaJhtI8aUKxgqb++W3ZXoHVzOF2VhosJm8aWr/V+Wks6y67GuR9r6
 gfvA==
X-Gm-Message-State: APjAAAWdQ4F/5zSLcH3r/6DjpqEyAG0qAEaY4kiWxgP/sYPP5WF6p72i
 Of7Epxxk1e3+6bejXrTF2vtzkIJSMyGiet3jJak=
X-Google-Smtp-Source: APXvYqxJApDXpzj1FOnjxH+AAVRCgvN1NeoUDeaCCanvCy0MevZvrPB85Z2en/tn58oZm1LLptyICiokUoRiSi5hhHQ=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr3848911lfn.137.1579645521720; 
 Tue, 21 Jan 2020 14:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20190703190715.5328-1-jonathan@fintelia.io>
 <156220784052.21218.15000022918303678126@c4a48874b076>
 <CANnJOVEosG_aUcSkS8v8foptEmCpuXQ=apwSawrRB+fs48NaoA@mail.gmail.com>
In-Reply-To: <CANnJOVEosG_aUcSkS8v8foptEmCpuXQ=apwSawrRB+fs48NaoA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jan 2020 08:24:53 +1000
Message-ID: <CAKmqyKN-uYUQ8RCJr+xfdN6XT=DDWeHFdikRrMQU7j+DnU8_iA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Disallow WFI instruction from
 U-mode
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 12:15 AM Jonathan Behrens <jonathan@fintelia.io> wr=
ote:
>
> I don't think this was ever merged?

I don't think so either. Can you send a new version of the patch with
my Reviewed by and an updated commit message and CC Palmers new
address at Google?

Alistair

>
> On Wed, Jul 3, 2019 at 10:37 PM <no-reply@patchew.org> wrote:
>>
>> Patchew URL: https://patchew.org/QEMU/20190703190715.5328-1-jonathan@fin=
telia.io/
>>
>>
>>
>> Hi,
>>
>> This series failed the asan build test. Please find the testing commands=
 and
>> their output below. If you have Docker installed, you can probably repro=
duce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> make docker-image-fedora V=3D1 NETWORK=3D1
>> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 N=
ETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> PASS 1 fdc-test /x86_64/fdc/cmos
>> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
>> PASS 3 fdc-test /x86_64/fdc/read_without_media
>> =3D=3D7862=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 fdc-test /x86_64/fdc/media_change
>> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
>> PASS 6 fdc-test /x86_64/fdc/relative_seek
>> ---
>> PASS 32 test-opts-visitor /visitor/opts/range/beyond
>> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-coroutine -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl =
--test-name=3D"test-coroutine"
>> =3D=3D7913=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D7913=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffea51ee000; bottom 0x7fcaef4f8000; size: 0x0033b5cf6000=
 (222093598720)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 1 test-coroutine /basic/no-dangling-access
>> ---
>> PASS 11 test-aio /aio/event/wait
>> PASS 12 test-aio /aio/event/flush
>> PASS 13 test-aio /aio/event/wait/no-flush-cb
>> =3D=3D7929=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 14 test-aio /aio/timer/schedule
>> PASS 15 test-aio /aio/coroutine/queue-chaining
>> PASS 16 test-aio /aio-gsource/flush
>> ---
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/ide-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"ide-test"
>> PASS 28 test-aio /aio-gsource/timer/schedule
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-aio-multithread -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driv=
er.pl --test-name=3D"test-aio-multithread"
>> =3D=3D7938=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D7942=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-aio-multithread /aio/multi/lifecycle
>> PASS 1 ide-test /x86_64/ide/identify
>> =3D=3D7959=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 test-aio-multithread /aio/multi/schedule
>> PASS 2 ide-test /x86_64/ide/flush
>> PASS 3 test-aio-multithread /aio/multi/mutex/contended
>> =3D=3D7970=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
>> =3D=3D7981=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 ide-test /x86_64/ide/bmdma/trim
>> =3D=3D7987=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
>> PASS 5 ide-test /x86_64/ide/bmdma/short_prdt
>> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
>> =3D=3D7998=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 6 ide-test /x86_64/ide/bmdma/one_sector_short_prdt
>> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
>> =3D=3D8009=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-throttle -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"test-throttle"
>> =3D=3D8016=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-throttle /throttle/leak_bucket
>> PASS 2 test-throttle /throttle/compute_wait
>> PASS 3 test-throttle /throttle/init
>> ---
>> PASS 15 test-throttle /throttle/config/iops_size
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-thread-pool -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"test-thread-pool"
>> PASS 7 ide-test /x86_64/ide/bmdma/long_prdt
>> =3D=3D8022=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-thread-pool /thread-pool/submit
>> PASS 2 test-thread-pool /thread-pool/submit-aio
>> PASS 3 test-thread-pool /thread-pool/submit-co
>> PASS 4 test-thread-pool /thread-pool/submit-many
>> =3D=3D8024=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8024=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffd539ab000; bottom 0x7f7e855fe000; size: 0x007ece3ad000=
 (544625840128)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 8 ide-test /x86_64/ide/bmdma/no_busmaster
>> PASS 5 test-thread-pool /thread-pool/cancel
>> PASS 9 ide-test /x86_64/ide/flush/nodev
>> =3D=3D8100=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 10 ide-test /x86_64/ide/flush/empty_drive
>> PASS 6 test-thread-pool /thread-pool/cancel-async
>> =3D=3D8106=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-hbitmap -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --=
test-name=3D"test-hbitmap"
>> PASS 1 test-hbitmap /hbitmap/granularity
>> PASS 2 test-hbitmap /hbitmap/size/0
>> ---
>> PASS 4 test-hbitmap /hbitmap/iter/empty
>> PASS 11 ide-test /x86_64/ide/flush/retry_pci
>> PASS 5 test-hbitmap /hbitmap/iter/partial
>> =3D=3D8117=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 6 test-hbitmap /hbitmap/iter/granularity
>> PASS 7 test-hbitmap /hbitmap/iter/iter_and_reset
>> PASS 8 test-hbitmap /hbitmap/get/all
>> ---
>> PASS 14 test-hbitmap /hbitmap/set/twice
>> PASS 15 test-hbitmap /hbitmap/set/overlap
>> PASS 16 test-hbitmap /hbitmap/reset/empty
>> =3D=3D8123=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 17 test-hbitmap /hbitmap/reset/general
>> PASS 13 ide-test /x86_64/ide/cdrom/pio
>> PASS 18 test-hbitmap /hbitmap/reset/all
>> ---
>> PASS 28 test-hbitmap /hbitmap/truncate/shrink/medium
>> PASS 29 test-hbitmap /hbitmap/truncate/shrink/large
>> PASS 30 test-hbitmap /hbitmap/meta/zero
>> =3D=3D8129=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 14 ide-test /x86_64/ide/cdrom/pio_large
>> =3D=3D8135=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 15 ide-test /x86_64/ide/cdrom/dma
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/ahci-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl =
--test-name=3D"ahci-test"
>> PASS 31 test-hbitmap /hbitmap/meta/one
>> PASS 32 test-hbitmap /hbitmap/meta/byte
>> PASS 33 test-hbitmap /hbitmap/meta/word
>> =3D=3D8149=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 ahci-test /x86_64/ahci/sanity
>> PASS 34 test-hbitmap /hbitmap/meta/sector
>> PASS 35 test-hbitmap /hbitmap/serialize/align
>> =3D=3D8155=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 ahci-test /x86_64/ahci/pci_spec
>> =3D=3D8161=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 36 test-hbitmap /hbitmap/serialize/basic
>> PASS 37 test-hbitmap /hbitmap/serialize/part
>> PASS 38 test-hbitmap /hbitmap/serialize/zeroes
>> ---
>> PASS 43 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-bdrv-drain -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl=
 --test-name=3D"test-bdrv-drain"
>> PASS 3 ahci-test /x86_64/ahci/pci_enable
>> =3D=3D8169=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-bdrv-drain /bdrv-drain/nested
>> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
>> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
>> ---
>> PASS 23 test-bdrv-drain /bdrv-drain/blockjob/drain_subtree
>> PASS 24 test-bdrv-drain /bdrv-drain/blockjob/error/drain_all
>> PASS 25 test-bdrv-drain /bdrv-drain/blockjob/error/drain
>> =3D=3D8171=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 26 test-bdrv-drain /bdrv-drain/blockjob/error/drain_subtree
>> PASS 27 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain_all
>> PASS 28 test-bdrv-drain /bdrv-drain/blockjob/iothread/drain
>> ---
>> PASS 38 test-bdrv-drain /bdrv-drain/detach/driver_cb
>> PASS 39 test-bdrv-drain /bdrv-drain/attach/drain
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-bdrv-graph-mod -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"test-bdrv-graph-mod"
>> =3D=3D8215=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 ahci-test /x86_64/ahci/hba_spec
>> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
>> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-blockjob -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"test-blockjob"
>> =3D=3D8221=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-blockjob /blockjob/ids
>> PASS 2 test-blockjob /blockjob/cancel/created
>> PASS 3 test-blockjob /blockjob/cancel/running
>> =3D=3D8219=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 test-blockjob /blockjob/cancel/paused
>> PASS 5 test-blockjob /blockjob/cancel/ready
>> PASS 6 test-blockjob /blockjob/cancel/standby
>> PASS 7 test-blockjob /blockjob/cancel/pending
>> PASS 8 test-blockjob /blockjob/cancel/concluded
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-blockjob-txn -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-blockjob-txn"
>> =3D=3D8231=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-blockjob-txn /single/success
>> PASS 2 test-blockjob-txn /single/failure
>> PASS 3 test-blockjob-txn /single/cancel
>> ---
>> PASS 7 test-blockjob-txn /pair/fail-cancel-race
>> PASS 5 ahci-test /x86_64/ahci/hba_enable
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-block-backend -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"test-block-backend"
>> =3D=3D8237=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-block-backend /block-backend/drain_aio_error
>> PASS 2 test-block-backend /block-backend/drain_all_aio_error
>> =3D=3D8235=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-block-iothread -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"test-block-iothread"
>> =3D=3D8247=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-block-iothread /sync-op/pread
>> PASS 2 test-block-iothread /sync-op/pwrite
>> PASS 3 test-block-iothread /sync-op/load_vmstate
>> ---
>> PASS 16 test-block-iothread /propagate/mirror
>> PASS 6 ahci-test /x86_64/ahci/identify
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-image-locking -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"test-image-locking"
>> =3D=3D8269=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-image-locking /image-locking/basic
>> PASS 2 test-image-locking /image-locking/set-perm-abort
>> =3D=3D8267=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-x86-cpuid -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl =
--test-name=3D"test-x86-cpuid"
>> PASS 1 test-x86-cpuid /cpuid/topology/basic
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-xbzrle -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --t=
est-name=3D"test-xbzrle"
>> ---
>> PASS 3 test-xbzrle /xbzrle/encode_decode_unchanged
>> PASS 4 test-xbzrle /xbzrle/encode_decode_1_byte
>> PASS 5 test-xbzrle /xbzrle/encode_decode_overflow
>> =3D=3D8285=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 6 test-xbzrle /xbzrle/encode_decode
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-vmstate -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --=
test-name=3D"test-vmstate"
>> PASS 1 test-vmstate /vmstate/tmp_struct
>> ---
>> PASS 9 test-int128 /int128/int128_gt
>> PASS 10 test-int128 /int128/int128_rshift
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/rcutorture -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --te=
st-name=3D"rcutorture"
>> =3D=3D8313=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8313=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffc6c940000; bottom 0x7f6224bfe000; size: 0x009a47d42000=
 (662630047744)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 1 rcutorture /rcu/torture/1reader
>> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
>> =3D=3D8346=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 rcutorture /rcu/torture/10readers
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-rcu-list -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"test-rcu-list"
>> =3D=3D8346=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7fff8706d000; bottom 0x7f38de3fe000; size: 0x00c6a8c6f000=
 (853235134464)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
>> =3D=3D8359=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-rcu-list /rcu/qlist/single-threaded
>> =3D=3D8359=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffd909ac000; bottom 0x7f7a81bfe000; size: 0x00830edae000=
 (562889940992)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
>> PASS 2 test-rcu-list /rcu/qlist/short-few
>> =3D=3D8371=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8371=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffc4e8db000; bottom 0x7f6dc61fe000; size: 0x008e886dd000=
 (612174254080)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
>> =3D=3D8398=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8398=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffecf140000; bottom 0x7fb9bd7fe000; size: 0x004511942000=
 (296647663616)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 3 test-rcu-list /rcu/qlist/long-many
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-rcu-simpleq -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"test-rcu-simpleq"
>> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
>> =3D=3D8411=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded
>> =3D=3D8411=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe90d23000; bottom 0x7f7d0f5fe000; size: 0x008181725000=
 (556222533632)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
>> PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few
>> =3D=3D8423=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8423=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffc5891a000; bottom 0x7f14ded24000; size: 0x00e779bf6000=
 (994180030464)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
>> =3D=3D8450=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8450=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7fff839f1000; bottom 0x7f0c10ffe000; size: 0x00f3729f3000=
 (1045600088064)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-rcu-tailq -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl =
--test-name=3D"test-rcu-tailq"
>> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
>> =3D=3D8463=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
>> =3D=3D8463=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffcde472000; bottom 0x7fb7b677c000; size: 0x004527cf6000=
 (297020645376)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
>> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
>> =3D=3D8496=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
>> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-qdist -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --te=
st-name=3D"test-qdist"
>> =3D=3D8502=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-qdist /qdist/none
>> PASS 2 test-qdist /qdist/pr
>> PASS 3 test-qdist /qdist/single/empty
>> ---
>> PASS 8 test-qdist /qdist/binning/shrink
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-qht -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --test=
-name=3D"test-qht"
>> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
>> =3D=3D8517=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
>> =3D=3D8523=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8523=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffc92234000; bottom 0x7f2d413fe000; size: 0x00cf50e36000=
 (890415308800)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
>> =3D=3D8529=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8529=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe9ceaf000; bottom 0x7f2408bfe000; size: 0x00da942b1000=
 (938788720640)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
>> =3D=3D8535=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8535=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffdbaa3a000; bottom 0x7fadd47fe000; size: 0x004fe623c000=
 (343163518976)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
>> =3D=3D8541=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8541=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe3fc80000; bottom 0x7f5d5f5fe000; size: 0x00a0e0682000=
 (690959687680)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
>> =3D=3D8547=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8547=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffcdaf8b000; bottom 0x7f03e41fe000; size: 0x00f8f6d8d000=
 (1069293293568)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
>> =3D=3D8553=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8553=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffff7a41000; bottom 0x7fad853fe000; size: 0x005272643000=
 (354106486784)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
>> =3D=3D8559=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8559=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7fff219ce000; bottom 0x7f9e96124000; size: 0x00608b8aa000=
 (414657978368)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
>> =3D=3D8565=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D8565=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe154da000; bottom 0x7fce2f7fe000; size: 0x002fe5cdc000=
 (205718929408)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low
>> =3D=3D8571=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-qht /qht/mode/default
>> =3D=3D8571=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffd0d93e000; bottom 0x7ff88157c000; size: 0x00048c3c2000=
 (19532619776)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 2 test-qht /qht/mode/resize
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-qht-par -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --=
test-name=3D"test-qht-par"
>> PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high
>> =3D=3D8587=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s
>> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
>> =3D=3D8600=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-bitops -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --t=
est-name=3D"test-bitops"
>> PASS 1 test-bitops /bitops/sextract32
>> ---
>> PASS 1 check-qom-interface /qom/interface/direct_impl
>> PASS 2 check-qom-interface /qom/interface/intermediate_impl
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/check-qom-proplist -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"check-qom-proplist"
>> =3D=3D8622=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 check-qom-proplist /qom/proplist/createlist
>> PASS 2 check-qom-proplist /qom/proplist/createv
>> PASS 3 check-qom-proplist /qom/proplist/createcmdline
>> ---
>> PASS 3 test-write-threshold /write-threshold/multi-set-get
>> PASS 4 test-write-threshold /write-threshold/not-trigger
>> PASS 5 test-write-threshold /write-threshold/trigger
>> =3D=3D8654=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-crypto-hash -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"test-crypto-hash"
>> PASS 1 test-crypto-hash /crypto/hash/iov
>> PASS 2 test-crypto-hash /crypto/hash/alloc
>> ---
>> PASS 15 test-crypto-secret /crypto/secret/crypt/missingiv
>> PASS 16 test-crypto-secret /crypto/secret/crypt/badiv
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-crypto-tlscredsx509 -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"test-crypto-tlscredsx509"
>> =3D=3D8678=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver
>> PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient
>> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
>> PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1
>> =3D=3D8690=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
>> PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2
>> =3D=3D8696=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
>> =3D=3D8702=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3
>> PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1
>> PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2
>> ---
>> PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1
>> PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2
>> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
>> =3D=3D8708=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
>> PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3
>> PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4
>> =3D=3D8714=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5
>> PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6
>> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
>> =3D=3D8720=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7
>> PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1
>> PASS 17 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver2
>> ---
>> PASS 33 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive2
>> PASS 34 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive3
>> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
>> =3D=3D8726=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 35 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain1
>> PASS 36 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain2
>> PASS 37 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingca
>> ---
>> PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-crypto-tlssession -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dr=
iver.pl --test-name=3D"test-crypto-tlssession"
>> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
>> =3D=3D8737=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
>> =3D=3D8743=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk
>> PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca
>> PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca
>> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
>> =3D=3D8749=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1
>> PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2
>> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
>> PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3
>> =3D=3D8755=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4
>> PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5
>> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
>> PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6
>> PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1
>> =3D=3D8761=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2
>> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
>> =3D=3D8767=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3
>> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
>> =3D=3D8773=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4
>> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
>> =3D=3D8779=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5
>> PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6
>> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
>> =3D=3D8785=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-qga -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --test=
-name=3D"test-qga"
>> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
>> ---
>> PASS 8 test-qga /qga/get-memory-block-info
>> PASS 9 test-qga /qga/get-memory-blocks
>> PASS 10 test-qga /qga/file-ops
>> =3D=3D8797=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 11 test-qga /qga/file-write-read
>> PASS 12 test-qga /qga/get-time
>> PASS 13 test-qga /qga/id
>> ---
>> PASS 19 test-qga /qga/config
>> PASS 20 test-qga /qga/guest-exec
>> PASS 21 test-qga /qga/guest-exec-invalid
>> =3D=3D8805=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
>> =3D=3D8818=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 22 test-qga /qga/guest-get-osinfo
>> PASS 23 test-qga /qga/guest-get-host-name
>> PASS 24 test-qga /qga/guest-get-timezone
>> ---
>> PASS 7 test-util-sockets /socket/fd-pass/num/bad
>> PASS 8 test-util-sockets /socket/fd-pass/num/nocli
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-authz-simple -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-authz-simple"
>> =3D=3D8841=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-authz-simple /authz/simple
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-authz-list -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl=
 --test-name=3D"test-authz-list"
>> PASS 1 test-authz-list /auth/list/complex
>> ---
>> PASS 4 test-io-channel-file /io/channel/pipe/sync
>> PASS 5 test-io-channel-file /io/channel/pipe/async
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-io-channel-tls -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"test-io-channel-tls"
>> =3D=3D8910=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-io-channel-tls /qio/channel/tls/basic
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-io-channel-command -m=3Dquick -k --tap < /dev/null | ./scripts/tap-d=
river.pl --test-name=3D"test-io-channel-command"
>> PASS 1 test-io-channel-command /io/channel/command/fifo/sync
>> ---
>> PASS 3 test-base64 /util/base64/not-nul-terminated
>> PASS 4 test-base64 /util/base64/invalid-chars
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-crypto-pbkdf -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-crypto-pbkdf"
>> =3D=3D8943=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1
>> PASS 2 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter2
>> PASS 3 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1200a
>> ---
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-crypto-block -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-crypto-block"
>> PASS 1 test-crypto-block /crypto/block/qcow
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-logging -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --=
test-name=3D"test-logging"
>> =3D=3D8975=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-logging /logging/parse_range
>> PASS 2 test-logging /logging/parse_path
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-replication -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"test-replication"
>> =3D=3D8990=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-replication /replication/primary/read
>> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
>> PASS 2 test-replication /replication/primary/write
>> =3D=3D8995=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 test-replication /replication/primary/start
>> PASS 4 test-replication /replication/primary/stop
>> PASS 5 test-replication /replication/primary/do_checkpoint
>> PASS 6 test-replication /replication/primary/get_error_all
>> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
>> =3D=3D9001=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 7 test-replication /replication/secondary/read
>> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
>> =3D=3D9007=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 8 test-replication /replication/secondary/write
>> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
>> =3D=3D9013=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 61 ahci-test /x86_64/ahci/flush/simple
>> =3D=3D8990=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe50cfb000; bottom 0x7fc4228fc000; size: 0x003a2e3ff000=
 (249884045312)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> =3D=3D9019=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 9 test-replication /replication/secondary/start
>> PASS 62 ahci-test /x86_64/ahci/flush/retry
>> =3D=3D9043=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9048=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 10 test-replication /replication/secondary/stop
>> PASS 63 ahci-test /x86_64/ahci/flush/migrate
>> =3D=3D9057=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 11 test-replication /replication/secondary/do_checkpoint
>> =3D=3D9062=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 12 test-replication /replication/secondary/get_error_all
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-bufferiszero -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl --test-name=3D"test-bufferiszero"
>> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
>> =3D=3D9076=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9081=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
>> =3D=3D9090=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9095=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
>> =3D=3D9104=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9109=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
>> =3D=3D9118=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9123=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
>> =3D=3D9132=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
>> =3D=3D9137=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
>> =3D=3D9143=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
>> =3D=3D9149=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
>> =3D=3D9155=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> =3D=3D9155=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_ret=
urn: stack top: 0x7ffe44ee2000; bottom 0x7fc156f74000; size: 0x003cedf6e000=
 (261690417152)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
>> =3D=3D9161=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/hd-geo-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"hd-geo-test"
>> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
>> =3D=3D9175=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
>> =3D=3D9181=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
>> =3D=3D9187=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-bufferiszero /cutils/bufferiszero
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-uuid -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --tes=
t-name=3D"test-uuid"
>> PASS 1 test-uuid /uuid/is_null
>> ---
>> PASS 1 test-qapi-util /qapi/util/qapi_enum_parse
>> PASS 2 test-qapi-util /qapi/util/parse_qapi_name
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  test=
s/test-qgraph -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl --t=
est-name=3D"test-qgraph"
>> =3D=3D9201=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 test-qgraph /qgraph/init_nop
>> PASS 2 test-qgraph /qgraph/test_machine
>> PASS 3 test-qgraph /qgraph/test_contains
>> ---
>> PASS 22 test-qgraph /qgraph/test_test_in_path
>> PASS 23 test-qgraph /qgraph/test_double_edge
>> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
>> =3D=3D9216=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
>> =3D=3D9222=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
>> =3D=3D9228=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
>> =3D=3D9234=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
>> =3D=3D9239=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/boot-order-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driv=
er.pl --test-name=3D"boot-order-test"
>> PASS 1 boot-order-test /x86_64/boot-order/pc
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9307=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 bios-tables-test /x86_64/acpi/piix4
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9313=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 bios-tables-test /x86_64/acpi/q35
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9319=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 bios-tables-test /x86_64/acpi/piix4/bridge
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9325=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9331=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 5 bios-tables-test /x86_64/acpi/piix4/cpuhp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9338=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 6 bios-tables-test /x86_64/acpi/piix4/memhp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9344=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 7 bios-tables-test /x86_64/acpi/piix4/numamem
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9350=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 8 bios-tables-test /x86_64/acpi/piix4/dimmpxm
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9359=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 9 bios-tables-test /x86_64/acpi/q35/bridge
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9365=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 10 bios-tables-test /x86_64/acpi/q35/mmio64
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9371=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 11 bios-tables-test /x86_64/acpi/q35/ipmi
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9377=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 12 bios-tables-test /x86_64/acpi/q35/cpuhp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9384=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 13 bios-tables-test /x86_64/acpi/q35/memhp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9390=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 14 bios-tables-test /x86_64/acpi/q35/numamem
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9396=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 15 bios-tables-test /x86_64/acpi/q35/dimmpxm
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/boot-serial-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dri=
ver.pl --test-name=3D"boot-serial-test"
>> PASS 1 boot-serial-test /x86_64/boot-serial/isapc
>> ---
>> PASS 1 i440fx-test /x86_64/i440fx/defaults
>> PASS 2 i440fx-test /x86_64/i440fx/pam
>> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
>> =3D=3D9480=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/fw_cfg-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.p=
l --test-name=3D"fw_cfg-test"
>> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
>> ---
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/drive_del-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"drive_del-test"
>> PASS 1 drive_del-test /x86_64/drive_del/without-dev
>> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
>> =3D=3D9568=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-drive=
r.pl --test-name=3D"wdt_ib700-test"
>> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
>> ---
>> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
>> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
>> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
>> =3D=3D9763=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/usb-hcd-xhci-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-dr=
iver.pl --test-name=3D"usb-hcd-xhci-test"
>> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
>> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
>> =3D=3D9772=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
>> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/cpu-plug-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl --test-name=3D"cpu-plug-test"
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9878=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9884=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9890=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/tpm-crb-swtpm-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-d=
river.pl --test-name=3D"tpm-crb-swtpm-test"
>> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in=
 PATH or missing --tpm2 support
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D9995=3D=3DWARNING: ASan doesn't fully support makecontext/swapcont=
ext functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10000=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 3 migration-test /x86_64/migration/fd_proto
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10008=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10013=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 4 migration-test /x86_64/migration/postcopy/unix
>> PASS 5 migration-test /x86_64/migration/postcopy/recovery
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10043=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10048=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 6 migration-test /x86_64/migration/precopy/unix
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10057=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10062=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 7 migration-test /x86_64/migration/precopy/tcp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10071=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: failed to initialize KVM: No such file or directory
>> qemu-system-x86_64: Back to tcg accelerator
>> =3D=3D10076=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 8 migration-test /x86_64/migration/xbzrle/unix
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/test-x86-cpuid-compat -m=3Dquick -k --tap < /dev/null | ./scripts/ta=
p-driver.pl --test-name=3D"test-x86-cpuid-compat"
>> PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus
>> ---
>> PASS 6 numa-test /x86_64/numa/pc/dynamic/cpu
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTES=
T_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img=
 tests/qmp-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl -=
-test-name=3D"qmp-test"
>> PASS 1 qmp-test /x86_64/qmp/protocol
>> =3D=3D10405=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
>> PASS 2 qmp-test /x86_64/qmp/oob
>> PASS 3 qmp-test /x86_64/qmp/preconfig
>> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
>> ---
>> PASS 5 device-introspect-test /x86_64/device/introspect/abstract-interfa=
ces
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D10653=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>>     #0 0x563b8efcbb6e in calloc (/tmp/qemu-test/build/x86_64-softmmu/qem=
u-system-x86_64+0x19f9b6e)
>> ---
>>
>> SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
>> /tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate =
QEMU process but encountered exit status 1
>> ERROR - too few tests run (expected 6, got 5)
>> make: *** [/tmp/qemu-test/src/tests/Makefile.include:896: check-qtest-x8=
6_64] Error 1
>> make: *** Waiting for unfinished jobs....
>> Traceback (most recent call last):
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20190703190715.5328-1-jonathan@fintelia.io/testi=
ng.asan/?type=3Dmessage.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com

