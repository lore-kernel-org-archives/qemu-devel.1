Received: from eggs.gnu.org ([209.51.188.92]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xg7-0005Vq-RW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xg7-0002xR-3z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:23:35 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1xg6-0002uP-Qx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:23:35 -0500
Received: by mail-pf1-x443.google.com with SMTP id n125so12062108pfn.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:23:34 -0800 (PST)
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8497b2bc-8789-1e0c-dcdc-06e34fa92275@linaro.org>
Date: Thu, 7 Mar 2019 10:23:30 -0800
MIME-Version: 1.0
In-Reply-To: <20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] target/ppc: move Vsr* macros from
 internal.h to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
> It isn't possible to include internal.h from cpu.h so move the Vsr* macros
> into cpu.h alongside the other VMX/VSX register access functions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h      | 20 ++++++++++++++++++++
>  target/ppc/internal.h | 19 -------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)

Although to some extent I think we should be minimizing the amount
of code within cpu.h, to avoid rebuilding the world.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
