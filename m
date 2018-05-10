Received: from eggs.gnu.org ([2001:4830:134:3::10]:33140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGme7-0002Jt-7n
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGme3-000708-9S
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:34:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180510140934.22855-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7a4a1ad9-0e47-5c2c-6f93-4e13066ecfac@twiddle.net>
Date: Thu, 10 May 2018 07:34:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180510140934.22855-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fp16 tininess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/10/2018 07:09 AM, Peter Maydell wrote:
> In commit d81ce0ef2c4f105 we added an extra float_status field
> fp_status_fp16 for Arm, but forgot to initialize it correctly
> by setting it to float_tininess_before_rounding. This currently
> will only cause problems for the new V8_FP16 feature, since the
> float-to-float conversion code doesn't use it yet. The effect
> would be that we failed to set the Underflow IEEE exception flag
> in all the cases where we should.
> 
> Add the missing initialization.
> 
> Fixes: d81ce0ef2c4f105
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
