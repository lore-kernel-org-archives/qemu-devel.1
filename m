Received: from eggs.gnu.org ([2001:4830:134:3::10]:38681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKn9F-0005eX-Uc
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKn9B-0005KC-2b
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:54:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:47198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fKn9A-0005JL-ON
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:54:52 -0400
Date: Mon, 21 May 2018 09:54:49 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180521155449.GA22635@linux.intel.com>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
	<20180517050024.20101-4-ross.zwisler@linux.intel.com>
	<AT5PR8401MB11697DD6A19AA3F499ACDDBAAB910@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
	<20180518152306.GA3413@linux.intel.com>
	<AT5PR8401MB11694A7F7825A488105AEFADAB900@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB11694A7F7825A488105AEFADAB900@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] [qemu PATCH v2 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: 'Ross Zwisler' <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, May 18, 2018 at 04:37:10PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> ...
> > Would it help to show them in hex?
> > 
> >   As of ACPI 6.2 Errata A, the following values are valid for the bottom
> >   two bits:
> > 
> >   0x2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capable.
> >   0x3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.
> 
> Yes, that helps (unless the parser for that command-line does not 
> accept hex values).

Yep, the command-line parser does accept hex values.  I ended up just trying
to make the text clearer, though.

> It would also help to make the text be:
> 	"CPU Cache and Memory Controller Flush"

My descriptions for the bits are coming straight out of ACPI. :)  I'd prefer
to stay consistent with what's written in the spec.
