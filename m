Received: from eggs.gnu.org ([2001:4830:134:3::10]:50446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHA19-0000gM-Uz
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHA14-0004cI-H1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:03:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHA14-0004O6-4U
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:03:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id r63-v6so8807067wma.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:03:23 -0700 (PDT)
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-3-richard.henderson@linaro.org>
	<CAFEAcA-ft-mktP5fz=fHvWzvJtZN1m86WHWYvXKba0Bv0hqPtw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <762ccc95-2adf-2fc6-f2bc-8ad7d26d74a6@linaro.org>
Date: Mon, 29 Oct 2018 16:03:19 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ft-mktP5fz=fHvWzvJtZN1m86WHWYvXKba0Bv0hqPtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/arm: Fill in ARMISARegisters
 for kvm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/29/18 2:58 PM, Peter Maydell wrote:
> I think I would prefer it if we expanded the id_isar* fields
> in the ARMISARegisters struct to uint64_t. If you dislike
> that, I think we should make this code fail a bit more gracefully
> in the presence of an unexpected extension into the high bits
> of these registers. Or just ignore the high bits, since we're
> effectively trusting that future architecture versions use
> a compatible meaning for these registers anyway.

Given these options, I'd prefer to just ignore the high bits.
I'm fairly comfortable trusting that the architecture gods
won't mess up and assign values in there.  Otherwise they
would have already expanded instead of adding ID_ISAR6.


r~
