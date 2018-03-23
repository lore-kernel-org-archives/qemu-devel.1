Received: from eggs.gnu.org ([2001:4830:134:3::10]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ezHL1-0006Qw-Oj
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ezHKy-0007Nb-N5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:42:11 -0400
References: <20180320130702.188689-1-borntraeger@de.ibm.com>
	<c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <44a34aee-6515-2682-0ef5-7fb874780d2a@redhat.com>
Date: Fri, 23 Mar 2018 08:42:04 +0100
MIME-Version: 1.0
In-Reply-To: <c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/cpumodel: fix feature groups and
 breakage of MSA8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>

On 20.03.2018 14:17, Christian Borntraeger wrote:
> David, Jason, Michael,
> 
> the cpumodel code is somewhat fragile as we have to add maintain things
> in multiple places. I would like to have more robust code, e.g. by either
> generating more or by having build bug_ons or something like that. 
> Any idea is highly welcome.
> 
> Christian

Yes, error prone. I was also wondering if we should explicitly address
array items when initializing - e.g. in target/s390x/cpu_features.c the
"indexed by feature number for easy lookup" part. More LOC but less
error prone.

As Mimu also suggested, if we can generate something automatically, we
should do that.


-- 

Thanks,

David / dhildenb
