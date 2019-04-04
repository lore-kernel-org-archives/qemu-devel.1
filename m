Received: from eggs.gnu.org ([209.51.188.92]:60031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hC4S5-0000g3-6V
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hC4S4-0007le-AH
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:38:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hC4S4-0007ek-0U
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:38:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so3947085wmk.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 08:38:51 -0700 (PDT)
Date: Thu, 4 Apr 2019 17:38:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190404153847.vcif7wgtyabiyrhw@steredhat>
References: <20190404150746.12585-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404150746.12585-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] block: Forward 'discard' to
 temporary overlay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Apr 04, 2019 at 05:07:46PM +0200, Kevin Wolf wrote:
> When bdrv_temp_snapshot_options() is called for snapshot=on, the
> 'discard' option in the options QDict hasn't been parsed and merged into
> the flags yet. So copy the dict entry to make sure that the temporary
> overlay enables discard when it was requested for the drive.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
