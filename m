Received: from eggs.gnu.org ([2001:4830:134:3::10]:46526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIb1i-0000lu-8y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIb1c-0007XJ-G6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:34:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIb1c-0007VU-9y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:34:00 -0400
References: <20180515134835.3409-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e30e289f-e23d-7abc-6407-fb28b609606e@redhat.com>
Date: Tue, 15 May 2018 16:33:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180515134835.3409-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory.h: Fix typo in documentation comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 15/05/2018 15:48, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 525619a5f4..4fa1227f13 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -679,7 +679,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>   * memory_region_init_reservation: Initialize a memory region that reserves
>   *                                 I/O space.
>   *
> - * A reservation region primariy serves debugging purposes.  It claims I/O
> + * A reservation region primarily serves debugging purposes.  It claims I/O
>   * space that is not supposed to be handled by QEMU itself.  Any access via
>   * the memory API will cause an abort().
>   * This function is deprecated. Use memory_region_init_io() with NULL
> 

Let's just get rid of the function... Patch along the way.

Paolo
