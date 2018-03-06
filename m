Received: from eggs.gnu.org ([2001:4830:134:3::10]:50398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1et8fP-0005gm-G6
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1et8fK-00045j-EY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:13:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1et8fK-00044X-AW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:13:46 -0500
Message-ID: <1520327623.4132.10.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 06 Mar 2018 10:13:43 +0100
In-Reply-To: <CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
	<CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
	<CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
	<CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, 2018-03-06 at 14:30 +1300, Michael Clark wrote:
> I'm currently working on some changes locally to split the firmware from
> the kernel image. Currently the kernel image is embedded in the firmware (r
> iscv-pk/bbl).

I was wondering about this just yesterday.

Will this eventually lead to a situation where we can have a single
firmware image which is shared between all guests, a la OVMF/AAVMF,
with grub and the kernels stored on the virtual disk itself, like
on most other architectures?

That should make it less awkward to add RISC-V support to libvirt,
plus I expect it to be kind of a requirement for full distribution
support, especially when it comes to updates and such.

-- 
Andrea Bolognani / Red Hat / Virtualization
