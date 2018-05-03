Received: from eggs.gnu.org ([2001:4830:134:3::10]:42593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEIU2-0006wb-Ce
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEITy-0004l2-Ej
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:57:34 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEITy-0004kG-9d
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:57:30 -0400
Received: by mail-pg0-x244.google.com with SMTP id m21-v6so13660062pgv.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:57:30 -0700 (PDT)
References: <20180503105730.5958-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <deba008a-1a79-37b3-e908-86d348640017@linaro.org>
Date: Thu, 3 May 2018 10:57:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180503105730.5958-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement v8M VLLDM and VLSTM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org

On 05/03/2018 03:57 AM, Peter Maydell wrote:
> For v8M the instructions VLLDM and VLSTM support lazy saving
> and restoring of the secure floating-point registers. Even
> if the floating point extension is not implemented, these
> instructions must act as NOPs in Secure state, so they can
> be used as part of the secure-to-nonsecure call sequence.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1768295
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Worth cc'ing stable on this one because gcc and clang will
> emit this insn when calling functions with the cmse_nonsecure_call
> attribute.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
