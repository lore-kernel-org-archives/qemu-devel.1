Received: from eggs.gnu.org ([2001:4830:134:3::10]:42373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08r8-0000ol-RT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08r7-0005tc-OQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:18:38 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:50062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e08r7-0005tS-Hq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:18:37 -0400
Received: by mail-qt0-x22b.google.com with SMTP id o3so26397958qte.6
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:18:37 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c36a6fd8-f3cc-6f7c-6499-32c414e6a4cc@linaro.org>
Date: Thu, 5 Oct 2017 12:18:34 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/20] target/arm: Restore SPSEL to correct
 CONTROL register on exception return
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> On exception return for v8M, the SPSEL bit in the EXC_RETURN magic
> value should be restored to the SPSEL bit in the CONTROL register
> banked specified by the EXC_RETURN.ES bit.
> 
> Add write_v7m_control_spsel_for_secstate() which behaves like
> write_v7m_control_spsel() but allows the caller to specify which
> CONTROL bank to use, reimplement write_v7m_control_spsel() in
> terms of it, and use it in exception return.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
