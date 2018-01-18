Received: from eggs.gnu.org ([2001:4830:134:3::10]:60406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAa2-0000QW-3m
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAa1-0008Jj-5W
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAa1-0008Ih-06
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:50:09 -0500
Date: Thu, 18 Jan 2018 13:50:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118135004.GC16350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-4-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171101142526.1006-4-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] io: Don't call close multiple times
 in QIOChannelFile
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

On Wed, Nov 01, 2017 at 02:25:25PM +0000, Ross Lagerwall wrote:
> If the file descriptor underlying QIOChannelFile is closed in the
> io_close() method, don't close it again in the finalize() method since
> the file descriptor number may have been reused in the meantime.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
> New in v2.
> 
>  io/channel-file.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
