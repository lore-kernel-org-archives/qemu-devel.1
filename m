Received: from eggs.gnu.org ([2001:4830:134:3::10]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhox-0003dT-Gz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhow-0005ZV-77
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:43:23 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:38173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZhov-0005YT-Vr
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:43:22 -0500
Received: by mail-oi0-x235.google.com with SMTP id m65so2291008oig.5
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:43:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e78a8a10-b46b-a9da-8c81-7dd48eb47b10@redhat.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-22-git-send-email-mjc@sifive.com>
	<e78a8a10-b46b-a9da-8c81-7dd48eb47b10@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Jan 2018 07:43:20 +1300
Message-ID: <CAHNT7NuoL8b6EQdcku8Ex41_AHD8BVoA8504EBGFwNZqXyf1tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Jan 12, 2018 at 3:05 AM, Eric Blake <eblake@redhat.com> wrote:

> On 01/10/2018 08:22 PM, Michael Clark wrote:
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
> > +++ b/qapi-schema.json
> > @@ -413,7 +413,7 @@
> >  # Since: 2.6
> >  ##
> >  { 'enum': 'CpuInfoArch',
> > -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> > +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' ]
> }
>
> Still missing documentation that riscv was added in 2.12 (see my
> comments on v1).


My apologies. I had a look at QKeyCode and it was not clear to me how to
specify since on an enum value vs a field.

--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -411,6 +411,9 @@
 # @query-cpus.

why is this @query-cpus and not @CpuInfoArch: as is the case for @QKeyCode?

 #
 # Since: 2.6
+#
+# @riscv: since 2.12
+#
 ##
 { 'enum': 'CpuInfoArch',
   'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'riscv', 'other' ] }

 Is this correct?

> --- /dev/null
> > +++ b/target/riscv/trace-events
> > @@ -0,0 +1 @@
> > +# See docs/devel/tracing.txt for syntax documentation.
> >
>
> Do we really need this file if you don't have any traces yet?
>

I'll remove the file or add some tracing in the next spin.
