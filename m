Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfR2s-0006ko-Ca
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfR2o-0007nO-TG
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfR2o-0007mo-NV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:29:06 -0400
Date: Wed, 9 Aug 2017 15:29:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809152900.6ffe0f28.cohuck@redhat.com>
In-Reply-To: <9ea9555d-5210-d574-0ddf-40ae6739a862@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-6-david@redhat.com>
	<20170809150105.66c970c0.cohuck@redhat.com>
	<9ea9555d-5210-d574-0ddf-40ae6739a862@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] target/s390x: add basic MSA features
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

On Wed, 9 Aug 2017 15:25:36 +0200
David Hildenbrand <david@redhat.com> wrote:

> > A comment which subfunction this is might be helpful.  
> 
> Indeed.
> 
> /* query subfunction */

Looks good!

> 
> >   
> >> +        for (i = 0; i < 16; i++) {
> >> +            param_addr = wrap_address(env, env->regs[1] + i);  
> > 
> > This does not compile for me (after massaging the Makefile above), as
> > wrap_address does not seem to be exported... can you do a respin,
> > please?
> >   
> 
> Contained in patch nr4 in this series. But I'm planning to do a respin
> (most likely introducing internal.h).

Ah yes, that issue had dropped out of my cache :)

I'll just wait for a respin of your pending patches, then.
