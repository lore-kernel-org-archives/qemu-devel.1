Received: from eggs.gnu.org ([208.118.235.92]:48680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdMfT-0001NV-IV
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdMRp-0006ho-6n
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:47:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdMRn-0006d5-8C
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 16:47:08 -0500
Received: by mail-pf1-x442.google.com with SMTP id z9so11856210pfi.2
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 13:47:06 -0800 (PST)
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20181228135235.6859-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32d08033-be02-5c28-5114-8c077b46c54f@linaro.org>
Date: Sun, 30 Dec 2018 08:46:58 +1100
MIME-Version: 1.0
In-Reply-To: <20181228135235.6859-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] target/ppc: remove various
 HOST_WORDS_BIGENDIAN hacks in int_helper.c
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
> Following on from the previous work, there are numerous endian-related hacks
> in int_helper.c that can now be replaced with Vsr* macros.
> 
> There are also a few places where the VECTOR_FOR_INORDER_I macro can be
> replaced with a normal iterator since the processing order is irrelevant.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 155 ++++++++++++++----------------------------------
>  1 file changed, 45 insertions(+), 110 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
