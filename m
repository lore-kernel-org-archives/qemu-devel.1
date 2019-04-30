Received: from eggs.gnu.org ([209.51.188.92]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2K-0004C1-ON
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVza-0000NH-TF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVza-0000Mh-O5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so2045698pfk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:30 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-11-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45ae496e-eb58-9bd8-a96a-e1620a792d9e@linaro.org>
Date: Tue, 30 Apr 2019 09:52:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] target/ppc: introduce
 GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_R2_AB macro which performs the decode based
> upon rA and rB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 10 ++++------
>  target/ppc/helper.h                 |  6 +++---
>  target/ppc/translate/vsx-impl.inc.c | 24 +++++++++++++++++++++---
>  3 files changed, 28 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
