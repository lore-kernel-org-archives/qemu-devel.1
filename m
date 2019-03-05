Received: from eggs.gnu.org ([209.51.188.92]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFp-0004Tl-1M
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFo-0004Dv-E3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:21:53 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:42863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LFo-0004Dl-6a
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:21:52 -0500
Received: by mail-pf1-x436.google.com with SMTP id n74so7106309pfi.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:21:52 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ccaeb82-3182-21e1-a81b-5f876e6d0929@linaro.org>
Date: Tue, 5 Mar 2019 14:33:50 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/12] Makefile: Abstract out "identify
 the pkgversion" code
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
> +  if test -d .git; then \

As mentioned somewhere else this week, test -e, since .git may be a file.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
