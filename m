Received: from eggs.gnu.org ([2001:4830:134:3::10]:57797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQ4y-0007ag-Jv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQ4u-0002v5-LE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:52 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:34467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQ4n-0002qS-RQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:44 -0500
Received: by mail-oi1-x230.google.com with SMTP id h25so9790786oig.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:14:37 -0800 (PST)
References: <20181210173350.13073-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4271875c-faeb-ca7f-413c-df085b4a7da6@linaro.org>
Date: Mon, 10 Dec 2018 12:14:33 -0600
MIME-Version: 1.0
In-Reply-To: <20181210173350.13073-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] hw/alpha/typhoon: Stop calling
 cpu_unassigned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 12/10/18 11:33 AM, Peter Maydell wrote:
> The typhoon MemoryRegionOps callbacks directly call
> cpu_unassigned_access(), presumably as the old-fashioned way
> to provoke a CPU exception.  This won't work since commit
> 6ad4d7eed05a1e235 when we switched Alpha over to the
> transaction_failed hook API, because now cpu_unassigned_access()
> is a no-op for Alpha.

Oops.

> Make the MemoryRegionOps callbacks use the read_with_attrs
> and write_with_attrs hooks, so they can signal a failure
> that should cause a CPU exception by returning MEMTX_ERROR.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> RFC because untested, since I don't have an alpha test image.
> 
>  hw/alpha/typhoon.c | 47 ++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.  Thanks.


r~
