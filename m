Received: from eggs.gnu.org ([2001:4830:134:3::10]:47924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVjA-0004B9-9M
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVj7-0005lD-Bd
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:58:44 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLVj7-0005kN-6D
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 09:58:41 -0500
Received: by mail-pf0-x241.google.com with SMTP id d23so6712160pfe.9
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 06:58:40 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <37cb7baa-223a-2fc1-7eca-16cac60ba390@linaro.org>
Date: Sun, 3 Dec 2017 06:58:36 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/arm: Handle SPSEL and current
 stack being out of sync in MSP/PSP reads
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
> For v8M it is possible for the CONTROL.SPSEL bit value and the
> current stack to be out of sync. This means we need to update
> the checks used in reads and writes of the PSP and MSP special
> registers to use v7m_using_psp() rather than directly checking
> the SPSEL bit in the control register.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
