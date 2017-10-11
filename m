Received: from eggs.gnu.org ([2001:4830:134:3::10]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Dk2-0001gR-Jd
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Dk1-0006v8-Q7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:55:54 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:55129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2Dk1-0006sH-Io
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:55:53 -0400
Received: by mail-wr0-x22e.google.com with SMTP id o44so833351wrf.11
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 02:55:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <520fa164-103e-c09d-67af-5d0e9d8ebb9b@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-7-git-send-email-peter.maydell@linaro.org>
	<520fa164-103e-c09d-67af-5d0e9d8ebb9b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 10:55:30 +0100
Message-ID: <CAFEAcA_ttfHBZpneED7C7tv=p958XooRMMFE1rnCt=fTAgtQZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/9] target/arm: Pull Thumb insn word loads
 up to top level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 11 October 2017 at 03:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/09/2017 06:48 AM, Peter Maydell wrote:
>> +    if ((insn >> 11) == 0x1e && (s->pc < s->next_page_start - 3)) {
>> +        /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
>> +         * is not on the next page; we merge this into a 32-bit
>> +         * insn.
>> +         */
>> +        return false;
>> +    }
>> +    /* 0b1110_1xxx_xxxx_xxxx : BLX suffix (or UNDEF);
>> +     * 0b1111_1xxx_xxxx_xxxx : BL suffix;
>> +     * 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix on the end of a page
>> +     *  -- handle as single 16 bit insn
>> +     */
>
> I really had to search to find docs for this.  I suspect it's quite clear in v5
> manuals, but I didn't have one handy and arm.com seems to have dropped
> everything before v6M.  However, I did see a footnote in v7M that explained.

Yes, it's in the ARMv5 and v6 ARM, which you can get from here:
https://developer.arm.com/docs/ddi0100/latest/armv5-architecture-reference-manual

thanks
-- PMM
