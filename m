Received: from eggs.gnu.org ([2001:4830:134:3::10]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej37Q-00011A-DF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej37P-0006C9-GF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:17:04 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej37P-0006Bu-AH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:17:03 -0500
Received: by mail-oi0-x22c.google.com with SMTP id e15so1292864oiy.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 05:17:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_eGdAC7MEZy1crt1wXqE0Mb=iwNqbt_XErho7Mg8O4uQ@mail.gmail.com>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
	<20180122172643.29742-3-ard.biesheuvel@linaro.org>
	<CAKv+Gu_eGdAC7MEZy1crt1wXqE0Mb=iwNqbt_XErho7Mg8O4uQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 13:16:42 +0000
Message-ID: <CAFEAcA8VQx1ptxuuf-626dz0+1Q53jvkWDvAWQyBF1-TDVSd0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/4] target/arm: implement SHA-3
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2018 at 20:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 January 2018 at 17:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> This implements emulation of the new SHA-3 instructions that have
>> been added as an optional extensions to the ARMv8 Crypto Extensions
>> in ARM v8.2.

>> +    if (op0 < 2) {
>> +        TCG_i64 tcg_op1, tcg_op2, tcg_op3, tcg_res[2];
>
> Apologies, there's a typo here: TCGv_i64 not TCG_i64
>
> Let me know if I need to resend.

No, if that's the only issue I'll just fix it up locally.


>> +        tcg_temp_free(tcg_op1);
>> +        tcg_temp_free(tcg_op2);
>> +        tcg_temp_free(tcg_op3);
>> +        tcg_temp_free(tcg_res[0]);
>> +        tcg_temp_free(tcg_res[1]);

These I think should all be tcg_temp_free_i64(). The unsuffixed
version is for "TCGv", which is a value of size target_ulong.
As it happens that's always i64 for code in translate-a64.c,
so it's only a stylistic difference, but the rest of the code
explicitly uses i64. I'll fix this locally too.

thanks
-- PMM
