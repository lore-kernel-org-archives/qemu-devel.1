Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A1AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804EC2078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804EC2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeBmU-0006OU-NA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jeBlv-0005zD-6t
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:12:07 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47640)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jeBlt-0007K4-F1
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:12:06 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 913C2CD461;
 Thu, 28 May 2020 09:12:00 +0300 (MSK)
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay test
 for x86_64
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <87sgfl5qsl.fsf@linaro.org>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <e9b00219-e7f2-a109-dcc1-f5a325cfae40@ispras.ru>
Date: Thu, 28 May 2020 09:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87sgfl5qsl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=83.149.199.45; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:12:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 27.05.2020 18:41, Alex Bennée wrote:
> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>
>> This patch adds a test for record/replay an execution of x86_64 machine.
>> Execution scenario includes simple kernel boot, which allows testing
>> basic hardware interaction in RR mode.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>   0 files changed
>>
>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
>> index b8b277ad2f..c7526f1aba 100644
>> --- a/tests/acceptance/replay_kernel.py
>> +++ b/tests/acceptance/replay_kernel.py
>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>                       True, shift, args)
>>           self.run_vm(kernel_path, kernel_command_line, console_pattern,
>>                       False, shift, args)
>> +
>> +    def test_x86_64_pc(self):
>> +        """
>> +        :avocado: tags=arch:x86_64
>> +        :avocado: tags=machine:pc
>> +        """
>> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>> +                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> +                      '/vmlinuz')
>> +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> +
>> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
>> +
>> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
> This test fails for me on the replay:

Have you applied latest RR patches?


>
>    2020-05-27 16:22:21,658 machine          L0326 DEBUG| VM launch command: 'x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmp4n_geosi/qemu-9516-monitor.sock -mon chardev=mon,mode=control -machine pc -chardev socket,id=console,path=/var/tmp/tmp4n_geosi/qemu-9516-console.sock,server,nowait -serial chardev:console -icount shift=7,rr=replay,rrfile=/var/tmp/avocado_b85h3ycg/avocado_job_8xrxksgj/1-._tests_acceptance_replay_kernel.py_ReplayKernel.test_x86_64_pc/replay.bin -kernel /home/alex/avocado/data/cache/by_location/df533120a0e0ffda2626bed6e8a975d3b07e3f05/vmlinuz -append printk.time=0 console=ttyS0 -net none'
>    2020-05-27 16:22:21,725 qmp              L0194 DEBUG| >>> {'execute': 'qmp_capabilities'}
>    2020-05-27 16:22:21,736 qmp              L0202 DEBUG| <<< {'return': {}}
>    2020-05-27 16:23:49,372 stacktrace       L0039 ERROR|
>    2020-05-27 16:23:49,372 stacktrace       L0042 ERROR| Reproduced traceback from: /home/alex/lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/site-packages/avocado/core/test.py:860
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR| Traceback (most recent call last):
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 73, in test_x86_64_pc
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.run_rr(kernel_path, kernel_command_line, console_pattern)
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 57, in run_rr
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     False, shift, args)
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 46, in run_vm
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.wait_for_console_pattern(console_pattern, vm)
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/boot_linux_console.py", line 37, in wait_for_console_pattern
>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     vm=vm)
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", line 131, in wait_for_console_pattern
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     _console_interaction(test, success_message, failure_message, None, vm=vm)
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", line 83, in _console_interaction
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     msg = console.readline().strip()
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/usr/lib/python3.7/socket.py", line 589, in readinto
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     return self._sock.recv_into(b)
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/site-packages/avocado/plugins/runner.py", line 89, in sigterm_handler
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     raise RuntimeError("Test interrupted by SIGTERM")
>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR| RuntimeError: Test interrupted by SIGTERM
>
>

