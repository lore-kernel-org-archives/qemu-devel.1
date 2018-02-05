Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eiiQV-0001f4-F2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eiiQS-0001e0-Pb
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:11:23 -0500
Date: Mon, 5 Feb 2018 16:11:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205161114.7189c033.cohuck@redhat.com>
In-Reply-To: <f90354e5-663a-b996-e031-3c2ca12732e5@de.ibm.com>
References: <20180205141215.50207-1-borntraeger@de.ibm.com>
	<f90354e5-663a-b996-e031-3c2ca12732e5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Mon, 5 Feb 2018 15:43:55 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/05/2018 03:12 PM, Christian Borntraeger wrote:
> 
> [...]
> 
> > diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> > index a1123ad621..71414cc324 100644
> > --- a/target/s390x/cpu.h
> > +++ b/target/s390x/cpu.h
> > @@ -77,6 +77,14 @@ typedef struct MchkQueue {
> >      uint16_t type;
> >  } MchkQueue;
> > 
> > +/* Crash cases. */
> > +enum crash_reasons {  
> I should add a CRASH_REASON_UNKNOWN,
> 
> 
> > +    CRASH_REASON_PGM,
> > +    CRASH_REASON_EXT,
> > +    CRASH_REASON_WAITPSW,
> > +    CRASH_REASON_OPEREXC,
> > +};  
> 
> 
> > +
> >  struct CPUS390XState {
> >      uint64_t regs[16];     /* GP registers */
> >      /*
> > @@ -102,6 +110,8 @@ struct CPUS390XState {
> > 
> >      PSW psw;
> > 
> > +    enum crash_reasons crash_reason;
> > +  
> 
> as this gets zeroed on reset.
> If we ever get called from other code that does not set a crash reason we better
> say "unknown"
> 

v5 on the way? (I don't see anything obviously wrong with this one.)
