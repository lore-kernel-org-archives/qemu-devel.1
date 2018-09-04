Received: from eggs.gnu.org ([2001:4830:134:3::10]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fxAwm-0008Gw-40
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fxAwh-0006hM-4J
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:00:43 -0400
Received: from mail-eopbgr50136.outbound.protection.outlook.com
	([40.107.5.136]:40890
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fxAwg-0006fO-Cc
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 09:00:39 -0400
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180720092717.GB16910@xz-mi>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <4c3e07f4-ba82-9b88-6d32-4407b10a9926@virtuozzo.com>
Date: Tue, 4 Sep 2018 16:00:31 +0300
MIME-Version: 1.0
In-Reply-To: <20180720092717.GB16910@xz-mi>
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

Hi Peter

I moved the code to the repository 
https://github.com/denis-plotnikov/qemu/tree/background-snapshot-kvm.
the current version includes fixes with respect to your comments for 
version 1.
I moved KVM related patches to the end of the branch (formerly patch 
series).
Since, the KVM patches and the other parts to modify (vhost an others) 
are needless in favor of upcoming userfaltfd,
I would ask you to review the general framework which is able to work 
with tcg.

Thanks in advance!

Denis

On 20.07.2018 12:27, Peter Xu wrote:
> On Wed, Jul 18, 2018 at 06:41:43PM +0300, Denis Plotnikov wrote:
>> The workflow to make a snapshot is the following:
>> 1. Pause the vm
>> 2. Make a snapshot of block devices using the scheme of your choice
>> 3. Turn on background-snapshot migration capability
>> 4. Start the migration using the destination (migration stream) of your choice.
>>     The migration will resume the vm execution by itself
>>     when it has the devices' states saved  and is ready to start ram writing
>>     to the migration stream.
>> 5. Listen to the migration finish event
>>
>> The bakground snapshot works with support of KVM patch:
>> "x86: mmu: report failed memory access to the userspace"
>> (not applied to the mainstream, it's in the kvm mailing list)
> 
> Hello, Denis,
> 
> Do you mind to push your tree to an online repository in case to make
> review easier?
> 
> Thanks,
> 

-- 
Best,
Denis
