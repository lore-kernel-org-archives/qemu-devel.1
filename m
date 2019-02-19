Received: from eggs.gnu.org ([209.51.188.92]:55854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gw6yr-0005wY-Ki
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gw6yn-0003Nl-Q0
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:06:42 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gw6yn-0003Lu-4W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:06:41 -0500
Received: by mail-pg1-x542.google.com with SMTP id r11so10259766pgp.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:06:36 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-2-richard.henderson@linaro.org>
	<87ef84596c.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e85f698-b9d7-97a4-24ba-202f5f5a1f13@linaro.org>
Date: Tue, 19 Feb 2019 07:06:32 -0800
MIME-Version: 1.0
In-Reply-To: <87ef84596c.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Split out recompute_hflags
 et al
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org

On 2/19/19 3:06 AM, Alex Bennée wrote:
>> +    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> This is technically a TODO isn't it?
> 

Yeah, sure, but we aren't good about that categorization.
And anyway this is code movement.


r~
