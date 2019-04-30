Received: from eggs.gnu.org ([209.51.188.92]:39265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2T-0004E1-Se
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVpA-0003du-9E
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:41:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVpA-0003dI-2F
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:41:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so6985171plr.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:41:43 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a60992b-d6db-4761-38fa-bb413f69d3ae@linaro.org>
Date: Tue, 30 Apr 2019 09:41:37 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/14] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
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
> introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
> upon xA and xB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 15 ++++++---------
>  target/ppc/helper.h                 | 12 ++++++------
>  target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
>  3 files changed, 36 insertions(+), 21 deletions(-)

This time I see VSX_TDIV right away as a place that still
uses opcode.  It can certainly be cleaned up, but that's
a different patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
