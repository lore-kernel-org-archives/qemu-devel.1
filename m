Received: from eggs.gnu.org ([2001:4830:134:3::10]:46106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftbAA-00043P-8W
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftauq-0003vZ-Tb
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 11:55:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftauq-0003v8-NC
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 11:55:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id z25-v6so5585479pgu.7
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 08:55:56 -0700 (PDT)
References: <20180824170422.5783-1-peter.maydell@linaro.org>
	<20180824170422.5783-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93a8de9e-b5c6-fdae-05a8-e0a8717e24d1@linaro.org>
Date: Sat, 25 Aug 2018 08:55:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180824170422.5783-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] memory: Remove old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 08/24/2018 10:04 AM, Peter Maydell wrote:
> Now that all the users of old_mmio MemoryRegion accessors
> have been converted, we can remove the core code support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/memory.txt |  2 --
>  include/exec/memory.h |  5 ----
>  memory.c              | 64 ++-----------------------------------------
>  3 files changed, 2 insertions(+), 69 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
