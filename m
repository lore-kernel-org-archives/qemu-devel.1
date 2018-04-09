Received: from eggs.gnu.org ([2001:4830:134:3::10]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5T7C-0007Zb-Uu
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5T78-0001Wz-Vd
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:29:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180406164108.26118-1-mreitz@redhat.com>
References: <20180406164108.26118-1-mreitz@redhat.com>
Date: Mon, 09 Apr 2018 11:28:39 +0200
Message-ID: <w51r2nowwxk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Split 214 off of 122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri 06 Apr 2018 06:41:08 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
> Commit abd3622cc03cf41ed542126a540385f30a4c0175 added a case to 122
> regarding how the qcow2 driver handles an incorrect compressed data
> length value.  This does not really fit into 122, as that file is
> supposed to contain qemu-img convert test cases, which this case is not.
> So this patch splits it off into its own file; maybe we will even get
> more qcow2-only compression tests in the future.
>
> Also, that test case does not work with refcount_bits=1, so mark that
> option as unsupported.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Looks good to me

> I was a bit lost what to do about the copyright text, since this test
> case was written by Berto.  I figured I'd drop the "owner" variable
> (it isn't used anyway), but I put "Red Hat" into the copyright line --
> currently every test has copyright information, so I decided it'd be
> difficult to leave that out, and I figured I simply cannot claim
> copyright for Igalia.  So, here we go.

The new file contains only my test, right? You can use

Copyright (C) 2018 Igalia, S.L.
Author: Alberto Garcia <berto@igalia.com>

and add

Signed-off-by: Alberto Garcia <berto@igalia.com>

Berto
