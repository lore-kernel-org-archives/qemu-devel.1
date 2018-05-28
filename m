Received: from eggs.gnu.org ([2001:4830:134:3::10]:42720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fNMvJ-0000vP-5Y
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fNMvI-000544-92
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:31:13 -0400
Date: Mon, 28 May 2018 19:30:58 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180528183058.GG2209@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
> As someone who is just naive and doesn't see the big picture, I don't
> see what's wrong with using a tar file that contains the image and
> additional data.

FWIW an OVA file is exactly this: an uncompressed tar file containing
disk image(s) and metadata.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
