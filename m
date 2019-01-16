Received: from eggs.gnu.org ([209.51.188.92]:35128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtRK-0005Qx-FP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtRJ-0004xS-Kq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:13:38 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjtRJ-0004kt-Dc
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:13:37 -0500
Received: by mail-pg1-x544.google.com with SMTP id c25so3440820pgb.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:13:36 -0800 (PST)
References: <20190116202349.29272-1-alex.bennee@linaro.org>
	<20190116202349.29272-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6db7653e-8c2c-3a68-d4b0-514a6d0d89ed@linaro.org>
Date: Thu, 17 Jan 2019 09:13:27 +1100
MIME-Version: 1.0
In-Reply-To: <20190116202349.29272-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] softfloat: enforce softfloat if the
 host's FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, cohuck@redhat.com, "Emilio G. Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>

On 1/17/19 7:23 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> The added branch to the FMA ops is marked as unlikely and therefore
> its impact on performance (measured with fp-bench) is within noise range
> when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
> 
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
