Received: from eggs.gnu.org ([2001:4830:134:3::10]:57898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAXab-0006pi-9m
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAXaX-0004xD-Vm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:49:05 -0400
Date: Thu, 11 Oct 2018 11:48:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181011114845.75275acd.cohuck@redhat.com>
In-Reply-To: <ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 0/6] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com

On Wed, 10 Oct 2018 20:15:55 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10/10/2018 07:03 PM, Tony Krowiak wrote:
> > This patch series is the QEMU counterpart to the KVM/kernel support for 
> > guest dedicated crypto adapters. The KVM/kernel model is built on the 
> > VFIO mediated device framework and provides the infrastructure for 
> > granting exclusive guest access to crypto devices installed on the linux 
> > host. This patch series introduces a new QEMU command line option, QEMU 
> > object model and CPU model features to exploit the KVM/kernel model.
> > 
> > See the detailed specifications for AP virtualization provided by this 
> > patch set in docs/vfio-ap.txt for a more complete discussion of the 
> > design introduced by this patch series.
> > 
> > v10 => v11 Change log:  
> 
> 
> 
> Series seems to work fine.
> 
> Christian

Is that a Tested-by:, or just 'looks sane'?
