Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmK3-0005SV-Rp
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmK0-0005NZ-LS
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:36:43 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmK0-0005NJ-H6
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:36:40 -0500
Received: by mail-vk0-f51.google.com with SMTP id x186so58916567vkd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:36:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481130858-31767-1-git-send-email-julian@codesourcery.com>
References: <1481130858-31767-1-git-send-email-julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 12:35:19 +0000
Message-ID: <CAFEAcA9DFG3NqTAtAXd3W7y70Mdn9jH5Y9yXFdtgbRKa7p_qow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Correct value of ARM Cortex-A8 MVFR1
 register.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 17:14, Julian Brown <julian@codesourcery.com> wrote:
> The value of the MVFR1 (Media and VFP Feature Register 1) register for
> the Cortex-A8 appears to be incorrect (according to the TRM, DDI0344K),
> with the "full denormal arithmetic" and "propagation of NaN" fields
> holding both 0 instead of both 1.
>
> I had a go tracing the history of the use of this value, and it seems
> it's always just been wrong in QEMU: maybe it was derived from early
> documentation, or guessed based on the use of a "VFP Lite" implementation
> in the Cortex-A8.
>
> Depending on the startup/early-boot code in use, this can manifest as
> failure to perform denormal arithmetic properly: in our case, selecting
> a Cortex-A8 CPU when using QEMU as an instruction-set simulator for
> bare-metal GCC testing caused tests using denormal arithmetic to
> fail. Problems might be masked (or not occur) when using a full OS kernel
> with suitable trap handlers (I'm not sure).
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

Applied to target-arm.next for 2.9, thanks.

-- PMM
