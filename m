Received: from eggs.gnu.org ([2001:4830:134:3::10]:37337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFQ6-0000iz-T0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFQ1-0006gX-UE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:37:18 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFQ1-0006fz-O4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:37:13 -0500
Received: by mail-pl0-x244.google.com with SMTP id ay8so1980325plb.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:37:13 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f40e2494-0216-6452-f7ed-b7e4cacc8960@linaro.org>
Date: Fri, 9 Feb 2018 12:37:10 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/11] hw/intc/armv7m_nvic: Implement
 v8M CPPWR register
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
> The Coprocessor Power Control Register (CPPWR) is new in v8M.
> It allows software to control whether coprocessors are allowed
> to power down and lose their state. QEMU doesn't have any
> notion of power control, so we choose the IMPDEF option of
> making the whole register RAZ/WI (indicating that no coprocessors
> can ever power down and lose state).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
