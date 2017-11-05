Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eBUZJ-0004G4-JW
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 18:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eBUZI-0003j1-R9
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 18:43:09 -0500
Received: from mail-yw0-x234.google.com ([2607:f8b0:4002:c05::234]:43965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eBUZI-0003ho-LZ
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 18:43:08 -0500
Received: by mail-yw0-x234.google.com with SMTP id y75so6524677ywg.0
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 15:43:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5cr_Pi7_HKsxDRwfkPhYPc6rGU=53AdbW0HoHbm-LrFw@mail.gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
	<1509767121-26925-16-git-send-email-jcmvbkbc@gmail.com>
	<CAAdtpL5cr_Pi7_HKsxDRwfkPhYPc6rGU=53AdbW0HoHbm-LrFw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 5 Nov 2017 15:43:06 -0800
Message-ID: <CAMo8BfKYk0zMhnbP6VoyG8Di87hndaLD6rtHT=3yXFVfuhCk2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] target/xtensa: implement const16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Philippe,

On Sun, Nov 5, 2017 at 7:23 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>> +static void translate_const16(DisasContext *dc, const uint32_t arg[],
>> +                             const uint32_t par[])
>> +{
>> +    if (gen_window_check1(dc, arg[0])) {
>> +        TCGv_i32 v =3D tcg_temp_new_i32();
>> +
>> +        tcg_gen_shli_i32(v, cpu_R[arg[0]], 16);
>> +        tcg_gen_ori_i32(cpu_R[arg[0]], v, arg[1] & 0xffff);
>
> this is missing:
>
>              tcg_temp_free_i32(v);

Indeed, thank you.

>> +    }
>
> however I think this can be simplified in 1 instr on target supporting
> deposit32:
>
>     tcg_gen_deposit_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[0]], 16, =
16)

arg[1] is an immediate argument, not a register index, so probably not.

--=20
Thanks.
-- Max
