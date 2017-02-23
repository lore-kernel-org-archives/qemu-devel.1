Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgs9p-00080r-Tl
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgruN-0004Cr-LK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:50:04 -0500
Date: Thu, 23 Feb 2017 19:49:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223114956.GE14175@lemon.lan>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-11-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-11-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/54] vvfat: Use opened node as backing
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/21 15:58, Kevin Wolf wrote:
> -    backing = bdrv_new();
> +    backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
> +                                   &error_abort);
> +    *(void**) backing->opaque = s;

Could be simply "backing->opaque = s".

> +
>      bdrv_set_backing_hd(s->bs, backing);
>      bdrv_unref(backing);
>  
> -    s->bs->backing->bs->drv = &vvfat_write_target;
> -    s->bs->backing->bs->opaque = g_new(void *, 1);
> -    *(void**)s->bs->backing->bs->opaque = s;
> -
>      return 0;
>  
>  err:
> -- 
> 1.8.3.1
> 

Fam
