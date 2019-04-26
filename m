Received: from eggs.gnu.org ([209.51.188.92]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsSc-0003Hm-Ll
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsSb-000704-Le
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:42 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsSb-0006yu-DX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:41 -0400
Received: by mail-vs1-xe44.google.com with SMTP id d8so1211825vsp.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190424142714.28460-1-arilou@gmail.com>
	<87r29quo2x.fsf@zen.linaroharston>
In-Reply-To: <87r29quo2x.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Apr 2019 07:27:28 +0300
Message-ID: <CAP7QCohTShnzDuao6YbtvH+51odyP7059rhBR08sDNDsPoP31Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>

Hi Alex,

Thank you for your comments I will add a cover-letter and update it
with the review changes, as for what I'm was hoping to add later on is
mostly
custom query commands for KVM perhaps might apply to other
architectures as well here are things i had mind:
1. Get VM nested state, this way you can get the correct VMCS12 if we
are in nested state
2. Read/Write MSR
3. Read/Write Control Registers
4. Read/Write physical memory
5. Search pattern in Physical memory

I did notice there are few custom things already in gdbstub one in
particular that I would have considered that needs to modified a bit
in order to be easier to parse is the 'F' command which is currently
used only for ARM to syscall cb, but that's a different topic

Thanks,
-- Jon.

On Thu, Apr 25, 2019 at 6:00 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> arilou@gmail.com writes:
>
> > From: Jon Doron <arilou@gmail.com>
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
>
> Multi-patch series should have a cover letter:
>
>   https://wiki.qemu.org/index.php/Contribute/SubmitAPatch#Include_a_meani=
ngful_cover_letter
>
> Overall this looks like a nice improvement to the parsing code. Please
> CC me on the next revision.
>
> I'm still curious as to what additional commands you plan to implement
> once this is merged?
>
> --
> Alex Benn=C3=A9e
