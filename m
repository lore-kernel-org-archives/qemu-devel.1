Received: from eggs.gnu.org ([2001:4830:134:3::10]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNedL-0003hO-FX
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNedI-0001E5-9Y
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:58:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
References: <20181011072135.588-1-famz@redhat.com>
	<20181011072135.588-3-famz@redhat.com>
	<w51tvkjkbmc.fsf@maestria.local.igalia.com>
	<8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
Date: Fri, 16 Nov 2018 14:58:01 +0100
Message-ID: <w51lg5tunti.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/3] file-posix: Drop
 s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Fri 16 Nov 2018 02:34:25 PM CET, Max Reitz wrote:
> To me that looks like a problem in the general reopen code.
> raw_reopen_prepare() is called and succeeds.  Then
> bdrv_reopen_prepare() notices the option wasn't handled and therefore
> fails.  bdrv_reopen_multiple() thus doesn't set bs_entry->prepared to
> true, which means raw_reopen_abort() won't be called.
>
> We should always call either BlockDriver.bdrv_reopen_commit() or
> BlockDriver.bdrv_reopen_abort() when BlockDriver.bdrv_reopen_prepare()
> succeeded.

So you mean getting rid of BlockReopenQueueEntry.prepared altogether?

Berto
