Received: from eggs.gnu.org ([2001:4830:134:3::10]:59117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2Rg-0002mi-7N
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2Rf-0005OY-Fe
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:54:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2Rf-0005Nj-6r
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:54:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id v13-v6so3511506pgr.10
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:54:03 -0700 (PDT)
References: <20180724115950.17316-1-peter.maydell@linaro.org>
	<20180724115950.17316-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2c14d35-19fc-ecdf-75d3-aa518747c62f@linaro.org>
Date: Tue, 24 Jul 2018 11:53:59 -0700
MIME-Version: 1.0
In-Reply-To: <20180724115950.17316-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/arm: Honour HCR_EL2.TGE when
 raising synchronous exceptions
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
> Whene we raise a synchronous exception, if HCR_EL2.TGE is set then
> exceptions targeting NS EL1 must be redirected to EL2.  Implement
> this in raise_exception() -- all synchronous exceptions go through
> this function.
> 
> (Asynchronous exceptions go via arm_cpu_exec_interrupt(), which
> already honours HCR_EL2.TGE when it determines the target EL
> in arm_phys_excp_target_el().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/op_helper.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
