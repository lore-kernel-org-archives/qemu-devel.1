Received: from eggs.gnu.org ([209.51.188.92]:54406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsA7h-0000yV-AC
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsA7f-0002pt-FG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:39:32 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsA7f-0002or-7B
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:39:31 -0500
Received: by mail-pl1-x643.google.com with SMTP id k15so2003545pls.8
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 09:39:30 -0800 (PST)
References: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ed73de0-9d3b-8e7c-cda1-1c759ba969f2@linaro.org>
Date: Fri, 8 Feb 2019 09:39:25 -0800
MIME-Version: 1.0
In-Reply-To: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: fix unsigned vector saturating
 arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 2/7/19 2:42 PM, Mark Cave-Ayland wrote:
> Due to a cut/paste error in the original implementation, the unsigned vector
> saturating arithmetic was erroneously being calculated as signed vector saturating
> arithmetic.
> 
> Fixes: 8ffafbcec2 ("tcg/i386: Implement vector saturating arithmetic")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  tcg/i386/tcg-target.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ooof.  Thanks.


r~
