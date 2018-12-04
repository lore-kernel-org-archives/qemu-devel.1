Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBCw-00069d-UM
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBCt-0000Hd-Mw
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:50 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUBCt-0000Gz-EO
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:47 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so15179963otr.10
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:57:47 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db25e95d-1c35-94b8-eb1b-939c44a4135e@linaro.org>
Date: Tue, 4 Dec 2018 07:57:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/arm/mps2-tz.c: Free mscname string
 in make_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 12/4/18 7:29 AM, Peter Maydell wrote:
> The clang leak sanitizer spots a (one-off, trivial) memory
> leak in make_dma() due to a missing free.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2-tz.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
