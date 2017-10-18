Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4fzr-0004CO-KW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4fzo-0008BL-Es
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:30:23 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:49603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4fzo-0008A3-8f
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:30:20 -0400
Received: by mail-pf0-x234.google.com with SMTP id i5so2999652pfe.6
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 21:30:18 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-11-richard.henderson@linaro.org>
	<20171017220322.GJ1345@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10093a86-e1e3-9712-2a31-474f64d05b69@linaro.org>
Date: Tue, 17 Oct 2017 21:30:15 -0700
MIME-Version: 1.0
In-Reply-To: <20171017220322.GJ1345@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 10/50] tcg: Avoid loops against variable
 bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 10/17/2017 03:03 PM, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:25:29 -0700, Richard Henderson wrote:
>> From: Richard Henderson <rth@twiddle.net>
>>
>> Copy s->nb_globals or s->nb_temps to a local variable for the purposes
>> of iteration.  This should allow the compiler to use low-overhead
>> looping constructs on some hosts.
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> 
> FWIW on a Skylake host I couldn't measure a difference. However, the
> generated code is indeed slightly different.

I wouldn't expect so.  Low-overhead loops are more of a ppc thing.


r~
