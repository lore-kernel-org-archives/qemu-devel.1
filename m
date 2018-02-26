Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eqGz8-0006qH-Du
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eqGz5-0006AQ-3P
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eqGz4-00068h-PM
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:30:18 -0500
Date: Mon, 26 Feb 2018 11:30:15 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180226113015.GK2450@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

If anyone wants a simple way to test this, grab the latest bbl &
stage4 disk image from here and boot it under qemu-system-riscv64
using the command line given in the readme.txt file:

  https://fedorapeople.org/groups/risc-v/disk-images/

I've added v6 to Fedora copr, and switched to using it for the
Fedora/RISC-V build system, so it'll get a lot of heavy testing
shortly.

  http://copr-fe.cloud.fedoraproject.org/coprs/rjones/riscv/build/721136/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
