Received: from eggs.gnu.org ([2001:4830:134:3::10]:51164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxY0n-00043m-4T
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxY0j-0001jf-8Q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxY0j-0001jH-2d
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:33:49 -0400
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
	<14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
	<4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
	<20170927142837.GB2108@work-vm>
	<20170927164644.42205e6f.cohuck@redhat.com>
	<20170927144927.GC2108@work-vm>
	<20170927170346.68ca0cd8.cohuck@redhat.com>
	<9c8c2596-c4cf-41ad-7228-0ed598cf65cd@de.ibm.com>
	<dc15f576-8397-718d-0c75-0cba607c53b9@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <06985cad-8fc0-8eb5-8cd1-6baabd5a217b@redhat.com>
Date: Thu, 28 Sep 2017 14:33:44 +0200
MIME-Version: 1.0
In-Reply-To: <dc15f576-8397-718d-0c75-0cba607c53b9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com


>> In the end that means that you should revert
>>
>> commit d32bd032d8fde41281aae34c16a4aa97e9acfeac
>> Author:     Cornelia Huck <cohuck@redhat.com>
>> AuthorDate: Thu Jul 6 17:21:52 2017 +0200
>> Commit:     Cornelia Huck <cohuck@redhat.com>
>> CommitDate: Wed Aug 30 18:23:25 2017 +0200
>>
>>     s390x/ccw: create s390 phb conditionally
>>
>> to keep s390-ccw-virtio clean proper.
>>
>> If you want to have PCI disabled, you can do you in a machine like 
> too quick                                     ^that^					 
>> s390-rhelx.y.z or whatever. 
> 
> I think we really must revert this commit. 
> 

I tend to agree.

-- 

Thanks,

David
