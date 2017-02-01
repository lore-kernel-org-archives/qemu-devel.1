Received: from eggs.gnu.org ([2001:4830:134:3::10]:36606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZ2xY-0001Fg-UF
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZ2xV-00021h-NT
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:01:01 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1cd63da2-1cab-6404-9f20-c63d68b6f6a3@redhat.com>
References: <cover.1485878688.git.berto@igalia.com>
	<c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
	<9d413d87-33ac-7c41-2944-ec9974cd1e44@redhat.com>
	<w51k299lgoj.fsf@maestria.local.igalia.com>
	<1cd63da2-1cab-6404-9f20-c63d68b6f6a3@redhat.com>
Date: Wed, 01 Feb 2017 23:00:55 +0100
Message-ID: <w51y3xplgfc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't
 exceed INT_MAX
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

On Wed 01 Feb 2017 10:56:29 PM CET, Max Reitz <mreitz@redhat.com> wrote:

>> I was actually just reading virtio_blk_handle_request() and I see
>> that the I/O vector is initialized before the check for the maximum
>> request size that returns VIRTIO_BLK_S_IOERR.
>> 
>> So you're probably right and it's safer not to add that assertion.
>
> So... Apply patch 1 and hope we do everything right in the future? :-)

I think patch 1 is definitely necessary and enough to solve the crash
that I reported.

Tomorrow I'll think about what to do in place of the second one :-)

Berto
