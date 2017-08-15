Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhebv-00070j-Dp
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhebu-0001RM-GN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:22:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dhebu-0001Qx-AC
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:22:30 -0400
Received: by mail-wm0-x241.google.com with SMTP id y206so1952683wmd.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:22:30 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <73e9be7e-c87a-9514-0fbe-55d082bf4e47@amsat.org>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-2-richard.henderson@linaro.org>
	<73e9be7e-c87a-9514-0fbe-55d082bf4e47@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 15 Aug 2017 09:21:58 -0700
Message-ID: <CAKmqyKPtAV4mcBm3zNOOtmuwDriHOYd=G8WgyfzCdsPOQc1mGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/3] target/arm: Correct
 exclusive store cmpxchg memop mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, portia.stephens@xilinx.com

On Tue, Aug 15, 2017 at 8:41 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 08/15/2017 11:57 AM, Richard Henderson wrote:
>>
>> From: Alistair Francis <alistair.francis@xilinx.com>
>>
>> When we perform the atomic_cmpxchg operation we want to perform the
>> operation on a pair of 32-bit registers. Previously we were just passing
>> the register size in which was set to MO_32. This would result in the
>> high register to be ignored. To fix this issue we hardcode the size to
>> be 64-bits long when operating on 32-bit pairs.
>>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Message-Id:
>> <bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.franci=
s@xilinx.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Can we keep this as well, it was posted for my entire series:

Tested-by: Portia Stephens <portia.stephens@xilinx.com>

Thanks,
Alistair

>
>
>> ---
>>   target/arm/translate-a64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 58ed4c6d05..113e2e172b 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1913,7 +1913,7 @@ static void gen_store_exclusive(DisasContext *s, i=
nt
>> rd, int rt, int rt2,
>>               tcg_gen_concat32_i64(val, cpu_exclusive_val,
>> cpu_exclusive_high);
>>               tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
>>                                          get_mem_index(s),
>> -                                       size | MO_ALIGN | s->be_data);
>> +                                       MO_64 | MO_ALIGN | s->be_data);
>>               tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
>>               tcg_temp_free_i64(val);
>>           } else if (s->be_data =3D=3D MO_LE) {
>>
>
