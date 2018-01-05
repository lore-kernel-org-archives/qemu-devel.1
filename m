Received: from eggs.gnu.org ([2001:4830:134:3::10]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLnB-0000IM-8p
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLn9-0003Hd-Qs
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:47:49 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:44311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eXLn9-0003GN-Ec
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:47:47 -0500
Received: by mail-oi0-x22a.google.com with SMTP id g6so2551732oib.11
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 22:47:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
	<4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 5 Jan 2018 19:47:46 +1300
Message-ID: <CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Jan 4, 2018 at 12:23 PM, Eric Blake <eblake@redhat.com> wrote:

> On 01/02/2018 06:44 PM, Michael Clark wrote:
> > This adds RISC-V into the build system enabling the following targets:
> >
> > - riscv32-softmmu
> > - riscv64-softmmu
> > - riscv32-linux-user
> > - riscv64-linux-user
> >
> > This adds defaults configs for RISC-V, enables the build for the RISC-V
> > CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
> > script is updated to add the RISC-V ELF magic.
> >
> > Expected checkpatch errors for consistency reasons:
> >
> > ERROR: line over 90 characters
> > FILE: scripts/qemu-binfmt-conf.sh
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
>
> > +++ b/qapi-schema.json
> > @@ -413,7 +413,7 @@
> >  # Since: 2.6
> >  ##
> >  { 'enum': 'CpuInfoArch',
> > -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> > +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' ]
> }
>
> Missing documentation that riscv was added in 2.12 (see QKeyCode in
> qapi/ui.json for an enum that serves as an example of documenting
> changes over time).


OK. Will add this in the next spin.

>
> >  ##
> > +# @CpuInfoRISCV:
> > +#
> > +# Additional information about a virtual RISCV CPU
> > +#
> > +# @pc: the instruction pointer
> > +#
> > +# Since 2.8
>
> 2.12, actually.
>
> > +##
> > +{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
>
> Should this be 'uint64' or other specific type, rather than the generic
> 'int' (which happens to be 64 bits, but signed)?  Other architectures
> use 'int' because of history, but we could use this chance to improve
> things if desired.
>

I'll have to defer to your better judgement as to whether we need to change
this. I like consistency. Is it a change that needs to be made to multiple
arches? It sounds relatively low risk. You decide.

QAPI Schema
M: Eric Blake <eblake@redhat.com>
M: Markus Armbruster <armbru@redhat.com>
S: Supported
F: qapi-schema.json
F: qapi/*.json
T: git git://repo.or.cz/qemu/armbru.git qapi-next
