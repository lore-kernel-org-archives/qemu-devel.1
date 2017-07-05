Received: from eggs.gnu.org ([2001:4830:134:3::10]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dSdtr-0008SO-4A
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dSdtq-0000Du-2k
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:34:59 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dSdtp-0000C8-Qc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:34:57 -0400
Received: by mail-wr0-x232.google.com with SMTP id c11so257725701wrc.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 23:34:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7103e7ca-1504-58b0-1f32-aabba7f45792@twiddle.net>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<CAK4993hiFSozkL-5B0gud-nPVFqcvP2mgBR1Rk1vQSmhts3fGQ@mail.gmail.com>
	<7103e7ca-1504-58b0-1f32-aabba7f45792@twiddle.net>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 5 Jul 2017 09:34:14 +0300
Message-ID: <CAK4993j5SEAqySt4VQhXCwAkbU09+4YUfiaw8zypvW3803GJ_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v19 00/13] QEMU AVR 8 bit cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anichang <anichang@protonmail.ch>

Hi Richard.

Thank you for finding a bug.
As for the testing
1. I have a small program that calculates fibonacci numbers. I use it to
test mainly stack operations for different CPU flavors (1, 2 or 3 bytes PC).
2. I manually verified that I can debug with gdb, that includes
    a. stepping
    b. running
    c. stopping
    d. breakpoints
    e. backtrace shows correct stack
3. I manually verified that I can save and load vm states
4. `make check` passes

If you please point me to a doc that explains how automatic unit tests can
be added to a QEMU target, I will happily add them.


Regards,
Michael


On Wed, Jul 5, 2017 at 1:38 AM, Richard Henderson <rth@twiddle.net> wrote:

> On 06/21/2017 09:15 PM, Michael Rolnik wrote:
>
>> Hi all,
>>
>> are there any action items for me?
>>
>
> What kind of testing are you doing for this?
>
> I just briefly browsed through the code again and happened to see that ROR
> has a critical typo.  Considering that ROR must be used for multi-byte
> shifts, I'm wondering how you wouldn't have found this via even cursory
> testing.
>
> +int avr_translate_ROR(CPUAVRState *env, DisasContext *ctx, uint32_t
>> opcode)
>> +{
>> +    TCGv Rd = cpu_r[ROR_Rd(opcode)];
>> +    TCGv t0 = tcg_temp_new_i32();
>> +
>> +    tcg_gen_shli_tl(t0, cpu_Cf, 7);
>> +    tcg_gen_andi_tl(cpu_Cf, Rd, 0);
>>
>
>
> r~
>



-- 
Best Regards,
Michael Rolnik
