Received: from eggs.gnu.org ([2001:4830:134:3::10]:49824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2fO-0003Yz-K3
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2fM-00036x-ER
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:03:26 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ga2fG-0002u8-Iq
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:03:18 -0500
Received: by mail-pl1-x642.google.com with SMTP id w4so1238425plz.1
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 10:03:10 -0800 (PST)
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
	<20181220163123.9233-10-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <068c98c7-7279-46cf-771b-a6addf3f4145@linaro.org>
Date: Thu, 20 Dec 2018 10:03:07 -0800
MIME-Version: 1.0
In-Reply-To: <20181220163123.9233-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] target/ppc: replace AVR* macros
 with Vsr* macros
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
> Now that the VMX and VSR register sets have been combined, the same macros can
> be used to access both AVR and VSR field members.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 38 +++++++++++++-------------------------
>  target/ppc/internal.h   |  4 ++++
>  2 files changed, 17 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>  #if defined(HOST_WORDS_BIGENDIAN)
> +#define HI_IDX 0
> +#define LO_IDX 1
>  #define VsrB(i) u8[i]
>  #define VsrH(i) u16[i]
>  #define VsrW(i) u32[i]
>  #define VsrD(i) u64[i]

Since this is in internal.h, we can use it elsewhere than just helpers.  E.g.
if you sort some patches earlier, you could use it in get_avr64 instead of ifdefs.


r~
