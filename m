Received: from eggs.gnu.org ([2001:4830:134:3::10]:57731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmd9F-00084y-Ul
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmd9A-0004rp-WA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmd9A-0004rb-Pn
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:49:24 -0400
Date: Tue, 29 Aug 2017 11:49:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829114920.48eb459b.cohuck@redhat.com>
In-Reply-To: <20170829113353.0a13f88a.cohuck@redhat.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
	<20170829100746.66c47fd8.cohuck@redhat.com>
	<0d7cc071-cebe-82d5-90da-9737a5f0733e@linux.vnet.ibm.com>
	<20170829113353.0a13f88a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Tue, 29 Aug 2017 11:33:53 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> My question was whether virtio-pci works with your patches on top at
> all - last time I checked on master, virtio-pci devices failed to
> realize with a "msi-x is mandatory" message.

Just checked again, I still get

qemu-system-s390x: -device virtio-rng-pci: MSI-X support is mandatory in the S390 architecture

Any clue to what is missing?
