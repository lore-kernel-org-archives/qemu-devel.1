Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaaU-0001yN-Ga
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaaT-0003nJ-R6
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:38:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaaT-0003mt-7O
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:38:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id z33so1747969otz.11
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <762ccc95-2adf-2fc6-f2bc-8ad7d26d74a6@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-3-richard.henderson@linaro.org>
	<CAFEAcA-ft-mktP5fz=fHvWzvJtZN1m86WHWYvXKba0Bv0hqPtw@mail.gmail.com>
	<762ccc95-2adf-2fc6-f2bc-8ad7d26d74a6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:37:51 +0000
Message-ID: <CAFEAcA8bHDDHn9kX0x0sdy38GQDC8Xf3GDODHx1uwevsva5J3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 October 2018 at 16:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/29/18 2:58 PM, Peter Maydell wrote:
>> I think I would prefer it if we expanded the id_isar* fields
>> in the ARMISARegisters struct to uint64_t. If you dislike
>> that, I think we should make this code fail a bit more gracefully
>> in the presence of an unexpected extension into the high bits
>> of these registers. Or just ignore the high bits, since we're
>> effectively trusting that future architecture versions use
>> a compatible meaning for these registers anyway.
>
> Given these options, I'd prefer to just ignore the high bits.
> I'm fairly comfortable trusting that the architecture gods
> won't mess up and assign values in there.  Otherwise they
> would have already expanded instead of adding ID_ISAR6.

OK with me.

I think we could also add a comment noting that if the host
CPU doesn't have AArch32 then the AArch32 sysregs still exist
to be read, but they return UNKNOWN values.

thanks
-- PMM
