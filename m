Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmxPx-0004vw-1r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmxPt-0006oN-UX
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmxPt-0006ni-OS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:28:01 -0400
Date: Wed, 30 Aug 2017 09:27:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170830092757.5715a37f.cohuck@redhat.com>
In-Reply-To: <f2aaa9ff-d98a-b8fe-aff8-f5d931e10643@linux.vnet.ibm.com>
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
	<c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
	<b5a9ab05-4e3c-66bc-33ce-d953d7f911e2@linux.vnet.ibm.com>
	<20170828160554.45855dfa.cohuck@redhat.com>
	<e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
	<9b9880e4-71fd-4bc5-961b-ab0e2b298f03@linux.vnet.ibm.com>
	<3421f46f-fa82-ac23-b0ac-5a2acce26d41@linux.vnet.ibm.com>
	<20170829140429.08a1731c.cohuck@redhat.com>
	<ffe9c512-4238-7456-27d2-cdc8fa39d8e0@linux.vnet.ibm.com>
	<20170829144533.54891819.cohuck@redhat.com>
	<f2aaa9ff-d98a-b8fe-aff8-f5d931e10643@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, walling@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Tue, 29 Aug 2017 14:45:51 -0400
Eric Farman <farman@linux.vnet.ibm.com> wrote:

> There were multiple $QEMUSRC directories on this system.  At least one 
> 2.9.xx version didn't have commit 198c0d1f9df8c4 (and thus wouldn't care 
> about the boundary alignment), while others did.  The aligned(8) fix 
> described here was not applied universally, resulting in, uh, 
> inconsistent results.  Shared systems are fun.  :)
> 
> After a little cleanup, the results from that system match what the rest 
> of us have seen/expected.

Thanks a lot for figuring that one out! I'll queue a bios update as
well.
