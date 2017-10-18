Received: from eggs.gnu.org ([2001:4830:134:3::10]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4g0s-0004lD-RW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4g0p-0000PQ-Kq
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:26 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:51233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4g0p-0000Op-ES
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:31:23 -0400
Received: by mail-pf0-x230.google.com with SMTP id n14so2996103pfh.8
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 21:31:23 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-15-richard.henderson@linaro.org>
	<20171017221629.GN1345@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8962018e-1305-0299-e7f6-8c947bf3b425@linaro.org>
Date: Tue, 17 Oct 2017 21:31:19 -0700
MIME-Version: 1.0
In-Reply-To: <20171017221629.GN1345@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 14/50] tcg: Use per-temp state data in
 optimize
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

On 10/17/2017 03:16 PM, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:25:33 -0700, Richard Henderson wrote:
>> From: Richard Henderson <rth@twiddle.net>
>>
>> While we're touching many of the lines anyway, adjust the naming
>> of the functions to better distinguish when "TCGArg" vs "TCGTemp"
>> should be used.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
> (snip)
>> -static struct tcg_temp_info temps[TCG_MAX_TEMPS];
>> +static struct tcg_temp_info temps_[TCG_MAX_TEMPS];
> 
> Is this rename really necessary?

It was a temp rename to ensure that all changes were made.
The variable disappears later.


r~
