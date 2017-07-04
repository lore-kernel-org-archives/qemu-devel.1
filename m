Received: from eggs.gnu.org ([2001:4830:134:3::10]:37187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dSELP-0000E3-S6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 23:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dSELL-000423-Kr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 23:17:42 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dSELL-0003zQ-Cs
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 23:17:39 -0400
Received: by mail-pg0-x243.google.com with SMTP id u62so24865383pgb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 20:17:37 -0700 (PDT)
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
	<4dffc169-5cf2-8f37-bd99-9941bef50825@gmail.com>
	<6db0c80d-2ae2-9e89-356e-35acd241fdc5@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <3b6a2db4-af92-2a5b-9e35-2b226e721882@gmail.com>
Date: Tue, 4 Jul 2017 11:17:40 +0800
MIME-Version: 1.0
In-Reply-To: <6db0c80d-2ae2-9e89-356e-35acd241fdc5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/03/2017 11:47 PM, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 16:39, Xiao Guangrong wrote:
>>
>>
>> On 06/20/2017 05:15 PM, guangrong.xiao@gmail.com wrote:
>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> Changelog in v2:
>>> thanks to Paolo's review, this version disables write-protect-all if
>>> PML is supported
>>
>> Hi Paolo,
>>
>> Do you have time to have a look at this new version? ;)
>> Or I should wait until the patchset of dirty ring-buffer is merged?
> 
> I will look at it soon, but I still plan to merge dirty ring buffer first.
> 
> Thanks for your understanding,

Sure, i fully understand, thank you for bearing my push. :)
