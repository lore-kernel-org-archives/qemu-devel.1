Received: from eggs.gnu.org ([2001:4830:134:3::10]:52158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BOj-0006hc-Vb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BOe-0000iq-DW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:01:30 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:46559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0BOe-0000iV-7m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:01:24 -0400
Received: by mail-qt0-x231.google.com with SMTP id 6so18207465qtw.3
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:01:24 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-21-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e3d42e9-a660-6a8a-067a-f31a93ad669a@linaro.org>
Date: Thu, 5 Oct 2017 15:01:20 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-21-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/20] nvic: Add missing code for writing
 SHCSR.HARDFAULTPENDED bit
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

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> When we added support for the new SHCSR bits in v8M in commit
> 437d59c17e9 the code to support writing to the new HARDFAULTPENDED
> bit was accidentally only added for non-secure writes; the
> secure banked version of the bit should also be writable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
