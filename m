Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxXv5-0001Nn-22
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxXuz-0008Cy-HO
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxXuz-0008Cl-BE
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:27:53 -0400
Date: Thu, 28 Sep 2017 14:27:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928142745.2ab4da2a.cohuck@redhat.com>
In-Reply-To: <ebe58241-049a-bb4e-acee-8ef4c12e2d3a@de.ibm.com>
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
	<20170928140704.0cc18986.cohuck@redhat.com>
	<ebe58241-049a-bb4e-acee-8ef4c12e2d3a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com

On Thu, 28 Sep 2017 14:17:54 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> I see no point if PCI disable machines. There is no non-PCI x86 machine
> besides the isapc. But this has no version whatsoever so it certainly
> is not made for being migrated.
> As far as I can see and we would make things much more complex.
> 
> non-PCI will trigger other issues. e.g. zpci and aen is part of the z14 cpu model
> since 2.10. Really this is not helping, its making things worse.  

What about creating the phb depending upon pci_available? Has no impact
for normal builds unless you muck around manually...

> If you really want to avoid PCI for whatever redhat is doing, can't you just hide
> it in a rhel specific machine (which you seem to have anyway for x86 and power)?

...but makes it easier to disable it correctly, if wanted.
