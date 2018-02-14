Received: from eggs.gnu.org ([2001:4830:134:3::10]:39083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1em0rZ-0001Uj-RT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1em0rZ-0007i6-2K
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:28:57 -0500
Date: Wed, 14 Feb 2018 18:28:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214172829.GH4766@localhost.localdomain>
References: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: fix write with zero flag set
 and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, berto@igalia.com

Am 14.02.2018 um 17:09 hat Anton Nefedov geschrieben:
> v3: patch 1: image cluster size reduced to get away with a smaller test image
>     (the cluster size can be as small as 512 bytes for qcow2,
>      but the test runs for all generic formats and minimum for qed is 4k)

Thanks, applied to the block branch (in reverse order, tests should
always pass).

Kevin
