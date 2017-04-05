Received: from eggs.gnu.org ([2001:4830:134:3::10]:45570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvhL8-0006UI-OF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvhL7-0000Ij-W5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:34:58 -0400
Date: Wed, 5 Apr 2017 10:34:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170405093441.GH21911@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>

On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
> 
> when migration with high speed, mig_save_device_bulk invoke
> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
> this patch limit the time used for bdrv_is_allocated.

Can you explain why calling bdrv_is_allocated is impacting VNC performance ?

Migration is running in a background thread, so shouldn't be impacting the
main thread which handles VNC, unless the block layer is perhaps acquiring
the global qemu lock ? I wouldn't expect such a lock to be held for just
the bdrv_is_allocated call though.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
