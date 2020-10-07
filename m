Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91315C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FDF206D9
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FDF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8XG-0005Nt-0X
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQ8RE-0000HE-WA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:20:58 -0400
Received: from mail.ispras.ru ([83.149.199.84]:56514)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQ8RC-0004PH-Sy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:20:56 -0400
Received: from [10.12.39.188] (unknown [85.142.117.224])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0A3BA40D3BFF;
 Wed,  7 Oct 2020 12:20:48 +0000 (UTC)
Subject: Re: acceptance-system-fedora failures
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com> <878sci1dt0.fsf@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
Date: Wed, 7 Oct 2020 15:20:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sci1dt0.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.10.2020 14:22, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>>> On 07.10.2020 11:23, Thomas Huth wrote:
>>>> On 07/10/2020 09.13, Philippe Mathieu-Daudé wrote:
>>>> Thanks, that was helpful. ... and the winner is:
>>>>
>>>>       commit   55adb3c45620c31f29978f209e2a44a08d34e2da
>>>>       Author:  John Snow <jsnow@redhat.com>
>>>>       Date:    Fri Jul 24 01:23:00 2020 -0400
>>>>       Subject: ide: cancel pending callbacks on SRST
>>>>
>>>> ... starting with this commit, the tests starts failing. John, any
>>>> idea what
>>>> might be causing this?
>>>
>>> This patch includes the following lines:
>>>
>>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>> +                                ide_bus_perform_srst, bus);
>>>
>>> replay_bh_schedule_oneshot_event should be used instead of this
>>> function, because it synchronizes non-deterministic BHs.
>>
>> Why do we have 2 different functions? BH are already complex
>> enough, and we need to also think about the replay API...
>>
>> What about the other cases such vhost-user (blk/net), virtio-blk?
> 
> This does seem like something that should be wrapped up inside
> aio_bh_schedule_oneshot itself or maybe we need a
> aio_bh_schedule_transaction_oneshot to distinguish it from the other
> uses the function has.
> 

Maybe there should be two functions:
- one for the guest modification
- one for internal qemu things

The first one may be implemented though the rr+second one.
Maybe replay_ prefix is confusing and the whole BH interface should look 
like that?


Pavel Dovgalyuk

