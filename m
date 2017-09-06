Received: from eggs.gnu.org ([2001:4830:134:3::10]:55788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpYf2-0000wn-KC
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpYez-0002MD-Hx
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpYez-0002Lx-Bf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:38:21 -0400
Date: Wed, 6 Sep 2017 13:38:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906133817.344972d1.cohuck@redhat.com>
In-Reply-To: <20170906083708.GA31680@bjsdjshi@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
	<20170906083708.GA31680@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 6 Sep 2017 16:37:08 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-09-05 17:46:06 +0200]:
> 
> > On Tue, 5 Sep 2017 17:24:19 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> > > In the end I don't care that deeply about vfio-ccw, and this problem
> > > already took me more time than I intended to spend on this. We have
> > > people driving this whole vfio-ccw stuff and I'm not one of them (I'm
> > > rather in the supporting role).
> > > 
> > > I'm also fine with me being credited with a reported-by once the
> > > more involved people figure out what to do, and keeping the vfio-ccw
> > > stuff as is. Should we go with that option?   
> > 
> > If converting the reporting to a device status is straightforward
> > enough, let's do that. I'm fine with postponing this and waiting for a
> > real fix as well (I don't really have spare cycles to actually write
> > vfio-ccw code currently...)
> >   
> 
> I can do this after this series.

Cool, thanks!
