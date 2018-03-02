Received: from eggs.gnu.org ([2001:4830:134:3::10]:48161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erpZP-0002ub-Ag
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erpZK-0006Zr-7N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:38:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erpZK-0006ZZ-1P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:38:10 -0500
Date: Fri, 2 Mar 2018 20:37:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302203557-mutt-send-email-mst@kernel.org>
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
	<1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Fri, Mar 02, 2018 at 04:47:29PM +0800, Wei Wang wrote:
> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
> index af49e19..16a2aae 100644
> --- a/include/sysemu/balloon.h
> +++ b/include/sysemu/balloon.h

...

> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
> +typedef void (QEMUBalloonFreePageStop)(void *opaque);

So I think the rule is that no bitmap sync must happen
between these two, otherwise a hint might arrive and
override the sync output.

Should be documented I think.

-- 
MST
