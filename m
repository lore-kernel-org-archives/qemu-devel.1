Received: from eggs.gnu.org ([209.51.188.92]:55395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggRmG-0002CU-Ra
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggRmF-000498-OY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:05:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ggRmF-00047v-JX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:04:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so37377076otk.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 02:04:58 -0800 (PST)
MIME-Version: 1.0
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1544063533-10139-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 7 Jan 2019 11:04:46 +0100
Message-ID: <CAGxU2F59T+4a73vfd4mAGkC==dxqzhZKWA9sieFNPsZ2TVARCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 1/4] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, philip.li@intel.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Philippe Mathieu Daude <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Li,

On Thu, Dec 6, 2018 at 3:26 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> Some address/memory APIs have different type between
> 'hwaddr/target_ulong addr' and 'int len'. It is very unsafe, espcially


As Philippe already suggested,
s/espcially/especially


> some APIs will be passed a non-int len by caller which might cause
> overflow quietly.
> Below is an potential overflow case:
>     dma_memory_read(uint32_t len)
>       -> dma_memory_rw(uint32_t len)
>         -> dma_memory_rw_relaxed(uint32_t len)
>           -> address_space_rw(int len) # len overflow
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> V4: minor fix at commit message and add Reviewed-by tag
> V3: use the same type between len and addr(Peter Maydell)
>     rebase code basing on https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org/
> ---
>  exec.c                    | 47 +++++++++++++++++++++++------------------------
>  include/exec/cpu-all.h    |  2 +-
>  include/exec/cpu-common.h |  8 ++++----
>  include/exec/memory.h     | 22 +++++++++++-----------
>  4 files changed, 39 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
