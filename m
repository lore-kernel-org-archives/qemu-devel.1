Received: from eggs.gnu.org ([2001:4830:134:3::10]:51234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbT7D-0003HK-IN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbT78-0003pJ-J2
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:20:59 -0500
Date: Wed, 8 Feb 2017 14:20:51 +0000
From: Stephane Chazelas <stephane.chazelas@gmail.com>
Message-ID: <20170208142051.GB19518@chaz.gmail.com>
References: <20170202123045.GA24714@chaz.gmail.com>
	<f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

2017-02-08 00:43:18 +0100, Max Reitz:
[...]
> Therefore, the patch as it is makes sense. The fact that said lseek() is
> slow on ZFS is (in my humble opinion) the ZFS driver's problem that
> needs to be fixed there.
[...]

For the record, I've mentioned the qemu performance implication at
https://github.com/zfsonlinux/zfs/issues/4306#issuecomment-277000682

Not much more I can do at that point.

That issue was raised a year ago and has not been assigned any
milestone yet.

-- 
Stephane
