Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C08C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D824722251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D824722251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQprg-0004fA-Sx
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQpmq-0000ZT-VQ; Fri, 09 Oct 2020 06:38:10 -0400
Received: from mail.ispras.ru ([83.149.199.84]:36902)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQpmm-000478-OZ; Fri, 09 Oct 2020 06:38:08 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 93D1440A1DCC;
 Fri,  9 Oct 2020 10:37:59 +0000 (UTC)
Subject: Re: acceptance-system-fedora failures
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com> <878sci1dt0.fsf@linaro.org>
 <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
 <c5e6f7ea-93c4-a46a-dfee-7699c08c1060@redhat.com>
 <4f4eee5e-e8cd-0595-cccc-8b648773c9ba@ispras.ru>
 <43eac2fb-7325-9e9f-ce13-d0774638753f@redhat.com>
 <20201008115018.GD4672@linux.fritz.box>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <a1230ec4-13ae-3a0b-5b8a-71c9c87250ac@ispras.ru>
Date: Fri, 9 Oct 2020 13:37:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008115018.GD4672@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:35:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.10.2020 14:50, Kevin Wolf wrote:
> Am 08.10.2020 um 12:26 hat Philippe Mathieu-DaudÃ© geschrieben:
>> On 10/7/20 3:11 PM, Pavel Dovgalyuk wrote:
>>> On 07.10.2020 15:49, Philippe Mathieu-DaudÃ© wrote:
>>>> On 10/7/20 2:20 PM, Pavel Dovgalyuk wrote:
>>>>> On 07.10.2020 14:22, Alex BennÃ©e wrote:
>>>>>>
>>>>>> Philippe Mathieu-DaudÃ© <philmd@redhat.com> writes:
>>>>>>
>>>>>>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>>>>>>>> On 07.10.2020 11:23, Thomas Huth wrote:
>>>>>>>>> On 07/10/2020 09.13, Philippe Mathieu-DaudÃ© wrote:
>>>>>>>>> Thanks, that was helpful. ... and the winner is:
>>>>>>>>>
>>>>>>>>> Â Â Â Â Â Â  commitÂ Â  55adb3c45620c31f29978f209e2a44a08d34e2da
>>>>>>>>> Â Â Â Â Â Â  Author:Â  John Snow <jsnow@redhat.com>
>>>>>>>>> Â Â Â Â Â Â  Date:Â Â Â  Fri Jul 24 01:23:00 2020 -0400
>>>>>>>>> Â Â Â Â Â Â  Subject: ide: cancel pending callbacks on SRST
>>>>>>>>>
>>>>>>>>> ... starting with this commit, the tests starts failing. John, any
>>>>>>>>> idea what
>>>>>>>>> might be causing this?
>>>>>>>>
>>>>>>>> This patch includes the following lines:
>>>>>>>>
>>>>>>>> +Â Â Â Â Â Â Â  aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  ide_bus_perform_srst, bus);
>>>>>>>>
>>>>>>>> replay_bh_schedule_oneshot_event should be used instead of this
>>>>>>>> function, because it synchronizes non-deterministic BHs.
>>>>>>>
>>>>>>> Why do we have 2 different functions? BH are already complex
>>>>>>> enough, and we need to also think about the replay API...
>>>>>>>
>>>>>>> What about the other cases such vhost-user (blk/net), virtio-blk?
>>>>>>
>>>>>> This does seem like something that should be wrapped up inside
>>>>>> aio_bh_schedule_oneshot itself or maybe we need a
>>>>>> aio_bh_schedule_transaction_oneshot to distinguish it from the other
>>>>>> uses the function has.
>>>>>>
>>>>>
>>>>> Maybe there should be two functions:
>>>>> - one for the guest modification
>>>>
>>>> aio_bh_schedule_oneshot_deterministic()?
>>>>
>>>>> - one for internal qemu things
>>>>
>>>> Not sure why there is a difference, BH are used to
>>>> avoid delaying the guest, so there always something
>>>> related to "guest modification".
>>>
>>> Not exactly. At least there is one non-related-to-guest case
>>> in monitor_init_qmp:
>>> Â Â Â Â Â Â Â  /*
>>> Â Â Â Â Â Â Â Â  * We can't call qemu_chr_fe_set_handlers() directly here
>>> Â Â Â Â Â Â Â Â  * since chardev might be running in the monitor I/O
>>> Â Â Â Â Â Â Â Â  * thread.Â  Schedule a bottom half.
>>> Â Â Â Â Â Â Â Â  */
>>> Â Â Â Â Â Â Â  aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
>>> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  monitor_qmp_setup_handlers_bh, mon);
>>
>> I don't understand the documentation in docs/devel/replay.txt:
>>
>> ---
>> Bottom halves
>> =============
>>
>> Bottom half callbacks, that affect the guest state, should be invoked
>> through
>> replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
>> Their invocations are saved in record mode and synchronized with the
>> existing
>> log in replay mode.
>> ---
>>
>> But then it is only used in block drivers, which are not
>> related to guest state:
> 
> Pavel can tell you the details, but I think the idea was that you need
> to use this function not when the code calling it modifies guest state,
> but when the BH implementation can do so.
> 
> In the case of generic callbacks like provided by the blk_aio_*()
> functions, we don't know whether this is the case, but it's generally
> device emulation code, so chances are relatively high that they do.
> 
> I seem to remember that when reviewing the code that introduced
> replay_bh_schedule_event(), I was relatively sure that we didn't catch
> all necessary instances, but since it worked for Pavel and I didn't feel
> like getting too involved with replay code, we just merged it anyway.

That's right.
Block layer does not touch guest by itself.
But it includes callbacks that may invoke interrupts on finishing disk 
operations. That is why we synchronize these callbacks with vCPU through 
the replay layer.

Pavel Dovgalyuk

