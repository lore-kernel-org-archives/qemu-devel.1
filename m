Received: from eggs.gnu.org ([2001:4830:134:3::10]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08yG-0003nd-Di
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08yF-0004H2-IK
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:26:00 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e08yF-0004GM-Df
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:59 -0400
Received: by mail-qt0-x22f.google.com with SMTP id x54so26371008qth.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:25:59 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <86c98e0d-ed73-6d6e-d4bd-9f28df46b4ce@linaro.org>
Date: Thu, 5 Oct 2017 12:25:56 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/20] target/arm: Check for xPSR mismatch
 usage faults earlier for v8M
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
> ARM v8M specifies that the INVPC usage fault for mismatched
> xPSR exception field and handler mode bit should be checked
> before updating the PSR and SP, so that the fault is taken
> with the existing stack frame rather than by pushing a new one.
> Perform this check in the right place for v8M.
> 
> Since v7M specifies in its pseudocode that this usage fault
> check should happen later, we have to retain the original
> code for that check rather than being able to merge the two.
> (The distinction is architecturally visible but only in
> very obscure corner cases like attempting an invalid exception
> return with an exception frame in read only memory.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
