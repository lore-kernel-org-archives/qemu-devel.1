Received: from eggs.gnu.org ([2001:4830:134:3::10]:39625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWbd0-0006lP-22
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWbcw-0001S7-HM
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:13 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:39969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWbcw-0001RM-Ba
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:30:10 -0500
Received: by mail-pl0-x234.google.com with SMTP id 62so616143pld.7
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 21:30:10 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-5-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6604226-cab3-6b6b-7a2b-79ae4d071174@linaro.org>
Date: Tue, 2 Jan 2018 21:30:06 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/21] RISC-V Disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +static const char *rv_ireg_name_sym[] = {
> +    "zero", "ra",   "sp",   "gp",   "tp",   "t0",   "t1",   "t2",
> +    "s0",   "s1",   "a0",   "a1",   "a2",   "a3",   "a4",   "a5",
> +    "a6",   "a7",   "s2",   "s3",   "s4",   "s5",   "s6",   "s7",
> +    "s8",   "s9",   "s10",  "s11",  "t3",   "t4",   "t5",   "t6",
> +    NULL
> +};

static const char * const

But maybe even better as

static const char rv_ireg_name_sym[32][4]

and without the useless NULL.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
