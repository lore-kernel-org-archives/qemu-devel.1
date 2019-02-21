Received: from eggs.gnu.org ([209.51.188.92]:45703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwt2V-0007SK-Pr
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwt2V-0002kS-6o
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:25:43 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:43355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwt2T-0002gX-9P
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:25:43 -0500
Received: by mail-pg1-x536.google.com with SMTP id l11so2637929pgq.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:25:39 -0800 (PST)
References: <20190221093459.22547-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4af8afe9-c489-0988-91ff-ea9d2fd1d17a@linaro.org>
Date: Thu, 21 Feb 2019 10:25:35 -0800
MIME-Version: 1.0
In-Reply-To: <20190221093459.22547-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] include/exec/helper-head.h: support
 "const void *" in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/21/19 1:34 AM, David Hildenbrand wrote:
> Especially when dealing with out-of-line gvec helpers, it is often
> helpful to specify some vector pointers as constant. E.g. when
> we have two inputs and one output, marking the two inputs as consts
> pointers helps to avoid bugs.
> 
> Const pointers can be specified via "cptr", however behave in TCG just
> like ordinary pointers. We can specify helpers like:
> 
> DEF_HELPER_FLAGS_4(gvec_vbperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
> 
> void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
>                          uint32_t desc)
> 
> And make sure that here, only v1 will be written (as long as const is
> not casted away, of course).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/helper-head.h | 5 +++++
>  1 file changed, 5 insertions(+)

Queued, thanks.


r~
