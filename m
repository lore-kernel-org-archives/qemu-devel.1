Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDaFM-0002YV-HQ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDaFJ-0003Qk-CY
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:43:28 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDaFJ-0003QZ-6A
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:43:25 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so8839685pgq.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:43:25 -0700 (PDT)
References: <20180429235840.16659-1-lvivier@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46927e99-c504-fd3f-cc8e-98f08ef75efb@linaro.org>
Date: Tue, 1 May 2018 11:43:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180429235840.16659-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] tcg: workaround branch instruction
 overflow in tcg_out_qemu_ld/st
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 04/29/2018 04:58 PM, Laurent Vivier wrote:
> ppc64 uses a BC instruction to call the tcg_out_qemu_ld/st
> slow path. BC instruction uses a relative address encoded
> on 14 bits.
> 
> The slow path functions are added at the end of the generated
> instructions buffer, in the reverse order of the callers.
> So more we have slow path functions more the distance between
> the caller (BC) and the function increases.
> 
> This patch changes the behavior to generate the functions in
> the same order of the callers.
> 
> Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Thanks, applied to tcg-next.


r~
