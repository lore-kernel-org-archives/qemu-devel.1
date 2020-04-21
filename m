Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24100C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54EA206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 04:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGCjRZZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54EA206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQkAC-00020y-2n
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 00:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQk9S-0001UU-J9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQk9P-0008H2-Ue
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:04:50 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:47004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQk9P-0008Gi-GI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 00:04:47 -0400
Received: by mail-io1-xd44.google.com with SMTP id i3so13557662ioo.13
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LkUbYdIsR3N5NuVDUpWT5F6kmjNxcZ4T4R5sLNgMcpI=;
 b=KGCjRZZkAfiBi3v5vm95OOzXEtl1YlnZ3zof+SVQ8Ix98qcRhjvhsGRZwmJ73VDx1s
 H43oUPtdyMf5Z5EQc+Zsf4Hbb0HXO+HmE9ZI0036Jgch2bIGs8L11Pj3QRZotO/bHeZn
 9iL5sxTDrLq23G27CTc3vd2CIXEadl0+zOeuAIl3fIPt4yrOihc6igRdmw+TChGE+NVr
 EbzrtMWveu1P9kYQiHbYJtbR0Jo/krIuwmQRCAUZfc3UAVM6q4IRkjG8vMXx43uWOvnB
 cLhgnRIL1Idh+p36XsxwFdXAPaFizpm4/NSFdZdOcsNHAeUZhd2jchGndE1LP4fnsqUy
 si1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LkUbYdIsR3N5NuVDUpWT5F6kmjNxcZ4T4R5sLNgMcpI=;
 b=j4SVBLkuUR5Mykosc0l65Tj5OERwY9Jkdt+NOAYRn8SWdc1nEgu2UyrhRKU0x95Of8
 ZcmsMsegHmQmWB4zm8kY3gBVOgu6TJYIByfpNtbIOe/WFEGiU8Hpd9ybWoIzt8BqR80W
 8J97NgrHeaN8H0ujld2+Krm6oGD9PahWAkqhm3JdRNmQvn8Zpp4nv45U2lxeyL2g56H2
 IRWEQi5lcrY+T8l6jCOjHYfwnQ2vnE0/gHGZflgjhAVpDnCCtnxhZOTYQ3mLUobuIN4u
 3nhU/8f65058m0e9oHRucRPrTa5AhjpPqOnzdW+afvHnsovv2UZqWr9R/DM2B3jD45U2
 S+Hg==
X-Gm-Message-State: AGi0PubSt7tD7LfrC7m/jATAe8edka7N4kPTMAiw4pWftx2lftBCIDhP
 guJjE+C0wL/S236mq28b9239PFGyQTY7A9PuMPejAkJwq72WOw==
X-Google-Smtp-Source: APiQypLlg5CfcQUTml8XXBrTUO1QuXpsfE6JUmuw+YX0SxfCl1Nq05t7gxcEUdh9OkAkhZIyo9tcaSHETAaeWpVGeHw=
X-Received: by 2002:a6b:3fc6:: with SMTP id m189mr7155854ioa.97.1587441885487; 
 Mon, 20 Apr 2020 21:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200421014551.10426-1-pauldzim@gmail.com>
 <158743893692.13510.6600527854290913642@39012742ff91>
In-Reply-To: <158743893692.13510.6600527854290913642@39012742ff91>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 20 Apr 2020 21:04:19 -0700
Message-ID: <CADBGO7_gryYoSsf9CwFEghQEUCpS8EpFuWCYPPdMVOUNcGZ1dA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000afa5ab05a3c51de9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000afa5ab05a3c51de9
Content-Type: text/plain; charset="UTF-8"

Just FYI I think I have the fix for this (missing a
DEFINE_PROP_END_OF_LIST()).

Thanks,
Paul


On Mon, Apr 20, 2020 at 8:15 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20200421014551.10426-1-pauldzim@gmail.com/
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
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14
> NETWORK=1
> === TEST SCRIPT END ===
>
> PASS 2 check-qlit /qlit/qobject_from_qlit
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qobject-output-visitor -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-qobject-output-visitor"
> =================================================================
> ==6149==ERROR: AddressSanitizer: global-buffer-overflow on address
> 0x56224c1caf88 at pc 0x5622493e6bb5 bp 0x7ffe5c060dc0 sp 0x7ffe5c060db8
> READ of size 8 at 0x56224c1caf88 thread T0
> PASS 1 test-qobject-output-visitor /visitor/output/int
> PASS 2 test-qobject-output-visitor /visitor/output/bool
> ---
> PASS 32 test-opts-visitor /visitor/opts/range/beyond
> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-coroutine -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-coroutine"
> ==6260==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-coroutine /basic/no-dangling-access
> PASS 2 test-coroutine /basic/lifecycle
> ==6260==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7ffd4f2ef000; bottom 0x7f4998ecb000; size: 0x00b3b6424000
> (771856941056)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 3 test-coroutine /basic/yield
> ---
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> PASS 14 test-aio /aio/timer/schedule
> ==6275==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> PASS 17 test-aio /aio-gsource/bh/schedule
> ---
> PASS 28 test-aio /aio-gsource/timer/schedule
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-aio-multithread"
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> ==6280==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 2 test-aio-multithread /aio/multi/schedule
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-throttle -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-throttle"
> ==6314==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-throttle /throttle/leak_bucket
> PASS 2 test-throttle /throttle/compute_wait
> PASS 3 test-throttle /throttle/init
> ---
> PASS 14 test-throttle /throttle/config/max
> PASS 15 test-throttle /throttle/config/iops_size
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-thread-pool -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-thread-pool"
> ==6318==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-thread-pool /thread-pool/submit
> PASS 2 test-thread-pool /thread-pool/submit-aio
> PASS 3 test-thread-pool /thread-pool/submit-co
> ---
> PASS 39 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
> PASS 40 test-hbitmap
> /hbitmap/next_dirty_area/next_dirty_area_after_truncate
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-drain -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-bdrv-drain"
> ==6390==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-bdrv-drain /bdrv-drain/nested
> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
> ---
> PASS 41 test-bdrv-drain /bdrv-drain/bdrv_drop_intermediate/poll
> PASS 42 test-bdrv-drain /bdrv-drain/replace_child/mid-drain
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bdrv-graph-mod -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-bdrv-graph-mod"
> ==6429==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-blockjob"
> ==6433==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob /blockjob/ids
> PASS 2 test-blockjob /blockjob/cancel/created
> PASS 3 test-blockjob /blockjob/cancel/running
> ---
> PASS 7 test-blockjob /blockjob/cancel/pending
> PASS 8 test-blockjob /blockjob/cancel/concluded
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-blockjob-txn -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-blockjob-txn"
> ==6437==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-blockjob-txn /single/success
> PASS 2 test-blockjob-txn /single/failure
> PASS 3 test-blockjob-txn /single/cancel
> ---
> PASS 6 test-blockjob-txn /pair/cancel
> PASS 7 test-blockjob-txn /pair/fail-cancel-race
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-backend -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-block-backend"
> ==6441==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-block-backend /block-backend/drain_aio_error
> PASS 2 test-block-backend /block-backend/drain_all_aio_error
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-block-iothread -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-block-iothread"
> ==6445==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-block-iothread /sync-op/pread
> PASS 2 test-block-iothread /sync-op/pwrite
> PASS 3 test-block-iothread /sync-op/load_vmstate
> ---
> PASS 15 test-block-iothread /propagate/diamond
> PASS 16 test-block-iothread /propagate/mirror
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-image-locking -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-image-locking"
> ==6465==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-image-locking /image-locking/basic
> PASS 2 test-image-locking /image-locking/set-perm-abort
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-x86-cpuid -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-x86-cpuid"
> ---
> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest_init_without_qmp_handshake:
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> /tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1 (expected 0)
> ERROR - Bail out!
> ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest_init_without_qmp_handshake:
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:636:
> check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
> ---
> PASS 3 test-logging /logging/logfile_write_path
> PASS 4 test-logging /logging/logfile_lock_path
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-replication -m=quick -k --tap < /dev/null | ./scripts/
> tap-driver.pl --test-name="test-replication"
> ==6882==WARNING: ASan doesn't fully support makecontext/swapcontext
> functions and may produce false positives in some cases!
> PASS 1 test-replication /replication/primary/read
> PASS 2 test-replication /replication/primary/write
> PASS 3 test-replication /replication/primary/start
> ---
> PASS 6 test-replication /replication/primary/get_error_all
> PASS 7 test-replication /replication/secondary/read
> PASS 8 test-replication /replication/secondary/write
> ==6882==WARNING: ASan is ignoring requested __asan_handle_no_return: stack
> top: 0x7fffab8b6000; bottom 0x7f38b34b0000; size: 0x00c6f8406000
> (854568493056)
> False positive error reports may follow
> For details see https://github.com/google/sanitizers/issues/189
> PASS 9 test-replication /replication/secondary/start
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',
> '--label', 'com.qemu.instance.uuid=45f88c4b9a644d6bb7f191a23649e083', '-u',
> '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e',
> 'TARGET_LIST=x86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=',
> '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e',
> 'CCACHE_DIR=/var/tmp/ccache', '-v',
> '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-v1o9n7mt/src/docker-src.2020-04-20-22.43.23.2115:/var/tmp/qemu:z,ro',
> 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' returned non-zero exit
> status 2.
>
> filter=--filter=label=com.qemu.instance.uuid=45f88c4b9a644d6bb7f191a23649e083
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-v1o9n7mt/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>
> real    32m12.420s
> user    0m8.663s
>
>
> The full log is available at
>
> http://patchew.org/logs/20200421014551.10426-1-pauldzim@gmail.com/testing.asan/?type=message
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--000000000000afa5ab05a3c51de9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Just FYI I think I have the fix for this (missing a<br></div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace">DEFIN=
E_PROP_END_OF_LIST()).</div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">Thanks,</div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace">Paul<br></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20, =
2020 at 8:15 PM &lt;<a href=3D"mailto:no-reply@patchew.org">no-reply@patche=
w.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Patchew URL: <a href=3D"https://patchew.org/QEMU/20200421014551.10426-=
1-pauldzim@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew=
.org/QEMU/20200421014551.10426-1-pauldzim@gmail.com/</a><br>
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
PASS 2 check-qlit /qlit/qobject_from_qlit<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-qobject-output-visitor -m=3Dquick -k --tap &lt; /dev/null | ./scri=
pts/<a href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">t=
ap-driver.pl</a> --test-name=3D&quot;test-qobject-output-visitor&quot; <br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=3D=3D6149=3D=3DERROR: AddressSanitizer: global-buffer-overflow on address =
0x56224c1caf88 at pc 0x5622493e6bb5 bp 0x7ffe5c060dc0 sp 0x7ffe5c060db8<br>
READ of size 8 at 0x56224c1caf88 thread T0<br>
PASS 1 test-qobject-output-visitor /visitor/output/int<br>
PASS 2 test-qobject-output-visitor /visitor/output/bool<br>
---<br>
PASS 32 test-opts-visitor /visitor/opts/range/beyond<br>
PASS 33 test-opts-visitor /visitor/opts/dict/unvisited<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-coroutine -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-coroutine&quot; <br>
=3D=3D6260=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-coroutine /basic/no-dangling-access<br>
PASS 2 test-coroutine /basic/lifecycle<br>
=3D=3D6260=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7ffd4f2ef000; bottom 0x7f4998ecb000; size: 0x00b3b6424000 (7=
71856941056)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 3 test-coroutine /basic/yield<br>
---<br>
PASS 12 test-aio /aio/event/flush<br>
PASS 13 test-aio /aio/event/wait/no-flush-cb<br>
PASS 14 test-aio /aio/timer/schedule<br>
=3D=3D6275=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 15 test-aio /aio/coroutine/queue-chaining<br>
PASS 16 test-aio /aio-gsource/flush<br>
PASS 17 test-aio /aio-gsource/bh/schedule<br>
---<br>
PASS 28 test-aio /aio-gsource/timer/schedule<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-aio-multithread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a =
href=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driv=
er.pl</a> --test-name=3D&quot;test-aio-multithread&quot; <br>
PASS 1 test-aio-multithread /aio/multi/lifecycle<br>
=3D=3D6280=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 2 test-aio-multithread /aio/multi/schedule<br>
PASS 3 test-aio-multithread /aio/multi/mutex/contended<br>
PASS 4 test-aio-multithread /aio/multi/mutex/handoff<br>
PASS 5 test-aio-multithread /aio/multi/mutex/mcs<br>
PASS 6 test-aio-multithread /aio/multi/mutex/pthread<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-throttle -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-throttle&quot; <br>
=3D=3D6314=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-throttle /throttle/leak_bucket<br>
PASS 2 test-throttle /throttle/compute_wait<br>
PASS 3 test-throttle /throttle/init<br>
---<br>
PASS 14 test-throttle /throttle/config/max<br>
PASS 15 test-throttle /throttle/config/iops_size<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-thread-pool -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-thread-pool&quot; <br>
=3D=3D6318=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-thread-pool /thread-pool/submit<br>
PASS 2 test-thread-pool /thread-pool/submit-aio<br>
PASS 3 test-thread-pool /thread-pool/submit-co<br>
---<br>
PASS 39 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4<br>
PASS 40 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_after_truncat=
e<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-bdrv-drain -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-bdrv-drain&quot; <br>
=3D=3D6390=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
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
=3D=3D6429=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree<br>
PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-blockjob -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=3D=
"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.pl</=
a> --test-name=3D&quot;test-blockjob&quot; <br>
=3D=3D6433=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
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
=3D=3D6437=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
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
=3D=3D6441=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-block-backend /block-backend/drain_aio_error<br>
PASS 2 test-block-backend /block-backend/drain_all_aio_error<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-block-iothread -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a h=
ref=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-drive=
r.pl</a> --test-name=3D&quot;test-block-iothread&quot; <br>
=3D=3D6445=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
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
=3D=3D6465=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-image-locking /image-locking/basic<br>
PASS 2 test-image-locking /image-locking/set-perm-abort<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-x86-cpuid -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-x86-cpuid&quot; <br>
---<br>
PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded<br>
socket_accept failed: Resource temporarily unavailable<br>
**<br>
ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest_init_without_qmp_=
handshake: assertion failed: (s-&gt;fd &gt;=3D 0 &amp;&amp; s-&gt;qmp_fd &g=
t;=3D 0)<br>
/tmp/qemu-test/src/tests/qtest/libqtest.c:166: kill_qemu() tried to termina=
te QEMU process but encountered exit status 1 (expected 0)<br>
ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/libqtest.c:301:qtest=
_init_without_qmp_handshake: assertion failed: (s-&gt;fd &gt;=3D 0 &amp;&am=
p; s-&gt;qmp_fd &gt;=3D 0)<br>
make: *** [/tmp/qemu-test/src/tests/Makefile.include:636: check-qtest-x86_6=
4] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
PASS 2 test-rcu-tailq /rcu/qtailq/short-few<br>
PASS 3 test-rcu-tailq /rcu/qtailq/long-many<br>
---<br>
PASS 3 test-logging /logging/logfile_write_path<br>
PASS 4 test-logging /logging/logfile_lock_path<br>
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}=C2=A0 te=
sts/test-replication -m=3Dquick -k --tap &lt; /dev/null | ./scripts/<a href=
=3D"http://tap-driver.pl" rel=3D"noreferrer" target=3D"_blank">tap-driver.p=
l</a> --test-name=3D&quot;test-replication&quot; <br>
=3D=3D6882=3D=3DWARNING: ASan doesn&#39;t fully support makecontext/swapcon=
text functions and may produce false positives in some cases!<br>
PASS 1 test-replication /replication/primary/read<br>
PASS 2 test-replication /replication/primary/write<br>
PASS 3 test-replication /replication/primary/start<br>
---<br>
PASS 6 test-replication /replication/primary/get_error_all<br>
PASS 7 test-replication /replication/secondary/read<br>
PASS 8 test-replication /replication/secondary/write<br>
=3D=3D6882=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_return=
: stack top: 0x7fffab8b6000; bottom 0x7f38b34b0000; size: 0x00c6f8406000 (8=
54568493056)<br>
False positive error reports may follow<br>
For details see <a href=3D"https://github.com/google/sanitizers/issues/189"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sanitizers/=
issues/189</a><br>
PASS 9 test-replication /replication/secondary/start<br>
---<br>
=C2=A0 =C2=A0 raise CalledProcessError(retcode, cmd)<br>
subprocess.CalledProcessError: Command &#39;[&#39;sudo&#39;, &#39;-n&#39;, =
&#39;docker&#39;, &#39;run&#39;, &#39;--label&#39;, &#39;com.qemu.instance.=
uuid=3D45f88c4b9a644d6bb7f191a23649e083&#39;, &#39;-u&#39;, &#39;1003&#39;,=
 &#39;--security-opt&#39;, &#39;seccomp=3Dunconfined&#39;, &#39;--rm&#39;, =
&#39;-e&#39;, &#39;TARGET_LIST=3Dx86_64-softmmu&#39;, &#39;-e&#39;, &#39;EX=
TRA_CONFIGURE_OPTS=3D&#39;, &#39;-e&#39;, &#39;V=3D&#39;, &#39;-e&#39;, &#3=
9;J=3D14&#39;, &#39;-e&#39;, &#39;DEBUG=3D&#39;, &#39;-e&#39;, &#39;SHOW_EN=
V=3D&#39;, &#39;-e&#39;, &#39;CCACHE_DIR=3D/var/tmp/ccache&#39;, &#39;-v&#3=
9;, &#39;/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z&#39;, &=
#39;-v&#39;, &#39;/var/tmp/patchew-tester-tmp-v1o9n7mt/src/docker-src.2020-=
04-20-22.43.23.2115:/var/tmp/qemu:z,ro&#39;, &#39;qemu:fedora&#39;, &#39;/v=
ar/tmp/qemu/run&#39;, &#39;test-debug&#39;]&#39; returned non-zero exit sta=
tus 2.<br>
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D45f88c4b9a644d6bb7f191=
a23649e083<br>
make[1]: *** [docker-run] Error 1<br>
make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-v1o9n7mt/src&#39;<b=
r>
make: *** [docker-run-test-debug@fedora] Error 2<br>
<br>
real=C2=A0 =C2=A0 32m12.420s<br>
user=C2=A0 =C2=A0 0m8.663s<br>
<br>
<br>
The full log is available at<br>
<a href=3D"http://patchew.org/logs/20200421014551.10426-1-pauldzim@gmail.co=
m/testing.asan/?type=3Dmessage" rel=3D"noreferrer" target=3D"_blank">http:/=
/patchew.org/logs/20200421014551.10426-1-pauldzim@gmail.com/testing.asan/?t=
ype=3Dmessage</a>.<br>
---<br>
Email generated automatically by Patchew [<a href=3D"https://patchew.org/" =
rel=3D"noreferrer" target=3D"_blank">https://patchew.org/</a>].<br>
Please send your feedback to <a href=3D"mailto:patchew-devel@redhat.com" ta=
rget=3D"_blank">patchew-devel@redhat.com</a></blockquote></div>

--000000000000afa5ab05a3c51de9--

