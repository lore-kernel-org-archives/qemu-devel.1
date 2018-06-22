Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWMSC-000583-GW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fWMS7-0007yr-3g
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:50:19 -0400
Date: Fri, 22 Jun 2018 15:50:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180622155009.19eeffaf.cohuck@redhat.com>
In-Reply-To: <20180622102928.173420-1-borntraeger@de.ibm.com>
References: <20180622102928.173420-1-borntraeger@de.ibm.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 22 Jun 2018 12:29:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> kexec/kdump as well as the bootloader use a subcode of diagnose 308
> that is supposed to reset the I/O subsystem but not comprise a full
> "reboot". With the latest refactoring this is now broken when
> -no-reboot is used or when libvirt acts on a reboot QMP event, for
> example a virt-install from iso images.
> We need to mark these "subsystem reset" as special.

s/reset/resets/

> 
> Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> v3->v4: - rename to SHUTDOWN_CAUSE_SUBSYSTEM_RESET
>         - modify comments and patch descriptions
> 
>  hw/s390x/ipl.c          | 8 +++++++-
>  include/sysemu/sysemu.h | 4 ++++
>  vl.c                    | 4 ++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

Thanks, applied.
