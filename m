Received: from eggs.gnu.org ([2001:4830:134:3::10]:37717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emMnj-0002O4-0y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emMng-0007CT-EG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:54:27 -0500
Date: Thu, 15 Feb 2018 16:54:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180215165418.GA24818@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863726311.3003.8227524786940828598.stgit@bahia.lan>
	<20180215040818.GH5247@umbus.fritz.box>
	<20180215170831.39645199@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215170831.39645199@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: drop DIV_ROUND_UP() from
 xics_max_server_number()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>

On Thu, Feb 15, 2018 at 05:08:57PM +0100, Greg Kurz wrote:
> On Thu, 15 Feb 2018 15:08:18 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Wed, Feb 14, 2018 at 08:41:03PM +0100, Greg Kurz wrote:
> 
> <snip>
> 
> > > 
> > > It breaks migration of pre-2.7 machine types with unusual CPU topologies,
> > > but I guess this is an acceptable trade-off.  
> > 
> > No, not really.  Weird topologies are still allowed on old machine
> > types for backwards compatibility, and we shouldn't break that.  I
> > like the idea of consolidating this calculation, but we can't do it by
> > just breaking the older machines (at least not until they're formally
> > deprecated).
> > 
> 
> Heh, I had put this patch at the end because I was expecting you might
> nack it :)
> 
> Per curiosity, when/how do we decide that an older machine type may be
> formally deprecated ?

For versioned machine types we decided that we'd keep them around upstream
for as long as they were needed by a downstream vendor, *provided* that
downstream vendor is contributing to QEMU in order to mitigate the maint
burden it would entail. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
