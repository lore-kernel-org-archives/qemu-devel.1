Received: from eggs.gnu.org ([2001:4830:134:3::10]:46862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUKOg-0007AN-2a
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUKOc-00070b-Jf
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:42:01 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:45411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUKOc-0006xo-8b
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:41:58 -0500
Received: by mail-pf0-x229.google.com with SMTP id u19so20249148pfa.12
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 14:41:57 -0800 (PST)
References: <20171218171758.16964-1-richard.henderson@linaro.org>
	<20171218171758.16964-9-richard.henderson@linaro.org>
	<alpine.DEB.2.20.1712271821081.4787@bulbul.intra.ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c098868c-352d-e69e-3cc6-ba1c5378250d@linaro.org>
Date: Wed, 27 Dec 2017 14:41:53 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1712271821081.4787@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 08/26] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 12/27/2017 07:31 AM, Kirill Batuzov wrote:
> I think something is wrong with instruction encodings here. Looks like
>   tcg_out_mov(&tcg_ctx, TCG_TYPE_I64, TCG_REG_EBP, TCG_REG_XMM0)
> produces
>   vmovq %xmm5, %rax
> instead.

Bah.  The operands are swapped -- ebp == 5 and eax == 0.


r~
