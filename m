Received: from eggs.gnu.org ([2001:4830:134:3::10]:41214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBGQ-0001NA-S4
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBGI-00030R-Ug
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:01:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUBGG-0002ya-UG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:01:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so15190763otr.10
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 06:01:15 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2961450d-063e-5037-b8ce-fc9881e48014@linaro.org>
Date: Tue, 4 Dec 2018 08:01:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/arm: Create timers in realize,
 not init
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

On 12/4/18 7:29 AM, Peter Maydell wrote:
> The timer_new() function allocates memory; this means that
> if we call it in the CPU's init method we would need
> to provide an instance_finalize method to free it. Defer
> the timer creation to the realize function instead.
> 
> This fixes a memory leak spotted by clang LeakSanitizer
> when a CPU object is created for introspection.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
