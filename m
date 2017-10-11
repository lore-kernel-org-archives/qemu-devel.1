Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e24tp-0008N0-QE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e24tn-000657-49
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:29:25 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:48940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e24tm-00063x-Tv
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:29:23 -0400
Received: by mail-pg0-x22b.google.com with SMTP id v78so73796pgb.5
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:29:22 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46303e7b-2f9e-cf0f-8b55-0ebf03392462@linaro.org>
Date: Tue, 10 Oct 2017 17:29:19 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target-arm: Don't check for "Thumb2 or
 M profile" for not-Thumb1
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
> The code which implements the Thumb1 split BL/BLX instructions
> is guarded by a check on "not M or THUMB2". All we really need
> to check here is "not THUMB2" (and we assume that elsewhere too,
> eg in the ARCH(6T2) test that UNDEFs the Thumb2 insns).
> 
> This doesn't change behaviour because all M profile cores
> have Thumb2 and so ARM_FEATURE_M implies ARM_FEATURE_THUMB2.
> (v6M implements a very restricted subset of Thumb2, but we
> can cross that bridge when we get to it with appropriate
> feature bits.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
