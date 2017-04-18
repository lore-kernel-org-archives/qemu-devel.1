Received: from eggs.gnu.org ([2001:4830:134:3::10]:51260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0TZD-0002Il-00
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0TZ8-0005yf-V1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:53:15 -0400
Date: Tue, 18 Apr 2017 10:53:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170418135303.GM25239@thinpad.lan.raisama.net>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-6-ehabkost@redhat.com>
	<cdec6fba-6cbd-1e17-7f45-36dba034c174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdec6fba-6cbd-1e17-7f45-36dba034c174@redhat.com>
Subject: Re: [Qemu-devel] [RFC 5/7] pci: Set phb->bus inside
 pci_register_bus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Paul Burton <paul.burton@imgtec.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

On Tue, Apr 18, 2017 at 04:43:48PM +0300, Marcel Apfelbaum wrote:
> On 04/18/2017 12:59 AM, Eduardo Habkost wrote:
> > Every single caller of of pci_register_bus() saves the return value in
> > phb->bus. Do that inside pci_register_bus() to avoid code duplication
> > and make it harder to break.
> > 
> 
> I personally find that more difficult to follow, maybe the function
> name is misleading.
> Maybe we can find a better function name or explain the side effect
> in a comment?

I agree we need better function names (for both
pci_register_bus() and pci_bus_new*()). But I am not experienced
enough with the PCI code to find a good name. Any suggestions?

-- 
Eduardo
