Received: from eggs.gnu.org ([2001:4830:134:3::10]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLGrq-0001wg-K2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLGrl-00081w-Nk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:38:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLGrl-00081n-KL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:38:53 -0400
Date: Wed, 23 May 2018 02:38:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180523005048-mutt-send-email-mst@kernel.org>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<20180522234410-mutt-send-email-mst@kernel.org>
	<20180522153659.2e33fbe0@w520.home>
	<20180523004236-mutt-send-email-mst@kernel.org>
	<20180522154741.3939d1e0@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522154741.3939d1e0@w520.home>
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On Tue, May 22, 2018 at 03:47:41PM -0600, Alex Williamson wrote:
> On Wed, 23 May 2018 00:44:22 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, May 22, 2018 at 03:36:59PM -0600, Alex Williamson wrote:
> > > On Tue, 22 May 2018 23:58:30 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:   
> > > >
> > > > It's not hard to think of a use-case where >256 devices
> > > > are helpful, for example a nested virt scenario where
> > > > each device is passed on to a different nested guest.
> > > >
> > > > But I think the main feature this is needed for is numa modeling.
> > > > Guests seem to assume a numa node per PCI root, ergo we need more PCI
> > > > roots.  
> > > 
> > > But even if we have NUMA affinity per PCI host bridge, a PCI host
> > > bridge does not necessarily imply a new PCIe domain.  
> > 
> > What are you calling a PCIe domain?
> 
> Domain/segment
> 
> 0000:00:00.0
> ^^^^ This

Right. So we can thinkably have PCIe root complexes share an ACPI segment.
I don't see what this buys us by itself.

> Isn't that the only reason we'd need a new MCFG section and the reason
> we're limited to 256 buses?  Thanks,
> 
> Alex

I don't know whether a single MCFG section can describe multiple roots.
I think it would be certainly unusual.

-- 
MST
