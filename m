Received: from eggs.gnu.org ([2001:4830:134:3::10]:39847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Avp-0001IF-E3
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Avo-00082I-L3
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:31:37 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:56974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Avo-00081W-Fv
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:31:36 -0400
Received: by mail-qt0-x233.google.com with SMTP id 34so10032639qtb.13
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:31:36 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-13-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce4d6f21-e7b7-8fe5-a3f0-f8ba52645b5c@linaro.org>
Date: Thu, 5 Oct 2017 14:31:33 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-13-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Add v8M support to
 exception entry code
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
> Add support for v8M and in particular the security extension
> to the exception entry code. This requires changes to:
>  * calculation of the exception-return magic LR value
>  * push the callee-saves registers in certain cases
>  * clear registers when taking non-secure exceptions to avoid
>    leaking information from the interrupted secure code
>  * switch to the correct security state on entry
>  * use the vector table for the security state we're targeting
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 145 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
