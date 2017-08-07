Received: from eggs.gnu.org ([2001:4830:134:3::10]:47486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1defHi-0008A7-WC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1defHe-0000V4-T1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:29:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1defHe-0000U6-MA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:29:14 -0400
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804112946.5247-6-cohuck@redhat.com>
	<789fa061-be02-9fdb-b01b-bdec4c18d1c4@redhat.com>
	<20170807120027.75d6b971@gondolin>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a0d90bab-359c-5d60-2980-082faf6ff82e@redhat.com>
Date: Mon, 7 Aug 2017 12:21:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170807120027.75d6b971@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] s390x/ccw: create s390 phb
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07.08.2017 12:00, Cornelia Huck wrote:
> On Fri, 4 Aug 2017 15:20:26 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 04.08.2017 13:29, Cornelia Huck wrote:
>>> Don't create the s390 pci host bridge if we do not provide the zpci
>>> facility.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
>>
>> This works, because s390_init_cpus(machine) (which sets up features) is
>> called before adding the bus. Mind to add a comment so nobody tries to
>> reshuffle these functions?
> 
> This is already needed by the flic setup (which also relies on the
> features being set up). We really want the cpu setup as early as
> possible.
> 
> Do you have a good comment handy? :)
> 

/* init CPUs (incl. CPU model) early so s390_has_feature() works */

-- 

Thanks,

David
