Received: from eggs.gnu.org ([2001:4830:134:3::10]:37592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiFM-0001bl-S0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiFH-0003fm-Tr
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:10:40 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:37412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiFH-0003f1-Nr
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:10:35 -0500
Received: by mail-pf0-x233.google.com with SMTP id p1so2377868pfh.4
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:10:35 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-2-richard.henderson@linaro.org>
	<CAFEAcA_zoqWwAhg5PhuUG=xkRuC3uwT0MF7D3NOvEFg0Z3yKMQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ffa6112-d2bf-df10-c8ee-e96ead760359@linaro.org>
Date: Thu, 11 Jan 2018 11:10:31 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zoqWwAhg5PhuUG=xkRuC3uwT0MF7D3NOvEFg0Z3yKMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/23] scripts: Add decodetree.py
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

On 01/11/2018 10:06 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> To be used to decode ARM SVE, but could be used for any 32-bit RISC.
>> It would need additional work to extend to insn sizes other than 32-bit.
> 
> I guess we could make that extension without requiring all
> existing pattern files to be updated, right?

Sure.  I would expect that to be a command-line option for the script.

> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  scripts/decodetree.py | 984 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 984 insertions(+)
>>  create mode 100755 scripts/decodetree.py
> 
> This is rather large for a single patch...

Ok, but... what bits of it are functional without the whole?

> 
>> +# Pattern examples:
>> +#
>> +#   addl_r   010000 ..... ..... .... 0000000 ..... @opr
>> +#   addl_i   010000 ..... ..... .... 0000000 ..... @opi
>> +#
> 
> I think we should insist that a pattern defines all the
> bits (either as constant values or as fields that get
> passed to the decode function). That will help prevent
> accidental under-decoding.

Hmm.  What do you suggest then for bits that the cpu does not decode at all?
This doesn't happen with ARM (I don't think) but it does happen with HPPA, and
probably others.

I suppose I could either wrap it in a field that the translator ignores, or
choose another character besides ".", e.g.

mfia            000000 xxxxx 00000 xxx 10100101 t:5

where bits [21-25] and bits [13-15] really are ignored by hardware.

Thoughts?


r~
