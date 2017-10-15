Received: from eggs.gnu.org ([2001:4830:134:3::10]:50485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3Wpv-0004Fl-Cz
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3Wps-0007km-9s
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3Wps-0007iM-3D
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:31:20 -0400
Date: Sun, 15 Oct 2017 03:31:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171015033021-mutt-send-email-mst@kernel.org>
References: <alpine.DEB.2.10.1709111119480.19719@sstabellini-ThinkPad-X260>
	<20170912031509.vufszbju3s2v2bw3@hz-desktop>
	<20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
	<f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
	<20171013075326.77azyi4j2wo3b2fx@hz-desktop>
	<20171013104453.50284426@nial.brq.redhat.com>
	<20171013111341.feb2462nh2rcrjpp@hz-desktop>
	<59E0C9F602000078001862C4@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1710131544350.2967@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1710131544350.2967@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v3 00/10] Implement vNVDIMM for
 Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Jan Beulich <JBeulich@suse.com>, Haozhong Zhang <haozhong.zhang@intel.com>, andrew.cooper3@citrix.com, Anthony Perard <anthony.perard@citrix.com>, george.dunlap@citrix.com, wei.liu2@citrix.com, ian.jackson@eu.citrix.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, xen-devel@lists.xen.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Oct 13, 2017 at 03:46:39PM -0700, Stefano Stabellini wrote:
> On Fri, 13 Oct 2017, Jan Beulich wrote:
> > >>> On 13.10.17 at 13:13, <haozhong.zhang@intel.com> wrote:
> > > To Jan, Andrew, Stefano and Anthony,
> > > 
> > > what do you think about allowing QEMU to build the entire guest ACPI
> > > and letting SeaBIOS to load it? ACPI builder code in hvmloader is
> > > still there and just bypassed in this case.
> > 
> > Well, if that can be made work in a non-quirky way and without
> > loss of functionality, I'd probably be fine. I do think, however,
> > that there's a reason this is being handled in hvmloader right now.
> 
> And not to discourage you, just as a clarification, you'll also need to
> consider backward compatibility: unless the tables are identical, I
> imagine we'll have to keep using the old tables for already installed
> virtual machines.

Maybe you can handle this using machine type versioning.
Installed guests would use the old type.

-- 
MST
