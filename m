Received: from eggs.gnu.org ([2001:4830:134:3::10]:49120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0ZL8-0002dH-Af
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0ZL7-0008Jz-Km
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:03:06 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170412174920.8744-3-eblake@redhat.com> (Eric Blake's message
	of "Wed, 12 Apr 2017 12:49:10 -0500")
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-3-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 22:02:50 +0200
Message-ID: <87o9vth4b9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/12] migration: Don't lose errno across
 aio context changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> set_drity_tracking() was assuming that the errno value set by
> bdrv_create_dirty_bitmap() would not be corrupted by either
> blk_get_aio_context() or aio_context_release().  Rather than
> audit whether this assumption is safe, rewrite the code to just
> grab the value of errno sooner.
>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
