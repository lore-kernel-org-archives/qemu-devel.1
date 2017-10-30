Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9FRc-0001cH-OL
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9FRb-0000Ab-6A
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:09:56 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:55985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9FRb-0000A2-1P
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:09:55 -0400
Received: by mail-io0-x241.google.com with SMTP id p186so29598460ioe.12
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 12:09:55 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <836e7a63-c841-a866-c82c-04bf785420ca@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<de8125f4-fb99-1f9e-f7a8-7f1f9c4f0b5a@amsat.org>
	<836e7a63-c841-a866-c82c-04bf785420ca@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 16:09:53 -0300
Message-ID: <CAAdtpL61YQxwqhS-4pDRVM=Y3B2sJgpipjgUwA28ocvxP+FNfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv4 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>

On Mon, Oct 30, 2017 at 4:00 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 27/10/17 17:42, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
>> If you don't accept my comments (or don't have time) about keeping
>> "hw/sparc/sparc32_dma.h" generic and moving network/scsi parts in
>> "hw/sparc/sun4m.h" you can still add to your series:
>>
>> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Thanks for the review, I've added your R-B tags to the individual
> patches. Note that while potentially I could move the network/scsi parts
> to hw/sparc/sun4m.h I feel that it's a slightly better match for the
> SPARC32 DMA container device to remain in sparc32_dma.c. So for these
> patches I've just added your A-B tag.

OK.

>> Also while testing your series on a Debian image, I noted your series
>> results faster, I timed:
>>
>> master: 104s
>> your series: 85s (>20% faster!)
>
> Really? Is that for just this patchset or also with the v2 IOMMU
> patchset applied on top? I can't immediately see how moving the logic
> into sparc32_dma.c could make a difference here...

Yes, I was trying with both series applied, so this comment belong to
the other series (IOMMU).

Regards,

Phil.
