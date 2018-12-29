Received: from eggs.gnu.org ([208.118.235.92]:43710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdMKl-0004zS-FM
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdMKg-0006sj-Iq
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:39:51 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdMKg-0006qZ-9Q
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:39:46 -0500
Received: by mail-pg1-x544.google.com with SMTP id g189so11384568pgc.5
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 13:39:46 -0800 (PST)
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20181228135235.6859-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df897522-d470-8062-5fe7-6e8811c06b42@linaro.org>
Date: Sun, 30 Dec 2018 08:39:38 +1100
MIME-Version: 1.0
In-Reply-To: <20181228135235.6859-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/8] target/ppc: remove ROTRu32 and
 ROTRu64 macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/29/18 12:52 AM, Mark Cave-Ayland wrote:
> Richard points out that these macros suffer from a -fsanitize=shift bug in that
> they improperly handle n == 0 turning it into a shift by 32/64 respectively.
> Replace them with QEMU's existing ror32() and ror64() functions instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 48 ++++++++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
