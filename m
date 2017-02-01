Received: from eggs.gnu.org ([2001:4830:134:3::10]:58201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYs1X-00029L-PC
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYs1T-0000bV-SX
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:20:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cYs1T-0000bN-Ml
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:20:19 -0500
Date: Wed, 1 Feb 2017 10:20:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170201102013.GC3232@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Wed, Feb 01, 2017 at 11:06:46AM +0100, Ladi Prosek wrote:
> Analogous to guest-file-read and guest-file-write, this commit adds
> support for issuing IOCTLs to files in the guest. With the goal of
> abstracting away the differences between Posix ioctl() and Win32
> DeviceIoControl() to provide one unified API, the schema distinguishes
> between input and output buffer sizes (as required by Win32) and
> allows the caller to supply either a 'buffer', pointer to which will
> be passed to the Posix ioctl(), or an integer argument, passed to
> ioctl() directly.

What is the intended usage scenario for this ?

The size of arguments that need to be provided to ioctl()s vary on
the architecture of the guest kernel that's running, which cannot be
assumed to be the same as the architecture of the QEMU binary. ie
you can be running i686 kernel in an x86_64 QEMU.  So it feels like
it is going to be hard for applications to reliably use this feature
unless they have more information about the guest OS, that is not
currently provided by QEMU guest agent. So it feels like this design
is not likely to be satisfactory to me.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
