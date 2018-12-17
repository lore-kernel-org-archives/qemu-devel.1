Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYw3W-000235-0z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYw3R-0004c3-6i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:47:45 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYw3Q-0004b9-VX
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:47:41 -0500
Received: by mail-pf1-x444.google.com with SMTP id 64so6634675pfr.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:47:40 -0800 (PST)
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e293e63-cb5f-3f0a-ee01-ae9941af5914@linaro.org>
Date: Mon, 17 Dec 2018 08:47:37 -0800
MIME-Version: 1.0
In-Reply-To: <20181217122405.18732-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/9] target/ppc: merge ppc_vsr_t and
 ppc_avr_t union types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 12/17/18 4:24 AM, Mark Cave-Ayland wrote:
> Since the VSX registers are actually a superset of the VMX registers then they
> can be represented by the same type. Merge ppc_avr_t into ppc_vsr_t and change
> ppc_avr_t to be a simple typedef alias.
> 
> Note that due to a difference in the naming of the float32 member between
> ppc_avr_t and ppc_vsr_t, references to the ppc_avr_t f member must be replaced
> with f32 instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h        | 17 ++++++++-------
>  target/ppc/int_helper.c | 56 +++++++++++++++++++++++++------------------------
>  target/ppc/internal.h   | 11 ----------
>  3 files changed, 39 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
