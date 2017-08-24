Received: from eggs.gnu.org ([2001:4830:134:3::10]:52363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkotx-0002Rb-Jl
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkotu-0005ib-Ez
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkotu-0005iL-8D
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:58:10 -0400
Date: Thu, 24 Aug 2017 11:58:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824115803.4ca91b6a.cohuck@redhat.com>
In-Reply-To: <83230def-0eae-803b-d788-da0978ec48ec@linux.vnet.ibm.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-4-cohuck@redhat.com>
	<5c445775-eb1c-7f20-94d4-80eda7d4c623@de.ibm.com>
	<87ab396e-437f-27f9-4b31-e4b5417bed74@de.ibm.com>
	<20170824110959.3b9c3f72.cohuck@redhat.com>
	<83230def-0eae-803b-d788-da0978ec48ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/9] s390x/pci: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On Thu, 24 Aug 2017 11:50:54 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/24/2017 11:09 AM, Cornelia Huck wrote:
> > On Thu, 24 Aug 2017 09:43:48 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 08/24/2017 09:38 AM, Christian Borntraeger wrote:  
> >>>
> >>>
> >>> On 08/23/2017 05:54 PM, Cornelia Huck wrote:    
> >>>> Some non-pci code calls into zpci code. Provide some stubs for builds
> >>>> without pci.
> >>>>
> >>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>>> ---
> >>>>  hw/s390x/Makefile.objs   |  3 +-
> >>>>  hw/s390x/s390-pci-stub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  2 files changed, 76 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 hw/s390x/s390-pci-stub.c  
> >   
> >>>> +/* hw/s390x/sclp.c */
> >>>> +void s390_pci_sclp_configure(SCCB *sccb)
> >>>> +{
> >>>> +}
> >>>> +
> >>>> +void s390_pci_sclp_deconfigure(SCCB *sccb)
> >>>> +{
> >>>> +}    
> >>>
> >>> shouldnt these function set an error code in the sccb, e.g.
> >>> something like
> >>>
> >>>    sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> >>>
> >>>
> >>>     
> >>
> >> Oh you have something like that in patch 7. Maybe move?  
> > 
> > Does not really change anything in practice, but I can move it.
> >   
> 
> You mean these stubs are not supposed to be reachable and are just
> for making the linker happy, or? If that's the case I would prefer
> having that expressed by something like assert(false) or even 
> #define NOT_REACHABLE assert(false).

Without the last patch that makes virtio-pci depend on pci for s390x,
you can't compile without pci anyway ;)

> 
> Otherwise patch looks good, but I did not a full review on it,
> so let's try this:
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 

Thanks!
