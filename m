Received: from eggs.gnu.org ([209.51.188.92]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu57-00015V-1e
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu56-0001KG-3x
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu55-0001Jd-TX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so8630841pgg.13
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:35:47 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <243c271f-ffff-6a6c-d5ad-1b5ced78491c@linaro.org>
Date: Wed, 1 May 2019 11:35:44 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 04/15] tests/tcg/multiarch: move the
 system memory test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> There is nothing inherently architecture specific about the memory
> test although we may have to manage different restrictions of
> unaligned access across architectures.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/{i386 => multiarch}/system/memory.c | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename tests/tcg/{i386 => multiarch}/system/memory.c (100%)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
