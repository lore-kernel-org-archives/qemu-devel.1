Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrJ5-0002C9-2U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrJ1-0003bm-8R
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:42:51 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTrJ1-0003bJ-2i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:42:47 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so12203646oth.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:42:46 -0800 (PST)
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db93993f-a034-a22a-56b1-9a44e7c67a35@linaro.org>
Date: Mon, 3 Dec 2018 10:42:42 -0600
MIME-Version: 1.0
In-Reply-To: <1543848532-12604-2-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 1/4] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, philip.li@intel.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/3/18 8:48 AM, Li Zhijian wrote:
> Some address/memory APIs have different type between
> 'hwaddr/target_ulong addr' and 'int len'. It is very unsafety, espcially
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
> 
> ---
> V3: use the same type between len and addr(Peter Maydell)
>     rebase code basing on https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org/
> ---
>  exec.c                    | 47 +++++++++++++++++++++++------------------------
>  include/exec/cpu-all.h    |  2 +-
>  include/exec/cpu-common.h |  8 ++++----
>  include/exec/memory.h     | 22 +++++++++++-----------
>  4 files changed, 39 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
