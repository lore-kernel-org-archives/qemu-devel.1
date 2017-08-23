Received: from eggs.gnu.org ([2001:4830:134:3::10]:53444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXHx-0000zN-4r
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkXHs-0003Cv-Pi
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkXHs-0003CT-KD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:09:44 -0400
Date: Wed, 23 Aug 2017 17:09:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170823170917.7bf55837.cohuck@redhat.com>
In-Reply-To: <1503483383-199649-1-git-send-email-borntraeger@de.ibm.com>
References: <1503483383-199649-1-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Dan Horak <dhorak@redhat.com>

On Wed, 23 Aug 2017 12:16:23 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> KVM guests on s390 need a different page table layout than normal
> processes (2kb page table + 2kb page status extensions vs 2kb page table
> only). As of today this has to be enabled via the vm.allocate_pgste
> sysctl.
> 
> Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
> and enable the pgste page table extensions in that case. This makes the
> vm.allocate_pgste sysctl unnecessary. We enable this program header for
> the s390 system emulation (qemu-system-s390x) if we build on s390
> - for s390 system emulation
> - the linker supports --s390-pgste (binutils >= 2.29)
> - KVM is enabled
> 
> This will allow distributions to disable the global vm.allocate_pgste
> sysctl, which will improve the page table allocation for non KVM
> processes as only 2kb chunks are necessary.
> 
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Dan Horak <dhorak@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
> V1->V2:
> 	- provide ld_has function
> 	- use ld_has to replace some open coded variants
> 	- check target arch and arch for s390
> 	- check for s390x before calling the linker
> V2->V3: 
> 	- fix typos
>  configure | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Thanks, applied.
