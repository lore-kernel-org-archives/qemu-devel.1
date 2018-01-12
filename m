Received: from eggs.gnu.org ([2001:4830:134:3::10]:57500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZwya-0005hq-GV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZwyZ-0004FT-Pm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:54:20 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:46221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZwyZ-0004Eb-LU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:54:19 -0500
Received: by mail-ot0-x233.google.com with SMTP id f6so4708768oti.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 02:54:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3ffa6112-d2bf-df10-c8ee-e96ead760359@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-2-richard.henderson@linaro.org>
	<CAFEAcA_zoqWwAhg5PhuUG=xkRuC3uwT0MF7D3NOvEFg0Z3yKMQ@mail.gmail.com>
	<3ffa6112-d2bf-df10-c8ee-e96ead760359@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 10:53:58 +0000
Message-ID: <CAFEAcA8L4q83NZOg8P8QveOOfR+Y4RUEM_BdgOZ3pdBmDjsnEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/23] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 January 2018 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/11/2018 10:06 AM, Peter Maydell wrote:
>> On 18 December 2017 at 17:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> To be used to decode ARM SVE, but could be used for any 32-bit RISC.
>>> It would need additional work to extend to insn sizes other than 32-bit.
>>
>> I guess we could make that extension without requiring all
>> existing pattern files to be updated, right?
>
> Sure.  I would expect that to be a command-line option for the script.

It occurs to me that we could just make it silently DTRT --
we want to check the bit count in patterns and so on to
detect typos, but it would be a weird typo that was wrong
by 8 bits, so as long as the patterns are all a multiple
of 8 bits long we could accept them (and handle them in
whatever way we find we need to handle mixed-length
instruction sets). So we might not even need a command
line option.

thanks
-- PMM
