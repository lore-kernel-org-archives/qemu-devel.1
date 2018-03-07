Received: from eggs.gnu.org ([2001:4830:134:3::10]:48731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1etW31-0003zl-I5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1etW2w-000557-Qk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:11:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1etW2w-00054x-Kg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:11:42 -0500
Date: Wed, 7 Mar 2018 10:11:39 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180307101139.GK2787@redhat.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsMoYNNXyPPqWaDD4op8vtQAZGHKnjWtpTpb8xv80CaUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NsMoYNNXyPPqWaDD4op8vtQAZGHKnjWtpTpb8xv80CaUg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Mar 07, 2018 at 01:09:29PM +1300, Michael Clark wrote:
> Hopefully, this PR gets merged...

I hope so too.  We've been testing v8 (substantially the same as v8.2)
extensively, including SMP.  It's building hundreds of packages a day
in the autobuilder, and being used for manual builds by several
people.

Please don't forget about the softfloat fix!  Although it's not
specific to riscv-qemu, it is required for reliable operation and I
don't see if in the v8.2 tree.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
