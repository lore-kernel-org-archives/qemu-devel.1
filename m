Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3JhI-0000N6-SO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3JhE-0001XX-7C
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:57:20 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
	<1493051615-30715-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3b00cc54-e40f-9dfb-3701-3cda61a6ce8a@twiddle.net>
Date: Wed, 26 Apr 2017 11:57:11 +0200
MIME-Version: 1.0
In-Reply-To: <1493051615-30715-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/3] arm: Use the mmu_idx we're passed in
 arm_cpu_do_unaligned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/24/2017 06:33 PM, Peter Maydell wrote:
> When identifying the DFSR format for an alignment fault, use
> the mmu index that we are passed, rather than calling cpu_mmu_index()
> to get the mmu index for the current CPU state. This doesn't actually
> make any difference since the only cases where the current MMU index
> differs from the index used for the load are the "unprivileged
> load/store" instructions, and in that case the mmu index may
> differ but the translation regime is the same (apart from the
> "use from Hyp mode" case which is UNPREDICTABLE).
> However it's the more logical thing to do.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/op_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
