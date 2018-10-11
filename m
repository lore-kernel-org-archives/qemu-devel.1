Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAf19-0006Es-9e
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAf15-0006Bi-4K
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAf12-0006AO-Pp
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id v133-v6so4523656pgb.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 10:44:52 -0700 (PDT)
References: <20181011172057.9466-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec34b8bd-0939-4ab9-b94f-08ab4a3c10cf@linaro.org>
Date: Thu, 11 Oct 2018 10:44:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181011172057.9466-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Initialize ARMMMUFaultInfo in
 v7m_stack_read/write
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

On 10/11/18 10:20 AM, Peter Maydell wrote:
> The get_phys_addr() functions take a pointer to an ARMMMUFaultInfo
> struct, which they fill in only if a fault occurs. This means that
> the caller must always zero-initialize the struct before passing
> it in. We forgot to do this in v7m_stack_read() and v7m_stack_write().
> Correct the error.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Noticed this in passing while I was working in the file on
> an entirely different issue.
> 
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
