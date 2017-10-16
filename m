Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1e46j5-0002kP-6x
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1e46j1-0004JW-AU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:50:43 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1e46j1-0004I9-2Y
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:50:39 -0400
Date: Mon, 16 Oct 2017 10:49:51 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20171016144951.GG30178@char.us.oracle.com>
References: <20170912031509.vufszbju3s2v2bw3@hz-desktop>
	<20171010160544.GA1772@char.us.oracle.com>
	<20171012124544.dq3wyr65tefi3glk@hz-desktop>
	<f6478644-0d4a-6531-9016-aee2a0e76417@redhat.com>
	<20171013075326.77azyi4j2wo3b2fx@hz-desktop>
	<20171013104453.50284426@nial.brq.redhat.com>
	<20171013111341.feb2462nh2rcrjpp@hz-desktop>
	<59E0C9F602000078001862C4@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1710131544350.2967@sstabellini-ThinkPad-X260>
	<20171015033021-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171015033021-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [Xen-devel] [RFC QEMU PATCH v3 00/10] Implement
 vNVDIMM for Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Haozhong Zhang <haozhong.zhang@intel.com>, wei.liu2@citrix.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org, andrew.cooper3@citrix.com, ian.jackson@eu.citrix.com, george.dunlap@citrix.com, xen-devel@lists.xen.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Beulich <JBeulich@suse.com>, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Chao Peng <chao.p.peng@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Sun, Oct 15, 2017 at 03:31:15AM +0300, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2017 at 03:46:39PM -0700, Stefano Stabellini wrote:
> > On Fri, 13 Oct 2017, Jan Beulich wrote:
> > > >>> On 13.10.17 at 13:13, <haozhong.zhang@intel.com> wrote:
> > > > To Jan, Andrew, Stefano and Anthony,
> > > > 
> > > > what do you think about allowing QEMU to build the entire guest ACPI
> > > > and letting SeaBIOS to load it? ACPI builder code in hvmloader is
> > > > still there and just bypassed in this case.
> > > 
> > > Well, if that can be made work in a non-quirky way and without
> > > loss of functionality, I'd probably be fine. I do think, however,
> > > that there's a reason this is being handled in hvmloader right now.
> > 
> > And not to discourage you, just as a clarification, you'll also need to
> > consider backward compatibility: unless the tables are identical, I
> > imagine we'll have to keep using the old tables for already installed
> > virtual machines.
> 
> Maybe you can handle this using machine type versioning.

<nods> And the type could be v2 if nvdimm was provided (which is
something that the toolstack would figure out).

The toolstack could also have a seperate 'v2' config flag if somebody
wanted to play with this _outside_ of having NVDIMM in the guest?


> Installed guests would use the old type.

<nods>
