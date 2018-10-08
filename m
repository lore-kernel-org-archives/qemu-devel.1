Received: from eggs.gnu.org ([2001:4830:134:3::10]:55246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9ZyU-0001rC-5B
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9ZuU-0006jK-Ft
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:05:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <2e99d517-ae42-0692-fe6e-66de36f73c9d@redhat.com>
References: <cover.1537367701.git.berto@igalia.com>
	<8f8a151dae565027208268ed8d120e4612ef5f9f.1537367701.git.berto@igalia.com>
	<2e99d517-ae42-0692-fe6e-66de36f73c9d@redhat.com>
Date: Mon, 08 Oct 2018 20:04:50 +0200
Message-ID: <w51a7no71rx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/14] block: Use
 bdrv_reopen_set_read_only() in external_snapshot_commit()
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

On Mon 08 Oct 2018 03:31:08 AM CEST, Max Reitz wrote:
> On 19.09.18 16:47, Alberto Garcia wrote:
>> This patch replaces the bdrv_reopen() calls that set and remove the
>> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>
> Ha!  Got you!  It's just one call this time, not "calls"! :-)

:-D

Berto
