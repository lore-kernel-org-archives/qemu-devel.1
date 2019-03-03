Received: from eggs.gnu.org ([209.51.188.92]:37330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h0U0G-0003MX-EO
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h0Tmz-0000cN-Nu
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:16:34 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h0Tmz-0000bp-ED
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:16:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id d17so2858295wre.10
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 08:16:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
	<CAL1e-=iV_0Fak=_QjzxgU-eWqG6hkVYgEbwaDKc4MT3MkGu=Eg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c63cc0c0-85f8-3caa-74aa-66a72a94d438@amsat.org>
Date: Sun, 3 Mar 2019 17:16:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iV_0Fak=_QjzxgU-eWqG6hkVYgEbwaDKc4MT3MkGu=Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "philmd@redhat.com" <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 3/3/19 4:40 PM, Aleksandar Markovic wrote:
> On Sunday, March 3, 2019, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> 
>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>> guests running on these and the PMON2000 firmware of the fulong2e
>> expect this to be available. Fortunately these are very similar chips
>> so they can be mostly emulated in the same device model. This patch
>> adds basic emulation of these ATI VGA chips.
> 
> 
> I am not familiar enough with display/graphics code in QEMU to give this
> patch an official "reviewed-by", but from the standpoint of MIPS (Fulong 2E
> is a MIPS-based board), this patch is a desirable one, and we want it, if
> possible, even before March 12th (the planned soft freeze date). Though, I
> am not rushing anyone in any way. So, FWIW:
> 
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Using
$ qemu-system-mips64el -M fulong2e -bios pmon_2e.bin -device ati-vga

Regards,

Phil.

>> While this is incomplete and currently only enough to run the MIPS
>> firmware and get framebuffer output with Linux, it allows the fulong2e
>> board to work more like the real hardware and having it in QEMU in
>> this state provides a way to experiment with it and allows others to
>> contribute to improve it. It is compiled for all archs but only the
>> fulong2e (which currently has no display output at all) is set to use
>> it by default (in a patch sent separately).
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
