Received: from eggs.gnu.org ([2001:4830:134:3::10]:49738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYbQW-0006A8-FQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYbQV-0004Wk-0N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:37:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
Date: Tue, 31 Jan 2017 17:36:22 +0100
Message-ID: <w51efzjnq49.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 31 Jan 2017 05:31:32 PM CET, Eric Blake wrote:

> Ideally, it would be nice to fix the block layer to allow larger
> requests (since we already have code to auto-fragment down to device
> limits, we should be able to rely on that code instead of having to
> duplicate artificial constraints everywhere else in the tree).  But
> that's a bigger task, and this is a good patch in the interim.

Related question: what's the largest request than a guest can
theoretically submit?

Berto
