Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D22C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 05:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DD120716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 05:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkl+UFVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DD120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI3cD-0007Fh-08
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 01:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jI3b6-0006Q3-5o
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jI3av-0005op-Tf
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:01:28 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:41320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jI3av-0005mw-Bk
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:01:17 -0400
Received: by mail-oi1-x230.google.com with SMTP id k9so10783099oia.8
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WxS0givc95Knp9pkLJZcQD1By/w/tcm9aA2hPIyxl2w=;
 b=Dkl+UFVmpwoKPKExSQBomv2T27UO+E8gAzbKNUprp0uduJoaMvAR/yrwrrJOML2CiN
 nBT2OwOGNJOPyhNKYFaKKS59FDbM+X9+bvyvpfBnkXgylz6u5MbBWnkf6Mdpvh4RfVp9
 GdqCJqyif/KhB+K6aOlh5OTfmZeniLNVE3ugZySZHMdhoXFNyU1AbEdvZGKIMKDuol4d
 MFjeU2prPrAVyKl5rJRBgq0RIzO5qHM5E0/KGx0DLG8axJy+ww70+RIJOOakUbhGNkmu
 OutXL97WTbhcz1o4g5n7B1UiGzAGMRh7mO2p4dX5L7DTIoE3qYCenBEPAmD2r+nSDaug
 rBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WxS0givc95Knp9pkLJZcQD1By/w/tcm9aA2hPIyxl2w=;
 b=sxjuo2fwZTFZmOgN33ZUWHbt/S8XyGC0I+auKN3qUDNovafNc+ZCfnGTNP47kDjp/v
 lkzMvlgmjWF1/bVqK4MMZ1fdOv7yZ8UJ1rlKsKDI7CZdHvoySOCPQFvvwwDDMoofINMC
 NIX7TzasmIJL53sXzx8piQNzJNXzF5PrkGcDE4xn51SDdJPcnatCyYEwIU5hsr1hXQ9S
 YGyR++KBVR7g26Y1GtetOoxVUoAeup8lxF3LIFo7QzoF0lVBKpAaLY7OIsZA6rO1lv2F
 PpYo1MqHGMktliSsEMlPBLz0ybEdk+scw1bdjYqt18ncPV2/NqerxzpL+H9xmrdgyo7H
 sj4g==
X-Gm-Message-State: ANhLgQ0JpA0ouz9ZqKDny2DkCjKSGnZzNzuXZv+EEXAexhmfJ+bwR5YH
 4lLEexurowfZ0bdjsaz0rWTxLfKMjKzU0lL//rMdwQ==
X-Google-Smtp-Source: ADFU+vv5cBionhVB95i3Dk1kNu13B2m2Sx+jZ90BeOakAsxHMW/e1EIsXtTATqIgSUk3GzxRZF8Nh4QuxcdcxrN8MoI=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr1651903oib.56.1585371675064; 
 Fri, 27 Mar 2020 22:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200327161146.16402-1-liq3ea@163.com>
 <158533704433.31566.18061885663592296960@39012742ff91>
In-Reply-To: <158533704433.31566.18061885663592296960@39012742ff91>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 28 Mar 2020 13:00:35 +0800
Message-ID: <CAKXe6S+dafV7+TF5mk3Q4sPsi0omK+H9NgUxSeuq7MjqFNDUpA@mail.gmail.com>
Subject: Re: [PATCH] qtest: add tulip test case
To: Qemu Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000877d8905a1e31bbf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000877d8905a1e31bbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

This is in expectation.
Jason I think this patch maybe go your tree, with the Prasad's fix path.

Thanks,
Li Qiang


<no-reply@patchew.org> =E4=BA=8E2020=E5=B9=B43=E6=9C=8828=E6=97=A5=E5=91=A8=
=E5=85=AD =E4=B8=8A=E5=8D=883:24=E5=86=99=E9=81=93=EF=BC=9A

> Patchew URL:
> https://patchew.org/QEMU/20200327161146.16402-1-liq3ea@163.com/
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
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14
> NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> PASS 1 fdc-test /x86_64/fdc/cmos
> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
> PASS 3 fdc-test /x86_64/fdc/read_without_media
> =3D=3D6166=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 fdc-test /x86_64/fdc/media_change
> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
> PASS 6 fdc-test /x86_64/fdc/relative_seek
> ---
> PASS 32 test-opts-visitor /visitor/opts/range/beyond
> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-coroutine -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-coroutine"
> =3D=3D6211=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6211=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffee7b7c000; bottom 0x7fa15e601000; size: 0x005d8957b000
> (401736183808)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-coroutine /basic/no-dangling-access
> ---
> PASS 11 test-aio /aio/event/wait
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> =3D=3D6226=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 14 test-aio /aio/timer/schedule
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> ---
> PASS 12 fdc-test /x86_64/fdc/read_no_dma_19
> PASS 13 fdc-test /x86_64/fdc/fuzz-registers
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/ide-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"ide-test"
> =3D=3D6234=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 28 test-aio /aio-gsource/timer/schedule
> PASS 1 ide-test /x86_64/ide/identify
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-aio-multithread"
> =3D=3D6243=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> =3D=3D6240=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 ide-test /x86_64/ide/flush
> PASS 2 test-aio-multithread /aio/multi/schedule
> =3D=3D6260=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> =3D=3D6271=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 ide-test /x86_64/ide/bmdma/trim
> =3D=3D6282=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-throttle -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-throttle"
> =3D=3D6299=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-throttle /throttle/leak_bucket
> PASS 2 test-throttle /throttle/compute_wait
> PASS 3 test-throttle /throttle/init
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-thread-pool -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-thread-pool"
> PASS 1 test-thread-pool /thread-pool/submit
> PASS 2 test-thread-pool /thread-pool/submit-aio
> =3D=3D6303=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 test-thread-pool /thread-pool/submit-co
> PASS 4 test-thread-pool /thread-pool/submit-many
> =3D=3D6305=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 5 test-thread-pool /thread-pool/cancel
> PASS 6 test-thread-pool /thread-pool/cancel-async
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-hbitmap -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl
> --test-name=3D"test-hbitmap"
> ---
> PASS 14 test-hbitmap /hbitmap/set/twice
> PASS 15 test-hbitmap /hbitmap/set/overlap
> PASS 16 test-hbitmap /hbitmap/reset/empty
> =3D=3D6380=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 17 test-hbitmap /hbitmap/reset/general
> PASS 18 test-hbitmap /hbitmap/reset/all
> PASS 19 test-hbitmap /hbitmap/truncate/nop
> ---
> PASS 39 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
> PASS 40 test-hbitmap
> /hbitmap/next_dirty_area/next_dirty_area_after_truncate
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-drain -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-bdrv-drain"
> =3D=3D6387=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-bdrv-drain /bdrv-drain/nested
> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
> ---
> PASS 41 test-bdrv-drain /bdrv-drain/bdrv_drop_intermediate/poll
> PASS 42 test-bdrv-drain /bdrv-drain/replace_child/mid-drain
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-graph-mod -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-bdrv-graph-mod"
> =3D=3D6426=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-blockjob"
> =3D=3D6430=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob /blockjob/ids
> PASS 2 test-blockjob /blockjob/cancel/created
> PASS 3 test-blockjob /blockjob/cancel/running
> ---
> PASS 7 test-blockjob /blockjob/cancel/pending
> PASS 8 test-blockjob /blockjob/cancel/concluded
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob-txn -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-blockjob-txn"
> =3D=3D6434=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob-txn /single/success
> PASS 2 test-blockjob-txn /single/failure
> PASS 3 test-blockjob-txn /single/cancel
> ---
> PASS 6 test-blockjob-txn /pair/cancel
> PASS 7 test-blockjob-txn /pair/fail-cancel-race
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-backend -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-block-backend"
> =3D=3D6438=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-block-backend /block-backend/drain_aio_error
> PASS 2 test-block-backend /block-backend/drain_all_aio_error
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-iothread -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-block-iothread"
> =3D=3D6444=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-block-iothread /sync-op/pread
> PASS 2 test-block-iothread /sync-op/pwrite
> PASS 3 test-block-iothread /sync-op/load_vmstate
> ---
> PASS 15 test-block-iothread /propagate/diamond
> PASS 16 test-block-iothread /propagate/mirror
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-image-locking -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-image-locking"
> =3D=3D6464=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-image-locking /image-locking/basic
> PASS 2 test-image-locking /image-locking/set-perm-abort
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-x86-cpuid -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-x86-cpuid"
> =3D=3D6440=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-x86-cpuid /cpuid/topology/basic
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-xbzrle -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl
> --test-name=3D"test-xbzrle"
> PASS 1 test-xbzrle /xbzrle/uleb
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-list -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-rcu-list"
> PASS 1 test-rcu-list /rcu/qlist/single-threaded
> PASS 2 test-rcu-list /rcu/qlist/short-few
> =3D=3D6532=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 test-rcu-list /rcu/qlist/long-many
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-simpleq -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-rcu-simpleq"
> PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded
> PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few
> =3D=3D6592=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-tailq -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-rcu-tailq"
> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-rcu-slist -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-rcu-slist"
> =3D=3D6631=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-rcu-slist /rcu/qslist/single-threaded
> PASS 2 test-rcu-slist /rcu/qslist/short-few
> PASS 3 test-rcu-slist /rcu/qslist/long-many
> ---
> PASS 7 test-qdist /qdist/binning/expand
> PASS 8 test-qdist /qdist/binning/shrink
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qht -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name=3D"test-qht"
> =3D=3D6677=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6683=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 5 ide-test /x86_64/ide/bmdma/various_prdts
> =3D=3D6689=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6689=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe5f4ce000; bottom 0x7ff3fcbfe000; size: 0x000a628d0000
> (44603080704)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 6 ide-test /x86_64/ide/bmdma/no_busmaster
> PASS 7 ide-test /x86_64/ide/flush/nodev
> PASS 1 test-qht /qht/mode/default
> =3D=3D6700=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 test-qht /qht/mode/resize
> PASS 8 ide-test /x86_64/ide/flush/empty_drive
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qht-par -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl
> --test-name=3D"test-qht-par"
> =3D=3D6706=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 9 ide-test /x86_64/ide/flush/retry_pci
> PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s
> =3D=3D6720=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 10 ide-test /x86_64/ide/flush/retry_isa
> PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bitops -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.=
pl
> --test-name=3D"test-bitops"
> =3D=3D6732=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-bitops /bitops/sextract32
> PASS 2 test-bitops /bitops/sextract64
> PASS 3 test-bitops /bitops/half_shuffle32
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/check-qom-interface -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"check-qom-interface"
> PASS 1 check-qom-interface /qom/interface/direct_impl
> PASS 2 check-qom-interface /qom/interface/intermediate_impl
> =3D=3D6744=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/check-qom-proplist -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"check-qom-proplist"
> PASS 1 check-qom-proplist /qom/proplist/createlist
> PASS 2 check-qom-proplist /qom/proplist/createv
> ---
> PASS 27 test-crypto-cipher /crypto/cipher/null-iv
> PASS 28 test-crypto-cipher /crypto/cipher/short-plaintext
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-secret -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-crypto-secret"
> =3D=3D6788=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 13 ide-test /x86_64/ide/cdrom/dma
> PASS 1 test-crypto-secret /crypto/secret/direct
> PASS 2 test-crypto-secret /crypto/secret/indirect/good
> ---
> PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver
> PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient
> PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1
> =3D=3D6818=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 ahci-test /x86_64/ahci/sanity
> =3D=3D6824=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2
> =3D=3D6830=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 ahci-test /x86_64/ahci/pci_enable
> PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3
> PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1
> PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2
> PASS 8 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca3
> =3D=3D6836=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1
> PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2
> PASS 4 ahci-test /x86_64/ahci/hba_spec
> PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3
> =3D=3D6842=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 5 ahci-test /x86_64/ahci/hba_enable
> =3D=3D6848=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 6 ahci-test /x86_64/ahci/identify
> =3D=3D6854=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4
> PASS 7 ahci-test /x86_64/ahci/max
> PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5
> =3D=3D6860=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 8 ahci-test /x86_64/ahci/reset
> PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6
> =3D=3D6866=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7
> PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1
> PASS 17 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver2
> ---
> PASS 38 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingserver
> PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-tlssession -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-crypto-tlssession"
> =3D=3D6866=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc0b5c7000; bottom 0x7fab527fe000; size: 0x0050b8dc9000
> (346698846208)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
> =3D=3D6876=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6876=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff3769b000; bottom 0x7fabf8bfe000; size: 0x00533ea9d000
> (357533601792)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
> =3D=3D6882=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6882=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc51f34000; bottom 0x7f8edcdfe000; size: 0x006d75136000
> (470115639296)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
> =3D=3D6888=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6888=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffeb05c5000; bottom 0x7fab93ffe000; size: 0x00531c5c7000
> (356958105600)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk
> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
> =3D=3D6894=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6894=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc068e8000; bottom 0x7f26891fe000; size: 0x00d57d6ea000
> (916932435968)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
> =3D=3D6900=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca
> =3D=3D6900=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fffe8370000; bottom 0x7fa4cdffe000; size: 0x005b1a372000
> (391281844224)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
> =3D=3D6906=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6906=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe3707c000; bottom 0x7f31a69fe000; size: 0x00cc9067e000
> (878596055040)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca
> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
> PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1
> PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2
> =3D=3D6912=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6912=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc9f482000; bottom 0x7f60eb5fe000; size: 0x009bb3e84000
> (668738273280)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3
> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
> PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4
> PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5
> =3D=3D6918=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6918=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc331f7000; bottom 0x7f08a7ffe000; size: 0x00f38b1f9000
> (1046011154432)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6
> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
> PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1
> =3D=3D6924=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
> PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2
> =3D=3D6930=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3
> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
> =3D=3D6936=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4
> PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5
> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
> =3D=3D6942=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6942=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff6097f000; bottom 0x7f1a7edfe000; size: 0x00e4e1b81000
> (983039479808)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6
> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
> PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qga -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name=3D"test-qga"
> =3D=3D6948=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6948=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff99987000; bottom 0x7f52b7bfe000; size: 0x00ace1d89000
> (742523441152)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
> =3D=3D6962=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-qga /qga/sync-delimited
> PASS 2 test-qga /qga/sync
> PASS 3 test-qga /qga/ping
> ---
> PASS 8 test-qga /qga/get-memory-block-info
> PASS 9 test-qga /qga/get-memory-blocks
> PASS 10 test-qga /qga/file-ops
> =3D=3D6962=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe55625000; bottom 0x7f525effe000; size: 0x00abf6627000
> (738573053952)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 11 test-qga /qga/file-write-read
> ---
> PASS 16 test-qga /qga/invalid-args
> PASS 17 test-qga /qga/fsfreeze-status
> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
> =3D=3D6971=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6971=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe03137000; bottom 0x7f804e1fe000; size: 0x007db4f39000
> (539906772992)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
> ---
> PASS 19 test-qga /qga/config
> PASS 20 test-qga /qga/guest-exec
> PASS 21 test-qga /qga/guest-exec-invalid
> =3D=3D6977=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D6977=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fffa7b49000; bottom 0x7f8404dfe000; size: 0x007ba2d4b000
> (531012825088)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
> PASS 22 test-qga /qga/guest-get-osinfo
> PASS 23 test-qga /qga/guest-get-host-name
> PASS 24 test-qga /qga/guest-get-timezone
> =3D=3D6995=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 25 test-qga /qga/guest-get-users
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-timed-average -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-timed-average"
> =3D=3D6995=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff90d75000; bottom 0x7fdbeadfe000; size: 0x0023a5f77000
> (153108312064)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-timed-average /timed-average/average
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-authz-simple -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-authz-simple"
> PASS 1 test-authz-simple /authz/simple
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-authz-list -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-authz-list"
> =3D=3D7011=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-authz-list /auth/list/complex
> PASS 2 test-authz-list /auth/list/add-remove
> PASS 3 test-authz-list /auth/list/default/deny
> ---
> PASS 4 test-authz-listfile /auth/list/explicit/deny
> PASS 5 test-authz-listfile /auth/list/explicit/allow
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-io-task -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver=
.pl
> --test-name=3D"test-io-task"
> =3D=3D7011=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff22523000; bottom 0x7fba0757c000; size: 0x00451afa7000
> (296805363712)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-io-task /crypto/task/complete
> ---
> PASS 4 test-io-channel-file /io/channel/pipe/sync
> PASS 5 test-io-channel-file /io/channel/pipe/async
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-io-channel-tls -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-io-channel-tls"
> =3D=3D7082=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7082=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe28d22000; bottom 0x7fa443dfe000; size: 0x0059e4f24000
> (386093170688)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-io-channel-tls /qio/channel/tls/basic
> ---
> PASS 3 test-base64 /util/base64/not-nul-terminated
> PASS 4 test-base64 /util/base64/invalid-chars
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-pbkdf -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-crypto-pbkdf"
> =3D=3D7105=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1
> PASS 2 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter2
> PASS 3 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1200a
> ---
> PASS 8 test-crypto-ivgen /crypto/ivgen/essiv/1f2e3d4c
> PASS 9 test-crypto-ivgen /crypto/ivgen/essiv/1f2e3d4c5b6a7988
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-crypto-afsplit -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-crypto-afsplit"
> =3D=3D7105=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fffd4698000; bottom 0x7fbf929fe000; size: 0x004041c9a000
> (275981639680)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 1 test-crypto-afsplit /crypto/afsplit/sha256/5
> ---
> PASS 3 test-logging /logging/logfile_write_path
> PASS 4 test-logging /logging/logfile_lock_path
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-replication -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-replication"
> =3D=3D7142=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7145=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
> PASS 1 test-replication /replication/primary/read
> PASS 2 test-replication /replication/primary/write
> =3D=3D7153=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 31 ahci-test /x86_64/ahci/io/pio/lba48/short/low
> PASS 3 test-replication /replication/primary/start
> PASS 4 test-replication /replication/primary/stop
> PASS 5 test-replication /replication/primary/do_checkpoint
> PASS 6 test-replication /replication/primary/get_error_all
> =3D=3D7159=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 32 ahci-test /x86_64/ahci/io/pio/lba48/short/high
> =3D=3D7165=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 7 test-replication /replication/secondary/read
> PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented
> =3D=3D7171=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 8 test-replication /replication/secondary/write
> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
> =3D=3D7177=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
> =3D=3D7183=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
> =3D=3D7190=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
> =3D=3D7145=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffef72a3000; bottom 0x7ff0b0a79000; size: 0x000e4682a000
> (61312507904)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> =3D=3D7196=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 9 test-replication /replication/secondary/start
> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
> =3D=3D7217=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
> =3D=3D7223=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
> =3D=3D7229=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7229=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffedf651000; bottom 0x7f7a4c123000; size: 0x00849352e000
> (569407365120)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
> =3D=3D7236=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 10 test-replication /replication/secondary/stop
> =3D=3D7236=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe69c99000; bottom 0x7f86621fd000; size: 0x007807a9c000
> (515524640768)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
> =3D=3D7243=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7243=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffe93f0c000; bottom 0x7fa1f51fd000; size: 0x005c9ed0f000
> (397801484288)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
> =3D=3D7249=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
> =3D=3D7255=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
> PASS 11 test-replication /replication/secondary/continuous_replication
> =3D=3D7261=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
> =3D=3D7267=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
> =3D=3D7273=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
> =3D=3D7279=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 12 test-replication /replication/secondary/do_checkpoint
> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
> =3D=3D7285=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 13 test-replication /replication/secondary/get_error_all
> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bufferiszero -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"test-bufferiszero"
> =3D=3D7291=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low
> =3D=3D7300=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
> =3D=3D7306=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7306=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffcc1ced000; bottom 0x7f06bedfd000; size: 0x00f602ef0000
> (1056611172352)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero
> =3D=3D7313=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7313=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7fff4dca2000; bottom 0x7f77013fd000; size: 0x00884c8a5000
> (585399685120)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low
> =3D=3D7320=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7320=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffc3c7cf000; bottom 0x7f1a5c7fd000; size: 0x00e1dffd2000
> (970125549568)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high
> =3D=3D7327=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero
> =3D=3D7333=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
> =3D=3D7339=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
> =3D=3D7345=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
> =3D=3D7351=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
> =3D=3D7357=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 61 ahci-test /x86_64/ahci/flush/simple
> =3D=3D7363=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 62 ahci-test /x86_64/ahci/flush/retry
> =3D=3D7369=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7375=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 63 ahci-test /x86_64/ahci/flush/migrate
> =3D=3D7383=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7389=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
> =3D=3D7397=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7403=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
> =3D=3D7411=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7417=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
> =3D=3D7425=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7431=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
> =3D=3D7439=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7445=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 test-bufferiszero /cutils/bufferiszero
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-uuid -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name=3D"test-uuid"
> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
> ---
> PASS 21 test-qgraph /qgraph/test_two_test_same_interface
> PASS 22 test-qgraph /qgraph/test_test_in_path
> PASS 23 test-qgraph /qgraph/test_double_edge
> =3D=3D7456=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
> =3D=3D7471=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
> =3D=3D7477=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
> =3D=3D7483=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
> =3D=3D7489=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7489=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack
> top: 0x7ffd0aaa2000; bottom 0x7fd7befee000; size: 0x00254bab4000
> (160183304192)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
> =3D=3D7495=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/hd-geo-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"hd-geo-test"
> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
> =3D=3D7509=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
> =3D=3D7515=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
> =3D=3D7521=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba
> =3D=3D7527=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
> =3D=3D7533=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
> =3D=3D7539=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
> =3D=3D7545=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
> =3D=3D7551=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
> =3D=3D7556=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
> =3D=3D7562=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7566=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7570=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7574=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7578=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7582=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7586=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7590=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7593=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 11 hd-geo-test /x86_64/hd-geo/override/ide
> =3D=3D7600=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7604=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7608=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7612=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7616=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7620=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7624=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7628=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7631=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 12 hd-geo-test /x86_64/hd-geo/override/scsi
> =3D=3D7638=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7642=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7646=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7650=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7654=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7658=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7662=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7666=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7669=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 13 hd-geo-test /x86_64/hd-geo/override/scsi_2_controllers
> =3D=3D7676=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7680=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7684=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7688=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7691=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 14 hd-geo-test /x86_64/hd-geo/override/virtio_blk
> =3D=3D7698=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7702=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7705=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 15 hd-geo-test /x86_64/hd-geo/override/zero_chs
> =3D=3D7712=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7716=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7720=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7724=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7727=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 16 hd-geo-test /x86_64/hd-geo/override/scsi_hot_unplug
> =3D=3D7734=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7738=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7742=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7746=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> =3D=3D7749=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 17 hd-geo-test /x86_64/hd-geo/override/virtio_hot_unplug
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/boot-order-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"boot-order-test"
> PASS 1 boot-order-test /x86_64/boot-order/pc
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7818=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7824=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP'
> Using expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7830=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.bridge'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7836=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.ipmikcs'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7842=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.cphp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7849=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.memhp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7855=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.numamem'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7861=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7870=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7877=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7883=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.mmio64'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7889=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.ipmibt'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7895=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.cphp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7902=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.memhp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7908=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.numamem'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7914=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D7923=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> PASS 1 i440fx-test /x86_64/i440fx/defaults
> PASS 2 i440fx-test /x86_64/i440fx/pam
> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
> =3D=3D8015=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/fw_cfg-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"fw_cfg-test"
> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/drive_del-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"drive_del-test"
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> =3D=3D8108=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"wdt_ib700-test"
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
> =3D=3D8303=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/usb-hcd-ehci-test -m=3Dquick -k --tap < /dev/null | ./scripts=
/
> tap-driver.pl --test-name=3D"usb-hcd-ehci-test"
> PASS 1 usb-hcd-ehci-test /x86_64/ehci/pci/uhci-port-1
> ---
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/usb-hcd-xhci-test -m=3Dquick -k --tap < /dev/null | ./scripts=
/
> tap-driver.pl --test-name=3D"usb-hcd-xhci-test"
> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
> =3D=3D8321=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/cpu-plug-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"cpu-plug-test"
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8457=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8463=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8469=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/tpm-crb-swtpm-test -m=3Dquick -k --tap < /dev/null | ./script=
s/
> tap-driver.pl --test-name=3D"tpm-crb-swtpm-test"
> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in
> PATH or missing --tpm2 support
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8568=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8574=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 3 migration-test /x86_64/migration/fd_proto
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8581=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8587=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 4 migration-test /x86_64/migration/validate_uuid
> PASS 5 migration-test /x86_64/migration/validate_uuid_error
> PASS 6 migration-test /x86_64/migration/validate_uuid_src_not_set
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8637=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8643=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 8 migration-test /x86_64/migration/auto_converge
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8651=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8657=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 9 migration-test /x86_64/migration/postcopy/unix
> PASS 10 migration-test /x86_64/migration/postcopy/recovery
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8686=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8692=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 11 migration-test /x86_64/migration/precopy/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8700=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8706=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 12 migration-test /x86_64/migration/precopy/tcp
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8714=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8720=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 13 migration-test /x86_64/migration/xbzrle/unix
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8728=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8734=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 14 migration-test /x86_64/migration/multifd/tcp/none
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8852=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 15 migration-test /x86_64/migration/multifd/tcp/cancel
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8908=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8914=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 16 migration-test /x86_64/migration/multifd/tcp/zlib
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8970=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
> directory
> qemu-system-x86_64: falling back to tcg
> =3D=3D8976=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 17 migration-test /x86_64/migration/multifd/tcp/zstd
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/test-x86-cpuid-compat -m=3Dquick -k --tap < /dev/null | ./scr=
ipts/
> tap-driver.pl --test-name=3D"test-x86-cpuid-compat"
> PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus
> ---
> PASS 1 machine-none-test /x86_64/machine/none/cpu_option
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqe=
mu-img
> tests/qtest/qmp-test -m=3Dquick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name=3D"qmp-test"
> PASS 1 qmp-test /x86_64/qmp/protocol
> =3D=3D9414=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 2 qmp-test /x86_64/qmp/oob
> PASS 3 qmp-test /x86_64/qmp/preconfig
> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
> ---
> PASS 16 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82562/pci-device/pci-device=
-tests/nop
> PASS 17 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82801/pci-device/pci-device=
-tests/nop
> PASS 18 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ES1370/pci-device/pci-device=
-tests/nop
> =3D=3D9832=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt
> functions and may produce false positives in some cases!
> PASS 19 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/pci-device/pci-devic=
e-tests/nop
> PASS 20 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/megasas-tests/dcmd/p=
d-get-info/fuzz
> PASS 21 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ne2k_pci/pci-device/pci-devi=
ce-tests/nop
> PASS 22 qos-test
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tulip/pci-device/pci-device-=
tests/nop
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D9842=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x628000007cd0 at pc 0x55afa0cc27bc bp 0x7ffcc1aa0f50 sp 0x7ffcc1aa0700
> WRITE of size 2047 at 0x628000007cd0 thread T0
>     #0 0x55afa0cc27bb in __asan_memcpy
> (/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64+0x1acb7bb)
>     #1 0x55afa0d28368 in flatview_read_continue
> /tmp/qemu-test/src/exec.c:3194:13
> ---
> =3D=3D9842=3D=3DABORTING
> Broken pipe
> /tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1 (expected 0)
> ERROR - too few tests run (expected 81, got 22)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:636:
> check-qtest-x86_64] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',
> '--label', 'com.qemu.instance.uuid=3Dfd7ecc242d654dbb9aa25b433433a86b', '=
-u',
> '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e',
> 'TARGET_LIST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=
=3D',
> '-e', 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e',
> 'CCACHE_DIR=3D/var/tmp/ccache', '-v',
> '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-w1fqn3u3/src/docker-src.2020-03-27-14.45.34.=
12696:/var/tmp/qemu:z,ro',
> 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' returned non-zero exit
> status 2.
>
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dfd7ecc242d654dbb9aa2=
5b433433a86b
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-w1fqn3u3/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>
> real    38m27.972s
> user    0m8.800s
>
>
> The full log is available at
>
> http://patchew.org/logs/20200327161146.16402-1-liq3ea@163.com/testing.asa=
n/?type=3Dmessage
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--000000000000877d8905a1e31bbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>This is in expectation.</div=
><div>Jason I think this patch maybe go your tree, with the Prasad&#39;s fi=
x path.</div><div><br></div><div>Thanks,</div><div>Li Qiang</div><div><br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">&lt;<a href=3D"mailto:no-reply@patchew.org">no-reply@patchew.org</a>&g=
t; =E4=BA=8E2020=E5=B9=B43=E6=9C=8828=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=
=E5=8D=883:24=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Patchew URL: <a href=3D"https://patchew.org/QEMU/2=
0200327161146.16402-1-liq3ea@163.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchew.org/QEMU/20200327161146.16402-1-liq3ea@163.com/</a><br>
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
export ARCH=3Dx86_64<br>
make docker-image-fedora V=3D1 NETWORK=3D1<br>
time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NETW=
ORK=3D1<br>
=3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
<br>
PASS 1 fdc-test /x86_64/fdc/cmos<br>
PASS 2 fdc-test /x86_64/fdc/no_media_on_start<br>
PASS 3 fdc-test /x86_64/fdc/read_without_media<br>
=3D=3D6166=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
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
=3D=3D6211=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6211=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffee7b7c000; bottom 0x7fa15e601000; size: 0x005d8957b000 (4=
01736183808)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-coroutine /basic/no-dangling-access<br>
---<br>
PASS 11 test-aio /aio/event/wait<br>
PASS 12 test-aio /aio/event/flush<br>
PASS 13 test-aio /aio/event/wait/no-flush-cb<br>
=3D=3D6226=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 test-aio /aio/timer/schedule<br>
PASS 15 test-aio /aio/coroutine/queue-chaining<br>
PASS 16 test-aio /aio-gsource/flush<br>
---<br>
PASS 12 fdc-test /x86_64/fdc/read_no_dma_19<br>
PASS 13 fdc-test /x86_64/fdc/fuzz-registers<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/ide-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;ide-test&quot; <br>
=3D=3D6234=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 28 test-aio /aio-gsource/timer/schedule<br>
PASS 1 ide-test /x86_64/ide/identify<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-aio-multithread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a =
href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driv=
er.pl</a> --test-name=3D&quot;test-aio-multithread&quot; <br>
=3D=3D6243=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-aio-multithread /aio/multi/lifecycle<br>
=3D=3D6240=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 ide-test /x86_64/ide/flush<br>
PASS 2 test-aio-multithread /aio/multi/schedule<br>
=3D=3D6260=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 ide-test /x86_64/ide/bmdma/simple_rw<br>
PASS 3 test-aio-multithread /aio/multi/mutex/contended<br>
=3D=3D6271=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 ide-test /x86_64/ide/bmdma/trim<br>
=3D=3D6282=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 test-aio-multithread /aio/multi/mutex/handoff<br>
PASS 5 test-aio-multithread /aio/multi/mutex/mcs<br>
PASS 6 test-aio-multithread /aio/multi/mutex/pthread<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-throttle -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-throttle&quot; <br>
=3D=3D6299=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-throttle /throttle/leak_bucket<br>
PASS 2 test-throttle /throttle/compute_wait<br>
PASS 3 test-throttle /throttle/init<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-thread-pool -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-thread-pool&quot; <br>
PASS 1 test-thread-pool /thread-pool/submit<br>
PASS 2 test-thread-pool /thread-pool/submit-aio<br>
=3D=3D6303=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 test-thread-pool /thread-pool/submit-co<br>
PASS 4 test-thread-pool /thread-pool/submit-many<br>
=3D=3D6305=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 test-thread-pool /thread-pool/cancel<br>
PASS 6 test-thread-pool /thread-pool/cancel-async<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-hbitmap -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-hbitmap&quot; <br>
---<br>
PASS 14 test-hbitmap /hbitmap/set/twice<br>
PASS 15 test-hbitmap /hbitmap/set/overlap<br>
PASS 16 test-hbitmap /hbitmap/reset/empty<br>
=3D=3D6380=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 17 test-hbitmap /hbitmap/reset/general<br>
PASS 18 test-hbitmap /hbitmap/reset/all<br>
PASS 19 test-hbitmap /hbitmap/truncate/nop<br>
---<br>
PASS 39 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4<br>
PASS 40 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_after_truncat=
e<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bdrv-drain -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-bdrv-drain&quot; <br>
=3D=3D6387=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bdrv-drain /bdrv-drain/nested<br>
PASS 2 test-bdrv-drain /bdrv-drain/multiparent<br>
PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context<br>
---<br>
PASS 41 test-bdrv-drain /bdrv-drain/bdrv_drop_intermediate/poll<br>
PASS 42 test-bdrv-drain /bdrv-drain/replace_child/mid-drain<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bdrv-graph-mod -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-bdrv-graph-mod&quot; <br>
=3D=3D6426=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree<br>
PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-blockjob -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-blockjob&quot; <br>
=3D=3D6430=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-blockjob /blockjob/ids<br>
PASS 2 test-blockjob /blockjob/cancel/created<br>
PASS 3 test-blockjob /blockjob/cancel/running<br>
---<br>
PASS 7 test-blockjob /blockjob/cancel/pending<br>
PASS 8 test-blockjob /blockjob/cancel/concluded<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-blockjob-txn -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-blockjob-txn&quot; <br>
=3D=3D6434=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-blockjob-txn /single/success<br>
PASS 2 test-blockjob-txn /single/failure<br>
PASS 3 test-blockjob-txn /single/cancel<br>
---<br>
PASS 6 test-blockjob-txn /pair/cancel<br>
PASS 7 test-blockjob-txn /pair/fail-cancel-race<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-block-backend -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-block-backend&quot; <br>
=3D=3D6438=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-block-backend /block-backend/drain_aio_error<br>
PASS 2 test-block-backend /block-backend/drain_all_aio_error<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-block-iothread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-block-iothread&quot; <br>
=3D=3D6444=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-block-iothread /sync-op/pread<br>
PASS 2 test-block-iothread /sync-op/pwrite<br>
PASS 3 test-block-iothread /sync-op/load_vmstate<br>
---<br>
PASS 15 test-block-iothread /propagate/diamond<br>
PASS 16 test-block-iothread /propagate/mirror<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-image-locking -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-image-locking&quot; <br>
=3D=3D6464=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-image-locking /image-locking/basic<br>
PASS 2 test-image-locking /image-locking/set-perm-abort<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-x86-cpuid -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-x86-cpuid&quot; <br>
=3D=3D6440=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-x86-cpuid /cpuid/topology/basic<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-xbzrle -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"h=
ttp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a>=
 --test-name=3D&quot;test-xbzrle&quot; <br>
PASS 1 test-xbzrle /xbzrle/uleb<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-list -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-rcu-list&quot; <br>
PASS 1 test-rcu-list /rcu/qlist/single-threaded<br>
PASS 2 test-rcu-list /rcu/qlist/short-few<br>
=3D=3D6532=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 test-rcu-list /rcu/qlist/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-simpleq -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-rcu-simpleq&quot; <br>
PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded<br>
PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few<br>
=3D=3D6592=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-tailq -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-rcu-tailq&quot; <br>
PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded<br>
PASS 2 test-rcu-tailq /rcu/qtailq/short-few<br>
PASS 3 test-rcu-tailq /rcu/qtailq/long-many<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-rcu-slist -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-rcu-slist&quot; <br>
=3D=3D6631=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-rcu-slist /rcu/qslist/single-threaded<br>
PASS 2 test-rcu-slist /rcu/qslist/short-few<br>
PASS 3 test-rcu-slist /rcu/qslist/long-many<br>
---<br>
PASS 7 test-qdist /qdist/binning/expand<br>
PASS 8 test-qdist /qdist/binning/shrink<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qht -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"http=
://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> --=
test-name=3D&quot;test-qht&quot; <br>
=3D=3D6677=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6683=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 ide-test /x86_64/ide/bmdma/various_prdts<br>
=3D=3D6689=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6689=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe5f4ce000; bottom 0x7ff3fcbfe000; size: 0x000a628d0000 (4=
4603080704)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 6 ide-test /x86_64/ide/bmdma/no_busmaster<br>
PASS 7 ide-test /x86_64/ide/flush/nodev<br>
PASS 1 test-qht /qht/mode/default<br>
=3D=3D6700=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 test-qht /qht/mode/resize<br>
PASS 8 ide-test /x86_64/ide/flush/empty_drive<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qht-par -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-qht-par&quot; <br>
=3D=3D6706=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 ide-test /x86_64/ide/flush/retry_pci<br>
PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s<br>
=3D=3D6720=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 ide-test /x86_64/ide/flush/retry_isa<br>
PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bitops -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"h=
ttp://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a>=
 --test-name=3D&quot;test-bitops&quot; <br>
=3D=3D6732=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bitops /bitops/sextract32<br>
PASS 2 test-bitops /bitops/sextract64<br>
PASS 3 test-bitops /bitops/half_shuffle32<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/check-qom-interface -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;check-qom-interface&quot; <br>
PASS 1 check-qom-interface /qom/interface/direct_impl<br>
PASS 2 check-qom-interface /qom/interface/intermediate_impl<br>
=3D=3D6744=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/check-qom-proplist -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;check-qom-proplist&quot; <br>
PASS 1 check-qom-proplist /qom/proplist/createlist<br>
PASS 2 check-qom-proplist /qom/proplist/createv<br>
---<br>
PASS 27 test-crypto-cipher /crypto/cipher/null-iv<br>
PASS 28 test-crypto-cipher /crypto/cipher/short-plaintext<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-secret -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-crypto-secret&quot; <br>
=3D=3D6788=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 ide-test /x86_64/ide/cdrom/dma<br>
PASS 1 test-crypto-secret /crypto/secret/direct<br>
PASS 2 test-crypto-secret /crypto/secret/indirect/good<br>
---<br>
PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver<br>
PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient<br>
PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1<br>
=3D=3D6818=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 ahci-test /x86_64/ahci/sanity<br>
=3D=3D6824=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 ahci-test /x86_64/ahci/pci_spec<br>
PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2<br>
=3D=3D6830=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 ahci-test /x86_64/ahci/pci_enable<br>
PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3<br>
PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1<br>
PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2<br>
PASS 8 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca3<br>
=3D=3D6836=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1<br>
PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2<br>
PASS 4 ahci-test /x86_64/ahci/hba_spec<br>
PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3<br>
=3D=3D6842=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 ahci-test /x86_64/ahci/hba_enable<br>
=3D=3D6848=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 ahci-test /x86_64/ahci/identify<br>
=3D=3D6854=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4<br>
PASS 7 ahci-test /x86_64/ahci/max<br>
PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5<br>
=3D=3D6860=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 ahci-test /x86_64/ahci/reset<br>
PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6<br>
=3D=3D6866=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7<br>
PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1<br>
PASS 17 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver2<br>
---<br>
PASS 38 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingserver<br>
PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-tlssession -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<=
a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dr=
iver.pl</a> --test-name=3D&quot;test-crypto-tlssession&quot; <br>
=3D=3D6866=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc0b5c7000; bottom 0x7fab527fe000; size: 0x0050b8dc9000 (3=
46698846208)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero<br>
=3D=3D6876=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6876=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff3769b000; bottom 0x7fabf8bfe000; size: 0x00533ea9d000 (3=
57533601792)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low<br>
=3D=3D6882=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6882=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc51f34000; bottom 0x7f8edcdfe000; size: 0x006d75136000 (4=
70115639296)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high<br>
=3D=3D6888=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6888=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffeb05c5000; bottom 0x7fab93ffe000; size: 0x00531c5c7000 (3=
56958105600)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk<br>
PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero<br>
=3D=3D6894=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6894=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc068e8000; bottom 0x7f26891fe000; size: 0x00d57d6ea000 (9=
16932435968)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low<br>
=3D=3D6900=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca<br>
=3D=3D6900=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fffe8370000; bottom 0x7fa4cdffe000; size: 0x005b1a372000 (3=
91281844224)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high<br>
=3D=3D6906=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6906=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe3707c000; bottom 0x7f31a69fe000; size: 0x00cc9067e000 (8=
78596055040)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca<br>
PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero<br>
PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1<br>
PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2<br>
=3D=3D6912=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6912=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc9f482000; bottom 0x7f60eb5fe000; size: 0x009bb3e84000 (6=
68738273280)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3<br>
PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low<br>
PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4<br>
PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5<br>
=3D=3D6918=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6918=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc331f7000; bottom 0x7f08a7ffe000; size: 0x00f38b1f9000 (1=
046011154432)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6<br>
PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high<br>
PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1<br>
=3D=3D6924=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero<br>
PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2<br>
=3D=3D6930=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3<br>
PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low<br>
=3D=3D6936=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4<br>
PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5<br>
PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high<br>
=3D=3D6942=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6942=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff6097f000; bottom 0x7f1a7edfe000; size: 0x00e4e1b81000 (9=
83039479808)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6<br>
PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero<br>
PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qga -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"http=
://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> --=
test-name=3D&quot;test-qga&quot; <br>
=3D=3D6948=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6948=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff99987000; bottom 0x7f52b7bfe000; size: 0x00ace1d89000 (7=
42523441152)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low<br>
=3D=3D6962=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-qga /qga/sync-delimited<br>
PASS 2 test-qga /qga/sync<br>
PASS 3 test-qga /qga/ping<br>
---<br>
PASS 8 test-qga /qga/get-memory-block-info<br>
PASS 9 test-qga /qga/get-memory-blocks<br>
PASS 10 test-qga /qga/file-ops<br>
=3D=3D6962=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe55625000; bottom 0x7f525effe000; size: 0x00abf6627000 (7=
38573053952)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 11 test-qga /qga/file-write-read<br>
---<br>
PASS 16 test-qga /qga/invalid-args<br>
PASS 17 test-qga /qga/fsfreeze-status<br>
PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high<br>
=3D=3D6971=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6971=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe03137000; bottom 0x7f804e1fe000; size: 0x007db4f39000 (5=
39906772992)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero<br>
---<br>
PASS 19 test-qga /qga/config<br>
PASS 20 test-qga /qga/guest-exec<br>
PASS 21 test-qga /qga/guest-exec-invalid<br>
=3D=3D6977=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D6977=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fffa7b49000; bottom 0x7f8404dfe000; size: 0x007ba2d4b000 (5=
31012825088)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low<br>
PASS 22 test-qga /qga/guest-get-osinfo<br>
PASS 23 test-qga /qga/guest-get-host-name<br>
PASS 24 test-qga /qga/guest-get-timezone<br>
=3D=3D6995=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 25 test-qga /qga/guest-get-users<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-timed-average -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hr=
ef=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver=
.pl</a> --test-name=3D&quot;test-timed-average&quot; <br>
=3D=3D6995=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff90d75000; bottom 0x7fdbeadfe000; size: 0x0023a5f77000 (1=
53108312064)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-timed-average /timed-average/average<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-authz-simple -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-authz-simple&quot; <br>
PASS 1 test-authz-simple /authz/simple<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-authz-list -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-authz-list&quot; <br>
=3D=3D7011=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-authz-list /auth/list/complex<br>
PASS 2 test-authz-list /auth/list/add-remove<br>
PASS 3 test-authz-list /auth/list/default/deny<br>
---<br>
PASS 4 test-authz-listfile /auth/list/explicit/deny<br>
PASS 5 test-authz-listfile /auth/list/explicit/allow<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-io-task -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"=
http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a=
> --test-name=3D&quot;test-io-task&quot; <br>
=3D=3D7011=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff22523000; bottom 0x7fba0757c000; size: 0x00451afa7000 (2=
96805363712)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-io-task /crypto/task/complete<br>
---<br>
PASS 4 test-io-channel-file /io/channel/pipe/sync<br>
PASS 5 test-io-channel-file /io/channel/pipe/async<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-io-channel-tls -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-io-channel-tls&quot; <br>
=3D=3D7082=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7082=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe28d22000; bottom 0x7fa443dfe000; size: 0x0059e4f24000 (3=
86093170688)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-io-channel-tls /qio/channel/tls/basic<br>
---<br>
PASS 3 test-base64 /util/base64/not-nul-terminated<br>
PASS 4 test-base64 /util/base64/invalid-chars<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-pbkdf -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-crypto-pbkdf&quot; <br>
=3D=3D7105=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1<br>
PASS 2 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter2<br>
PASS 3 test-crypto-pbkdf /crypto/pbkdf/rfc3962/sha1/iter1200a<br>
---<br>
PASS 8 test-crypto-ivgen /crypto/ivgen/essiv/1f2e3d4c<br>
PASS 9 test-crypto-ivgen /crypto/ivgen/essiv/1f2e3d4c5b6a7988<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-crypto-afsplit -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-crypto-afsplit&quot; <br>
=3D=3D7105=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fffd4698000; bottom 0x7fbf929fe000; size: 0x004041c9a000 (2=
75981639680)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 1 test-crypto-afsplit /crypto/afsplit/sha256/5<br>
---<br>
PASS 3 test-logging /logging/logfile_write_path<br>
PASS 4 test-logging /logging/logfile_lock_path<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-replication -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-replication&quot; <br>
=3D=3D7142=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7145=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero<br>
PASS 1 test-replication /replication/primary/read<br>
PASS 2 test-replication /replication/primary/write<br>
=3D=3D7153=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 31 ahci-test /x86_64/ahci/io/pio/lba48/short/low<br>
PASS 3 test-replication /replication/primary/start<br>
PASS 4 test-replication /replication/primary/stop<br>
PASS 5 test-replication /replication/primary/do_checkpoint<br>
PASS 6 test-replication /replication/primary/get_error_all<br>
=3D=3D7159=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 32 ahci-test /x86_64/ahci/io/pio/lba48/short/high<br>
=3D=3D7165=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 test-replication /replication/secondary/read<br>
PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented<br>
=3D=3D7171=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 test-replication /replication/secondary/write<br>
PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry<br>
=3D=3D7177=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero<br>
=3D=3D7183=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low<br>
=3D=3D7190=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high<br>
=3D=3D7145=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffef72a3000; bottom 0x7ff0b0a79000; size: 0x000e4682a000 (6=
1312507904)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
=3D=3D7196=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 test-replication /replication/secondary/start<br>
PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero<br>
=3D=3D7217=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low<br>
=3D=3D7223=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high<br>
=3D=3D7229=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7229=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffedf651000; bottom 0x7f7a4c123000; size: 0x00849352e000 (5=
69407365120)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero<br>
=3D=3D7236=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 test-replication /replication/secondary/stop<br>
=3D=3D7236=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe69c99000; bottom 0x7f86621fd000; size: 0x007807a9c000 (5=
15524640768)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low<br>
=3D=3D7243=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7243=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffe93f0c000; bottom 0x7fa1f51fd000; size: 0x005c9ed0f000 (3=
97801484288)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high<br>
=3D=3D7249=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero<br>
=3D=3D7255=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low<br>
PASS 11 test-replication /replication/secondary/continuous_replication<br>
=3D=3D7261=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high<br>
=3D=3D7267=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero<br>
=3D=3D7273=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low<br>
=3D=3D7279=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 test-replication /replication/secondary/do_checkpoint<br>
PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high<br>
=3D=3D7285=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 test-replication /replication/secondary/get_error_all<br>
PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bufferiszero -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a hre=
f=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.=
pl</a> --test-name=3D&quot;test-bufferiszero&quot; <br>
=3D=3D7291=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low<br>
=3D=3D7300=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high<br>
=3D=3D7306=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7306=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffcc1ced000; bottom 0x7f06bedfd000; size: 0x00f602ef0000 (1=
056611172352)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero<br>
=3D=3D7313=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7313=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fff4dca2000; bottom 0x7f77013fd000; size: 0x00884c8a5000 (5=
85399685120)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low<br>
=3D=3D7320=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7320=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffc3c7cf000; bottom 0x7f1a5c7fd000; size: 0x00e1dffd2000 (9=
70125549568)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high<br>
=3D=3D7327=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero<br>
=3D=3D7333=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low<br>
=3D=3D7339=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high<br>
=3D=3D7345=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 59 ahci-test /x86_64/ahci/io/ncq/simple<br>
=3D=3D7351=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 60 ahci-test /x86_64/ahci/io/ncq/retry<br>
=3D=3D7357=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 61 ahci-test /x86_64/ahci/flush/simple<br>
=3D=3D7363=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 62 ahci-test /x86_64/ahci/flush/retry<br>
=3D=3D7369=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7375=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 63 ahci-test /x86_64/ahci/flush/migrate<br>
=3D=3D7383=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7389=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 64 ahci-test /x86_64/ahci/migrate/sanity<br>
=3D=3D7397=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7403=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple<br>
=3D=3D7411=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7417=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted<br>
=3D=3D7425=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7431=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple<br>
=3D=3D7439=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7445=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bufferiszero /cutils/bufferiszero<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-uuid -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D"htt=
p://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</a> -=
-test-name=3D&quot;test-uuid&quot; <br>
PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted<br>
---<br>
PASS 21 test-qgraph /qgraph/test_two_test_same_interface<br>
PASS 22 test-qgraph /qgraph/test_test_in_path<br>
PASS 23 test-qgraph /qgraph/test_double_edge<br>
=3D=3D7456=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 69 ahci-test /x86_64/ahci/cdrom/eject<br>
=3D=3D7471=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single<br>
=3D=3D7477=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi<br>
=3D=3D7483=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single<br>
=3D=3D7489=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7489=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffd0aaa2000; bottom 0x7fd7befee000; size: 0x00254bab4000 (1=
60183304192)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi<br>
=3D=3D7495=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/hd-geo-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<=
a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dr=
iver.pl</a> --test-name=3D&quot;hd-geo-test&quot; <br>
PASS 1 hd-geo-test /x86_64/hd-geo/ide/none<br>
=3D=3D7509=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0<br>
=3D=3D7515=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank<br>
=3D=3D7521=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba<br>
=3D=3D7527=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs<br>
=3D=3D7533=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank<br>
=3D=3D7539=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba<br>
=3D=3D7545=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs<br>
=3D=3D7551=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs<br>
=3D=3D7556=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst<br>
=3D=3D7562=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7566=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7570=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7574=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7578=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7582=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7586=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7590=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7593=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 hd-geo-test /x86_64/hd-geo/override/ide<br>
=3D=3D7600=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7604=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7608=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7612=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7616=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7620=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7624=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7628=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7631=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 hd-geo-test /x86_64/hd-geo/override/scsi<br>
=3D=3D7638=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7642=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7646=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7650=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7654=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7658=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7662=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7666=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7669=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 hd-geo-test /x86_64/hd-geo/override/scsi_2_controllers<br>
=3D=3D7676=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7680=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7684=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7688=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7691=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 hd-geo-test /x86_64/hd-geo/override/virtio_blk<br>
=3D=3D7698=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7702=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7705=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 hd-geo-test /x86_64/hd-geo/override/zero_chs<br>
=3D=3D7712=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7716=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7720=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7724=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7727=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 16 hd-geo-test /x86_64/hd-geo/override/scsi_hot_unplug<br>
=3D=3D7734=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7738=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7742=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7746=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
=3D=3D7749=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 17 hd-geo-test /x86_64/hd-geo/override/virtio_hot_unplug<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/boot-order-test -m=3Dquick -k --tap &lt; /dev/null | ./scrip=
ts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">ta=
p-driver.pl</a> --test-name=3D&quot;boot-order-test&quot; <br>
PASS 1 boot-order-test /x86_64/boot-order/pc<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7818=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
Using expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7824=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
Using expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7830=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.bridge&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7836=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.ipmikcs&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7842=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.cphp&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7849=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.memhp&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7855=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.numamem&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7861=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.dimmpxm&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7870=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP.acpihmat&#39;<br>
Looking for expected file &#39;tests/data/acpi/pc/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7877=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.bridge&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7883=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.mmio64&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7889=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.ipmibt&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7895=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.cphp&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7902=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.memhp&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7908=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.numamem&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7914=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.dimmpxm&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D7923=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP.acpihmat&#39;<br>
Looking for expected file &#39;tests/data/acpi/q35/FACP&#39;<br>
---<br>
PASS 1 i440fx-test /x86_64/i440fx/defaults<br>
PASS 2 i440fx-test /x86_64/i440fx/pam<br>
PASS 3 i440fx-test /x86_64/i440fx/firmware/bios<br>
=3D=3D8015=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/fw_cfg-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<=
a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-dr=
iver.pl</a> --test-name=3D&quot;fw_cfg-test&quot; <br>
PASS 1 fw_cfg-test /x86_64/fw_cfg/signature<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/drive_del-test -m=3Dquick -k --tap &lt; /dev/null | ./script=
s/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap=
-driver.pl</a> --test-name=3D&quot;drive_del-test&quot; <br>
PASS 1 drive_del-test /x86_64/drive_del/without-dev<br>
PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add<br>
=3D=3D8108=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/wdt_ib700-test -m=3Dquick -k --tap &lt; /dev/null | ./script=
s/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap=
-driver.pl</a> --test-name=3D&quot;wdt_ib700-test&quot; <br>
PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause<br>
---<br>
PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init<br>
PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1<br>
PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug<br>
=3D=3D8303=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/usb-hcd-ehci-test -m=3Dquick -k --tap &lt; /dev/null | ./scr=
ipts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">=
tap-driver.pl</a> --test-name=3D&quot;usb-hcd-ehci-test&quot; <br>
PASS 1 usb-hcd-ehci-test /x86_64/ehci/pci/uhci-port-1<br>
---<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/usb-hcd-xhci-test -m=3Dquick -k --tap &lt; /dev/null | ./scr=
ipts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">=
tap-driver.pl</a> --test-name=3D&quot;usb-hcd-xhci-test&quot; <br>
PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init<br>
PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug<br>
=3D=3D8321=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas<br>
PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/cpu-plug-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts=
/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-=
driver.pl</a> --test-name=3D&quot;cpu-plug-test&quot; <br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8457=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8463=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8469=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/tpm-crb-swtpm-test -m=3Dquick -k --tap &lt; /dev/null | ./sc=
ripts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank"=
>tap-driver.pl</a> --test-name=3D&quot;tpm-crb-swtpm-test&quot; <br>
SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not in PA=
TH or missing --tpm2 support<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8568=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8574=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 3 migration-test /x86_64/migration/fd_proto<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8581=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8587=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 4 migration-test /x86_64/migration/validate_uuid<br>
PASS 5 migration-test /x86_64/migration/validate_uuid_error<br>
PASS 6 migration-test /x86_64/migration/validate_uuid_src_not_set<br>
---<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8637=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8643=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 8 migration-test /x86_64/migration/auto_converge<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8651=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8657=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 9 migration-test /x86_64/migration/postcopy/unix<br>
PASS 10 migration-test /x86_64/migration/postcopy/recovery<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8686=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8692=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 11 migration-test /x86_64/migration/precopy/unix<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8700=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8706=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 12 migration-test /x86_64/migration/precopy/tcp<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8714=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8720=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 13 migration-test /x86_64/migration/xbzrle/unix<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8728=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8734=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 14 migration-test /x86_64/migration/multifd/tcp/none<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8852=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 migration-test /x86_64/migration/multifd/tcp/cancel<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8908=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8914=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 16 migration-test /x86_64/migration/multifd/tcp/zlib<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8970=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
Could not access KVM kernel module: No such file or directory<br>
qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or d=
irectory<br>
qemu-system-x86_64: falling back to tcg<br>
=3D=3D8976=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 17 migration-test /x86_64/migration/multifd/tcp/zstd<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/test-x86-cpuid-compat -m=3Dquick -k --tap &lt; /dev/null | .=
/scripts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_bla=
nk">tap-driver.pl</a> --test-name=3D&quot;test-x86-cpuid-compat&quot; <br>
PASS 1 test-x86-cpuid-compat /x86/cpuid/parsing-plus-minus<br>
---<br>
PASS 1 machine-none-test /x86_64/machine/none/cpu_option<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 QT=
EST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-i=
mg tests/qtest/qmp-test -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;qmp-test&quot; <br>
PASS 1 qmp-test /x86_64/qmp/protocol<br>
=3D=3D9414=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 qmp-test /x86_64/qmp/oob<br>
PASS 3 qmp-test /x86_64/qmp/preconfig<br>
PASS 4 qmp-test /x86_64/qmp/missing-any-arg<br>
---<br>
PASS 16 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82562/pci-de=
vice/pci-device-tests/nop<br>
PASS 17 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/i82801/pci-de=
vice/pci-device-tests/nop<br>
PASS 18 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ES1370/pci-de=
vice/pci-device-tests/nop<br>
=3D=3D9832=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 19 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/pci-d=
evice/pci-device-tests/nop<br>
PASS 20 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/megasas/megas=
as-tests/dcmd/pd-get-info/fuzz<br>
PASS 21 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/ne2k_pci/pci-=
device/pci-device-tests/nop<br>
PASS 22 qos-test /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/tulip/pci-dev=
ice/pci-device-tests/nop<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=3D=3D9842=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0x=
628000007cd0 at pc 0x55afa0cc27bc bp 0x7ffcc1aa0f50 sp 0x7ffcc1aa0700<br>
WRITE of size 2047 at 0x628000007cd0 thread T0<br>
=C2=A0 =C2=A0 #0 0x55afa0cc27bb in __asan_memcpy (/tmp/qemu-test/build/x86_=
64-softmmu/qemu-system-x86_64+0x1acb7bb)<br>
=C2=A0 =C2=A0 #1 0x55afa0d28368 in flatview_read_continue /tmp/qemu-test/sr=
c/exec.c:3194:13<br>
---<br>
=3D=3D9842=3D=3DABORTING<br>
Broken pipe<br>
/tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to termina=
te QEMU process but encountered exit status 1 (expected 0)<br>
ERROR - too few tests run (expected 81, got 22)<br>
make: *** [/tmp/qemu-test/src/tests/Makefile.include:636: check-qtest-x86_6=
4] Error 1<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;./tests/docker/docker.py&quot;, line 664, in &lt;module&g=
t;<br>
=C2=A0 =C2=A0 sys.exit(main())<br>
---<br>
=C2=A0 =C2=A0 raise CalledProcessError(retcode, cmd)<br>
subprocess.CalledProcessError: Command &#39;[&#39;sudo&#39;, &#39;-n&#39;, =
&#39;docker&#39;, &#39;run&#39;, &#39;--label&#39;, &#39;com.qemu.instance.=
uuid=3Dfd7ecc242d654dbb9aa25b433433a86b&#39;, &#39;-u&#39;, &#39;1001&#39;,=
 &#39;--security-opt&#39;, &#39;seccomp=3Dunconfined&#39;, &#39;--rm&#39;, =
&#39;-e&#39;, &#39;TARGET_LIST=3Dx86_64-softmmu&#39;, &#39;-e&#39;, &#39;EX=
TRA_CONFIGURE_OPTS=3D&#39;, &#39;-e&#39;, &#39;V=3D&#39;, &#39;-e&#39;, &#3=
9;J=3D14&#39;, &#39;-e&#39;, &#39;DEBUG=3D&#39;, &#39;-e&#39;, &#39;SHOW_EN=
V=3D&#39;, &#39;-e&#39;, &#39;CCACHE_DIR=3D/var/tmp/ccache&#39;, &#39;-v&#3=
9;, &#39;/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z&#39;, &#=
39;-v&#39;, &#39;/var/tmp/patchew-tester-tmp-w1fqn3u3/src/docker-src.2020-0=
3-27-14.45.34.12696:/var/tmp/qemu:z,ro&#39;, &#39;qemu:fedora&#39;, &#39;/v=
ar/tmp/qemu/run&#39;, &#39;test-debug&#39;]&#39; returned non-zero exit sta=
tus 2.<br>
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dfd7ecc242d654dbb9aa25b=
433433a86b<br>
make[1]: *** [docker-run] Error 1<br>
make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-w1fqn3u3/src&#39;<b=
r>
make: *** [docker-run-test-debug@fedora] Error 2<br>
<br>
real=C2=A0 =C2=A0 38m27.972s<br>
user=C2=A0 =C2=A0 0m8.800s<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20200327161146.16402-1-liq3ea@163.com/te=
sting.asan/?type=3Dmessage" rel=3D"noreferrer" target=3D"_blank">http://pat=
chew.org/logs/20200327161146.16402-1-liq3ea@163.com/testing.asan/?type=3Dme=
ssage</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div>

--000000000000877d8905a1e31bbf--

