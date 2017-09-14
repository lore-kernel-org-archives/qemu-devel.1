Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsLnN-0006OE-IJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsLnK-0005B0-Dl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsLnK-00059o-8K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:30:30 -0400
Date: Thu, 14 Sep 2017 12:30:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170914043022.GI3617@pxdev.xzpeter.org>
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505328054-23805-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 13, 2017 at 08:40:54PM +0200, Thomas Huth wrote:
> A lot of tests provide code for adding and removing a device via the
> device_add and device_del QMP commands. Maintaining this code in so many
> places is cumbersome and error-prone (some of the code parts check the
> responses for device deletion in an incorrect way, for example, we've got
> to deal with both, error code and DEVICE_DEL event here). So let's provide
> some proper generic functions for adding and removing a device instead.
> 
> The code for correctly unplugging a device has been taken from a patch
> from Peter Xu.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I verified that this patch passes the "make check" either on master
branch or my private branch (which broke before this one). So:

Tested-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu
