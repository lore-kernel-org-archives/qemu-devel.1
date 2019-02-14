Received: from eggs.gnu.org ([209.51.188.92]:56712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gu7pa-0008C3-6j
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gu7bA-0005JE-SP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:22:06 -0500
Date: Wed, 13 Feb 2019 20:21:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190213202142.19c3b9fc@x1.home>
In-Reply-To: <192ed142-ee50-982f-46df-7b53d1f32ab8@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-4-aik@ozlabs.ru>
	<CAKmqyKOOp0Nv7wqL_=s6f_1hep==bicXKofnhYo_puResrjNRg@mail.gmail.com>
	<25ef3ad6-90b6-a255-7f65-f3a88625b622@ozlabs.ru>
	<937f3d53-5ed1-85fe-c8de-623b69c870e4@ozlabs.ru>
	<192ed142-ee50-982f-46df-7b53d1f32ab8@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/7] pci: Move NVIDIA vendor id to
 the rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, joserz@linux.ibm.com, Alistair Popple <alistair@popple.id.au>, sbobroff@linux.ibm.com, pjaroszynski@nvidia.com, "open list:New World" <qemu-ppc@nongnu.org>, lagarcia@br.ibm.com, oohall@gmail.com, arbab@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 14 Feb 2019 13:26:49 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Ping? 3 months today :)

How about a non-RFC?

> On 16/01/2019 15:20, Alexey Kardashevskiy wrote:
> > Ping, anyone?
> > 
> > On 14/12/2018 14:36, Alexey Kardashevskiy wrote:  
> >>
> >>
> >> On 21/11/2018 05:27, Alistair Francis wrote:  
> >>> On Tue, Nov 13, 2018 at 12:42 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
> >>>>
> >>>> sPAPR code will use it too so move it from VFIO to the common code.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> >>>
> >>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>  
> >>
> >>
> >>
> >> Aaaaaand who is taking this? I am going to repost the patchset, posting
> >> this one over and over again seems redundant. Thanks,
> >>
> >>
> >>  
> >>>
> >>> Alistair
> >>>  
> >>>> ---
> >>>>  include/hw/pci/pci_ids.h | 2 ++
> >>>>  hw/vfio/pci-quirks.c     | 2 --
> >>>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> >>>> index 63acc72..3ed7d10 100644
> >>>> --- a/include/hw/pci/pci_ids.h
> >>>> +++ b/include/hw/pci/pci_ids.h
> >>>> @@ -271,4 +271,6 @@
> >>>>
> >>>>  #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
> >>>>
> >>>> +#define PCI_VENDOR_ID_NVIDIA             0x10de
> >>>> +
> >>>>  #endif
> >>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> >>>> index eae31c7..40a1200 100644
> >>>> --- a/hw/vfio/pci-quirks.c
> >>>> +++ b/hw/vfio/pci-quirks.c
> >>>> @@ -526,8 +526,6 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
> >>>>   * note it for future reference.
> >>>>   */
> >>>>
> >>>> -#define PCI_VENDOR_ID_NVIDIA                    0x10de
> >>>> -
> >>>>  /*
> >>>>   * Nvidia has several different methods to get to config space, the
> >>>>   * nouveu project has several of these documented here:
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>>  
> >>  
> >   
> 
