Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09kz-0002lv-3u
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09kv-0004sX-9k
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:16:21 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:56231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e09kv-0004rt-3r
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:16:17 -0400
Received: by mail-qt0-x236.google.com with SMTP id x54so26659337qth.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 10:16:17 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-11-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ebb8d29-a45d-5d78-58e8-0ac0cfb150d7@linaro.org>
Date: Thu, 5 Oct 2017 13:16:13 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-11-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/20] target/arm: Update excret sanity
 checks for v8M
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> In v8M, more bits are defined in the exception-return magic
> values; update the code that checks these so we accept
> the v8M values when the CPU permits them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
