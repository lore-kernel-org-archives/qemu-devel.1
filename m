Received: from eggs.gnu.org ([2001:4830:134:3::10]:44697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQNs-0001sa-Rw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQNp-00073x-CY
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwQNp-00073N-3O
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:13:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PAB2EY106192
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:12:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6x8swhru-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:12:56 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 11:12:54 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
	<ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
	<eee7e600-a8b0-6e23-580b-803f3b4e9efa@linux.vnet.ibm.com>
	<4a31c53b-98aa-747a-1402-1a93e74c565b@de.ibm.com>
	<5cdfe359-2e78-7e2a-72c2-d3e69574288e@linux.vnet.ibm.com>
	<20170925120745.7326637e.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 12:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170925120745.7326637e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20da1950-3aa5-c29f-3d54-4f82289f34f1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/25/2017 12:07 PM, Cornelia Huck wrote:
> On Fri, 22 Sep 2017 16:27:00 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> One thing I would find very helpful is what do we expect to work and not
>> work for which version. Kind of a matrix. For instance should vfio pci
>> work for versions prior 2.11. I think in the not so distant past we
>> changed how SIC works (so it complains when we don't have ais).
> 
> A matrix sounds like a good idea.

I think we do not even need a matrix, a minimum level will suffice because...
> 
> I don't think we really ever had a setup that worked out of the box

exactly: ...it never worked until 2.10 and we do not have libvirt support yet.
Now with the fix 2.10 will also not work, so I think its fair to say

PCI passthrough via VFIO will be supported for 
- KVM: host kernel >= 4.13
- TCG: TBD
- QEMU >= 2.11
- libvirt TBD


> for a Linux guest prior to 2.10 anyway. For added fun, it also depends
> on the host kernel. And tcg won't work at all due to the pci
> instruction not yet being wired up.
> 
>> Btw nimm/dimm is simm/nimm. And I would really like to hear something

yes, I mixed that up. Too many letters :-)

>> form the original author(s) too.
