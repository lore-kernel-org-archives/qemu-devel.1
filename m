Received: from eggs.gnu.org ([209.51.188.92]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDpU-0008Fs-B5
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDpT-0005ZU-88
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:24:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grDpR-0005LY-6j
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:24:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id y139so968922wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 19:24:32 -0800 (PST)
References: <20190205181218.8995-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d455efb4-e64e-dbda-621e-a714dd6c7df2@linaro.org>
Date: Wed, 6 Feb 2019 03:24:28 +0000
MIME-Version: 1.0
In-Reply-To: <20190205181218.8995-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement HACR_EL2
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

On 2/5/19 6:12 PM, Peter Maydell wrote:
> HACR_EL2 is a register with IMPDEF behaviour, which allows
> implementation specific trapping to EL2. Implement it as RAZ/WI,
> since QEMU's implementation has no extra traps. This also
> matches what h/w implementations like Cortex-A53 and A57 do.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
