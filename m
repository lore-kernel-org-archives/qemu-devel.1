Received: from eggs.gnu.org ([2001:4830:134:3::10]:54224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9AH-0004hh-OS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9AE-000152-Jz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:07:21 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb9AE-000142-Ek
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:07:18 -0500
Received: by mail-pl0-x243.google.com with SMTP id f8so2222961plk.11
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:07:18 -0800 (PST)
References: <20180113004338.16867-1-laurent@vivier.eu>
	<20180113004338.16867-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a3f4e0b-dd3c-272a-b836-8f25647ceda5@linaro.org>
Date: Mon, 15 Jan 2018 10:07:12 -0800
MIME-Version: 1.0
In-Reply-To: <20180113004338.16867-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] accel/tcg: add size paremeter in
 tlb_fill()
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

On 01/12/2018 04:43 PM, Laurent Vivier wrote:
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
> ---
> v2: use "0" for the access size when we don't know
>     the size of the access
>     

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
