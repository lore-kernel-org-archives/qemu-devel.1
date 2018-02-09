Received: from eggs.gnu.org ([2001:4830:134:3::10]:36680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFN3-0006J6-QV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFN0-0005I2-Mj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:34:09 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFN0-0005Hf-HX
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:34:06 -0500
Received: by mail-it0-x244.google.com with SMTP id p139so12501649itb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:34:06 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18537b84-7150-01ca-bca9-29abb99d7f58@linaro.org>
Date: Fri, 9 Feb 2018 12:34:02 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/11] hw/intc/armv7m_nvic: Implement M
 profile cache maintenance ops
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
> For M profile cores, cache maintenance operations are done by
> writing to special registers in the system register space.
> For QEMU, cache operations are always NOPs, since we don't
> implement the cache. Implementing these explicitly avoids
> a spurious LOG_GUEST_ERROR when the guest uses them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
