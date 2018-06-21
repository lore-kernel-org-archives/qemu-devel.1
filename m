Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnY-0005bp-Ht
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnX-0000R5-Nm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:44 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWCnX-0000QL-Iq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:43 -0400
Received: by mail-pl0-x242.google.com with SMTP id g20-v6so2768146plq.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:31:43 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-6-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e0c099a-99fe-082c-f7c6-1817c385b6d3@linaro.org>
Date: Thu, 21 Jun 2018 16:48:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-6-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/35] target/mips: Add nanoMIPS 16bit
 ld/st instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> Add nanoMIPS 16bit load and store instructions
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/translate.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 633d0b4..f5b7e14 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16207,6 +16207,14 @@ static int mmreg_nanomips(int r)
>      return map[r & 0x7];
>  }
>  
> +/* Used for 16-bit store instructions.  */
> +static int mmreg2_nanomips(int r)
> +{
> +    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
> +
> +    return map[r & 0x7];

This is called gpr3.src.store in the manual.
Why the name change to "reg2"?


r~
