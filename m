Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er0Fy-00017e-QV
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er0Fu-0006WL-NN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:50:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1er0Fu-0006Va-Is
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:50:42 -0500
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<33183CC9F5247A488A2544077AF19020DA56A1AE@DGGEMA505-MBX.china.huawei.com>
	<b5b23b57-8f66-3774-3a45-e42fd7edae96@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa78a250-5a88-300d-e935-aaeb8a69748b@redhat.com>
Date: Wed, 28 Feb 2018 12:50:33 +0100
MIME-Version: 1.0
In-Reply-To: <b5b23b57-8f66-3774-3a45-e42fd7edae96@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Zhuangyanying <ann.zhuangyanying@huawei.com>

On 28/02/2018 00:55, Alexander Graf wrote:
> 
> 
> On 27.02.18 10:52, Gonglei (Arei) wrote:
>> Hi all,
>>
>> Guests could achive good performance in 'Message Passing Workloads' 
>> scenarios when knowing the X86_FEATURE_MWAIT feature which is presented by qemu. 
>> the reason is that after knowing that feature, 
>> the guest could use mwait method, which saves VMEXIT, 
>> to do idle, and achives high performace in latency-sensitive scenario.
>>
>> Is there any plan for this patch? 
>>
>> Or May I send a updated version based on yours? @Alex?
> 
> Oh, did I drop the ball on this one? If that's the case, sure, go ahead.

Hi, it is probably best to implement this feature based on the
HINT_DEDICATED cpuid bit that Wanpeng Li is adding.

Paolo
