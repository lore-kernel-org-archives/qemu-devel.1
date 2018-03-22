Received: from eggs.gnu.org ([2001:4830:134:3::10]:55499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ez8Oo-0003Hf-8k
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ez8Ok-0001Eu-UF
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ez8Ok-0001El-Ox
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:09:26 -0400
Date: Thu, 22 Mar 2018 22:09:24 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180322220924.GJ2787@redhat.com>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
	<20180319194242.GQ2787@redhat.com>
	<CAHNT7Ntu=LAm2r3G8ZiGioYC_FkhArA=0kXj8SxphaFTY6rV4Q@mail.gmail.com>
	<CAHNT7NsJBVruEQq1kR53wpadizjaHzJ5M-8D3_grmSzeogmtZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NsJBVruEQq1kR53wpadizjaHzJ5M-8D3_grmSzeogmtZA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, dj@redhat.com
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Mar 22, 2018 at 02:06:24PM -0700, Michael Clark wrote:
> On Mon, Mar 19, 2018 at 2:39 PM, Michael Clark <mjc@sifive.com> wrote:
> > On Mon, Mar 19, 2018 at 12:42 PM, Richard W.M. Jones <rjones@redhat.com>
> > wrote:
> >> Did you see the problem with restoring floating point registers on
> >> context switch?  The test case is quite simple:
> >>
> >>   http://oirase.annexia.org/tmp/sched.c
> >
> > No I didn't. Thanks.
> From my local testing, it appears to only show up with SMP enabled. With 1
> CPU enabled the sched.c test passes.
> I'll could try and revert this and see if it makes any difference...
> however I think the float code has changed substantially with respect to
> handling of flags. We could backport the more conservative approach of
> handling MSTATUS_FS in the float routines. We should also run the test case
> on hardware to rule out linux-kernel MSTATUS_FS bugs...

DJ, am I remembering correctly that you tried the test case on the
HiFive evaluation board and it didn't demonstrate the bug?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
