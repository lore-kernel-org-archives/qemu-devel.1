Received: from eggs.gnu.org ([2001:4830:134:3::10]:46495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuOu-0004v2-3Q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuOp-00023M-88
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:10:40 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejuOp-00022s-3w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:10:35 -0500
Received: by mail-it0-x244.google.com with SMTP id u12so979664ite.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:10:35 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01476a36-ea99-e11b-ce2c-8752cc6e8b2c@linaro.org>
Date: Thu, 8 Feb 2018 14:10:31 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/32] arm/translate-a64: add FP16 x2
 ops for simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> A bunch of the vectorised bitwise operations just operate on larger
> chunks at a time. We can do the same for the new half-precision
> operations by introducing some TWOHALFOP helpers which work on each
> half of a pair of half-precision operations at once.
> 
> Hopefully all this hoop jumping will get simpler once we have
> generically vectorised helpers here.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> ---
>  target/arm/helper-a64.c    | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/helper-a64.h    | 10 ++++++++++
>  target/arm/translate-a64.c | 36 +++++++++++++++++++++++++++++-------
>  3 files changed, 84 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
