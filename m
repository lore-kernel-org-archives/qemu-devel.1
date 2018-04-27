Received: from eggs.gnu.org ([2001:4830:134:3::10]:39445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fC4BS-0001mp-4R
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fC4BN-0002DA-6u
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fC4BM-0002BD-Tx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:17:05 -0400
References: <20180309142630.2170-1-laurent@vivier.eu>
	<20180309142630.2170-3-laurent@vivier.eu>
	<CAFEAcA_9biKcR9pon0eTVkDXwobBepUgs12rCfdGcRyE3HfUXQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ab1bcd13-0ccd-ee62-657a-cc823491e6fd@vivier.eu>
Date: Fri, 27 Apr 2018 16:17:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9biKcR9pon0eTVkDXwobBepUgs12rCfdGcRyE3HfUXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 2/8] target/m68k: implement flognp1
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

Le 27/04/2018 à 15:43, Peter Maydell a écrit :
> On 9 March 2018 at 14:26, Laurent Vivier <laurent@vivier.eu> wrote:
>> Using a local m68k floatx80_lognp1()
>> [copied from previous:
>> Written by Andreas Grabher for Previous, NeXT Computer Emulator.]
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Message-Id: <20180305203910.10391-3-laurent@vivier.eu>
> 
>> +floatx80 floatx80_lognp1(floatx80 a, float_status *status)
>> +{
> 
> ...
> 
>> +    if (aSign && aExp >= one_exp) {
>> +        if (aExp == one_exp && aSig == one_sig) {
>> +            float_raise(float_flag_divbyzero, status);
>> +            packFloatx80(aSign, floatx80_infinity.high, floatx80_infinity.low);
> 
> Hi; Coverity (CID1390587) points out that packFloatx80 doesn't
> do anything except return a value which is here being thrown
> away, making the call useless. Should this be maybe
> "return packFloatx80(...)" ?

Yes, you're right, I didn't correctly port the code from "Previous" here.

Thanks,
Laurent
