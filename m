Received: from eggs.gnu.org ([209.51.188.92]:59372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFx-0004aP-8z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFv-0004Gb-Cb
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:01 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LFt-0004Ep-FY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:21:58 -0500
Received: by mail-pf1-x444.google.com with SMTP id n74so7106422pfi.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:21:56 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <edae2ef7-74a2-e1a4-b3f8-15c5e9facd9c@linaro.org>
Date: Tue, 5 Mar 2019 14:34:08 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/12] docs/cpu-hotplug.rst: Fix rST
 markup issues
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
> sphinx-build complains:
> 
> docs/cpu-hotplug.rst:67: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:69: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:74: WARNING: Block quote ends without a blank line; unexpected unindent.
> docs/cpu-hotplug.rst:75: WARNING: Block quote ends without a blank line; unexpected unindent.
> docs/cpu-hotplug.rst:76: SEVERE: Unexpected section title.
> 
> }
> {
> docs/cpu-hotplug.rst:78: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> These are the result of not indicating one of the literal
> blocks by finishing the preceding paragraph with the "::" marker.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-2-peter.maydell@linaro.org
> ---
>  docs/cpu-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
