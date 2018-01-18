Received: from eggs.gnu.org ([2001:4830:134:3::10]:32842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAaR-0000nH-52
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAaN-0000Ox-Tb
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAaN-0000OQ-LF
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:31 -0500
Date: Thu, 18 Jan 2018 13:50:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118135024.GD16350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-5-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171101142526.1006-5-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] io: Add /dev/fdset/ support to
 QIOChannelFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org

On Wed, Nov 01, 2017 at 02:25:26PM +0000, Ross Lagerwall wrote:
> Add /dev/fdset/ support to QIOChannelFile by calling qemu_open() instead
> of open() and qemu_close() instead of close(). There is a subtle
> semantic change since qemu_open() automatically sets O_CLOEXEC, but this
> doesn't affect any of the users of the function.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
> Changed in v2:
> * Split into separate patch.
> 
>  io/channel-file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
