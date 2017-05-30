Received: from eggs.gnu.org ([2001:4830:134:3::10]:38336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFkGd-0000rq-QE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFkGZ-0006Oy-Tu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:45:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFkGZ-0006OX-OW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:45:07 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so13037069qtb.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:45:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-26-aurelien@aurel32.net>
	<c643c6b9-20fb-af8f-2e2f-9a8b6e4c1159@twiddle.net>
	<20170529111718.zmwzwy24fk5mhwgl@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f6104ef5-f9cc-fc1f-553c-d6247cb78dff@twiddle.net>
Date: Tue, 30 May 2017 09:45:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170529111718.zmwzwy24fk5mhwgl@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/26] target/s390x: implement TRANSLATE
 ONE/TWO TO ONE/TWO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 05/29/2017 04:17 AM, Aurelien Jarno wrote:
> On 2017-05-26 10:10, Richard Henderson wrote:
>> On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
>>> +uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
>>> +                      uint32_t sizes)
>>> +{
>>> +    uintptr_t ra = GETPC();
>>> +    int dsize = (sizes & 1) ? 1 : 2;
>>> +    int ssize = (sizes & 2) ? 1 : 2;
>>> +    uint16_t tst = env->regs[0] & ((1 << (8 * dsize)) - 1);
>>
>> I think you should pass in tst as an argument.  That way you can pass in an
>> out-of-band value when we implement ETF2 and test field M3 bit 3.
> 
> I don't mind passing r0 as an argument. That said if we want to pass tst
> or bundle the M3 field, it means we need to use TCG instructions to do
> so. I am not sure it brings a lot compare to doing so in the helper
> side.

Not at all -- the M3 bit test would be a translation-time check.


r~
