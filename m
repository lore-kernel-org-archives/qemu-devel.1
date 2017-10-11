Received: from eggs.gnu.org ([2001:4830:134:3::10]:55823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e27Db-0004yq-Rq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e27DY-0007un-Mg
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:57:59 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e27DY-0007u9-Fr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:57:56 -0400
Received: by mail-pg0-x232.google.com with SMTP id b192so248294pga.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 19:57:56 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-10-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5be0991-9dbf-4b84-f7ea-ce257197e9f2@linaro.org>
Date: Tue, 10 Oct 2017 19:57:52 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] target/arm: Implement SG instruction
 corner cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:48 AM, Peter Maydell wrote:
> The common situation of the SG instruction is that it is
> executed from S&NSC memory by a CPU in NS state. That case
> is handled by v7m_handle_execute_nsc(). However the instruction
> also has defined behaviour in a couple of other cases:
>  * SG instruction in NS memory (behaves as a NOP)
>  * SG in S memory but CPU already secure (clears IT bits and
>    does nothing else)
>  * SG instruction in v8M without Security Extension (NOP)
> 
> These can be implemented in translate.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
