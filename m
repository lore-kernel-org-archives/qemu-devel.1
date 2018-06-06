Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQRuC-0006An-1k
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQRuB-0004sG-60
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:26:48 -0400
Date: Wed, 6 Jun 2018 08:26:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180606062641.yl7ndptpk6pm5sm4@sirius.home.kraxel.org>
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605190324.GA11372@localhost.localdomain>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

  Hi,

> Based on this proposal for layer 2, it looks like you expect the
> number of keys used on layer 1 to become large.
> 
> I would prefer a solution that expects a very small set of keys
> for layer 0+1, and point to other specifications of how the blob
> can be interpreted for each key.  This way we can experiment with
> different solutions for layers 2-4, instead of deciding on a
> specific format like JSON.

Well, you never know what people will use this for ...

cheers,
  Gerd
