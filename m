Received: from eggs.gnu.org ([2001:4830:134:3::10]:35136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eb12p-0005Hx-71
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eb12l-0001DK-4b
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:27:07 -0500
References: <20180113111428.7066-1-laurent@vivier.eu>
	<20180113111428.7066-2-laurent@vivier.eu>
From: David Hildenbrand <david@redhat.com>
Message-ID: <933500bf-2833-9585-561b-40c43c3ab9e8@redhat.com>
Date: Mon, 15 Jan 2018 10:26:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180113111428.7066-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/7] accel/tcg: add size
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>

On 13.01.2018 12:14, Laurent Vivier wrote:
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
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
