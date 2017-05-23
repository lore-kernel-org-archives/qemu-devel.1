Received: from eggs.gnu.org ([2001:4830:134:3::10]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDCAW-0006Qc-6q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDCAV-0007JO-89
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:56:20 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDCAV-0007J8-1a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:56:19 -0400
Date: Tue, 23 May 2017 17:56:15 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523155615.qkxt6aifvawr4bvr@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523104851.37tseiq5zlpwevr6@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-23 12:48, Aurelien Jarno wrote:
> On 2017-05-22 20:02, Richard Henderson wrote:
> > Previously, helper_ex would construct the insn and then implement
> > the insn via direct calls other helpers.  This was sufficient to
> > boot Linux but that is all.
> > 
> > It is easy enough to go the whole nine yards by stashing state for
> > EXECUTE within the cpu, and then relying on a new TB to be created
> > that properly and completely interprets the insn.
> > 
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/s390x/cpu.h         |   4 +-
> >  target/s390x/helper.h      |   2 +-
> >  target/s390x/insn-data.def |   4 +-
> >  target/s390x/machine.c     |  19 +++++++
> >  target/s390x/mem_helper.c  | 136 +++++++++++----------------------------------
> >  target/s390x/translate.c   | 124 +++++++++++++++++++++++++----------------
> >  6 files changed, 133 insertions(+), 156 deletions(-)
> 
> This looks good on the principle, and finally removes a big hack. That
> said it prevent my test system to boot. I haven't investigated why yet.

This can aslo be reproduced using the kernel and initrd from the daily
Debian installer:

  https://d-i.debian.org/daily-images/s390x/daily/generic/

I am personally using the following command line:

  qemu-system-s390x -M s390-ccw-virtio -m 512 -nographic -kernel kernel.debian -initrd initrd.debian

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
