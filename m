Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1fg8Yb-0004He-1E
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1fg8VT-0006Ng-Bf
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1fg8VS-0006LB-Pk
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:07 -0400
Date: Thu, 19 Jul 2018 08:57:56 -0400
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180719085756.1b1f9678@doriath>
In-Reply-To: <20180719084819.730b7971@doriath>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<20180718085529.133a0a22@doriath>
	<367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com>
	<20180719121635.GA28107@stefanha-x1.localdomain>
	<20180719084819.730b7971@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, imammedo@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com

On Thu, 19 Jul 2018 08:48:19 -0400
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.  
> 
> Yes, defining your own constants work. But I think the only fsync()
> error that will make sense for the guest is EIO. The other errors
> only make sense for the host.

Just to clarify: of course you'll return an error to guest on any
fsync() error. But maybe you should always return EIO even if the error
was EBADF for example. Or just signal the error with some constant,
and let the guest implementation pick any errno it prefers (this was
my first suggestion).
