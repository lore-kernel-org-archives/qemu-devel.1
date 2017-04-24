Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2YNx-0003Q2-5j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2YNs-0006Py-Lr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d2YNs-0006PR-EA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:26:08 -0400
Date: Mon, 24 Apr 2017 15:26:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424072604.GE316@lemon.lan>
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
	<CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
	<3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 04/24 00:45, Kamil Rytarowski wrote:
> I will have a look and try to build qemu from git (master branch).
> 
> I also find it surprising that there was a call for CI machines and
> there is no infrastructure for it.

There are. We use travis and patchew. I don't know a lot about NetBSD testing
with travis, but patchew has x86_64 and s390x machines that test patches, and
welcomes more OSes/architectures:

http://patchew.org/QEMU/20170423223216.17856-1-aurelien@aurel32.net/

If qemu master can be build on NetBDS, I can create a VM for this on my x86_64
machine, or you can generously contribute one, which is even better. :)

Fam
