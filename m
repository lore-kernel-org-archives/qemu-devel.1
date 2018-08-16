Received: from eggs.gnu.org ([2001:4830:134:3::10]:36197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKAX-00059D-20
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKAP-0008CC-5I
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:26:34 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKAO-0008Ag-H2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:26:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id z8-v6so2218094pgu.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:26:26 -0700 (PDT)
References: <20180816120533.6587-1-rka@sysgo.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c7635af2-963f-6887-9042-7843655dc7a7@linaro.org>
Date: Thu, 16 Aug 2018 08:26:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180816120533.6587-1-rka@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: crash on conditional instr
 in it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/16/2018 05:05 AM, Roman Kapl wrote:
> If an instruction is conditional (like CBZ) and it is executed conditionally
> (using the ITx instruction), a jump to undefined label is generated.
> CBZ in IT block is an unpredictable behavior, and honouring the condition code
> is allowed by the spec in this case (constrained unpredictable, ARMv8, section
> K1.1.7).
> 
> Fix the 'skip on condtion' code to create a new label only if it does not
> already exist. Previously multiple labels were created, but only the last one of
> them was set.
> 
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
> v1 -> v2
>  Split arm_conditional_skip into arm_gen_condlabel and arm_skip_unless to
>  a) cover all usages
>  b) do not force callers to ^1 the condition
> 
>  Add note about CBZ in IT block to the commit message.
> 
>  target/arm/translate.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
