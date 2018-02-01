Received: from eggs.gnu.org ([2001:4830:134:3::10]:58865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIIj-0005GU-SK
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIIg-0002dv-NA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:05:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehIIf-0002cT-TJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:05:26 -0500
Date: Thu, 1 Feb 2018 19:05:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201190326-mutt-send-email-mst@kernel.org>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
	<CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
	<20180201000240.zmwa6wwnthg2su36@hz-desktop>
	<CAPcyv4gZSGtPLt7ED0eOngYApHM8=9CTTjOHKpDCG-GfBes4xQ@mail.gmail.com>
	<20180201002457.hgyvph7z6iys5yvy@hz-desktop>
	<CAPcyv4g=1FQYWTAjrrm9DmZaP3nZEZJKXc6JC=f8GSWhccv+wg@mail.gmail.com>
	<20180201022900.4znup2fovqr7bu5m@hz-desktop>
	<CAPcyv4i0UFoq-ot0KPBeNaDhENUZJs9iFdjotKny=kSnOHXeMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i0UFoq-ot0KPBeNaDhENUZJs9iFdjotKny=kSnOHXeMw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Jan 31, 2018 at 07:02:27PM -0800, Dan Williams wrote:
> > Another question is how a user-space application (e.g., QEMU) knows
> > whether it's safe to mmap a file on the DAX file system?
> 
> I think we fix vaddr_get_pfn() to start failing for DAX mappings
> unless/until we can add a "with lease" mechanism. Userspace will know
> when it is safe again when vfio stops failing.

I read some of the discussion around that but could not figure out what
exactly does happen if a file is truncated by a malicious userspace.
Could you let me know pls? Thanks!

-- 
MST
