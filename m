Received: from eggs.gnu.org ([2001:4830:134:3::10]:60964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1djkIE-0005Wi-H6
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1djkI9-0001EU-JA
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1djkI9-00017s-C7
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:50:45 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-8-david@redhat.com>
	<65be761f-752a-d63c-8654-d333bfb4bd08@redhat.com>
	<2b685ad1-fc58-e68d-51ee-32128b5b1555@redhat.com>
	<20170821115258.4f94ff12.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <05bd1704-d270-c7d2-3cce-11360472d9ff@redhat.com>
Date: Mon, 21 Aug 2017 12:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170821115258.4f94ff12.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 07/18] s390x: drop inclusion of
 sysemu/kvm.h from some files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, borntraeger@de.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 21.08.2017 11:52, Cornelia Huck wrote:
> On Fri, 18 Aug 2017 19:28:34 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.08.2017 18:08, Thomas Huth wrote:
>>> On 18.08.2017 13:43, David Hildenbrand wrote:  
>>>> s390-stattrib.c needs definition of TARGET_PAGE_SIZE, solve it via cpu.h.  
>>>
>>> Why not simply #include "exec/cpu-all.h" ? If cpu.h is not really needed
>>> here...
>>>
>>>  Thomas
>>>
>>>   
>>
>> Git grep showed me that this is a very rare thing to do, so I went for
>> cpu.h. If you prefer cpu-all.h, I can use that.
> 
> Is there any target that does not include cpu-all.h in its cpu.h? We
> probably can remove all includes of cpu-all.h in .c files, as all of
> them include cpu.h as well...
> 

I guess they have to, otherwise this stuff will not compile.

Yes, we should be able to remove exec/cpu-all.h from both remaining
users, dump.c and exec.c, as they already include cpu.h as you also noticed.

-- 

Thanks,

David
