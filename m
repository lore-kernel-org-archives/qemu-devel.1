Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFLqN-0003PT-S7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFLqI-0002O4-8l
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:12:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eFLqI-0002Jk-3Q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:12:38 -0500
Date: Thu, 16 Nov 2017 15:12:33 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171116151233.GW2787@redhat.com>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
	<4ddf423b-a713-8f8b-e7dc-c970ad206885@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddf423b-a713-8f8b-e7dc-c970ad206885@kamp.de>
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, libguestfs@redhat.com, qemu-devel@nongnu.org

On Thu, Nov 16, 2017 at 03:51:29PM +0100, Peter Lieven wrote:
> Afaik all writes to the same QCOW2 serialize because of the s->lock that
> is held during the write. So its not suprising that there is no benefit from
> mutliple threads as long as reading from the RAW file involves no delay.
> Which is likely due to readahead of the OS.

I guess this would explain it, thanks.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
