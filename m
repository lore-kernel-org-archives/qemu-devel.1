Received: from eggs.gnu.org ([2001:4830:134:3::10]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOnTY-0003Xq-Kj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOnTV-00032Y-Gi
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:27:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOnTV-00031f-9v
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:27:37 -0500
Date: Wed, 4 Jan 2017 15:27:31 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104152731.GF10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170104145652.30442-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170104145652.30442-1-nathan@nathanrossi.com>
Subject: Re: [Qemu-devel] [PATCH] configure: For libgcrypt if pkg-config is
 available use it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nathan Rossi <nathan@nathanrossi.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

On Thu, Jan 05, 2017 at 12:56:52AM +1000, Nathan Rossi wrote:
> If libgcrypt info is available with pkg-config use it over using the
> libgcrypt-config. pkg-config is preferred due to is compatibility with
> cross-compilation (where you cannot execute the targets version of
> libgcrypt-config).

It can be made to work, but you need to modify $PATH to ensure it finds
the build target libgcrypt-config first.

eg on Fedora you'd do this with mingw32

   PATH=/usr/i686-w64-mingw32/sys-root/mingw/bin:$PATH ./configure ...

> This change makes configure check for libgcrypt in pkg-config first,
> then falling back to use libgcrypt-config if available. This follows a
> similar process to how libsdl is handled.

AFAIK, no version of libgcrypt has ever shipped a pkg-config file. Their
maintainers have explicitly rejected patches adding that, ironically
because they claim pkg-config doesn't handle cross-compilation and
libgcrypt-config does :-)

https://lists.gnupg.org/pipermail/gcrypt-devel/2007-February/001109.html
https://lists.gnupg.org/pipermail/gcrypt-devel/2015-September/003569.html


So overall, I don't think this patch is needed/desirable for QEMU.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
