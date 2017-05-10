Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8YHt-0004Kj-5H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8YHs-0001Dm-BS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:32:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-3-f4bug@amsat.org>
	<b258b01d-74f9-e412-5367-d8e1d72eb159@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c58cdae9-5043-2506-9a91-f35f2da51e20@amsat.org>
Date: Wed, 10 May 2017 17:32:34 -0300
MIME-Version: 1.0
In-Reply-To: <b258b01d-74f9-e412-5367-d8e1d72eb159@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org

On 05/10/2017 05:20 PM, Richard Henderson wrote:
> On 05/10/2017 01:05 PM, Philippe Mathieu-Daudé wrote:
>> -    tcg_gen_shri_i32(t1, t1, 8);
>> -    tcg_gen_andi_i32(t1, t1, 0x00ff00ff);
>> +    tcg_gen_extract_i32(t1, t1, 8, 0x00ff00ff);
>
> This is very wrong.  See my previous comment.

Arghhh I see, I checked manually and though I had it...

I'll first check with the cocci script if it can handles this better 
then review the serie manually before bother you again.

Thinking about it, this should be quite easy unit-testable somehow ... 
Not sure if I want to start this path although.

Sorry for the noise and thank a lot for the review!

Phil.
