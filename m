Received: from eggs.gnu.org ([2001:4830:134:3::10]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnTAC-0007zz-Gz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnTAB-0008DL-Ei
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:21:56 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dnTAB-0008Ck-9P
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:21:55 -0400
Received: by mail-io0-x243.google.com with SMTP id f99so326198ioi.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 10:21:55 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA9N2dx6feVbw0BJ_xbs9czjJvmOCZfoOjf4ddpVk4ikbQ@mail.gmail.com>
References: <b35860a5f4377883fd2c2942bdb524d279a91de9.1504116039.git.alistair.francis@xilinx.com>
	<CAFEAcA9N2dx6feVbw0BJ_xbs9czjJvmOCZfoOjf4ddpVk4ikbQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 31 Aug 2017 10:21:23 -0700
Message-ID: <CAKmqyKN1YL_gi7+sQ2mzHKKB+ZDPZA6HER1ReAtVCynfxJZiAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>

On Wed, Aug 30, 2017 at 3:12 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 August 2017 at 19:02, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
>> let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  target/xtensa/op_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
>> index 519fbeddd6..3d990c0caa 100644
>> --- a/target/xtensa/op_helper.c
>> +++ b/target/xtensa/op_helper.c
>> @@ -1025,11 +1025,11 @@ void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
>>  uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
>>  {
>>      return address_space_ldl(env->address_space_er, addr,
>> -                             (MemTxAttrs){0}, NULL);
>> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>>  }
>>
>>  void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
>>  {
>>      address_space_stl(env->address_space_er, addr, data,
>> -                      (MemTxAttrs){0}, NULL);
>> +                      MEMTXATTRS_UNSPECIFIED, NULL);
>>  }
>
> Might be worth noting in the commit that this is technically
> a change of behaviour, because MEMTXATTRS_UNSPECIFIED
> sets the 'unspecified' field to 1 whereas {0} doesn't.
> I don't think anything actually checks that field, though.

Good point, I have added something to the commit message to indicate
that. It'll be included in v2.

Thanks,
Alistair

>
> thanks
> -- PMM
