Received: from eggs.gnu.org ([209.51.188.92]:57619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ2VH-0005AK-Lq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ2VG-0002BI-LV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:58:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ2VE-00029u-Mr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:58:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id v2so5781619pge.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:58:56 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f380f5c-f65b-49ba-7af8-f1c84b2fba7e@linaro.org>
Date: Tue, 23 Apr 2019 13:58:52 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/26] target/arm: Clear CONTROL_S.SFPA in
 SG insn if FPU present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> If the floating point extension is present, then the SG instruction
> must clear the CONTROL_S.SFPA bit. Implement this.
> 
> (On a no-FPU system the bit will always be zero, so we don't need
> to make the clearing of the bit conditional on ARM_FEATURE_VFP.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
