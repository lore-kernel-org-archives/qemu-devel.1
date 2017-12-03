Received: from eggs.gnu.org ([2001:4830:134:3::10]:49455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVo9-0006pS-I5
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVo6-00024b-FA
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:03:53 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:39036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLVo6-000247-8V
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:03:50 -0500
Received: by mail-pg0-x22b.google.com with SMTP id w7so6498976pgv.6
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:03:50 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff7a4f36-1892-4e1b-3ab3-7282fb8cbdf7@linaro.org>
Date: Sun, 3 Dec 2017 07:03:46 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/arm: Allow explicit writes to
 CONTROL.SPSEL in Handler mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/01/2017 10:44 AM, Peter Maydell wrote:
> In ARMv7M the CPU ignores explicit writes to CONTROL.SPSEL
> in Handler mode. In v8M the behaviour is slightly different:
> writes to the bit are permitted but will have no effect.
> 
> We've already done the hard work to handle the value in
> CONTROL.SPSEL being out of sync with what stack pointer is
> actually in use, so all we need to do to fix this last loose
> end is to update the condition we use to guard whether we
> call write_v7m_control_spsel() on the register write.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
