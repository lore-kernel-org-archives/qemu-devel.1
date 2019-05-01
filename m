Received: from eggs.gnu.org ([209.51.188.92]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4i-0000im-R7
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4h-000154-LB
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:24 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu4h-00014N-0Q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id f6so8641297pgs.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:35:22 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ef0d685-ddb1-850e-9478-e9c88da8ebb0@linaro.org>
Date: Wed, 1 May 2019 11:35:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/15] tests/tcg/multiarch: add support
 for multiarch system tests
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
> We can certainly support some common tests for system emulation that
> make use of our minimal defined boot.S support. It will still be up to
> individual architectures to ensure they build so we provide a
> MULTIARCH_TESTS variable that they can tack onto TESTS themselves.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile                                 |  1 +
>  tests/tcg/multiarch/system/Makefile.softmmu-target | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
