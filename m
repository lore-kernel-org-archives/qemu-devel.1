Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE96C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2A020789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2A020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8Qk-0007xk-2G
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQ8OX-0006hl-NH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:18:11 -0400
Received: from mail.ispras.ru ([83.149.199.84]:56098)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQ8OU-00042y-Sg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:18:09 -0400
Received: from [10.12.39.188] (unknown [85.142.117.224])
 by mail.ispras.ru (Postfix) with ESMTPSA id 783DB40D3BFF;
 Wed,  7 Oct 2020 12:17:58 +0000 (UTC)
Subject: Re: acceptance-system-fedora failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <a1689dcd-18e0-157f-6607-562a6a3e87c6@ispras.ru>
Date: Wed, 7 Oct 2020 15:17:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 08:18:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.10.2020 12:57, Philippe Mathieu-Daudé wrote:
> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>> On 07.10.2020 11:23, Thomas Huth wrote:
>>> On 07/10/2020 09.13, Philippe Mathieu-Daudé wrote:
>>>> On 10/7/20 7:20 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 10/7/20 1:07 AM, John Snow wrote:
>>>>>> I'm seeing this gitlab test fail quite often in my Python work; I
>>>>>> don't
>>>>>> *think* this has anything to do with my patches, but maybe I need
>>>>>> to try
>>>>>> and bisect this more aggressively.
>>> [...]
>>>>> w.r.t. the error in your build, I told Thomas about the
>>>>> test_ppc_mac99/day15/invaders.elf timeouting but he said this is
>>>>> not his area. Richard has been looking yesterday to see if it is
>>>>> a TCG regression, and said the test either finished/crashed raising
>>>>> SIGCHLD, but Avocado parent is still waiting for a timeout, so the
>>>>> children become zombie and the test hang.
>>>>
>>>> Expected output:
>>>>
>>>> Quiescing Open Firmware ...
>>>> Booting Linux via __start() @ 0x01000000 ...
>>>>
>>>> But QEMU exits in replay_char_write_event_load():
>>>>
>>>> Quiescing Open Firmware ...
>>>> qemu-system-ppc: Missing character write event in the replay log
>>>> $ echo $?
>>>> 1
>>>>
>>>> Latest events are CHECKPOINT CHECKPOINT INTERRUPT INTERRUPT INTERRUPT.
>>>>
>>>> Replay file is ~22MiB. End of record using "system_powerdown + quit"
>>>> in HMP.
>>>>
>>>> I guess we have 2 bugs:
>>>> - replay log
>>>> - avocado doesn't catch children exit(1)
>>>>
>>>> Quick reproducer:
>>>>
>>>> $ make qemu-system-ppc check-venv
>>>> $ tests/venv/bin/python -m \
>>>>     avocado --show=app,console,replay \
>>>>     run --job-timeout 300 -t machine:mac99 \
>>>>     tests/acceptance/replay_kernel.py
>>>
>>> Thanks, that was helpful. ... and the winner is:
>>>
>>>       commit   55adb3c45620c31f29978f209e2a44a08d34e2da
>>>       Author:  John Snow <jsnow@redhat.com>
>>>       Date:    Fri Jul 24 01:23:00 2020 -0400
>>>       Subject: ide: cancel pending callbacks on SRST
>>>
>>> ... starting with this commit, the tests starts failing. John, any
>>> idea what
>>> might be causing this?
>>
>> This patch includes the following lines:
>>
>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> +                                ide_bus_perform_srst, bus);
>>
>> replay_bh_schedule_oneshot_event should be used instead of this
>> function, because it synchronizes non-deterministic BHs.
> 
> Why do we have 2 different functions? BH are already complex
> enough, and we need to also think about the replay API...
> 

There is note about it in docs/devel/replay.txt
It's hard to protect the guest state from incorrect operations.
There was the similar problem with icount - everyone who modify 
translate modules, needs to take it info account.
But now we have record/replay tests that assert that patches do not 
break icount/rr.

> What about the other cases such vhost-user (blk/net), virtio-blk?

I do not know much about these modules.
The main idea is the following: if the code works with the guest state, 
it should deal with icount and rr functions.

Pavel Dovgalyuk

