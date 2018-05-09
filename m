Received: from eggs.gnu.org ([2001:4830:134:3::10]:39332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fGHHe-0005zG-AH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fGHHZ-0008W9-UO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:04:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fGHHZ-0008Uw-NQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:04:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id o4-v6so34361532wrm.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 22:04:53 -0700 (PDT)
References: <20180508203937.16796-1-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <0048408f-666d-6771-a4fa-7a92835f17bf@tuxfamily.org>
Date: Wed, 9 May 2018 07:04:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180508203937.16796-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] m68k: fix floatx80_mod() (Coverity
 CID1390568)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 08.05.2018 22:39, Laurent Vivier wrote:
> Update the variable checked by the loop condition (expDiff).
> Backport the update from Previous.
> 
> Fixes: 591596b77a ("target/m68k: add fmod/frem")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/softfloat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
> index e41b07d042..d093997219 100644
> --- a/target/m68k/softfloat.c
> +++ b/target/m68k/softfloat.c
> @@ -103,6 +103,7 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
>          mul64To128(bSig, qTemp, &term0, &term1);
>          sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
>          shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
> +        expDiff -= 62;
>      }
>      expDiff += 64;
>      if (0 < expDiff) {

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
