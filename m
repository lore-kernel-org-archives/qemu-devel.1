Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dbvyy-0004Gz-84
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 17:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dbvyt-0000sM-TS
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 17:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dbvyt-0000sD-Mv
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 17:42:35 -0400
Date: Sun, 30 Jul 2017 18:42:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170730214231.GC16400@localhost.localdomain>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>


CCing Alex, the original author of load_multiboot(), and Kevin,
who touched multiboot code recently.


On Fri, Jul 28, 2017 at 02:28:34PM -0700, Anatol Pomozov wrote:
> Hi
> 
> I am looking at x86 multiboot code and trying to add "ELF section
> header" info feature. This will let target to learn more about booted
> binary and its sections.

Are there existing OSes that use that information?


> 
> I have a draft here
> https://github.com/anatol/qemu/commit/ad943a6eb78feee048b6bb2a1e5f49f5b686e24c
> 
> My understanding is that qemu multiboot loads only TEXT/BSS/DATA
> sections. Other stuff like symbols sections and ELF headers are not
> available for target.
> 
> So I need to perform 2 things:
> 
>  - Load ELF section headers into target's memory. I did by appending
> additional space to mbs.mb_buf and copying header data. Is it the best
> way to do?
> 
>  - Next I need to load other ELF sections such as symbols (e.g.
> .shstrtab) that store section names. What is the best way to do in
> multiboo.c code? Would it make sense to load all ELF sections?
> 
> Thanks in advance.
> 

-- 
Eduardo
