Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZcCP-0006wA-3k
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZcCO-0006Ip-7v
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:38:41 -0500
Date: Fri, 3 Feb 2017 19:38:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170203113827.GS5151@pxdev.xzpeter.org>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<1485422381-29019-5-git-send-email-eric.auger@redhat.com>
	<20170126100643.GD2083@work-vm>
	<9bd0a672-d27c-f232-6ba0-67ad5c1e6f23@redhat.com>
	<20170203095529.GR5151@pxdev.xzpeter.org>
	<20170203095704.GA3208@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170203095704.GA3208@work-vm>
Subject: Re: [Qemu-devel] [RFC 4/4] hw/intc/arm_gicv3_its: Allow save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org, christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, quintela@redhat.com

On Fri, Feb 03, 2017 at 09:57:05AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Jan 26, 2017 at 02:30:17PM +0100, Auger Eric wrote:
> > 
> > [...]
> > 
> > > >> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > >> index 1a22887..ebd755c 100644
> > > >> --- a/include/migration/vmstate.h
> > > >> +++ b/include/migration/vmstate.h
> > > >> @@ -188,6 +188,8 @@ enum VMStateFlags {
> > > >>  
> > > >>  typedef enum {
> > > >>      MIG_PRI_DEFAULT = 0,
> > > >> +    MIG_PRI_GICV3_ITS,
> > > >> +    MIG_PRI_GICV3,
> > > >>      MIG_PRI_MAX,
> > > > 
> > > > Can we keep this commented so it's trivially easy to see the order, something like:
> > > > 
> > > >  typedef enum {
> > > >      MIG_PRI_DEFAULT = 0,
> > > > +    MIG_PRI_GICV3_ITS,    /* Needs to be before PCI devices */
> > > > +    MIG_PRI_GICV3,        /* Must be before ITS */
> > > Sure
> > > 
> > > Thanks!
> > 
> > Besides above: is it possible that in the future other platforms
> > (rather than ARM) can leverage these new introduced priority? If so,
> > would it be nicer that we use general names (like, e.g., INTCxxx? or
> > better?) rather than platform-specific names (like, GICxxx)?
> 
> Yes, but the ordering rules on other platforms might be subtly different.

I see. Then I have no problem in either way - we can rearrange the
defines until one day it is really needed. Thanks,

-- peterx
