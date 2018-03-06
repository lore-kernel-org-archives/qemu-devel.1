Received: from eggs.gnu.org ([2001:4830:134:3::10]:40103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1et9mN-0001wX-Im
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1et9mK-000242-FJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:25:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3c829c67-f6b9-ad7e-ba1d-a0f7d25623bd@redhat.com>
References: <20180302112050.26670-1-berto@igalia.com>
	<3c829c67-f6b9-ad7e-ba1d-a0f7d25623bd@redhat.com>
Date: Tue, 06 Mar 2018 11:25:02 +0100
Message-ID: <w514lltmrgh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 05 Mar 2018 05:59:47 PM CET, Max Reitz wrote:
> Secondly, I've reverted 3d5d319e1221082 to test this, and I could
> reproduce failure exactly once.  Since then, no luck (in like 20
> attempts, I think)...

Oh, I see. I was bisecting this and it seems that 1a63a907507fbbcf made
this problem more difficult to reproduce. If you revert that one too (in
addition to 3d5d319e1221082, that is) then it crashes very easily.

I don't think it makes sense to tweak the test ever further, I would
simply mention that "this triggers the bug that was fixed by 3d5d319e122
and 1a63a907507fbbcf" or something like that.

Berto
