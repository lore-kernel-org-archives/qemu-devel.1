Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE89C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4085925412
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085925412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHBM-000342-IB
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnH7h-0005dK-8e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:44:09 -0400
Received: from mail.ispras.ru ([83.149.199.84]:49902)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovgaluk@ispras.ru>)
 id 1jnH7e-00028k-FF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:44:08 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4721340A632F;
 Mon, 22 Jun 2020 07:44:03 +0000 (UTC)
Subject: Re: [PATCH v3 00/11] Record/replay acceptance tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
 <540831cc-c5b0-cf10-6889-bab499729a53@redhat.com>
 <343df8f4-9d26-bfce-a714-2d06940a2586@redhat.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <ec069b0d-e44b-f083-90e8-503f423488b2@ispras.ru>
Date: Mon, 22 Jun 2020 10:44:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <343df8f4-9d26-bfce-a714-2d06940a2586@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=dovgaluk@ispras.ru;
 helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 wrampazz@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.06.2020 02:36, Philippe Mathieu-Daudé wrote:
> Hi Pavel,
> 
> On 5/31/20 5:09 PM, Philippe Mathieu-Daudé wrote:
>> On 5/29/20 9:04 AM, Pavel Dovgalyuk wrote:
>>> The following series adds record/replay tests to the acceptance group.
>>> Test pass successfully with the latest submitted record/replay fixes:
>>>   - replay: notify the main loop when there are no instructions
>>>   - replay: synchronize on every virtual timer callback
>>>
>>> The provided tests perform kernel boot and disk image boot scenarios.
>>> For all of them recording and replaying phases are executed.
>>> Tests were borrowed from existing boot_linux*.py tests. But some
>>> of the platforms and images were excluded, because icount for them
>>> still has some issues.
>>>
>>> Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
>>>
>>> v3 changes:
>>>   - Added record/replay logging (suggested by Philippe Mathieu-Daudé)
>>>   - Changed the console pattern to get longer kernel execution (suggested by Alex Bennée)
>>>   - Coding style fixes
>>>   - Other minor changes
>>> v2 changes:
>>>   - Some test structure refactoring (suggested by Willian Rampazzo)
>>>
>>> ---
>>>
>>> Pavel Dovgaluk (11):
>>>        tests/acceptance: allow console interaction with specific VMs
>>>        tests/acceptance: refactor boot_linux_console test to allow code reuse
>>>        tests/acceptance: add base class record/replay kernel tests
>>>        tests/acceptance: add kernel record/replay test for x86_64
>>>        tests/acceptance: add record/replay test for aarch64
>>>        tests/acceptance: add record/replay test for arm
>>>        tests/acceptance: add record/replay test for ppc64
>>>        tests/acceptance: add record/replay test for m68k
> 
> You forgot to Cc the maintainers for each target/machine tested.
> 
> Anyway this series has been on the list for 3 weeks, so I'm
> queuing it for next acceptance-testing pull request.
> 
> Since the x86 tests generate some timeout errors on Travis-CI,

Errors occur with the commits that were not queued yet?

> I squashed the following changes:
> 
> -- >8 --
> diff --git a/tests/acceptance/replay_kernel.py
> b/tests/acceptance/replay_kernel.py
> index a25eb3d3ee..8fa6b517c5 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -12,6 +12,7 @@
>   import logging
>   import time
> 
> +from avocado import skipIf
>   from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import archive
>   from avocado.utils import process
> @@ -72,6 +73,7 @@ def run_rr(self, kernel_path, kernel_command_line,
> console_pattern,
>           logger = logging.getLogger('replay')
>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
> 
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>       def test_x86_64_pc(self):
>           """
>           :avocado: tags=arch:x86_64
> diff --git a/tests/acceptance/replay_linux.py
> b/tests/acceptance/replay_linux.py
> index 472ab730cd..8e43e282a7 100644
> --- a/tests/acceptance/replay_linux.py
> +++ b/tests/acceptance/replay_linux.py
> @@ -12,6 +12,7 @@
>   import logging
>   import time
> 
> +from avocado import skipIf
>   from avocado.utils import cloudinit
>   from avocado.utils import datadrainer
>   from avocado.utils import network
> @@ -92,6 +93,7 @@ def run_rr(self, args=None, shift=7):
>           logger = logging.getLogger('replay')
>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
> 
> +@skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>   class ReplayLinuxX8664(ReplayLinux):
>       """
>       :avocado: tags=arch:x86_64
> ---
> 
> Regards,
> 
> Phil.
> 
>>>        tests/acceptance: record/replay tests with advcal images
>>>        tests/acceptance: refactor boot_linux to allow code reuse
>>>        tests/acceptance: Linux boot test for record/replay
>>
>> Thanks, patches 1/2/10 applied to my python-next tree:
>> https://gitlab.com/philmd/qemu/commits/python-next
>>
>> - tests/acceptance: allow console interaction with specific VMs
>> - tests/acceptance: refactor boot_linux_console test to allow code reuse
>> - tests/acceptance: refactor boot_linux to allow code reuse
>>
> 


