Received: from eggs.gnu.org ([2001:4830:134:3::10]:39991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJM7a-0005tU-GZ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJM7X-0006E7-FU
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:51:18 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJM7X-0006Db-9B
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:51:15 -0400
Received: by mail-pl0-x243.google.com with SMTP id w19-v6so2883863plq.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:51:14 -0700 (PDT)
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-27-richard.henderson@linaro.org>
	<CAFEAcA-Erv++skS73s6_ZCWbo=G6xLaE69wukUKyX3-KyuV=oA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f423b535-f3f7-a8ce-8821-8e16f0cbfd38@linaro.org>
Date: Thu, 17 May 2018 09:51:11 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Erv++skS73s6_ZCWbo=G6xLaE69wukUKyX3-KyuV=oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3-a 26/27] target/arm: Extend
 vec_reg_offset to larger sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 05/17/2018 08:57 AM, Peter Maydell wrote:
> This looks right for element sizes up to 8, but I don't understand
> how it handles 16 byte elements as the commit message says -- the
> d[0] and d[1] are the wrong way round and don't form a single
> 16-byte big-endian value, so they must need special casing somewhere
> else ?

You're right that it's not a proper int128 for host arithmetic.  Fortunately,
the only operation we have on 128-bit values, at present, is move.

How better might you word the commit message?


r~
