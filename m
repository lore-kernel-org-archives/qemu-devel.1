Received: from eggs.gnu.org ([209.51.188.92]:46620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gpDzg-0001YY-V8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gpDze-0004We-Ff
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:11:08 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Date: Thu, 31 Jan 2019 16:11:00 +0100
Message-ID: <w51va24dfqz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Thu 17 Jan 2019 04:33:51 PM CET, Alberto Garcia wrote:
> Hi,
>
> here's a patch series to implement a QMP command for bdrv_reopen().
> This is not too different from the previous iteration (RFC v2, see
> changes below), but I'm not tagging it as RFC any longer.
>
> The new command is called x-blockdev-reopen, and it's designed to be
> similar to blockdev-add. It also takes BlockdevOptions as a
> parameter. The "node-name" field of BlockdevOptions must be set, and
> it is used to select the BlockDriverState to reopen.
