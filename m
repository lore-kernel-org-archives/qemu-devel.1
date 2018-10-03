Received: from eggs.gnu.org ([2001:4830:134:3::10]:47643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7naT-0003yd-0d
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7naP-0005J0-BQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:17:36 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7naO-0005Hj-KG
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:17:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id l197-v6so5627079oib.8
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:17:32 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e1f68c9-e878-8f75-d38f-7b73dd718a7a@linaro.org>
Date: Wed, 3 Oct 2018 15:17:28 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/13] target/arm: Add v8M stack checks for
 Thumb2 LDM/STM
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Add the v8M stack checks for:
>  * LDM (T2 encoding)
>  * STM (T2 encoding)
> 
> This includes the 32-bit encodings of the instructions listed
> in v8M ARM ARM rule R_YVWT as
>  * LDM, LDMIA, LDMFD
>  * LDMDB, LDMEA
>  * POP (multiple registers)
>  * PUSH (muliple registers)
>  * STM, STMIA, STMEA
>  * STMDB, STMFD
> 
> We perform the stack limit before doing any other part
> of the load or store.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
