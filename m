Received: from eggs.gnu.org ([2001:4830:134:3::10]:53169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fC0nc-00080Z-Q7
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fC0nY-0003xx-EF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:40:20 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fC0nY-0003wa-8j
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:40:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id z9so1200715pfe.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:40:15 -0700 (PDT)
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
	<a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
	<20180427093135.GC13269@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <2f84ab90-2b9c-9888-e6e2-9114ae046078@gmail.com>
Date: Fri, 27 Apr 2018 18:40:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180427093135.GC13269@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn



On 04/27/2018 05:31 PM, Peter Xu wrote:
> On Fri, Apr 27, 2018 at 11:15:37AM +0800, Xiao Guangrong wrote:
>>
>>
>> On 04/26/2018 10:01 PM, Eric Blake wrote:
>>> On 04/26/2018 04:15 AM, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> QEMU 2.13 enables strict check for compression & decompression to
>>>> make the migration more robuster, that depends on the source to fix
>>>
>>> s/robuster/robust/
>>>
>>
>> Will fix, thank you for pointing it out.
>>
>>>> the internal design which triggers the unexpected error conditions
>>>
>>> 2.13 hasn't been released yet.  Why do we need a knob to explicitly turn
>>> off strict checking?  Can we not instead make 2.13 automatically smart
>>> enough to tell if the incoming stream is coming from an older qemu
>>> (which might fail if the strict checks are enabled) vs. a newer qemu
>>> (the sender gave us what we need to ensure the strict checks are
>>> worthwhile)?
>>>
>>
>> Really smart.
>>
>> How about introduce a new command, MIG_CMD_DECOMPRESS_ERR_CHECK,
>> the destination will do strict check if got this command (i.e, new
>> QEMU is running on the source), otherwise, turn the check off.
> 
> Why not we just introduce a compat bit for that?  I mean something
> like: 15c3850325 ("migration: move skip_section_footers",
> 2017-06-28).  Then we turn that check bit off for <=2.12.
> 
> Would that work?

I am afraid it can not. :(

The compat bit only impacts local behavior, however, in this case, we
need the source QEMU to tell the destination if it supports strict
error check.
