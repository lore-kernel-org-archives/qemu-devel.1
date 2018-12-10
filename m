Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQwH-00063z-Eg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQwC-0004S9-Ld
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:09:57 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQwC-0004RR-Ea
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:09:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so11503592otr.10
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 11:09:52 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e67fd1ca-cc67-bc6f-e672-7c84d54b685b@linaro.org>
Date: Mon, 10 Dec 2018 13:09:48 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] target/ppc: convert vaddu[b, h, w,
 d] and vsubu[b, h, w, d] over to use vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 |  8 --------
>  target/ppc/int_helper.c             |  7 -------
>  target/ppc/translate/vmx-impl.inc.c | 16 ++++++++--------
>  3 files changed, 8 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
