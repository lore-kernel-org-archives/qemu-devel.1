Received: from eggs.gnu.org ([2001:4830:134:3::10]:40948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBFt-00015K-Ke
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBFg-0002VI-BO
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:00:51 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUBFd-0002Sy-MC
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:00:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so15230949otl.0
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 06:00:36 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cea0d044-7fd6-e186-78c5-e95536c8e72e@linaro.org>
Date: Tue, 4 Dec 2018 08:00:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/test-arm-mptimer: Don't leak
 string memory
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
> The test-arm-mptimer setup creates a lot of test names using
> g_strdup_printf() and never frees them. This is entirely
> harmless since it's one-shot test code, but it clutters
> up the output from clang's LeakSanitizer. Refactor to
> use a helper function so we can free the memory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/test-arm-mptimer.c | 153 ++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 84 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
