Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBB9V-0002Nm-4j
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBB9Q-0004rU-8E
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:26:57 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dBB9Q-0004r9-1W
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:26:52 -0400
Received: by mail-pg0-x243.google.com with SMTP id i63so4026710pgd.2
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 19:26:51 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
	<9626326d-977f-bf26-851a-59d420f27993@redhat.com>
Message-ID: <0900def5-6049-4338-1eb0-8a0404c6c839@gmail.com>
Date: Thu, 18 May 2017 10:26:54 +0800
MIME-Version: 1.0
In-Reply-To: <9626326d-977f-bf26-851a-59d420f27993@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] mc146818rtc: fix Windows VM clock
 faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/10/2017 05:53 PM, Paolo Bonzini wrote:
> 
> 
> On 10/05/2017 10:32, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Changelog in v3:
>> Thanks to Paolo's the elaborate review comments, this version
>> simplifies the logic of periodic_timer_update() significantly
>> that includes:
>> 1) introduce rtc_periodic_clock_ticks() that takes both regA and
>>     regB into account and returns the period clock
>> 2) count the clocks since last interrupt by always using current
>>     clock subtracts the clock when last interrupt happened
>> 3) improve the assert() logic
>>
>> Paolo, all you comments have been reflected in this version except
>> globally using s->period because in the current code, only x86 is
>> using s->period so that we should obey this rule to keep compatible
>> migration. I have added the comment to explain this suitable in the
>> code:
>>
>>              /*
>>               * as the old QEMUs only used s->period for the case that
>>               * LOST_TICK_POLICY_SLEW is used, in order to keep the
>>               * compatible migration, we obey the rule as old QEMUs.
>>               */
>>              s->period = period;
>> If anything i missed, please let me know. :)
> 
> Looks great.  Thanks for following up quickly on the reviews.
> 

Paolo, if it is okay to you, could you please consider to merge this
patchset? ;)
