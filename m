Received: from eggs.gnu.org ([209.51.188.92]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgij-00043a-Sf
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgV8-0004cp-A0
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIgV8-0004c1-3o
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:29:22 -0400
Date: Mon, 22 Apr 2019 18:29:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190422212917.GA5131@habkost.net>
References: <20190410000803.1744-1-ghook@redhat.com>
	<20190410000803.1744-3-ghook@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410000803.1744-3-ghook@redhat.com>
Subject: Re: [Qemu-devel] [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin
 the ram device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gary R Hook <ghook@redhat.com>
Cc: rhvirt-patches@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Apr 09, 2019 at 08:08:03PM -0400, Gary R Hook wrote:
> BZ: 1667249
> Branch: rhel-8.1.0
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
> Upstream Status: 4.0.0-rc1
> Build Info: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=20980582
> Conflicts: None
> 
> commit cedc0ad539afbbb669dba9e73dfad2915bc1c25b
> Author: Singh, Brijesh <brijesh.singh@amd.com>
> Date:   Mon Feb 4 22:23:40 2019 +0000
> 
>     target/i386: sev: Do not pin the ram device memory region
> 
>     The RAM device presents a memory region that should be handled
>     as an IO region and should not be pinned.
> 
>     In the case of the vfio-pci, RAM device represents a MMIO BAR
>     and the memory region is not backed by pages hence
>     KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.
> 
>     Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
>     Cc: Alex Williamson <alex.williamson@redhat.com>
>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>     Message-Id: <20190204222322.26766-3-brijesh.singh@amd.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com> 
> Cc: Richard Henderson <rth@twiddle.net> 
> Cc: Eduardo Habkost <ehabkost@redhat.com> 
> Cc: qemu-devel@nongnu.org 

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
