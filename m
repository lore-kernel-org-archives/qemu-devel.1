Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fQF2E-0006Cs-HB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fQF2A-00051Q-Hk
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:42:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:11331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fQF2A-000508-5G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:42:10 -0400
Date: Tue, 5 Jun 2018 10:42:05 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180605164205.GA21034@linux.intel.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-4-ross.zwisler@linux.intel.com>
	<20180605182243-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605182243-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [qemu PATCH v4 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On Tue, Jun 05, 2018 at 06:25:27PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 10:32:02AM -0600, Ross Zwisler wrote:
> > Add a machine command line option to allow the user to control the Platform
> > Capabilities Structure in the virtualized NFIT.  This Platform Capabilities
> > Structure was added in ACPI 6.2 Errata A.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> 
> I tried playing with it and encoding the capabilities is
> quite awkward.
> 
> Can we add bits for specific capabilities instead of nvdimm-cap?
> 
> How about:
> 
> "cpu-flush-on-power-loss-cap"
> "memory-flush-on-power-loss-cap"
> "byte-addressable-mirroring-cap"

Hmmm...I don't like that as much because:

a) It's very verbose.  Looking at my current qemu command line few other
   options require that many characters, and you'd commonly be defining more
   than one of these for a given VM.

b) It means that the QEMU will need to be updated if/when new flags are added,
   because we'll have to have new options for each flag.  The current
   implementation is more future-proof because you can specify any flags
   value you want.

However, if you feel strongly about this, I'll make the change.
