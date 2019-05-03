Received: from eggs.gnu.org ([209.51.188.92]:34651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMaJ3-0005Yy-17
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMaJ2-0004DY-41
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMaJ1-0004Af-Lh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id t87so2496111pfa.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:40:59 -0700 (PDT)
References: <20190503120448.13385-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6aa00050-1856-b96d-a5d6-ece2f794ef08@linaro.org>
Date: Fri, 3 May 2019 08:40:54 -0700
MIME-Version: 1.0
In-Reply-To: <20190503120448.13385-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 5/3/19 5:04 AM, Peter Maydell wrote:
> Currently the dc_zva helper function uses a variable length
> array. In fact we know (as the comment above remarks) that
> the length of this array is bounded because the architecture
> limits the block size and QEMU limits the target page size.
> Use a fixed array size and assert that we don't run off it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * use ARRAY_SIZE() instead of sizeof()
>  * add a comment to make it a bit clearer that the
>    expected size of hostaddr[] is only 2 entries
> ---
>  target/arm/helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
