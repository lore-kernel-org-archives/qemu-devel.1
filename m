Received: from eggs.gnu.org ([2001:4830:134:3::10]:55455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdAaA-0006DV-5G
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdAa6-00045r-TO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:34:42 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fdAa6-00045Q-GO
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 04:34:38 -0400
Date: Wed, 11 Jul 2018 11:34:31 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20180711083431.GA5085@dimastep-nix>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
	<1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
	<20180619141216.GA16512@dimastep-nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619141216.GA16512@dimastep-nix>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, pbonzini@redhat.com

Gentle ping. CCing Paolo Bonzini.

Regards, Dima.

On Tue, Jun 19, 2018 at 05:12:16PM +0300, Dima Stepanov wrote:
> Ping.
> 
> Regards, Dima.
> 
> On Wed, Jun 13, 2018 at 11:19:55AM +0300, Dima Stepanov wrote:
> > In the memory_region_do_invalidate_mmio_ptr() routine the section
> > variable is intialized by the memory_region_find() call. The section.mr
> > field can be set to NULL.
> > 
> > Add the check for NULL before trying to drop a section.
> > 
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index 3212acc..bb45248 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -2712,7 +2712,7 @@ static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
> >      /* Reset dirty so this doesn't happen later. */
> >      cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> >  
> > -    if (section.mr != mr) {
> > +    if (section.mr && (section.mr != mr)) {
> >          /* memory_region_find add a ref on section.mr */
> >          memory_region_unref(section.mr);
> >          if (MMIO_INTERFACE(section.mr->owner)) {
> > -- 
> > 2.7.4
> > 
> > 
