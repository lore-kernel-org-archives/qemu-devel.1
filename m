Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cfjX9-00064f-41
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cfjX6-0008N0-2t
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 03:41:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 20 Feb 2017 09:41:06 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <920b1c87-c1d8-9f73-6dad-cd6debafadd3@amsat.org>
References: <1487266008-13492-1-git-send-email-peter.maydell@linaro.org>
	<920b1c87-c1d8-9f73-6dad-cd6debafadd3@amsat.org>
Message-ID: <9f6cca837f4502e31ebb7d04e3394eaf@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] lm32: milkymist-tmu2: fix a
 third integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org, =?UTF-8?Q?Philippe_Mathie?= =?UTF-8?Q?u-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2017-02-18 00:00, schrieb Philippe Mathieu-Daud=C3=A9:
> On 02/16/2017 02:26 PM, Peter Maydell wrote:
>> Don't truncate the multiplication and do a 64 bit one instead
>> because the result is stored in a 64 bit variable.
>>=20
>> This fixes a similar coverity warning to commits 237a8650d640 and
>> 4382fa655498, in a similar way, and is the final third of the fix for
>> coverity CID 1167561 (hopefully!).
>>=20
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Michael Walle <michael@walle.cc>


>=20
>> ---
>> Third time lucky -- I checked and this is the last of these
>> multiply lines.
>>=20
>>  hw/display/milkymist-tmu2.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
>> index 7528665..59120dd 100644
>> --- a/hw/display/milkymist-tmu2.c
>> +++ b/hw/display/milkymist-tmu2.c
>> @@ -293,7 +293,7 @@ static void tmu2_start(MilkymistTMU2State *s)
>>      cpu_physical_memory_unmap(mesh, mesh_len, 0, mesh_len);
>>=20
>>      /* Write back the OpenGL framebuffer to the QEMU framebuffer */
>> -    fb_len =3D 2 * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
>> +    fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
>>      fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
>>      if (fb =3D=3D NULL) {
>>          glDeleteTextures(1, &texture);
>>=20
