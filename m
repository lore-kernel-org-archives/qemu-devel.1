Received: from eggs.gnu.org ([209.51.188.92]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggjJo-0008De-Bq
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 23:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggjJm-0005kh-7k
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 23:48:47 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:40084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggjJl-0005hG-WE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 23:48:46 -0500
Received: by mail-pg1-x52e.google.com with SMTP id z10so1154168pgp.7
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 20:48:45 -0800 (PST)
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-23-richard.henderson@linaro.org>
	<CAFEAcA-qLZu72eaaahdN8=qK79CRLwmAn3aMgOxCVc6Pq=fXww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cee1ccb-6913-3f78-7b80-35949d5b6e6b@linaro.org>
Date: Tue, 8 Jan 2019 14:48:37 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qLZu72eaaahdN8=qK79CRLwmAn3aMgOxCVc6Pq=fXww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/27] target/arm: Implement pauth_addpac
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

On 1/7/19 11:31 PM, Peter Maydell wrote:
>> +    /* Preserve the determination between upper and lower at bit 55,
>> +     * and insert pointer authentication code.
>> +     */
>> +    if (param.tbi) {
>> +        ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
>> +        pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
>> +    } else {
>> +        ptr &= MAKE_64BIT_MASK(0, bot_bit);
>> +        pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
>> +    }
>> +    ext &= MAKE_64BIT_MASK(55, 1);
> 
> I found this a bit confusing to disentangle and compare with
> the pseudocode: the difference between the tbi and
> not-tbi cases is only "what are bits 63:56 in the result",
> but the implementation of how we put together bits 55:0 is
> different in the two code paths here.

Yes.  I found the pseudocode itself to be confusing.
Perhaps I went away from it too far.


r~
