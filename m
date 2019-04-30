Received: from eggs.gnu.org ([209.51.188.92]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2y-0005AD-7X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2x-0002Y4-CN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:56:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW2x-0002Xb-5e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id e92so7004783plb.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:55:59 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-14-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28efda41-0002-c357-7329-55b3ce82d1d4@linaro.org>
Date: Tue, 30 Apr 2019 09:55:48 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/14] target/ppc: improve VSX_TEST_DC with
 new generator macros
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
> The source and destination registers can now be decoded in the generator
> function using the new GEN_VSX_HELPER_X2 and GEN_VSX_HELPER_R2 macros.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 16 +++++++---------
>  target/ppc/helper.h                 |  8 ++++----
>  target/ppc/translate/vsx-impl.inc.c |  8 ++++----
>  3 files changed, 15 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
