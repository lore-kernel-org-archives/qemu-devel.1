Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFuo-0003bD-WB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFul-0004jq-RI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:09:02 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:41823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFul-0004jS-Jr
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:08:59 -0500
Received: by mail-pg0-x230.google.com with SMTP id t4so3362588pgp.8
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:08:59 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <754213bf-131e-546e-a0ac-edf4c77b2e3a@linaro.org>
Date: Fri, 9 Feb 2018 13:08:55 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/11] target/arm: Implement writing to
 CONTROL_NS for v8M
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

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> In commit 50f11062d4c896 we added support for MSR/MRS access
> to the NS banked special registers, but we forgot to implement
> the support for writing to CONTROL_NS. Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
