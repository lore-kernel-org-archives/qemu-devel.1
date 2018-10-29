Received: from eggs.gnu.org ([2001:4830:134:3::10]:57346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHCU2-0001OG-0W
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHCTw-0008SV-HB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:41:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHCTw-0008NH-0F
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:41:44 -0400
Received: by mail-pf1-x441.google.com with SMTP id e22-v6so1436936pfn.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:41:38 -0700 (PDT)
Date: Mon, 29 Oct 2018 11:41:36 -0700 (PDT)
In-Reply-To: <CAFEAcA_oMG2qo_W_OFfdkPomu7-hc4vkFSZnC0CLQ_PD6zmW+Q@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-b2717513-e93b-43da-b724-f2adca348413@palmer-si-x1c4>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: alistair23@gmail.com, philmd@redhat.com, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Mon, 29 Oct 2018 10:59:47 PDT (-0700), Peter Maydell wrote:
> On 29 October 2018 at 17:14, Palmer Dabbelt <palmer@sifive.com> wrote:
>> I don't think we have anything ready to go right now: your PCIe patches
>> still have some outstanding feedback (on interrupt stuff), and Bastian's
>> decodetree stuff has some patches from Richard Henderson that should be
>> merged in.  I was hoping to get through reviewing Michael's patches to fix
>> the FS dirty bit, but haven't had time yet -- they're tested, but I haven't
>> actually read through them.
>>
>> Maybe we should get a RISC-V QEMU mailing list so we can keep everyone in
>> sync without spamming the whole world?
>
> We can sort out a qemu-riscv mailing list like the ones we have
> for ppc and arm if you like:
> https://wiki.qemu.org/Contribute/MailingLists

I think that'd be good.  It makes things a bit easier on my end as I can ensure 
I don't miss any patches that end up on our list.

> Our general principle is that all posts should cc qemu-devel as
> well as the subsystem list; the idea is that if you only care
> about riscv you can just subscribe to the lower volume list, but
> people on qemu-devel still get to see everything without having
> to subscribe to half a dozen different other lists.

OK, that's fine.

> NB: softfreeze is tomorrow, which is our deadline by which any
> pull requests for new feature work should be on the mailing list.
> After that it's bugfixes only. So my feeling is that both the
> decodetree and the PCI patches have missed the boat for 3.1
> and can be dealt with in a more leisurely timescale.

Makes sense.

> If you have bugfixes in your tree that could do with being
> upstreamed, this is a good time in the release cycle to look
> at doing that, I think.

We have a big bugfix list, but it's all intermingled with new features in one 
tree.  I'm working through sorting this out, with the hope being that we don't 
have any major known bugs in 3.1 -- that's my biggest worry, as I'd really like 
to have the QEMU shipped by distros actually work.

>
> thanks
> -- PMM
