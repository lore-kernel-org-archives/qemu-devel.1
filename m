Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fNx0Y-0005hi-Ha
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fNx0U-0001a1-K6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:03:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1fNx0U-0001ZV-De
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:02:58 -0400
From: Andreas Schwab <schwab@suse.de>
References: <mvm1sggjazj.fsf@suse.de>
	<CAHNT7NuOLVGyodcJ98ruM5t+m1s=in07dXfNp_77=vTOb=1yhQ@mail.gmail.com>
Date: Wed, 30 May 2018 11:02:55 +0200
In-Reply-To: <CAHNT7NuOLVGyodcJ98ruM5t+m1s=in07dXfNp_77=vTOb=1yhQ@mail.gmail.com>
	(Michael Clark's message of "Mon, 19 Mar 2018 15:10:46 -0700")
Message-ID: <mvmmuwh7by8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu:handle_cpu_signal received signal outside
 vCPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On M=C3=A4r 19 2018, Michael Clark <mjc@sifive.com> wrote:

> On Mon, Mar 19, 2018 at 9:17 AM, Andreas Schwab <schwab@suse.de> wrote:
>
>> I'm seeing this error while building gedit for riscv64 with linux-user
>> emulation:
>>
>> $ LD_LIBRARY_PATH=3Dgedit/.libs qemu-riscv64 gedit/.libs/gedit
>> --introspect-dump=3D/tmp/tmp-introspectnj0xla07/functions.txt,
>> /tmp/tmp-introspectnj0xla07/dump.xml
>> qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6=
003d7d5
>> qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6=
0106a16
>>
>
> Thanks. I can see this code in accel/tcg/user-exec.c
>
> It would be nice if that log message included the signal number. I wond=
er
> if we are getting a SIGSEGV. I also wonder what thread is actually
> running...

A native build doesn't see any issues, so this looks like a genuine qemu
bug.

> I wonder what is the best way for me to reproduce on my side... a tarba=
ll
> with binaries that I can use to trigger the fault?

There are some images under
<http://download.opensuse.org/repositories/openSUSE:/Factory:/RISCV/image=
s/>
that can be used as a base.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
"And now for something completely different."
