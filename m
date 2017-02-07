Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cb7cQ-0007wv-L8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cb7cN-0003uB-Hi
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cb7cN-0003tE-BC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:23:43 -0500
Date: Tue, 7 Feb 2017 15:23:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170207152339.GN2635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
Subject: Re: [Qemu-devel] How to find backing file for qemu-nbd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikolay Ivanets <stenavin@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, Feb 07, 2017 at 04:25:27PM +0200, Nikolay Ivanets wrote:
> Is there any way to find source file supplied for qemu-nbd similar to loop
> device:
> 
> cat /sys/block/loop0/loop/backing_file

Nothing simple like that - you have to find the qemu-nbd process and see
what file(s) it has open I'm afraid and figure out which is the image file
from there.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
