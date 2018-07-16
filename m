Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ff5RI-0002Cr-8w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ff5RF-0006rd-7o
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:29:28 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ff5RE-0006rN-TK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:29:25 -0400
Received: by mail-pl0-x244.google.com with SMTP id e11-v6so2451604plb.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 08:29:24 -0700 (PDT)
References: <20180713141636.18665-1-peter.maydell@linaro.org>
	<20180713141636.18665-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5e32655-f383-2f0a-6cb1-7a7228c7e697@linaro.org>
Date: Mon, 16 Jul 2018 08:29:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180713141636.18665-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/2] accel/tcg: Assert that tlb
 fill gave us a valid TLB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 07/13/2018 07:16 AM, Peter Maydell wrote:
> In commit 4b1a3e1e34ad97 we added a check for whether the TLB entry
> we had following a tlb_fill had the INVALID bit set.  This could
> happen in some circumstances because a stale or wrong TLB entry was
> pulled out of the victim cache.  However, after commit
> 68fea038553039e (which prevents stale entries being in the victim
> cache) and the previous commit (which ensures we don't incorrectly
> hit in the victim cache)) this should never be possible.
> 
> Drop the check on TLB_INVALID_MASK from the "is this a TLB_RECHECK?"
> condition, and instead assert that the tlb fill procedure has given
> us a valid TLB entry (or longjumped out with a guest exception).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
