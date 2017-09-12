Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfmf-0004Cp-NF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfme-0007wh-UY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:39:01 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-13-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed12752c-8eb4-5d15-444f-cbf707b253ce@redhat.com>
Date: Tue, 12 Sep 2017 09:38:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 12/38] libqos: Use explicit QTestState
 for virtio operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

On 11.09.2017 19:19, Eric Blake wrote:
> Now that QVirtioDevice and QVirtQueue point back to QVirtioBus,
> we can reuse the explicit QTestState stored there rather than
> relying on implicit global_qtest.  We also have to pass QTestState
> through a few functions that can't trace back through
> QVirtioDevice, and update those callers.
> 
> Drop some useless casts while touching things.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/virtio.h      |  6 ++--
>  tests/libqos/virtio-mmio.c | 57 ++++++++++++++++++-------------
>  tests/libqos/virtio-pci.c  |  8 ++---
>  tests/libqos/virtio.c      | 84 ++++++++++++++++++++++++++--------------------
>  tests/virtio-blk-test.c    | 11 +++---
>  5 files changed, 94 insertions(+), 72 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
