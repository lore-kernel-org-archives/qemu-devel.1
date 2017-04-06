Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cw9RX-0005G9-Vd
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cw9RT-0000TX-EJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cw9RT-0000T9-5b
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:35:23 -0400
Date: Thu, 6 Apr 2017 09:35:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170406093519.6ee61338@t450s.home>
In-Reply-To: <58E60218.4040500@cn.fujitsu.com>
References: <58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home>
	<58E4B0C9.50109@cn.fujitsu.com>
	<20170405133822.76cda620@t450s.home>
	<20170406004845-mutt-send-email-mst@kernel.org>
	<20170405161910.26fee7d1@t450s.home>
	<20170406013534-mutt-send-email-mst@kernel.org>
	<58E60218.4040500@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Thu, 6 Apr 2017 16:53:44 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> On 04/06/2017 06:36 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 05, 2017 at 04:19:10PM -0600, Alex Williamson wrote:  
> >> On Thu, 6 Apr 2017 00:50:22 +0300
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>  
> >>> On Wed, Apr 05, 2017 at 01:38:22PM -0600, Alex Williamson wrote:  
> >>>> The previous intention of trying to handle all sorts of AER faults
> >>>> clearly had more value, though even there the implementation and
> >>>> configuration requirements restricted the practicality.  For instance
> >>>> is AER support actually useful to a customer if it requires all ports
> >>>> of a multifunction device assigned to the VM?  This seems more like a
> >>>> feature targeting whole system partitioning rather than general VM
> >>>> device assignment use cases.  Maybe that's ok, but it should be a clear
> >>>> design decision.    
> >>>
> >>> Alex, what kind of testing do you expect to be necessary?
> >>> Would you say testing on real hardware and making it trigger
> >>> AER errors is a requirement?  
> >>
> >> Testing various fatal, non-fatal, and corrected errors with aer-inject,
> >> especially in multfunction configurations (where more than one port
> >> is actually usable) would certainly be required.  If we have cases where
> >> the driver for a companion function can escalate a non-fatal error to a
> >> bus reset, that should be tested, even if it requires temporary hacks to
> >> the host driver for the companion function to trigger that case.  AER
> >> handling is not something that the typical user is going to experience,
> >> so it should to be thoroughly tested to make sure it works when needed
> >> or there's little point to doing it at all.  Thanks,
> >>
> >> Alex  
> > 
> > Some things can be tested within a VM. What would you
> > say would be sufficient on a VM and what has to be
> > tested on bare metal?
> >   
> 
> Does the "bare metal" here mean something like XenServer?

No, bare metal means the non-virtualized host OS.  I think Michael was
trying to facilitate testing by proposing to do it in a VM such that we
can create strange and interesting topologies that aren't bound by a
system in a remote lab having only one NIC port connected.  Thanks,

Alex
