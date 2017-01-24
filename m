Received: from eggs.gnu.org ([2001:4830:134:3::10]:44832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW6qu-00085D-4P
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW6qt-0006tA-FQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:34:00 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <649a4b6e-2c7f-cf2c-5fb2-9213aaffd34a@twiddle.net>
Date: Tue, 24 Jan 2017 11:33:55 -0800
MIME-Version: 1.0
In-Reply-To: <1485285380-10565-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] armv7m: honour CCR.STACKALIGN on
 exception entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Liviu Ionescu <ilg@livius.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

On 01/24/2017 11:16 AM, Peter Maydell wrote:
> The CCR.STACKALIGN bit controls whether the CPU is supposed to force
> 8-alignment of the stack pointer on entry to the exception handler.

8...

> +    /* Align stack pointer if the guest wants that */
> +    if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {

4...

>          env->regs[13] -= 4;

Not alignment.  "&= -4"?


r~
