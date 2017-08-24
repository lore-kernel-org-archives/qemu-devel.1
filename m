Received: from eggs.gnu.org ([2001:4830:134:3::10]:34559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dknY8-00061k-7m
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dknY3-0001tj-C7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dknY3-0001tJ-65
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:31:31 -0400
Date: Thu, 24 Aug 2017 10:31:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824103124.72bd86c4.cohuck@redhat.com>
In-Reply-To: <ceb4412f-7909-73f8-5de1-4bbc7bd86079@linux.vnet.ibm.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-8-cohuck@redhat.com>
	<ceb4412f-7909-73f8-5de1-4bbc7bd86079@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 7/9] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Wed, 23 Aug 2017 18:25:05 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 23/08/2017 17:54, Cornelia Huck wrote:
> > If we do not provide zpci, pci reconfiguration via sclp is not available
> > either. I/O adapter configuration, however, should always be present.
> > 
> > Rename the values that refer to I/O adapter configuration (instead of only
> > pci) to make things clearer.
> > 
> > Move length checking of the sccb for I/O adapter configuration into the
> > common sclp code (out of the pci code). This also fixes an issue that
> > the pci code would refer to a field in the sccb before checking whether
> > it was actually long enough.
> > 
> > Check for the adapter type in the sccb and return unrecognized adapter
> > type if the guest tries to issue I/O adapter configure/deconfigure for
> > a type other than pci or for pci if the zpci facility is not provided.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/s390x/s390-pci-bus.c  | 14 ++------------
> >   hw/s390x/s390-pci-bus.h  |  8 --------
> >   hw/s390x/s390-pci-stub.c |  2 ++
> >   hw/s390x/sclp.c          | 39 ++++++++++++++++++++++++++++++++++-----
> >   include/hw/s390x/sclp.h  | 17 +++++++++++++----
> >   5 files changed, 51 insertions(+), 29 deletions(-)

> LGTM and
> I could also test the all serie on the hardware (sure is sure) :)
> with VFIO and virtio PCI... so
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>

Cool, thanks!
