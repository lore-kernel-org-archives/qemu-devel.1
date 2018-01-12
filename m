Received: from eggs.gnu.org ([2001:4830:134:3::10]:53998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eZwnn-00088t-Rk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eZwnj-0003FR-0T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:43:11 -0500
References: <20171218224616.21030-1-david@redhat.com>
	<20171222115734.1f2f03ca.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8cc73bae-a831-5c77-3716-fcb8c727cc4e@redhat.com>
Date: Fri, 12 Jan 2018 11:43:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171222115734.1f2f03ca.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 0/2] s390x/tcg: TEST
 PROTECTION and memory hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>


>> David Hildenbrand (2):
>>   s390x/tcg: implement TEST PROTECTION
>>   s390x/sclp: fix missing be conversion
>>
>>  hw/s390x/sclp.c           |  4 ++--
>>  target/s390x/helper.h     |  2 +-
>>  target/s390x/mem_helper.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>  target/s390x/translate.c  |  2 +-
>>  4 files changed, 43 insertions(+), 6 deletions(-)
>>
> 
> Thanks, applied.
> 

FWIW, just found out I interpreted the PGM_ADRESSING case wrong, will
resend once I fixed it.

-- 

Thanks,

David / dhildenb
