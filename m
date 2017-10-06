Received: from eggs.gnu.org ([2001:4830:134:3::10]:34655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0ScE-0005Ja-95
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0ScD-0005xT-CI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:24:34 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:49047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0ScD-0005x9-7e
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:24:33 -0400
Received: by mail-qt0-x230.google.com with SMTP id d13so30651225qta.5
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:24:33 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-3-git-send-email-peter.maydell@linaro.org>
	<c0b514b4-6474-87ed-6fa0-c109761d243c@linaro.org>
	<CAFEAcA8dmJLEz_J5z8hCipmPgjxm5WE0D-6DPs5mA3HC_5ou6Q@mail.gmail.com>
	<CAFEAcA_H_cgEPs1+aJ4fWzPys8-0Omyn_BtHGhJVwWuNbrr=gQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf724dc3-027e-c2ac-61e2-5ee0576de7b2@linaro.org>
Date: Fri, 6 Oct 2017 09:24:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H_cgEPs1+aJ4fWzPys8-0Omyn_BtHGhJVwWuNbrr=gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/20] target/arm: Don't switch to target
 stack early in v7M exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10/06/2017 09:22 AM, Peter Maydell wrote:
> I'm going to change this part of the comment to read
>      * Compare the v8M ARM ARM pseudocode LookUpSP_with_security_mode().
>      * Unlike that pseudocode, we require the caller to pass us in the
>      * SPSEL control bit value; this is because we also use this
>      * function in handling of pushing of the callee-saves registers
>      * part of the v8M stack frame (pseudocode PushCalleeStack()),
>      * and in the tailchain codepath the SPSEL bit comes from the exception
>      * return magic LR value from the previous exception. The pseudocode
>      * opencodes the stack-selection in PushCalleeStack(), but we prefer
>      * to make this utility function generic enough to do the job.
> 
> which hopefully is a little clearer.

Much, thanks.


r~
