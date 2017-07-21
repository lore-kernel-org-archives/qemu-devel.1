Received: from eggs.gnu.org ([2001:4830:134:3::10]:49924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYULd-0003FN-1E
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYULa-0000N8-8D
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:35:49 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYULa-0000MV-2Q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:35:46 -0400
Received: by mail-wr0-x231.google.com with SMTP id 33so23635300wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:35:45 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-16-alex.bennee@linaro.org>
	<38211f3f-b5c5-003c-f568-eb9088c09f4e@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <38211f3f-b5c5-003c-f568-eb9088c09f4e@twiddle.net>
Date: Fri, 21 Jul 2017 10:35:43 +0100
Message-ID: <87wp726sk0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 15/23]
 target/arm/translate-a64.c: AdvSIMD scalar 2 register misc decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 07/20/2017 05:04 AM, Alex Bennée wrote:
>> +    for (pass = 0; pass < elements; pass++) {
>> +        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
>> +        TCGv_i32 tcg_res = tcg_temp_new_i32();
>> +
>> +        read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
>> +
>> +        switch (fpopcode) {
>> +        default:
>> +            fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpopcode);
>> +            unsupported_encoding(s, insn);
>> +        }
>
> Just noticing that we ought not issue N copies of the
> unsupported_encoding exception.  Return afterwards seems in order.  Is
> this a pattern that you copied that wants fixing elsewhere?

No that's just me. I think all the other cases just define
g_assert_not_reached() as the unsupported encoding should be picked up
further up the call chain. I shall fix that.

--
Alex Bennée
