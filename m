Received: from eggs.gnu.org ([2001:4830:134:3::10]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQcP-0002dB-SZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQcL-0004ul-QH
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnQcL-0004uX-Jv
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:38:49 -0400
Date: Thu, 31 Aug 2017 16:38:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831163836.58a92296.cohuck@redhat.com>
In-Reply-To: <4694a0bd-6c4e-b762-158f-1f860990448f@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-4-david@redhat.com>
	<09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
	<aa375deb-69ba-e0a8-d617-bbb304207a12@redhat.com>
	<20170831162930.17657819.cohuck@redhat.com>
	<4694a0bd-6c4e-b762-158f-1f860990448f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On Thu, 31 Aug 2017 16:30:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 31.08.2017 16:29, Cornelia Huck wrote:
> > On Thu, 31 Aug 2017 15:11:28 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >>>> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >>>> +{
> >>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> >>>> +
> >>>> +    if (cpu_addr >= max_cpus) {
> >>>> +        return NULL;
> >>>> +    }
> >>>> +
> >>>> +    /* Fast lookup via CPU ID */
> >>>> +    return ms->cpus[cpu_addr];
> >>>> +}    
> >>>
> >>> I wonder whether that function should rather go into a file in
> >>> target/s390x/ instead, since it is also used there and its prototype is
> >>> in cpu.h ?    
> >>
> >> I thought about the same thing, but as it works directly on the machine,
> >> like ri_allowed() and friends. So I decided to keep it here for now.
> >>
> >> I'll think about moving the definition also into
> >> include/hw/s390x/s390-virtio-ccw.h  
> > 
> > It would be a bit nicer.
> >   
> 
> Adding patches right now to move everything out of cpu.h that lies under
> the "/* outside of target/s390x/ */" section. :)
> 

Ah, you really care about your patch count, don't you? :)

(I think it's a good idea.)
