Received: from eggs.gnu.org ([2001:4830:134:3::10]:57378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAc5N-0000vb-IF
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAc5M-0003TR-J2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:04:53 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAc5M-0003T5-EG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:04:52 -0400
Received: by mail-oi0-x22c.google.com with SMTP id 188-v6so14367087oih.8
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 07:04:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
	<20180423031639.GB19804@umbus.fritz.box>
	<a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 15:04:31 +0100
Message-ID: <CAFEAcA8T=aDjRAxxRWOKJuhDJa1ROjQ43cvaTG5B44+=d9SVLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2018 at 14:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/23/2018 12:16 AM, David Gibson wrote:
>> On Sun, Apr 22, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
>>> If we need to do an unaligned load, then ldl_p() is the
>>> right way to do it. (We could also just do
>>>  *addr =3D ldl_be_p(prop) but we maybe don't want to
>>> bake in knowledge that FDT is big-endian).
>
> Since it is, ldl_be_p() seems the clever/cleaner way indeed, but then we
> assume we know the underlying type of fdt32_t; while using memcpy we
> respect the FDT API.

 *addr =3D fdt32_to_cpu(ldl_p(prop));

is better than a raw memcpy still.

thanks
-- PMM
