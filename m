Received: from eggs.gnu.org ([2001:4830:134:3::10]:52250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2Pxb-0005Bo-3D
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2PxZ-0002vh-Nq
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:26:27 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d2PxZ-0002sr-Hi
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:26:25 -0400
Date: Mon, 24 Apr 2017 00:26:08 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170423222608.f3a7oky465xpqb7x@aurel32.net>
References: <20170423160854.3478-1-aurelien@aurel32.net>
	<1DFAD716-AE63-46E6-86E4-31032DFDA0BC@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DFAD716-AE63-46E6-86E4-31032DFDA0BC@suse.de>
Subject: Re: [Qemu-devel] [PATCH] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2017-04-23 19:19, Alexander Graf wrote:
> 
> 
> > Am 23.04.2017 um 18:08 schrieb Aurelien Jarno <aurelien@aurel32.net>:
> > 
> > s390_virtio_hypercall can trigger IO events and interrupts, most notably
> > when using virtio-ccw devices.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> > roms/qemu-palcode          | 2 +-
> > roms/seabios               | 2 +-
> > target/s390x/misc_helper.c | 2 ++
> > 3 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/roms/qemu-palcode b/roms/qemu-palcode
> > index f3c7e44c70..c87a92639b 160000
> > --- a/roms/qemu-palcode
> > +++ b/roms/qemu-palcode
> > @@ -1 +1 @@
> > -Subproject commit f3c7e44c70254975df2a00af39701eafbac4d471
> > +Subproject commit c87a92639b28ac42bc8f6c67443543b405dc479b
> > diff --git a/roms/seabios b/roms/seabios
> > index 5f4c7b13cd..e2fc41e24e 160000
> > --- a/roms/seabios
> > +++ b/roms/seabios
> > @@ -1 +1 @@
> > -Subproject commit 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
> > +Subproject commit e2fc41e24ee0ada60fc511d60b15a41b294538be
> 
> I guess you didn't mean to send those hunks?

Indeed that's a mistake sorry, i'll resend a new version.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
