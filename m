Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxPV-0004bX-W6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxPS-0003m6-Pm
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:30:49 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-5-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fb6279a8-26b4-66c8-57da-4882e0121e76@twiddle.net>
Date: Tue, 10 Jul 2018 11:30:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] accel/tcg: tb_gen_code(): Create
 single-insn TB for execution from non-RAM
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
> If get_page_addr_code() returns -1, this indicates that there is no RAM
> page we can read a full TB from. Instead we must create a TB which
> contains a single instruction and which we do not cache, so it is
> executed only once.
> 
> Since this means we can now have TBs which are not in any page list,
> we also need to make tb_phys_invalidate() handle them (by not trying
> to remove them from a nonexistent page list).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/translate-all.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
