Received: from eggs.gnu.org ([2001:4830:134:3::10]:38870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUmhG-0007PD-7J
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUmhB-0001M6-8E
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dUmhB-0001Lu-1b
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:22:45 -0400
Date: Tue, 11 Jul 2017 12:22:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170711042232.GA29326@pxdev.xzpeter.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-23-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170628190047.26159-23-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 22/29] vhost+postcopy: Call wakeups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Wed, Jun 28, 2017 at 08:00:40PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Cause the vhost-user client to be woken up whenever:
>   a) We place a page in postcopy mode

Just to make sure I understand it correctly - UFFDIO_COPY will only
wake up the waiters on the same userfaultfd context, so we don't need
to wake up QEMU userfaultfd (vcpu threads), but we need to explicitly
wake up other ufds/threads, like vhost-user backends. Am I right?

Thanks,

>   b) We get a fault and the page has already been received

-- 
Peter Xu
