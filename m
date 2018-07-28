Received: from eggs.gnu.org ([2001:4830:134:3::10]:40833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSJ2-0002rv-NQ
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSIz-0007Kj-L7
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:43:00 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fjSIz-0007IV-6t
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:42:57 -0400
Received: by mail-pl0-x244.google.com with SMTP id m16-v6so3622426pls.11
	for <qemu-devel@nongnu.org>; Sat, 28 Jul 2018 09:42:56 -0700 (PDT)
References: <20180727113854.20283-1-peter.maydell@linaro.org>
	<20180727113854.20283-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bae88ea9-5bbd-8abf-fd29-258b578f11d1@linaro.org>
Date: Sat, 28 Jul 2018 09:42:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180727113854.20283-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/2] armv7m_nvic: Fix m-security
 subsection name
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

On 07/27/2018 04:38 AM, Peter Maydell wrote:
> The vmstate save/load code insists that subsections of a VMState must
> have names which include their parent VMState's name as a leading
> substring.  Unfortunately it neither documents this nor checks it on
> device init or state save, but instead fails state load with a
> confusing error message ("Missing section footer for armv7m_nvic").
> 
> Fix the name of the m-security subsection of the NVIC, so that
> state save/load works correctly for the security-enabled NVIC.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
