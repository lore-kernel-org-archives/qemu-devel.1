Received: from eggs.gnu.org ([2001:4830:134:3::10]:59047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMG1n-0005GB-57
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMG1i-0004jo-78
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:25:03 -0500
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-4-david@redhat.com>
	<20171205155602.4b5ec96b.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f17391c8-05a5-1da0-5b44-c8bdc4b3d894@redhat.com>
Date: Tue, 5 Dec 2017 17:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171205155602.4b5ec96b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 3/9] s390x/tcg: wire up SET
 ADDRESS LIMIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 05.12.2017 15:56, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 15:01:44 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's handle it just like KVM:
>>     Depending on the model, this instruction may not be
>>     provided. When this instruction is not provided, it is
>>     checked for operand exception and privileged-opera-
>>     tion exception, and then is suppressed.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h      | 1 +
>>  target/s390x/insn-data.def | 1 +
>>  target/s390x/misc_helper.c | 9 +++++++++
>>  target/s390x/translate.c   | 7 +++++++
>>  4 files changed, 18 insertions(+)
> 
> Looks reasonable (does Linux use this at all?)
> 

Don't know, but assume not. I just went ahead and wired up everything I
could find :)

-- 

Thanks,

David / dhildenb
