Received: from eggs.gnu.org ([2001:4830:134:3::10]:38879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nK6-0008Hf-JJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nK1-0004LA-DB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:00:42 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:39518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nK0-0004CR-C5
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:00:36 -0400
Received: by mail-it1-x141.google.com with SMTP id w200-v6so10750785itc.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:00:12 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e70755b0-b09b-f324-45fd-e64663bc9aae@linaro.org>
Date: Wed, 3 Oct 2018 15:00:06 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/13] target/arm: Add v8M stack checks on
 ADD/SUB/MOV of SP
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
> Add code to insert calls to a helper function to do the stack
> limit checking when we handle these forms of instruction
> that write to SP:
>  * ADD (SP plus immediate)
>  * ADD (SP plus register)
>  * SUB (SP minus immediate)
>  * SUB (SP minus register)
>  * MOV (register)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h    |  2 ++
>  target/arm/internals.h | 14 ++++++++
>  target/arm/op_helper.c | 19 ++++++++++
>  target/arm/translate.c | 80 +++++++++++++++++++++++++++++++++++++-----
>  4 files changed, 106 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
