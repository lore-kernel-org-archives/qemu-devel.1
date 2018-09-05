Received: from eggs.gnu.org ([2001:4830:134:3::10]:43885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fxTxH-0002Kg-0l
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fxTxC-00007w-NW
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:18:30 -0400
Received: from mail-ve1eur01on0123.outbound.protection.outlook.com
	([104.47.1.123]:29152
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fxTxB-0008Bi-Vp
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:18:26 -0400
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180720092717.GB16910@xz-mi>
	<4c3e07f4-ba82-9b88-6d32-4407b10a9926@virtuozzo.com>
	<20180905033255.GA16809@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <bc0fc93d-0ad8-0715-de64-82181e83e4c0@virtuozzo.com>
Date: Wed, 5 Sep 2018 12:18:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180905033255.GA16809@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/17] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Hi Peter,

Thanks for the reply.

Ok, I understand about tcg.
So my only option is to wait for userfaultfd-wp.
Do you know if anyone is  currently working on this? And if so, then is 
there any estimations when the userfaultfd is ready?

Denis


On 05.09.2018 06:32, Peter Xu wrote:
> On Tue, Sep 04, 2018 at 04:00:31PM +0300, Denis Plotnikov wrote:
>> Hi Peter
> 
> Hi, Denis,
> 
>>
>> I moved the code to the repository
>> https://github.com/denis-plotnikov/qemu/tree/background-snapshot-kvm.
>> the current version includes fixes with respect to your comments for version
>> 1.
>> I moved KVM related patches to the end of the branch (formerly patch
>> series).
>> Since, the KVM patches and the other parts to modify (vhost an others) are
>> needless in favor of upcoming userfaltfd,
>> I would ask you to review the general framework which is able to work with
>> tcg.
>>
>> Thanks in advance!
> 
> Thank you for pushing the tree.
> 
> I might have made a mistake before that I thought this work is at
> least working for TCG, but I think I was wrong.  The problem is (I'm
> trying to repeat Dave's question that you seems haven't yet answered):
> even for TCG there could be use cases where the process might access
> guest memory from the kernel space (e.g., vhost, or any system calls
> that with a guest memory buffer passed in).  I'm afraid mprotect() and
> the whole signal-based mechanism cannot be able to address these page
> faults, then we'll encounter adhoc errors and we'll need to fix all
> these places up.  Userfaultfd-wp should not have this problem.
> 
> I think the general idea of the work is good, but I'm not sure whether
> we can merge the work if we don't settle these issues.
> 
> Regards,
> 

-- 
Best,
Denis
