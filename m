Received: from eggs.gnu.org ([2001:4830:134:3::10]:56428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2f8h-0006ZA-0P
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2f8d-0004RQ-1I
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:11:10 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2f8c-0004QJ-Qi
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:11:06 -0400
Received: by mail-pf0-x232.google.com with SMTP id 17so5218665pfn.12
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 08:11:06 -0700 (PDT)
References: <1507742676-9908-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <00fd7671-5d50-98a0-dc5e-b890489502a8@linaro.org>
Date: Thu, 12 Oct 2017 08:11:03 -0700
MIME-Version: 1.0
In-Reply-To: <1507742676-9908-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvic: Add missing 'break'
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

On 10/11/2017 10:24 AM, Peter Maydell wrote:
> Coverity points out that we forgot the 'break' for
> the SAU_CTRL write case (CID1381683). This has
> no actual visible consequences because it happens
> that the following case is effectively a no-op.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
