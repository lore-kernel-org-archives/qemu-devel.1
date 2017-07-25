Received: from eggs.gnu.org ([2001:4830:134:3::10]:58800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZzDE-0003cC-Ry
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZzDA-0004cm-Us
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZzDA-0004cO-O4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:45:16 -0400
Date: Tue, 25 Jul 2017 14:45:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725144504.3f535f5f@gondolin>
In-Reply-To: <971f9c67-1556-d002-07fa-a48929e335ec@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170725135534.55f9bd38@gondolin>
	<971f9c67-1556-d002-07fa-a48929e335ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] target/s390x: tcg improvments + MSA
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On Tue, 25 Jul 2017 14:16:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 25.07.2017 13:55, Cornelia Huck wrote:
> > On Fri, 21 Jul 2017 14:56:03 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Based on series:
> >>     "[PATCH v2 0/5] target/s390x: cpu model cleanups + improvements"  
> > 
> > I'm trying to decide what to do with this series; probably nothing for
> > 2.10.
> >   
> >>
> >> 1. smaller pgm irq instruction length fixes  
> > 
> > These, I would have considered. But it seems Richard had an alternative
> > idea which is 2.11 material. So I'll probably just ignore these for now.  
> 
> I'd suggest to simply pick these two up. Simple fixes. Richards series
> is a step into the right direction, getting rid of explicit ILEN
> specification/ILEN_AUTO completely, avoiding such bugs in the future.

These two are certainly small enough.

> 
> But I'll let Richard + you decide.
> 
> >   
> >> 2. implement IPM, which is often used in context of MSA instructions
> >> 3. implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
> >>    the query subfunction (to query available subfunctions), no actual
> >>    de/encryption yet  
> > 
> > This is certainly 2.11 material.  
> 
> We could discuss if IPM makes sense. I can resend the updated version.

As we're suppose to enter (or have entered) hardfreeze now, I'd prefer
to defer to 2.11.

> MSA can certainly wait for 2.11.
