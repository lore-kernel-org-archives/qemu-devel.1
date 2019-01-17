Received: from eggs.gnu.org ([209.51.188.92]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk6Gj-0005GU-K6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk6Gc-00073X-4U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:55:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk6GY-0006rU-Te
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:55:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so10694974wrw.5
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 03:55:20 -0800 (PST)
Date: Thu, 17 Jan 2019 12:55:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117115516.a7boafcxyuyuln5c@steredhat>
References: <1547691856-26675-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547691856-26675-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user-blk: add discard/write
 zeroes features support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com

Note: I removed my wrong e-mail address in CC.

On Thu, Jan 17, 2019 at 10:24:16AM +0800, Changpeng Liu wrote:
> Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
> added the support in the Guest kernel, while here also enable the features
> support with vhost-user-blk driver. Also enable the test example utility
> with DISCARD and WRITE ZEROES commands.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c     | 134 +++++++++++++++++++++-------
>  hw/block/vhost-user-blk.c                   |   4 +
>  include/standard-headers/linux/virtio_blk.h |  54 +++++++++++
>  3 files changed, 159 insertions(+), 33 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
