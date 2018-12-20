Received: from eggs.gnu.org ([2001:4830:134:3::10]:42817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2J2-0005Jl-89
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2J0-0001I9-Nz
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:20 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ga2J0-0001H7-GJ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:18 -0500
Received: by mail-pf1-x442.google.com with SMTP id b7so1249833pfi.8
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:40:18 -0800 (PST)
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
	<20181220163123.9233-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <836f76f4-5877-4b99-6233-31fab9a6817c@linaro.org>
Date: Thu, 20 Dec 2018 09:40:14 -0800
MIME-Version: 1.0
In-Reply-To: <20181220163123.9233-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] target/ppc: switch EXTRACT_HELPER
 macros over to use sextract32/extract32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/20/18 8:31 AM, Mark Cave-Ayland wrote:
> These ensure that we consistently handle signed and unsigned extensions correctly
> when decoding immediates from instruction opcodes.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/internal.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
