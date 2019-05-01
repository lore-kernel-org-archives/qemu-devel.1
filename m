Received: from eggs.gnu.org ([209.51.188.92]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvjh-0002ns-0A
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvjg-0007s7-3v
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLvjf-0007rY-Tn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so8671616plp.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 13:21:47 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-9-richard.henderson@linaro.org>
	<87lfzq5b4w.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71153219-741d-3c27-53b8-455c62de36c8@linaro.org>
Date: Wed, 1 May 2019 13:21:43 -0700
MIME-Version: 1.0
In-Reply-To: <87lfzq5b4w.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/29] tcg: Promote tcg_out_{dup,
 dupi}_vec to backend interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/1/19 10:37 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> The i386 backend already has these functions, and the aarch64
>> backend could easily split out one.  Nothing is done with these
>> functions yet, but this will aid register allocation of
>> INDEX_op_dup_vec in a later patch.
> 
>   "Also use correct type for tcg_out_dupi_vec"?

Added:

"Adjust the aarch64 tcg_out_dupi_vec signature to match the new interface."


r~
