Received: from eggs.gnu.org ([208.118.235.92]:60190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmhF-0007mI-Oi
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmhB-0005zR-Qb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:23:53 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWmhB-0005va-KI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:23:49 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so12819694oix.3
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 10:23:49 -0800 (PST)
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-19-richard.henderson@linaro.org>
	<CAFEAcA9Hz0oDKL4FWUGrg38whuOYUer7bfDETWmF6XE987JFcg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ada7faaf-2b49-8783-d50c-3fc088a6ebad@linaro.org>
Date: Tue, 11 Dec 2018 12:23:46 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Hz0oDKL4FWUGrg38whuOYUer7bfDETWmF6XE987JFcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/26] target/arm: Export
 aa64_va_parameters to internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 12/11/18 10:53 AM, Peter Maydell wrote:
> On Fri, 7 Dec 2018 at 10:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We need to reuse this from helper-a64.c.  Provide a stub
>> definition for CONFIG_USER_ONLY.  This matches the stub
>> definitions that we removed for arm_regime_tbi{0,1} before.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/internals.h | 29 +++++++++++++++++++++++++++++
>>  target/arm/helper.c    | 16 ++--------------
>>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

FWIW, I'll smoosh this into the creation of the helper.
At some point we may fix tbi for user-only.


r~
