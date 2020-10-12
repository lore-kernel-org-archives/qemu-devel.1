Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1905C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FF82074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjq/YyLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FF82074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwRa-0004tg-8H
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwOI-0001eN-Dd
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:53:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwOC-0000yX-Nq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:53:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id d3so17247592wma.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QshWfzsS7dVXnNOycZcqeQqxGE5WYa4sh7XiKOPf3JQ=;
 b=Gjq/YyLYezfm4dBF6Mtft10p6zybzHRU3uWqRZ9N0OpAiDKHvfRwmxYj2RtPc7Qw3q
 /7mJBch2mGXVLsozeeRbjVQtbRUBqB7Yi89XL03Ae5m5uWmmd9KKr9157imB2bxfD8OP
 cN3tfy7PiFdfzVG48MQzjGDZg8UvDtq2yBqZptWWoDQc7xhk5IvnQ48Wiac11u8l9B07
 +fQwNZTHB7co3mQwP/2R6DgJBZn1+hhw0wMb2GSQsKROnQCp+l24QriGTGgiu1CYXRPG
 6hKs0OCCFfrN/gYL742kNZEHZEB+pZQoSLOHRfAkH6fVo/ASZYuhqXOzKbJj5GLFK+VR
 2ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QshWfzsS7dVXnNOycZcqeQqxGE5WYa4sh7XiKOPf3JQ=;
 b=KICDB6NtOHWYN7uJtUuIz/aDIDOoorzYzWU7HCnoFOV5qbtc89LTjbcHXZgReWxdg5
 W7UgZZacrmtwVyjMuque3earRnP+bV5o4AqDpZO/hFTYHIJZDYHrsCWMuNSsxCJUhS2Q
 YuIpR8FhzgZP3mHFLZ1IE05rdAkPqIdAxjgjrhOp5XrHQbnRt+punds6tA2JuuuscGzy
 NnG0ls1pcKLT2RpTY1c2sFk6mjGOSrW2Cz7zEqlQpGLe7qW/umypVZ826I6pE2Mol7BZ
 xYy81ASxyi3ZrBc0Z/11//7G2ZqNoYfZn7xxJPQFtstAskaNhzulElj5v4UTSlWVT8KZ
 1MHw==
X-Gm-Message-State: AOAM530oALhYWgJ/jLhUv3MemDOZtePguWxsAD0/Yud3Y3NbTk0QkUfa
 1YDfhqzbIskVuMChtSUqi4EH4q+QI2Y=
X-Google-Smtp-Source: ABdhPJwCxisnj/GRRBjVeZK/PMRi6GMzMA7tpcpusJX1FiQuNqTMypqpyM519hx0tHikn7yxpVI5iw==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr2719261wme.152.1602503594398; 
 Mon, 12 Oct 2020 04:53:14 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l1sm4066586wrb.1.2020.10.12.04.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 04:53:13 -0700 (PDT)
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com> <87zh4rzpot.fsf@linaro.org>
 <20201012112506.GC7777@merkur.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
Date: Mon, 12 Oct 2020 13:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012112506.GC7777@merkur.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 1:25 PM, Kevin Wolf wrote:
> Am 12.10.2020 um 12:47 hat Alex Bennée geschrieben:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> From: Kevin Wolf <kwolf@redhat.com>
>>>
>>> This moves the QMP dispatcher to a coroutine and runs all QMP command
>>> handlers that declare 'coroutine': true in coroutine context so they
>>> can avoid blocking the main loop while doing I/O or waiting for other
>>> events.
>>
>> This subtly changes the replay behaviour leading to a hang in:
>>
>>    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2…)|✚1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
>>    Fetching asset from tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt
>>    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
>>    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12T11.40-ec11fd2/job.log
>>     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt: ERROR: Could not perform graceful shutdown (26.27 s)
>>    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>    JOB TIME   : 27.77 s
>>
>> Looking at the log:
>>
>>    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.887411] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UTC (1602499231)
>>    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.887431] sr_init: No PMIC hook to init smartreflex
>>    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.897193] uart-pl011 9000000.pl011: no DMA platform data
>>    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.897242] md: Waiting for all devices to be available before autodetect
>>    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.897259] md: If you don't use raid, use raid=noautodetect
>>    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.897819] md: Autodetecting RAID arrays.
>>    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.897832] md: autorun ...
>>    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.897842] md: ... autorun DONE.
>>    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.897962] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>>    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
>>    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'timestamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN', 'data': {'guest': True, 'reason': 'guest-reset'}}
>>    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu received signal 6; command: "./qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:console -icount shift=1,rr=record,rrfile=/var/tmp/avocado_n00stdrf/avocado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot"
> 
> This looks like a crash (SIGABRT) rather than a hang. Do you have a
> stack trace for the crashed process?

No crash, exit(0):

VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available 
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #1
Hardware name: Generic DT based system
[<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0x24)
[<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
[<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
[<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec)
[<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0x90)
[<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c/0x19c)
[<c1101ac4>] (prepare_namespace) from [<c11012e8>] 
(kernel_init_freeable+0x2c0/0x370)
[<c11012e8>] (kernel_init_freeable) from [<c0b63914>] 
(kernel_init+0x18/0x128)
[<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xc790bfb0 to 0xc790bff8)
bfa0:                                     00000000 00000000 00000000 
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

-> PSCI call
    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
       -> SHUTDOWN_CAUSE_GUEST_RESET
          -> exit(0)

> 
> Kevin
> 
>>    2020-10-12 11:40:31,734 stacktrace       L0039 ERROR|
>>    2020-10-12 11:40:31,734 stacktrace       L0042 ERROR| Reproduced traceback from: /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/core/test.py:767
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR| Traceback (most recent call last):
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 435, in _do_shutdown
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._soft_shutdown(timeout, has_quit)
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 415, in _soft_shutdown
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._qmp.cmd('quit')
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/qmp.py", line 266, in cmd
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     return self.cmd_obj(qmp_cmd)
>>    2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/qmp.py", line 249, in cmd_obj
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     raise QMPConnectError("Unexpected empty reply from server")
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| qemu.qmp.QMPConnectError: Unexpected empty reply from server
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| The above exception was the direct cause of the following exception:
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| Traceback (most recent call last):
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 128, in test_arm_virt
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 71, in run_rr
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     True, shift, args, replay_path)
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line 57, in run_vm
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     vm.shutdown()
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 465, in shutdown
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self._do_shutdown(timeout, has_quit)
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.bennee/lsrc/qemu.git/python/qemu/machine.py", line 439, in _do_shutdown
>>    2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     from exc
>>    2020-10-12 11:40:31,737 stacktrace       L0045 ERROR| qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
>>
>> The commit before:
>>
>>    2020-10-12 11:44:02,803 __init__         L0085 DEBUG| [    3.897837] md: ... autorun DONE.
>>    2020-10-12 11:44:02,806 __init__         L0085 DEBUG| [    3.897958] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>>    2020-10-12 11:44:02,806 qmp              L0245 DEBUG| >>> {'execute': 'quit'}
>>    2020-10-12 11:44:02,814 qmp              L0250 DEBUG| <<< {'return': {}}
>>    2020-10-12 11:44:02,879 replay_kernel    L0059 INFO | finished the recording with log size 237596 bytes
>>    2020-10-12 11:44:02,879 replay_kernel    L0064 INFO | elapsed time 24.35 sec
>>    2020-10-12 11:44:02,888 replay_kernel    L0044 INFO | replaying the execution...
>>    2020-10-12 11:44:02,889 machine          L0362 DEBUG| VM launch command: './qemu-system-arm -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpihqswp6_/qemu-7747-monitor.sock -mon chardev=mon,mode=control -machine virt -chardev socket,id=console,path=/var/tmp/tmpihqswp6_/qemu-7747-console.sock,server,nowait -serial chardev:console
>>    -icount shift=1,rr=replay,rrfile=/var/tmp/avocado_o3pfy2he/avocado_job_nf30vjqg/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=1 panic=-1 console=ttyAMA0 -net none -no-reboot'
>>    2020-10-12 11:44:03,001 qmp              L0245 DEBUG| >>> {'execute': 'qmp_capabilities'}
>>    2020-10-12 11:44:03,172 qmp              L0250 DEBUG| <<< {'return': {}}
>>    2020-10-12 11:44:04,899 __init__         L0085 DEBUG| [    0.000000] Booting Linux on physical CPU 0x0
>>    2020-10-12 11:44:04,904 __init__         L0085 DEBUG| [    0.000000] Linux version 4.18.16-300.fc29.armv7hl (mockbuild@buildvm-armv7-06.arm.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun Oct 21 00:56:28 UTC 2018
[...]

