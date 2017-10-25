Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7Iqx-00053j-5y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7Iqt-0004bg-4c
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e7Iqs-0004bB-US
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:23:59 -0400
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
Date: Wed, 25 Oct 2017 12:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 25.10.2017 12:18, Christian Borntraeger wrote:
> Ping, I plan to submit belows patch for 2.11. We can then still look into
> a libvirt<->qemu interface for limiting host-model depending on machine versions
> (or not).

I think this would be sufficient for now.

Having different host models, depending on the the machine type sounds
wrong. But maybe we'll need it in the future.


-- 

Thanks,

David
