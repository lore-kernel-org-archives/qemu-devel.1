Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoYGh-00033v-T7
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoYGd-0001Kv-Qm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:33:23 -0500
Date: Wed, 21 Feb 2018 18:33:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180221183316.03a87356.cohuck@redhat.com>
In-Reply-To: <20180221175119.4223dacd@p-imbrenda.boeblingen.de.ibm.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519152302-19079-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180221163459.50829ebf.cohuck@redhat.com>
	<20180221175119.4223dacd@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Wed, 21 Feb 2018 17:51:19 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> On Wed, 21 Feb 2018 16:34:59 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 20 Feb 2018 19:45:02 +0100
> > Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> > > +static const VMStateDescription vmstate_event_facility_mask64 = {
> > > +    .name = "vmstate-event-facility/mask64",
> > > +    .version_id = 0,
> > > +    .minimum_version_id = 0,
> > > +    .needed = vmstate_event_facility_mask64_needed,
> > > +    .pre_load = vmstate_event_facility_mask64_pre_load,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_UINT64(receive_mask, SCLPEventFacility),
> > > +        VMSTATE_END_OF_LIST()
> > > +     }
> > > +};
> > > +    
> > 
> > Are there plans for extending this beyond 64 bits? Would it make sense  
> 
> I don't know. I'm not even aware of anything above 32 bits, but since we
> are already using all of the first 32 bits, it's only matter of time I
> guess :)
> 
> > to use the maximum possible size for the mask here, so you don't need
> > to introduce yet another vmstate in the future? (If it's unlikely that  
> 
> That's true, but it requires changing simple scalars into bitmasks.
> Surely doable, but I wanted to touch as little as possible.

OK, that pushes this firmly into the 'overkill' area. Let's just go
with your current approach.

> 
> > the mask will ever move beyond 64 bit, that might be overkill, of
> > course.)
