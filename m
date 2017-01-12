Received: from eggs.gnu.org ([2001:4830:134:3::10]:44939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRiAr-0005Fu-V9
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRiAm-0006oh-V8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRiAm-0006nx-PQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:20 -0500
Date: Thu, 12 Jan 2017 18:24:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112182135-mutt-send-email-mst@kernel.org>
References: <1483175736-17137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110005600-mutt-send-email-mst@kernel.org>
	<5874C989.9080504@cn.fujitsu.com>
	<20170110170832-mutt-send-email-mst@kernel.org>
	<58759015.5060909@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58759015.5060909@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2] vfio/pci: Support error recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com

On Wed, Jan 11, 2017 at 09:53:25AM +0800, Cao jin wrote:
> 
> 
> On 01/10/2017 11:11 PM, Michael S. Tsirkin wrote:
> > On Tue, Jan 10, 2017 at 07:46:17PM +0800, Cao jin wrote:
> >>
> >>
> >> On 01/10/2017 07:04 AM, Michael S. Tsirkin wrote:
> >>> On Sat, Dec 31, 2016 at 05:15:36PM +0800, Cao jin wrote:
> >>>> Support serious device error recovery
> >>>
> >>> serious?
> >>>
> >>
> >> Sorry for my poor vocabulary if it confuses people. I wanted to express
> >> the meaning that: vfio-pci actually cannot do a real recovery for device
> >> even if it provides the callbacks, it relies on the user to do a
> >> effective(or word "serious"?) recovery.
> >>
> >> Welcome the amendment on the commit log.
> > 
> > It's up to Alex, maybe he's able to figure it all out from
> > code, but the rest of us could benefit from a description
> > of what the patch does from userspace point of view.
> > 
> > Also, is it a pre-requisite of the userspace patches you posted?
> > 
> 
> Yes, it is.

Looks like it's time for another design document :)
