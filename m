Received: from eggs.gnu.org ([2001:4830:134:3::10]:58699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fMCbb-0003aM-5E
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fMCbW-0004tV-UX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:18:03 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1527229488-49822-1-git-send-email-mjc@sifive.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <83728e91-de69-c376-a768-0aad501ff64e@twiddle.net>
Date: Fri, 25 May 2018 06:17:53 -0700
MIME-Version: 1.0
In-Reply-To: <1527229488-49822-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Correct typo in RV32 perf counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org

On 05/24/2018 11:24 PM, Michael Clark wrote:
> This patch enables mhpmcounter3h through mhpmcounter31h on RV32.
> Previously the RV32 h versions (high 32-bits of 64-bit counters)
> of these counters would trap with an illegal instruction instead
> of returning 0 as intended.
> 
> Reported-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: Coverity CID 1390849
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
