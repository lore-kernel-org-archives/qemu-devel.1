Received: from eggs.gnu.org ([2001:4830:134:3::10]:40391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmjQV-000835-CG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmjQQ-0008Ra-Co
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:43 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmjQQ-0008QR-5W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:38 -0400
Received: by mail-pg0-x231.google.com with SMTP id y15so12309525pgc.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:31:38 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-21-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cdc8025-089e-2a02-24cf-e8a02ae42bb6@linaro.org>
Date: Tue, 29 Aug 2017 09:31:34 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-21-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/20] target/arm: Implement BXNS,
 and banked stack pointers
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Implement the BXNS v8M instruction, which is like BX but will do a
> jump-and-switch-to-NonSecure if the branch target address has bit 0
> clear.
> 
> This is the first piece of code which implements "switch to the
> other security state", so the commit also includes the code to
> switch the stack pointers around, which is the only complicated
> part of switching security state.
> 
> BLXNS is more complicated than just "BXNS but set the link register",
> so we leave it for a separate commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 13 +++++++++
>  target/arm/helper.h    |  2 ++
>  target/arm/translate.h |  1 +
>  target/arm/helper.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/machine.c   |  2 ++
>  target/arm/translate.c | 42 ++++++++++++++++++++++++++-
>  6 files changed, 138 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
