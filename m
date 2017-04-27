Received: from eggs.gnu.org ([2001:4830:134:3::10]:52773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1d3jlL-0005Mw-8Z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1d3jlH-0004H8-8q
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1d3jlH-0004Fr-2j
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:47:11 -0400
Date: Thu, 27 Apr 2017 15:47:07 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170427134707.GG3508@redhat.com>
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
	<8a107a40-073c-8181-75aa-e5700f2900a7@de.ibm.com>
	<20170426190442.GG2394@work-vm> <20170426193743.GF3508@redhat.com>
	<20170427032037.GE26792@pxdev.xzpeter.org>
	<750be300-6f14-cbef-4b38-f28751e28032@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750be300-6f14-cbef-4b38-f28751e28032@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com

On Thu, Apr 27, 2017 at 08:44:03AM +0200, Christian Borntraeger wrote:
> I have started instrumenting the kernel. I can see a set_pte_at for this address
> and I see an (to be understood) invalidation shortly after that which explains
> why I get a fault.

Sounds great that you can see an invalidation shortly after, that is
the real source of the problem. Can you get a stack trace of such
invalidation?

Thanks!
Andrea
