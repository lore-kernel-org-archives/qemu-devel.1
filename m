Received: from eggs.gnu.org ([2001:4830:134:3::10]:36162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eZBz0-0005on-KZ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eZByz-0006h1-Pr
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:43:38 -0500
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-2-laurent@vivier.eu>
From: David Hildenbrand <david@redhat.com>
Message-ID: <66de9088-f8ed-2be4-c71a-5d149c63587b@redhat.com>
Date: Wed, 10 Jan 2018 09:43:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/6] accel/tcg: add size
 paremeter in tlb_fill()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>

On 09.01.2018 00:10, Laurent Vivier wrote:
> The MC68040 MMU provides the size of the access that
> triggers the page fault.
> 
> This size is set in the Special Status Word which
> is written in the stack frame of the access fault
> exception.
> 
> So we need the size in m68k_cpu_unassigned_access() and
> m68k_cpu_handle_mmu_fault().
> 
> To be able to do that, this patch modifies the prototype of
> handle_mmu_fault handler, tlb_fill() and probe_write().
> do_unassigned_access() already includes a size parameter.
> 
> This patch also updates handle_mmu_fault handlers and
> tlb_fill() of all targets (only parameter, no code change).
> 

There are a couple of places where you use "1" (when no other size is
available). e.g. in get_page_addr_code().

Wonder if that's the right thing to do - are there any architectures
that e.g. always fetch at least 2 bytes in these conditions?

Apart from that, looks sane to me (for other architectures :) )

-- 

Thanks,

David / dhildenb
