Received: from eggs.gnu.org ([2001:4830:134:3::10]:54771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnqD-0002vQ-6G
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnqC-0000Yv-CK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:11:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKnqC-0000Rb-0r
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:11:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id u13-v6so1923684wmc.4
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:11:28 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36e79569-1e58-503b-c2fb-e9b1df0353e6@linaro.org>
Date: Thu, 8 Nov 2018 18:11:24 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] target/arm64: hold BQL when calling
 do_interrupt()
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

On 11/8/18 5:33 PM, Alex Bennée wrote:
> Fix the assertion failure when running interrupts.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/kvm64.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
