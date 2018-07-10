Received: from eggs.gnu.org ([2001:4830:134:3::10]:58351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxMg-0002DE-K7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxMd-0002Qc-Gs
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:27:54 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-4-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e24ed93f-e386-ec00-0d83-1bd5b68db0e0@twiddle.net>
Date: Tue, 10 Jul 2018 11:27:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] accel/tcg: Handle get_page_addr_code()
 returning -1 in tb_check_watchpoint()
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
> When we support execution from non-RAM MMIO regions, get_page_addr_code()
> will return -1 to indicate that there is no RAM at the requested address.
> Handle this in tb_check_watchpoint() -- if the exception happened for a
> PC which doesn't correspond to RAM then there is no need to invalidate
> any TBs, because the one-instruction TB will not have been cached.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/translate-all.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
