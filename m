Received: from eggs.gnu.org ([2001:4830:134:3::10]:54695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drN6O-0002oB-H9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drN6J-0005fP-IN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:42:08 -0400
Date: Mon, 11 Sep 2017 13:41:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911134158.1f046176.cohuck@redhat.com>
In-Reply-To: <20170911110615.GK21444@redhat.com>
References: <20170911110037.6567-1-lvivier@redhat.com>
	<20170911110615.GK21444@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11 Sep 2017 12:06:15 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Mon, Sep 11, 2017 at 01:00:37PM +0200, Laurent Vivier wrote:
> > Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
> > fixes the problem for i386, do the same for ppc.  
> 
> What about all the other targets QEMU supports ?  Have you checked if they
> are similarly affected, as we don't want to wait another 6 months to get a
> bug report that s390 or aarch64 crash in exactly the same way too.

This patch actually prompted me to check s390, and the mentioned
command line works fine.

However, if we start a qemu with no guest memory defined and then call
dump-guest-memory without filtering, we get a core dump instead of a
guest dump (s390x or x86_64, machine none).

I can take a stab at fixing that, unless someone beats me to it.
