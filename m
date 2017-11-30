Received: from eggs.gnu.org ([2001:4830:134:3::10]:41066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eKEE9-0005JT-6w
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eKEE6-00027H-2x
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:05:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eKEE5-00026c-TH
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:05:22 -0500
Date: Wed, 29 Nov 2017 19:05:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171129190520.012e51b5@t450s.home>
In-Reply-To: <f41f2faa-25f2-1c1d-a6e4-ba646fe6fb14@ozlabs.ru>
References: <20171122073947.19325-1-aik@ozlabs.ru>
	<20171129083624.134d46ce@t450s.home>
	<f41f2faa-25f2-1c1d-a6e4-ba646fe6fb14@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio-pci: Remove unused fields from
 VFIOMSIXInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On Thu, 30 Nov 2017 12:56:09 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 30/11/17 02:36, Alex Williamson wrote:
> > On Wed, 22 Nov 2017 18:39:47 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > 
> > Missing reference to commit that made these fields unused.  A Fixes tag
> > to that commit also seems appropriate.  An empty commit log is pretty
> > much never justified.  
> 
> Ah. Right, sorry. I could not find when it was used, looks like never.

Nope, db0da029a185 vfio: Generalize region support

> > This also looks like 2.12 material.  Thanks,  
> 
> Indeed 2.12.
> 
> 
> > 
> > Alex
> >   
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  hw/vfio/pci.h | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> >> index c5e168e..06dcf99 100644
> >> --- a/hw/vfio/pci.h
> >> +++ b/hw/vfio/pci.h
> >> @@ -93,8 +93,6 @@ typedef struct VFIOMSIXInfo {
> >>      uint16_t entries;
> >>      uint32_t table_offset;
> >>      uint32_t pba_offset;
> >> -    MemoryRegion mmap_mem;
> >> -    void *mmap;
> >>      unsigned long *pending;
> >>  } VFIOMSIXInfo;
> >>    
> >   
> 
> 
