Received: from eggs.gnu.org ([2001:4830:134:3::10]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du0ZA-0004mt-1g
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1du0Z3-000117-Ea
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1du0Z3-00010t-7r
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:14:37 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-17-david@redhat.com>
	<21b0f4da-f89b-32c6-b0ef-efb668c11a98@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9f04b0eb-6422-a207-35d7-d92706195d2a@redhat.com>
Date: Mon, 18 Sep 2017 20:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <21b0f4da-f89b-32c6-b0ef-efb668c11a98@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 16/27] s390x/kvm: factor out SIGP code
 into sigp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 18.09.2017 19:25, Christian Borntraeger wrote:
> 
> 
> On 09/18/2017 06:00 PM, David Hildenbrand wrote:
>> We want to use the same code base for TCG, so let's cleanly factor it
>> out.
>>
>> The sigp mutex is currently not really needed, as everything is
>> protected by the iothread mutex. But this could change later, so leave
>> it in place and initialize it properly from common code.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c |   3 +
>>  target/s390x/Makefile.objs |   1 +
>>  target/s390x/cpu.c         |   8 -
>>  target/s390x/cpu.h         |   6 +-
>>  target/s390x/internal.h    |   4 +
>>  target/s390x/kvm-stub.c    |   5 -
>>  target/s390x/kvm.c         | 349 +-----------------------------------------
>>  target/s390x/kvm_s390x.h   |   1 -
>>  target/s390x/sigp.c        | 366 +++++++++++++++++++++++++++++++++++++++++++++
> 
> You should probably do something in MAINTAINERS for sigp.c,
> otherwise Conny and myself no longer maintain the sigp code.
> 

Good point, I'll add a patch. (copying the maintainers from kvm.c -  you
and Conny  :) )

-- 

Thanks,

David
