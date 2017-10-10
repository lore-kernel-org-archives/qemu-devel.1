Received: from eggs.gnu.org ([2001:4830:134:3::10]:36950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1e1wB5-0003u9-73
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1e1wAz-0001X4-Lb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:10:39 -0400
Message-ID: <1507648227.3683.24.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 10 Oct 2017 17:10:27 +0200
In-Reply-To: <20171010132159.15787-1-david@gibson.dropbear.id.au>
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Correct RAM size
 calculation for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-10-11 at 00:21 +1100, David Gibson wrote:
> In order to prevent the guest from forcing the allocation of large amounts
> of qemu memory (or host kernel memory, in the case of KVM HV), we limit
> the size of Hashed Page Table (HPT) it is allowed to allocated, based on
> its RAM size.
> 
> However, the current calculation is not correct: it only adds up the size
> of plugged memory, ignoring the base memory size.  This patch corrects it.
> 
> While we're there, use get_plugged_memory_size() instead of directly
> calling pc_existing_dimms_capacity().  The only difference is that it
> will abort on failure, which is right: a failure here indicates something
> wrong within qemu.

Does this change invalidate in any way the calculation performed
by libvirt to figure out the memory locking limit for guests?

-- 
Andrea Bolognani / Red Hat / Virtualization
