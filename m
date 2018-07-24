Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2Pk-0001Uz-Vl
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2Pk-00032T-67
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2Pj-0002zB-SY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:52:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id r1-v6so3506195pgp.11
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:52:03 -0700 (PDT)
References: <20180724115950.17316-1-peter.maydell@linaro.org>
	<20180724115950.17316-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d9a84683-1b25-be79-74f0-d2fb68b20a97@linaro.org>
Date: Tue, 24 Jul 2018 11:51:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180724115950.17316-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/arm: Treat SCTLR_EL1.M as if it
 were zero when HCR_EL2.TGE is set
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

On 07/24/2018 04:59 AM, Peter Maydell wrote:
> One of the required effects of setting HCR_EL2.TGE is that when
> SCR_EL3.NS is 1 then SCTLR_EL1.M must behave as if it is zero for
> all purposes except direct reads. That is, it effectively disables
> the MMU for the NS EL0/EL1 translation regime.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
