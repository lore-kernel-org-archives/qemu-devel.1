Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8AR-0006on-2g
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8AM-00031p-4X
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8AL-000318-WB
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:12:50 -0500
Date: Fri, 24 Nov 2017 15:12:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171124071244.GC10471@xz-mi>
References: <20171123092333.16085-1-peterx@redhat.com>
	<20171123092333.16085-3-peterx@redhat.com>
	<039e8f8a-53e1-4208-7b4e-48a05d6faf5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <039e8f8a-53e1-4208-7b4e-48a05d6faf5c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] cpu: refactor cpu_address_space_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Nov 23, 2017 at 05:06:31PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 10:23, Peter Xu wrote:
> > +                            const char *prefix, MemoryRegion *mr)
> >  {
> >      CPUAddressSpace *newas;
> > +    AddressSpace *as = g_new0(AddressSpace, 1);
> > +
> > +    assert(mr);
> > +    address_space_init(as, mr, prefix);
> >  
> 
> Now that address_space_init_shareable doesn't exist anymore, the
> AddressSpace could be placed directly in CPUAddressSpace instead of
> having a pointer.  But the patches are already okay, that's a separate
> change.

Yes.  Let me append another patch and repost.  Thanks,

-- 
Peter Xu
