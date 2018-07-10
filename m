Received: from eggs.gnu.org ([2001:4830:134:3::10]:59836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxRi-0005yp-Ky
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxRf-0006Sv-JP
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:33:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-6-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <09c87542-9178-6277-85d3-6a5830616e88@twiddle.net>
Date: Tue, 10 Jul 2018 11:33:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] accel/tcg: Return -1 for execution
 from MMIO regions in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/10/2018 09:00 AM, Peter Maydell wrote:
> Now that all the callers can handle get_page_addr_code() returning -1,
> remove all the code which tries to handle execution from MMIO regions
> or small-MMU-region RAM areas. This will mean that we can correctly
> execute from these areas, rather than ending up either aborting QEMU
> or delivering an incorrect guest exception.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cputlb.c | 95 +++++-----------------------------------------
>  1 file changed, 10 insertions(+), 85 deletions(-)

Yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
