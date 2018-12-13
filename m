Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZ5X-0004gQ-Ed
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZ5J-0005eg-BC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:04:05 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXZ5H-0002tO-IG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:03:56 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so2946314oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:02:58 -0800 (PST)
References: <20181213183249.3468-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <090c809e-bdf5-37a4-ef80-d03abd44ec9d@linaro.org>
Date: Thu, 13 Dec 2018 16:02:48 -0600
MIME-Version: 1.0
In-Reply-To: <20181213183249.3468-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/misc/tz-mpc: Fix value of BLK_MAX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 12/13/18 12:32 PM, Peter Maydell wrote:
> In the TZ Memory Protection Controller, the BLK_MAX register is supposed
> to return the maximum permitted value of the BLK_IDX register. Our
> implementation incorrectly returned max+1 (ie the total number of
> valid index values, since BLK_IDX is zero-based).
> 
> Correct this off-by-one error. Since we consistently initialize
> and use s->blk_max throughout the implementation as the 'size'
> of the LUT, just adjust the value we return when the guest reads
> the BLK_MAX register, rather than trying to change the semantics
> of the s->blk_max internal struct field.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1806824
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/tz-mpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
