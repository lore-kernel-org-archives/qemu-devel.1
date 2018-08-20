Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frg4T-0000Iq-I7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frg4P-00045d-Qq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:01:57 -0400
Date: Mon, 20 Aug 2018 11:01:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180820110144.4b738f07.cohuck@redhat.com>
In-Reply-To: <20180731132930.7640008f.cohuck@redhat.com>
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
	<20180731132930.7640008f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] etoken patch for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>

On Tue, 31 Jul 2018 13:29:30 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 31 Jul 2018 11:04:46 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > this depends on the current kvms390/next kernel tree.
> > 
> > Christian Borntraeger (2):
> >   header sync
> >   s390x/kvm: add etoken facility
> > 
> >  linux-headers/asm-s390/kvm.h    |  5 ++++-
> >  target/s390x/cpu.h              |  3 +++
> >  target/s390x/cpu_features.c     |  3 ++-
> >  target/s390x/cpu_features_def.h |  3 ++-
> >  target/s390x/gen-features.c     |  3 ++-
> >  target/s390x/kvm.c              | 11 +++++++++++
> >  target/s390x/machine.c          | 20 +++++++++++++++++++-
> >  7 files changed, 43 insertions(+), 5 deletions(-)
> >   
> 
> I can merge this (with a capital E in the feature name and a real
> headers update) once the kernel headers update hits Linux master.
> Please ping me if I forget :)

I did not forget; in fact, I just pushed it out to s390-next :)

Thanks, applied.
