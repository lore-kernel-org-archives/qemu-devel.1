Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgZTt-00056p-C8
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 12:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgZTq-0004Qt-Ai
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 12:41:45 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:34157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgZTq-0004Qf-3C
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 12:41:42 -0400
Received: by mail-pg0-x231.google.com with SMTP id u185so26462757pgb.1
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 09:41:41 -0700 (PDT)
References: <20170812154131.29372-1-richard.henderson@linaro.org>
	<CAKmqyKO=+QDLgEAyqrdTCkDsu6nojmDsdqsu5+po3OP_KOwYQA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7343971c-2563-d18b-cdac-60c4d66f5240@linaro.org>
Date: Sat, 12 Aug 2017 09:41:37 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKO=+QDLgEAyqrdTCkDsu6nojmDsdqsu5+po3OP_KOwYQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Correct load/store exclusive
 pairing and alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <rth7680@gmail.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 08/12/2017 09:29 AM, Alistair Francis wrote:
> Now we aren't ever checking cpu_exclusive_high. Is it even worth having?

We are checking cpu_exclusive_high for 64-bit STXP.
See paired_cmpxchg64_{l,b}e in target/arm/helper-a64.c.


r~
