Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eJjqh-0007cr-LD
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eJjqd-0005ZW-KY
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:39:11 -0500
References: <20171128173224.1138-1-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f0968b6f-a2da-2f1b-768a-649c7e51d59a@redhat.com>
Date: Tue, 28 Nov 2017 18:39:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171128173224.1138-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 28/11/2017 18:32, Laurent Vivier wrote:
> Migration of pseries is broken with TCG because
> QEMU tries to restore KVM MMU state unconditionally.
> 
> The result is a SIGSEGV in kvm_vm_ioctl():
> 
>     at qemu/accel/kvm/kvm-all.c:2032
>     radix=<optimized out>, gtse=<optimized out>, proc_tbl=<optimized out>)
>     at qemu/target/ppc/kvm.c:396
>     version_id=<optimized out>) at /home/lvivier/qemu/hw/ppc/spapr.c:1578
>     vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
>     version_id=<optimized out>) at /home/lvivier/qemu/migration/vmstate.c:165
>     at qemu/migration/savevm.c:748
> 

I'm going to resend the patch because the lines starting with "#" have
been removed...

Thanks,
Laurent
