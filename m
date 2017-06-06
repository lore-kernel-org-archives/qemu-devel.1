Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dIA5X-0002LE-Jp
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dIA5T-0007d3-NY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dIA5T-0007cm-Fl
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:43:39 -0400
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-3-david@redhat.com>
	<e70d08bd-bf75-4997-df7b-e64710046fc3@linux.vnet.ibm.com>
	<f1a8957a-9d13-efce-c0c4-b010ae4b6cd8@redhat.com>
	<e7465d88-84b3-8287-1e42-c5b60b514ef6@linux.vnet.ibm.com>
	<058e655a-af9b-5596-cd67-e2b2eb5701a8@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <39fb1b29-64c6-ca70-7248-839914ed290c@redhat.com>
Date: Tue, 6 Jun 2017 10:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <058e655a-af9b-5596-cd67-e2b2eb5701a8@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, jjherne@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, thuth@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 06.06.2017 10:39, Christian Borntraeger wrote:
> On 06/02/2017 07:28 PM, Halil Pasic wrote:
> [...]
>> Maybe integrating some of the discussion from above into the commit
>> message would be helpful.
> 
> applied with the following patch description

Just wanted to ask you to do that :) Thanks!

Looks good to me!

> 
> 
> Currently, under z/VM on a 0x2827, QEMU will detect a 0x2828 if no
> IBC value is provided. QEMU will simply take the last model of that HW
> generation, which happens to be the BC version.
> 
> Let's improve our search for that case by selecting the latest CPU
> definition that matches the CPU type. This for example will avoid
> detecting an z13 as a z13s.
> 
> We might still detect a GA2 version on a GA1 system, but as we don't
> have further information at hand, there isn't too much we can do about
> it. The alternative of always presenting the oldest GA is not backward
> compatible, e.g:
> You're running on 0x2827 GA2.
> Old QEMU version indicated "0x2828 GA1 == 0x2827 GA2". After you updated
> QEMU, you suddenly detect "0x2827 GA1". You're previous libvirt guest
> might suddenly refuse to run.
> 
> In the end presenting a newer GA level does not matter because:
> 
> 1: All GAX models share the same base feature set. A GAX++ might
> support "more features".
> 2: Without an IBC, the guest can't detect the GA version.
> 
> If we have no IBC (esp. unblocked_ibc == 0), the IBC we will present
> to the guest in read_SCP_info() will be 0. The guest will not know
> which GA version it has. The problem of missing IBC propagates.
> 
> If we don't have a feature of the GA++ version, also our guest won't
> have it. So in summary, the guest also has no idea of its GA version.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20170531193434.6918-3-david@redhat.com>
> Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [improve patch description by reusing mailing list discussion]
> 
> 



-- 

Thanks,

David
