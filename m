Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAaz-0001CB-BA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecAaw-0000rM-3P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecAav-0000r2-TE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:51:06 -0500
Date: Thu, 18 Jan 2018 13:51:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118135101.GE16350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] QIOChannelFile bug fixes
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

On Wed, Nov 01, 2017 at 02:25:22PM +0000, Ross Lagerwall wrote:
> Hi,
> 
> Here is a bug fix with the use of QIOChannelFile and 2 bug fixes and an
> improvement to implementation of QIOChannelFile.
> 
> Regards,
> Ross Lagerwall
> 
> Ross Lagerwall (4):
>   migration: Don't leak IO channels
>   io: Fix QIOChannelFile when creating and opening read-write
>   io: Don't call close multiple times in QIOChannelFile
>   io: Add /dev/fdset/ support to QIOChannelFile

I've queued the 3 io patches, but will leave the migration one for
the migration maintainer's queue.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
