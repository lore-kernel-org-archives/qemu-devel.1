Received: from eggs.gnu.org ([2001:4830:134:3::10]:36818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJhME-0003c8-V6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJhMA-0005U0-Vr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:31:50 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:33197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJhMA-0005Rr-Ny
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:31:46 -0400
Date: Fri, 18 May 2018 16:31:40 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180518153140.GW2057@perard.uk.xensource.com>
References: <1526654310-20797-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526654310-20797-1-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v4] xen-hvm: stop faking I/O to access PCI
 config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Roger Pau Monne <roger.pau@citrix.com>, Jan Beulich <JBeulich@suse.com>

On Fri, May 18, 2018 at 03:38:30PM +0100, Paul Durrant wrote:
> This patch removes the current hackery where IOREQ_TYPE_PCI_CONFIG
> requests are handled by faking PIO to 0xcf8 and 0xcfc and replaces it
> with direct calls to pci_host_config_read/write_common().
> Doing so necessitates mapping BDFs to PCIDevices but maintaining a simple
> QLIST in xen_device_realize/unrealize() will suffice.
> 
> NOTE: whilst config space accesses are currently limited to
>       PCI_CONFIG_SPACE_SIZE, this patch paves the way to increasing the
>       limit to PCIE_CONFIG_SPACE_SIZE when Xen gains the ability to
>       emulate MCFG table accesses.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
