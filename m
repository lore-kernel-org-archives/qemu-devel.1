Received: from eggs.gnu.org ([208.118.235.92]:41756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtEP-0007iq-N6
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtEK-0002PC-9S
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:23:13 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtEJ-0002OW-RD
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:23:08 -0500
Received: by mail-pg1-x543.google.com with SMTP id v28so6793525pgk.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:23:07 -0800 (PST)
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
	<20181223113859.3675-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3c2ad803-e68e-95f2-13e0-dda02ca7632d@linaro.org>
Date: Wed, 26 Dec 2018 07:22:59 +1100
MIME-Version: 1.0
In-Reply-To: <20181223113859.3675-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/ppc: eliminate use of EL_IDX
 macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/23/18 10:38 PM, Mark Cave-Ayland wrote:
> These macros can be eliminated by instead using the relavant Vsr* macros in
> the few locations where they appear.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 66 ++++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> -#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32-n)))
> +#define ROTRu32(v, n) (((v) >> (n)) | ((v) << (32 - n)))

For a different patch, this is ror32().

This version contains a -fsanitize=shift bug, in that it improperly handles n
== 0 into a shift by 32.


>  #define ROTRu64(v, n) (((v) >> (n)) | ((v) << (64-n)))

Similarly.


r~
