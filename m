Received: from eggs.gnu.org ([2001:4830:134:3::10]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWMPI-00033h-2P
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWMPE-0006WB-6x
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:47:20 -0400
Date: Fri, 22 Jun 2018 15:47:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180622154708.37167025.cohuck@redhat.com>
In-Reply-To: <5df62baa-268b-2624-e9d7-42c521546d04@de.ibm.com>
References: <152967373830.876.17089841294743780259@d39dc562802a>
	<5df62baa-268b-2624-e9d7-42c521546d04@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, david@redhat.com, agraf@suse.de, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Fri, 22 Jun 2018 15:29:04 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/22/2018 03:22 PM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed docker-mingw@fedora build test. Please find the testing commands and
> > their output below. If you have Docker installed, you can probably reproduce it
> > locally.
> >   
> 
> [...]
> 
> >   CC      os-win32.o
> >   CC      bt-host.o
> >   CC      bt-vhci.o
> >   CC      dma-helpers.o
> >   CC      vl.o
> >   CC      tpm.o
> >   CC      device_tree.o
> > /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
> > /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >      *length = end - offset;
> >                ~~~~^~~~~~~~
> > /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
> >      uint64_t begin = offset, end;
> >                               ^~~
> > cc1: all warnings being treated as errors  
> 
> This seems unrelated to the patch?
> 

Yes, the last few patches all failed with this error.
