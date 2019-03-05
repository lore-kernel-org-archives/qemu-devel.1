Received: from eggs.gnu.org ([209.51.188.92]:59504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGD-0004mE-Jh
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGC-0004O8-Qk
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:17 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LGC-0004MA-K8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:16 -0500
Received: by mail-pf1-x42e.google.com with SMTP id q17so7098846pfh.10
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:16 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e83f775c-0fcd-d3e8-02ca-56daeabb67d2@linaro.org>
Date: Tue, 5 Mar 2019 14:46:54 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/12] docs/conf.py: Don't hard-code
 QEMU version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/5/19 9:21 AM, Peter Maydell wrote:
> Don't hard-code the QEMU version number into conf.py. Instead
> we either pass it to sphinx-build on the command line, or
> (if doing a standalone Sphinx run in a readthedocs.org setup)
> extract it from the VERSION file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-12-peter.maydell@linaro.org
> ---
>  Makefile     |  2 +-
>  docs/conf.py | 21 ++++++++++++++++-----
>  2 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
