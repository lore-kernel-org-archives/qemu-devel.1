Received: from eggs.gnu.org ([2001:4830:134:3::10]:54525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgBtR-0008P2-Dc
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgBtM-0001bQ-CN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgBtM-0001b9-5j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:30:28 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811171515.623cd5c6.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <78d35202-a6cd-b71c-16b9-4653739b39bf@redhat.com>
Date: Fri, 11 Aug 2017 17:30:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170811171515.623cd5c6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] target/s390x: introduce internal.h
 and cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 17:15, Cornelia Huck wrote:
> On Fri, 11 Aug 2017 09:46:47 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> cpu.h is accessed outside of target/s390x. It should only contain
>> what is expected to be accessed outside of this folder. Therefore, create
>> internal.h and move a lot to that file.
> 
> Cool, I like that.
> 
>>
>> While doing that, I noticed that a lot of function prototypes not
>> available with CONFIG_USER_ONLY are not protected by CONFIG_USER_ONLY.
>>
>> As these CONFIG_USER_ONLY are in general ugly, I decided to minimize
>> them to the bare minimum :]. Do we care? I dropped it wherever possible.
>>
>> My compiler doesn't bail out, so let's see what the bot says.
> 
> That should be easy to fix :)
> 
>>
>> There is still a lot to clean up (e.g. do we want kvm-stub.c ?). This is
>> the first step.
> 
> Do you plan to send a v2 with kvm_s390x.h? If yes, I'll hold off
> looking at this series.
> 

Yes, will take care of the review comments from Richard and Thomas.
(including kvm_s390x.h)

-- 

Thanks,

David
