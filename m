Received: from eggs.gnu.org ([2001:4830:134:3::10]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF5v-0000t5-SG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekF5r-0000mE-TB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:16:27 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekF5r-0000lu-Ng
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:16:23 -0500
Received: by mail-io0-x243.google.com with SMTP id l17so10984526ioc.3
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:16:23 -0800 (PST)
References: <20180209104546.29401-1-pbonzini@redhat.com>
	<20180209104546.29401-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7bd39228-8445-028f-0595-87d3e65fb372@linaro.org>
Date: Fri, 9 Feb 2018 12:16:19 -0800
MIME-Version: 1.0
In-Reply-To: <20180209104546.29401-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] memory: hide
 memory_region_sync_dirty_bitmap behind DirtyBitmapSnapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 02/09/2018 02:45 AM, Paolo Bonzini wrote:
> Simplify the users of memory_region_snapshot_and_clear_dirty, so
> that they do not have to call memory_region_sync_dirty_bitmap
> explicitly.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/display/cg3.c             |  1 -
>  hw/display/exynos4210_fimd.c |  1 -
>  hw/display/framebuffer.c     |  1 -
>  hw/display/g364fb.c          |  1 -
>  hw/display/sm501.c           |  1 -
>  hw/display/tcx.c             |  2 --
>  hw/display/vga.c             |  6 ------
>  include/exec/memory.h        | 11 -----------
>  memory.c                     | 39 ++++++++++++++++++++-------------------
>  9 files changed, 20 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
