Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eo6xi-0007qr-OO
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eo6xe-0000Ng-QQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:23:58 -0500
Date: Tue, 20 Feb 2018 13:23:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180220132329.39d8b759.cohuck@redhat.com>
In-Reply-To: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 0/5] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On Fri, 16 Feb 2018 17:08:36 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> v5 synopsis: Split out HMP changes from Patch 2 into Patch 5. Please
>    	     re-review, as I've removed the a-b/r-b from Patch 2
> 	     as well.
> 
> This series consolidates patches around a performance issue
> caused by the usage of QMP query-cpus.
> 
> A performance issue was found in an OpenStack environment, where
> ceilometer was collecting domain statistics with libvirt. The domain
> statistics reported by libvirt include the vCPU halted state, which 
> in turn is retrieved with QMP query-cpus.
> 
> This causes two issues:
> 1. Performance: on most architectures query-cpus needs to issue a KVM ioctl
>    to find out whether a vCPU was halted. This is not the case for s390
>    but query-cpus is always causing the vCPU to exit the VM.
> 
> 2. Semantics: on x86 and other architectures, halted is a highly transient
>    state, which is likely to have already changed shortly after the state
>    information has been retrieved. This is not the case for s390, where
>    halted is an indication that the vCPU is stopped, meaning its not
>    available to the guest operating system until it has been restarted.

Thanks, queued to s390-next.
