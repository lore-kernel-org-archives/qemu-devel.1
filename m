Received: from eggs.gnu.org ([209.51.188.92]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQfe-00068V-Dh
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQfd-00019H-L4
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:56:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQfd-00018Z-Dg
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:56:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id c4so2510666pls.11
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 09:56:05 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a417877-fade-c8ec-038b-7c0ce9109649@linaro.org>
Date: Sun, 17 Feb 2019 09:56:01 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] hw/timer/pl031: Convert to using
 trace events
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

On 2/14/19 4:50 AM, Peter Maydell wrote:
> Convert the debug printing in the PL031 device to use trace events,
> and augment it to cover the interesting parts of device operation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/pl031.c      | 55 +++++++++++++++++++++++--------------------
>  hw/timer/trace-events |  6 +++++
>  2 files changed, 36 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
