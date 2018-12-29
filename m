Received: from eggs.gnu.org ([208.118.235.92]:36875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdLyE-0007dL-Fv
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdLwH-0005c4-6E
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:14:36 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdLwG-0005Zg-Vj
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:14:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id u6so11825029pfh.11
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 13:14:32 -0800 (PST)
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20181228135235.6859-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f99e36e2-ad04-88cc-88c8-3f8fcafcb108@linaro.org>
Date: Sun, 30 Dec 2018 08:14:25 +1100
MIME-Version: 1.0
In-Reply-To: <20181228135235.6859-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] target/ppc: simplify VEXT_SIGNED
 macro in int_helper.c
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
> As pointed out by Richard: it does not need the mask argument, nor does it need
> the recast argument. The masking is implied by the cast argument, and the
> recast is implied by the assignment.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
