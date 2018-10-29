Received: from eggs.gnu.org ([2001:4830:134:3::10]:51839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHB7u-00046J-MG
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHB7q-0003HD-Ow
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:14:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHB7q-0003Gv-C1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:14:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id f8-v6so4219294pgq.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 10:14:50 -0700 (PDT)
Date: Mon, 29 Oct 2018 10:14:47 -0700 (PDT)
In-Reply-To: <CAKmqyKPXFOw3hv+wYbVPn2c4xPCiUXVyzDPJ3XpOuBx0zp9xGw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-81205b33-ccd0-4600-9fbd-0a025c55dcfa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: philmd@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Mon, 29 Oct 2018 09:48:30 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Oct 29, 2018 at 9:44 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> On 29/10/18 17:16, Palmer Dabbelt wrote:
>> > Alistair has been contributing to the RISC-V QEMU port for a while now
>> > so I'd like him to be officially listed as a maintainer.  I've checked
>> > with the other RISC-V mainatiners and there are no objectics, and I've
>>
>> "maintainers" "objections"
>>
>> > also checked with Alistair so he knows I'm volunteering him.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> FWIW:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> I can send a pull request with this patch (and the other RISC-V
> patch). I'll fix the typos in the PR.

I don't think we have anything ready to go right now: your PCIe patches still 
have some outstanding feedback (on interrupt stuff), and Bastian's decodetree 
stuff has some patches from Richard Henderson that should be merged in.  I was 
hoping to get through reviewing Michael's patches to fix the FS dirty bit, but 
haven't had time yet -- they're tested, but I haven't actually read through 
them.

Maybe we should get a RISC-V QEMU mailing list so we can keep everyone in sync 
without spamming the whole world?

>
> Alistair
>
>>
>> > ---
>> >   MAINTAINERS | 1 +
>> >   1 file changed, 1 insertion(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index d794bd7a66fe..d550fd8b809c 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -241,6 +241,7 @@ F: disas/ppc.c
>> >   RISC-V
>> >   M: Michael Clark <mjc@sifive.com>
>> >   M: Palmer Dabbelt <palmer@sifive.com>
>> > +M: Alistair Francis <Alistair.Francis@wdc.com>
>> >   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> >   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> >   S: Maintained
>> >
>>
