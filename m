Received: from eggs.gnu.org ([2001:4830:134:3::10]:34942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWzfM-0005Q4-VY
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWzfH-0007UZ-Uq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:10:16 -0500
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:37671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWzfH-0007TW-PX
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:10:11 -0500
Received: by mail-io0-x230.google.com with SMTP id n14so1216301iob.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 23:10:11 -0800 (PST)
References: <20180104012913.30763-1-laurent@vivier.eu>
	<20180104012913.30763-8-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23a2fb75-ac09-b18d-74d8-7535d1b66807@linaro.org>
Date: Wed, 3 Jan 2018 23:10:07 -0800
MIME-Version: 1.0
In-Reply-To: <20180104012913.30763-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/03/2018 05:29 PM, Laurent Vivier wrote:
> +    /* From the specs:
> +     *   X: Not affected, N,V: Undefined,
> +     *   Z: Set if val is equal to lb or ub
> +     *   V: Set if val < lb or val > ub, cleared otherwise
            ^^
Just a typo here.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
