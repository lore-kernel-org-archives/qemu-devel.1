Received: from eggs.gnu.org ([2001:4830:134:3::10]:54503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXDO-00066W-AU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXDN-0007xS-D8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:38:50 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
	<87lgo0cgij.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <260addd5-45fe-ad10-5208-35906fd3f197@twiddle.net>
Date: Fri, 7 Jul 2017 07:38:26 -1000
MIME-Version: 1.0
In-Reply-To: <87lgo0cgij.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 23/29] target/arm: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/07/2017 07:18 AM, Lluís Vilanova wrote:
> There was no code being generated after this specific case, but I haven't
> checked if DISAS_EXC is set in any other place that is not immediately followed
> by a "goto done_generating".

Typically we haven't actually done a goto, but simply exit the loop and emit 
nothing within the final cleanup (tb_stop?).

> Does this mean DISAS_EXC should be on the generic code and do a "goto
> done_generating" whenever it is found? And if so, what are the correct places to
> check for this? After ops->insn_start, ops->translate_insn, ops->tb_stop?

Yes, this should be handled generically, since all targets need it.

That said, I would prefer a better name like DISAS_NORETURN, which does not 
imply that an actual exception has been raised, but explicitly says that all 
following code is dead.


r~
