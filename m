Received: from eggs.gnu.org ([2001:4830:134:3::10]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eW9A9-0003th-7B
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 18:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eW9A4-0007QT-LY
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 18:06:33 -0500
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:37884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eW9A4-0007Pe-GO
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 18:06:28 -0500
Received: by mail-ua0-x243.google.com with SMTP id r18so4572324uak.4
	for <qemu-devel@nongnu.org>; Mon, 01 Jan 2018 15:06:28 -0800 (PST)
References: <20171230225622.97409-1-michael.weiser@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19080078-e96a-cc33-bb02-97f9b726d080@linaro.org>
Date: Mon, 1 Jan 2018 15:06:21 -0800
MIME-Version: 1.0
In-Reply-To: <20171230225622.97409-1-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 12/30/2017 02:56 PM, Michael Weiser wrote:
> ldxp loads two consecutive doublewords from memory regardless of CPU
> endianness. On store, stlxp currently assumes to work with a 128bit
> value and consequently switches order in big-endian mode. With this
> change it packs the doublewords in reverse order in anticipation of the
> 128bit big-endian store operation interposing them so they end up in
> memory in the right order. This makes it work for both MTTCG and !MTTCG.
> It effectively implements the ARM ARM STLXP operation pseudo-code:
> 
> data = if BigEndian() then el1:el2 else el2:el1;
> 
> With this change an aarch64_be Linux 4.14.4 kernel succeeds to boot up
> in system emulation mode.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  target/arm/helper-a64.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> v2:
> - make it work for MTTCG as well by catering to the 128bit expectation

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +     * 128bit store but two doulbewords stored consecutively */
                               ^^ typo


r~
