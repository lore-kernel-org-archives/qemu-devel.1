Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85vV-0005u1-Is
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85vU-0007Gq-Jl
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:52:33 -0400
Date: Thu, 4 Oct 2018 17:52:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004155200.GJ6009@localhost.localdomain>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-8-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534844779-118784-8-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 7/8] file-posix: account discard
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

Am 21.08.2018 um 11:46 hat Anton Nefedov geschrieben:
> This will help to identify how many of the user-issued discard operations
> (accounted on a device level) have actually suceeded down on the host file
> (even though the numbers will not be exactly the same if non-raw format
> driver is used (e.g. qcow2 sending metadata discards)).
> 
> Note that these numbers will not include discards triggered by
> write-zeroes + MAY_UNMAP calls.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Why not implement accounting at the BDS level for all drivers? Then we
can also reuse the existing BlockStats fields instead of duplicating
them into driver-specific new ones.

Kevin
