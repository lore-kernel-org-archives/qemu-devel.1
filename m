Received: from eggs.gnu.org ([2001:4830:134:3::10]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFfBZ-0005l9-8q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFfBY-00050a-7k
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:19:37 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFfBY-00050J-1n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:19:36 -0400
Date: Tue, 30 May 2017 13:19:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170530111935.y3y7s47wdt7pgmyd@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-3-aurelien@aurel32.net>
	<def8df90-33e4-1ed3-5dbc-e8f9e872e671@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def8df90-33e4-1ed3-5dbc-e8f9e872e671@redhat.com>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH v2 02/29] target/s390x: remove some Linux
 assumptions from IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 2017-05-30 10:20, Thomas Huth wrote:
> On 29.05.2017 21:24, Aurelien Jarno wrote:
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target/s390x/cpu.h        |  2 ++
> >  target/s390x/mem_helper.c | 17 ++++++++++-------
> >  target/s390x/mmu_helper.c |  4 +---
> >  3 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> > index 79235cfa45..d89ad83e71 100644
> > --- a/target/s390x/cpu.h
> > +++ b/target/s390x/cpu.h
> > @@ -1033,6 +1033,8 @@ struct sysib_322 {
> >  #define _SEGMENT_ENTRY_RO       0x200     /* page protection bit              */
> >  #define _SEGMENT_ENTRY_INV      0x20      /* invalid segment table entry      */
> >  
> > +#define _VADDR_PX               0xff000   /* page index bits                  */
> 
> Even though the other #defines start with an underscore, we should not
> use this for new code anymore. #defines that start with an underscore +
> capital letter are reserved for the C compiler. If you're afraid that
> this "VADDR_PX" is not unique enough, maybe rename it to "MMU_VADDR_PX"
> instead?

Ok, I'll change that, possibly renaming a few other defines.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
