Received: from eggs.gnu.org ([209.51.188.92]:55171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqZK-0005ya-Vo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqZG-0003gu-3r
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqZC-0003fK-0t
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so8716964pfd.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:50:35 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9cb38f75-291c-b30a-b009-532e3b56d5eb@linaro.org>
Date: Wed, 1 May 2019 07:50:32 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 15/15] Makefile.target: support
 per-target coverage reports
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
> Add support for generating a single targets coverage report. Execute:
> 
>   make coverage-report
> 
> In the target build directory. This coverage report only cares about
> target specific blobs so only searches the target build subdirectory.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile.target | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
