Received: from eggs.gnu.org ([2001:4830:134:3::10]:58548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEcyt-0002ZD-Lr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEcys-0001pd-Eg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:18:31 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
References: <20171110224302.14424-1-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 16:18:20 +0100
Message-ID: <w51vaiczy6b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/4] blockdev: Mark
 BD-{remove, insert}-medium stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Fri 10 Nov 2017 11:42:58 PM CET, Max Reitz wrote:
> Berto's "Test I/O limits with removable media" patch proves that
> throttling survives a blockdev-remove-medium/blockdev-insert-medium pair
> now, so let's mark them stable (because that was the reason they were
> considered experimental, see commit
> 6e0abc251dd4f8eba1f53656dfede12e5840e83b for more).
>
> But before we do that, let's use the chance and drop the @device
> parameter.
>
>
> Based-on: <cover.1510339534.git.berto@igalia.com>
> ("Fix throttling crashes in BlockBackend with no BlockDriverState",
>  because of the test case added there)
>
>
> Max Reitz (4):
>   iotests: Make BD-{remove,insert}-medium use @id
>   tests/ahci: Switch tray and medium commands to @id
>   blockdev: Drop BD-{remove,insert}-medium's @device
>   blockdev: Mark BD-{remove,insert}-medium stable

This series,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
