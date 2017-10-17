Received: from eggs.gnu.org ([2001:4830:134:3::10]:49117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e4YYF-0007ur-LL
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e4YYC-0006Fc-Hv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:33:23 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1e4YYC-0006Es-Cz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:33:20 -0400
Received: by mail-pg0-x243.google.com with SMTP id y184so1141784pgd.12
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 13:33:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-3-richard.henderson@linaro.org>
	<20171017202826.GB1345@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8d3a2fbd-0b3a-b9ee-3bd1-5a06d957a183@twiddle.net>
Date: Tue, 17 Oct 2017 13:33:13 -0700
MIME-Version: 1.0
In-Reply-To: <20171017202826.GB1345@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 02/50] tcg: Propagate args to op->args
 in optimizer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 10/17/2017 01:28 PM, Emilio G. Cota wrote:
>> -        TCGArg * const args = op->args;
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> 
> Just for my own education: why doesn't gcc generate the same code when
> leaving 'args' as above? I thought we could simplify the diff without
> any side effects, but it turns out that more code is generated.

Um... this patch was intended to be code cleanup only.  It should have
generated the same code.  I admit I didn't check.

That there is a code difference is surprising and probably reportable as a
compiler bug.


r~
