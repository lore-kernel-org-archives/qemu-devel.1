Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwh21-00077i-GT
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwh20-0000L5-OR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:27:21 -0400
Date: Sat, 8 Apr 2017 11:27:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170408032708.GA6548@lemon>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
	<20170407132642.GF16146@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407132642.GF16146@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] coroutine: Explicitly specify
 AioContext when entering coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, 04/07 14:26, Stefan Hajnoczi wrote:
> I wasn't expecting the patch to touch so many places.  If a coroutine
> can be permanently associated with an AioContext then there's no need to
> keep assigning co->ctx on each qemu_coroutine_enter().

Maybe, but bs->job->co->ctx changes when bdrv_set_aio_context(bs->ctx) is
called. In v1 the co->ctx is associated at qemu_coroutine_create() time but
failed to handle bdrv_set_aio_context.

Fam
