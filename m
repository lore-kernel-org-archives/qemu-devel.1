Received: from eggs.gnu.org ([2001:4830:134:3::10]:32895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkSDY-0000N1-8b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkSDT-0008Sk-8p
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:49:28 -0400
Date: Tue, 31 Jul 2018 12:49:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180731124919.28ca4952.cohuck@redhat.com>
In-Reply-To: <e47ecf52-04a0-6724-0d47-6172628ad845@de.ibm.com>
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
	<20180731090448.36662-3-borntraeger@de.ibm.com>
	<20180731114438.594dd18b.cohuck@redhat.com>
	<e47ecf52-04a0-6724-0d47-6172628ad845@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: add etoken facility
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

On Tue, 31 Jul 2018 12:14:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/31/2018 11:44 AM, Cornelia Huck wrote:
> > On Tue, 31 Jul 2018 11:04:48 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> Provide the etoken facility. We need to handle cpu model, migration and
> >> clear reset.  
> >   ^^^^^^^^^^^  
> 
> Clear reset is the "strong one". Here we do a memset of the env structure.
> So this should be cleared along with the other registers.

I was confused why it was singled out...

> > 
> > Hm, anything special for that? I don't see it in the patch.
> >   
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  target/s390x/cpu.h              |  3 +++
> >>  target/s390x/cpu_features.c     |  3 ++-
> >>  target/s390x/cpu_features_def.h |  3 ++-
> >>  target/s390x/gen-features.c     |  3 ++-
> >>  target/s390x/kvm.c              | 11 +++++++++++
> >>  target/s390x/machine.c          | 20 +++++++++++++++++++-
> >>  6 files changed, 39 insertions(+), 4 deletions(-)  
> >   
> 
