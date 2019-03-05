Received: from eggs.gnu.org ([209.51.188.92]:59471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG8-0004hC-Ab
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG7-0004Ks-Ha
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:12 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LG7-0004KU-B1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:11 -0500
Received: by mail-pg1-x544.google.com with SMTP id h11so6957487pgl.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:11 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8018441-d5eb-cc67-ab41-12d90eb8ae7c@linaro.org>
Date: Tue, 5 Mar 2019 14:42:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/12] docs/conf.py: Disable option
 warnings
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
> sphinx-build complains about using :option: to mark up option
> flags that it doesn't know about (because they were not defined
> using the "option::" directive):
> docs/pr-manager.rst:68: WARNING: unknown option: -d
> 
> Suppress these warnings. This way we get the semantic markup
> of the option flag but no cross-referencing hyperlink.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-8-peter.maydell@linaro.org
> ---
>  docs/conf.py | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
