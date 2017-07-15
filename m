Received: from eggs.gnu.org ([2001:4830:134:3::10]:53664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWREj-0000om-NW
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWREj-0005Gr-0t
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:52:13 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002437386.22386.7745855254236101855.stgit@frigg.lan>
	<584dade6-5ce0-4950-c0e3-03128bae119e@twiddle.net>
	<a831e072-2a10-d6c5-5d04-f00772b85b5b@twiddle.net>
	<87eftib0bn.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c186f6bb-cd8c-3280-d3f5-d3fa7a64be56@twiddle.net>
Date: Sat, 15 Jul 2017 07:52:00 -1000
MIME-Version: 1.0
In-Reply-To: <87eftib0bn.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 18/26] target/arm: [tcg] Port to
 breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/14/2017 09:56 PM, Lluís Vilanova wrote:
>> Another possibility is is_jmp = DISAS_TOO_MANY, and exit the translation loop
>> after the breakpoint check only for is_jmp > DISAS_TOO_MANY.  That allows all of
>> the DISAS_TARGET_N values to exit as well.
> 
> After a quick check, I see that arm uses both (DISAS_NORETURN and
> DISAS_TARGET_N) to exit in different points after the breakpoint. Moxie, mips
> and unicore32 use use DISAS_NORETURN, and the rest use DISAS_TARGET_N.

Of course, because those targets have not yet been ported to this generic 
infrastructure.  I'm saying that we *define* the semantics of the hook to use 
DISAS_TOO_MANY to translate one more insn.  That said, ARM is the *only* target 
that will use this feature.  All others will only use NORETURN.

This isn't really any different than the enumerator you were using previously.

Anyway, you can see my thoughts on this in the v14 series I posted last night.


r~
