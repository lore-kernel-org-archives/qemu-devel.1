Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpQU-00043X-72
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpQT-00028q-Go
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:42:22 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTpQT-00028M-Cc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:42:21 -0500
Received: by mail-oi1-x242.google.com with SMTP id m6so11055915oig.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:42:21 -0800 (PST)
MIME-Version: 1.0
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1543848532-12604-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 14:42:08 +0000
Message-ID: <CAFEAcA_C2+p-04u0pUo3HY9_pC=J4nLiJV9gaRFESDR-az1f7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Mon, 3 Dec 2018 at 14:39, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
