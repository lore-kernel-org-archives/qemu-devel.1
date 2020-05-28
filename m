Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D47C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7CA207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7CA207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCqd-0007Yd-L7
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 03:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jeCpe-0006eN-FY
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:20:02 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56558)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1jeCpc-0006QD-QF
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:20:02 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4550DCD461;
 Thu, 28 May 2020 10:19:58 +0300 (MSK)
Subject: Re: [PATCH v2 03/11] tests/acceptance: add base class record/replay
 kernel tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
 <87y2pd5rrd.fsf@linaro.org>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <34f0a0f8-d7ab-2d81-c4da-594936db6c7f@ispras.ru>
Date: Thu, 28 May 2020 10:19:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87y2pd5rrd.fsf@linaro.org>
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


On 27.05.2020 18:20, Alex Bennée wrote:
> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>
>> This patch adds a base for testing kernel boot recording and replaying.
>> Each test has the phase of recording and phase of replaying.
>> Virtual machines just boot the kernel and do not interact with
>> the network.
>> Structure and image links for the tests are borrowed from boot_linux_console.py
>> Testing controls the message pattern at the end of the kernel
>> boot for both record and replay modes. In replay mode QEMU is also
>> intended to finish the execution automatically.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47ef3139e6..e9a9ce4f66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2497,6 +2497,7 @@ F: net/filter-replay.c
>   F: include/sysemu/replay.h
>   F: docs/replay.txt
>   F: stubs/replay.c
> +F: tests/acceptance/replay_kernel.py
>   
>   IOVA Tree
>   M: Peter Xu <peterx@redhat.com>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> new file mode 100644
> index 0000000000..b8b277ad2f
> --- /dev/null
> +++ b/tests/acceptance/replay_kernel.py
> @@ -0,0 +1,57 @@
> +# Record/replay test that boots a Linux kernel
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import gzip
>
> Do we actually use gzip in this test?

Removed that, thanks.

>
> +
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import process
> +from avocado.utils import archive
> +from boot_linux_console import LinuxKernelUtils
> +
> +class ReplayKernel(LinuxKernelUtils):
> +    """
> +    Boots a Linux kernel in record mode and checks that the console
> +    is operational and the kernel command line is properly passed
> +    from QEMU to the kernel.
> +    Then replays the same scenario and verifies, that QEMU correctly
> +    terminates.
>
> Shouldn't we be doing more to verify the replay behaved the same as the
> recorded session? What happens if things go wrong? Does QEMU barf out or
> just deviate from the previous run?

We hardly can compare vCPU states during record and replay.

But in the most cases it is not needed. When control flow goes in the 
wrong direction, it affects the interrupts and exceptions.

And interrupts and exceptions are the synchronization points in the 
replay log. Therefore when the executions differ, QEMU replay just hangs.

>
> +    """
> +
> +    timeout = 90
> +
> +    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
> +               record, shift, args):
> +        vm = self.get_vm()
> +        vm.set_console()
> +        if record:
> +            mode = 'record'
> +        else:
> +            mode = 'replay'
> +        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
> +                    (shift, mode, os.path.join(self.workdir, 'replay.bin')),
> +                    '-kernel', kernel_path,
> +                    '-append', kernel_command_line,
> +                    '-net', 'none')
> +        if args:
> +            vm.add_args(*args)
> +        vm.launch()
> +        self.wait_for_console_pattern(console_pattern, vm)
> +        if record:
> +            vm.shutdown()
> +        else:
> +            vm.wait()
> +
> +    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
> +        shift=7, args=None):
> +        self.run_vm(kernel_path, kernel_command_line, console_pattern,
> +                    True, shift, args)
> +        self.run_vm(kernel_path, kernel_command_line, console_pattern,
> +                    False, shift, args)
>
>
>

