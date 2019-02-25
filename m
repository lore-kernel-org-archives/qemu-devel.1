Received: from eggs.gnu.org ([209.51.188.92]:43005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyINM-0008B7-BQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyINL-0007EI-K5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:41:04 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyINL-00078a-57
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:41:03 -0500
Received: by mail-pg1-x544.google.com with SMTP id 196so4638331pgf.13
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:40:57 -0800 (PST)
References: <20190224151553.31344-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36a53b88-11cb-0206-9e4c-8a9fa174fe31@linaro.org>
Date: Mon, 25 Feb 2019 07:40:53 -0800
MIME-Version: 1.0
In-Reply-To: <20190224151553.31344-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/Makefile.include: test all rounding
 modes of softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 2/24/19 7:15 AM, Alex Bennée wrote:
> We missed a bug in a recent patch as we were not testing all the
> rounding modes for all operations. However enabling all rounding modes
> for mulAdd does slow down the already slowest test and doesn't really
> buy us much additional coverage so lets allow the default test flags
> to be overridden.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
