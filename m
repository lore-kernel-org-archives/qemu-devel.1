Received: from eggs.gnu.org ([2001:4830:134:3::10]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfTQw-0002O2-CL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfTQt-0006zi-62
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfTQs-0006zW-W9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:02:07 -0400
Date: Wed, 9 Aug 2017 18:02:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809180200.39546490.cohuck@redhat.com>
In-Reply-To: <20170809141001.3b65e53f@bahia.lan>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<20170809114705.39dc0455@bahia.lan>
	<20170809130608.3ce61bd3.cohuck@redhat.com>
	<20170809141001.3b65e53f@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 9 Aug 2017 14:10:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 9 Aug 2017 13:06:14 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:

> > Should the condition be VIRTFS && (VIRTIO || XEN), then?  
> 
> That's what I was beginning to think as well :)

OK, here's what should work:

- fsdev/Makefile.objs needs to check for VIRTFS && (VIRTIO || XEN)
- hw/Makefile.objs needs to check for VIRTFS && (VIRTIO || XEN) before
  building hw/9pfs/
- hw/9pfs/Makefile.objs needs a new VIRTIO check for the virtio device

I'm preparing a patch.
