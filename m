Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA08C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5C720838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9PW5eAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5C720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzMV-0001xH-K8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRzLa-0001UR-Li
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:02:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRzLU-00039y-6k
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:02:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id b127so5030480wmb.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hMvicMth6nuEewym2Bmi+3VKdDekbWVdIFUZXBZmDN4=;
 b=L9PW5eAp/w2HOXtFXqMc0d3LTJdnSQWeNBRryfI4dzU30gw9m1+k+mEiYwPpx6WgIA
 1q2RjXBnVlGbPHOep67mruU94H0fPYs4N8YhHEfZUQTbKpupJaUjJ0YBE4vq1a1WWKoY
 2jqKrK68Ua1sZuBq7v3TAZfpkZWJDmC2EMxDM4VmXyO2VBv2LZTLNl+ySb9kMlc8bxcn
 /o9wrUeMNYG0annTtw/Bq3Ot94JywkfkikkGWeoJr3cKtnf39K6awEt8YW93BOwvYo7G
 U1SQyZYq8r7yR8SJxkD6RfmC6Zo/Q8RVjnVsjPgp2aQp/eQJxQH4oUwsqXCMCGWzJAri
 oKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hMvicMth6nuEewym2Bmi+3VKdDekbWVdIFUZXBZmDN4=;
 b=F/A3Ivh9s7wtm0ys2pCf/KRycaOjy9KHQOwJaJ1KC4yXnsoeKARdtX5vhvcl0/42tm
 XPYFIdk3of9MBzj4+ax0XTpe44UBKilAEBjNENg3YwHxjL3Pd7skfDpChye/rMJ1qvh9
 6DC22wYuKvonNxJDpDquSyKpx9IlibymwaP8t9E9tUb4PL2RfeGY6ERkA80r+KmlnfoO
 U0eeMEClXb5OBvDbMh9E0spVWNulLKa6MMif+CXMkRuj8Exnn0vGJJkdt+RDxYNH895J
 Y/e0QfPeyH5jH0MlohdIeDPyVE6RATiQXiWX+sjIjmQwR1EBj8JI4fkk5Y4q+LqGHi6A
 60Tg==
X-Gm-Message-State: AOAM530tNPErhxnQHBNrUUe44+r1lF19QxFwwT6JARL16vXdw5l0yK1f
 IuP5tUxaq+dkexWEyXhASwcGsA==
X-Google-Smtp-Source: ABdhPJyqL0e3t9Zr4Y+x3sb/m+k+M9HJLjEmZjnWalhoVqHyv/HfHOxNRXWvHnKC73ZoyzSKOag3bg==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr10885482wmc.76.1602514956801; 
 Mon, 12 Oct 2020 08:02:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z191sm23515402wme.40.2020.10.12.08.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:02:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E77E1FF7E;
 Mon, 12 Oct 2020 16:02:34 +0100 (BST)
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com> <87zh4rzpot.fsf@linaro.org>
 <20201012112506.GC7777@merkur.fritz.box>
 <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
 <20201012124743.GD7777@merkur.fritz.box>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
In-reply-to: <20201012124743.GD7777@merkur.fritz.box>
Date: Mon, 12 Oct 2020 16:02:34 +0100
Message-ID: <87r1q3zdv9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.10.2020 um 13:53 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> On 10/12/20 1:25 PM, Kevin Wolf wrote:
>> > Am 12.10.2020 um 12:47 hat Alex Benn=C3=A9e geschrieben:
>> > >=20
>> > > Markus Armbruster <armbru@redhat.com> writes:
>> > >=20
>> > > > From: Kevin Wolf <kwolf@redhat.com>
>> > > >=20
>> > > > This moves the QMP dispatcher to a coroutine and runs all QMP comm=
and
>> > > > handlers that declare 'coroutine': true in coroutine context so th=
ey
>> > > > can avoid blocking the main loop while doing I/O or waiting for ot=
her
>> > > > events.
>> > >=20
>> > > This subtly changes the replay behaviour leading to a hang in:
>> > >=20
>> > >    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2=E2=80=A6=
)|=E2=9C=9A1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_=
kernel.py:ReplayKernel.test_arm_virt
>> > >    Fetching asset from tests/acceptance/replay_kernel.py:ReplayKerne=
l.test_arm_virt
>> > >    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
>> > >    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12=
T11.40-ec11fd2/job.log
>> > >     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_vi=
rt: ERROR: Could not perform graceful shutdown (26.27 s)
>> > >    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERR=
UPT 0 | CANCEL 0
>> > >    JOB TIME   : 27.77 s
>> > >=20
>> > > Looking at the log:
>> > >=20
>> > >    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.8874=
11] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UT=
C (1602499231)
>> > >    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.8874=
31] sr_init: No PMIC hook to init smartreflex
>> > >    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.8971=
93] uart-pl011 9000000.pl011: no DMA platform data
>> > >    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.8972=
42] md: Waiting for all devices to be available before autodetect
>> > >    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.8972=
59] md: If you don't use raid, use raid=3Dnoautodetect
>> > >    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.8978=
19] md: Autodetecting RAID arrays.
>> > >    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.8978=
32] md: autorun ...
>> > >    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.8978=
42] md: ... autorun DONE.
>> > >    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.8979=
62] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>> > >    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execu=
te': 'quit'}
>> > >    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'times=
tamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN'=
, 'data': {'guest': True, 'reason': 'guest-reset'}}
>> > >    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu receiv=
ed signal 6; command: "./qemu-system-arm -display none -vga none -chardev s=
ocket,id=3Dmon,path=3D/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon char=
dev=3Dmon,mode=3Dcontrol -machine virt -chardev socket,id=3Dconsole,path=3D=
/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:c=
onsole -icount shift=3D1,rr=3Drecord,rrfile=3D/var/tmp/avocado_n00stdrf/avo=
cado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm=
_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/6=
2750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=3D1 pan=
ic=3D-1 console=3DttyAMA0 -net none -no-reboot"
>> >=20
>> > This looks like a crash (SIGABRT) rather than a hang. Do you have a
>> > stack trace for the crashed process?
>>=20
>> No crash, exit(0):
>
> Why does the log say "qemu received signal 6" then?
>
>> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>
> Alex has this error in the logs before this commit, so I assume this is
> expected. All of the following is then probably expected, too, because
> it follows directly from this error:
>
>> Please append a correct "root=3D" boot option; here are the available
>> partitions:
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #1
>> Hardware name: Generic DT based system
>> [<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0x24)
>> [<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
>> [<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
>> [<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec)
>> [<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0x90)
>> [<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c/0x1=
9c)
>> [<c1101ac4>] (prepare_namespace) from [<c11012e8>]
>> (kernel_init_freeable+0x2c0/0x370)
>> [<c11012e8>] (kernel_init_freeable) from [<c0b63914>]
>> (kernel_init+0x18/0x128)
>> [<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
>> Exception stack(0xc790bfb0 to 0xc790bff8)
>> bfa0:                                     00000000 00000000 00000000
>> 00000000
>> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000
>> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>=20
>> -> PSCI call
>>    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
>>       -> SHUTDOWN_CAUSE_GUEST_RESET
>>          -> exit(0)

Yes - the test is recording the kernel up until the point it gives up.

> Hm... So you're saying that the test sends a 'quit' QMP command, but
> before it could be processed, the guest causes QEMU to exit, so the test
> will never receive a reply to its request?
>
> If commit 9ce44e2ce2 changes anything about this, it seems to me that it
> would be that more QMP commands are processed during monitor_cleanup()
> because it doesn't just delete the dispatcher BH, but waits until it's
> not busy any more.
>
> Looking at this code again, however, the order in monitor_cleanup() is
> probably wrong. We should first shut down the dispatcher (which may
> still be using Monitor objects) and then destroy the monitors. This
> could possibly explain a crash, but probably not wrong results with a
> successful shutdown.

I suspect this is a race between QEMU shutting down because the guest
shut it down and the acceptance test trying to shut things down via QMP.
I think the proper fix is either to:

  - s/panic=3D-1/panic=3D0/ in the command line (and probably drop --no-reb=
oot)

which would let the acceptance test cleanly shutdown via QMP. Or:

  - modify the test to declare that qemu will shutdown itself and
    therefor no "quit" needs to be sent

WDYT?

--=20
Alex Benn=C3=A9e

