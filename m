Received: from eggs.gnu.org ([2001:4830:134:3::10]:54467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqHs-0005Cv-5Z
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqHp-0001Im-9E
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:00:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLqHm-00011X-I8
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:00:23 -0500
Received: by mail-wm1-x344.google.com with SMTP id r63-v6so6018267wma.4
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 06:00:22 -0800 (PST)
References: <20181109152119.9242-1-alex.bennee@linaro.org>
	<20181109152119.9242-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01878252-88e2-43cd-1431-afde9510eecf@linaro.org>
Date: Sun, 11 Nov 2018 15:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181109152119.9242-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] arm: fix
 aa64_generate_debug_exceptions to work with EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/9/18 4:21 PM, Alex Bennée wrote:
> The test was incomplete and incorrectly caused debug exceptions to be
> generated when returning to EL2 after a failed attempt to single-step
> an EL1 instruction. Fix this while cleaning up the function a little.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - further re-arrangement as suggested by rth
> ---
>  target/arm/cpu.h | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
