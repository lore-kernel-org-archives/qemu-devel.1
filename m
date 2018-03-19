Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ey0gE-0002fR-4X
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ey0gA-00081O-6a
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ey0gA-000802-17
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:42:46 -0400
Date: Mon, 19 Mar 2018 19:42:42 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180319194242.GQ2787@redhat.com>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Mar 19, 2018 at 11:35:51AM -0700, Michael Clark wrote:
> The RISC-V post-merge spec conformance and cleanup series has had a lot of
> testing. I've been using it to compile QEMU inside of QEMU using the RISC-V
> Fedora Image and its native RISC-V GCC toolchain running inside SMP Linux
> 4.16-rc2. It appears to be pretty rock-solid. The rcu lock fix would likely
> only affect users who are ballooning memory while a guest is under load.
> The page walker changes have also been tested under load (including
> performance tests).

Did you see the problem with restoring floating point registers on
context switch?  The test case is quite simple:

  http://oirase.annexia.org/tmp/sched.c

Note you must compile it with gcc -O2 to manifest the bug.  (We
originally thought it was a problem with gcc's optimization, but it
isn't.)

In Fedora's qemu tree are carrying the following patch which is just a
workaround:

  https://github.com/rwmjones/fedora-riscv-bootstrap/blob/master/stage1-riscv-qemu/force-float-save.patch

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
