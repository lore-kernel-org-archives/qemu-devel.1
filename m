Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gQ7Hr-0006Wz-LE
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gQ7Hn-0001xv-NI
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:58:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gQ7Hl-0001uQ-RL
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 03:58:03 -0500
Date: Fri, 23 Nov 2018 09:57:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181123095733.35379735.cohuck@redhat.com>
In-Reply-To: <20181121181347.24035-3-farosas@linux.ibm.com>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-3-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/3] kvm-all: Introduce
 kvm_set_singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On Wed, 21 Nov 2018 16:13:46 -0200
Fabiano Rosas <farosas@linux.ibm.com> wrote:

> This will be used in a future patch to implement an
> architecture-specific single step mechanism for POWER.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  accel/kvm/kvm-all.c  | 10 ++++++++++
>  exec.c               |  1 +
>  include/sysemu/kvm.h |  4 ++++
>  target/arm/kvm.c     |  4 ++++
>  target/i386/kvm.c    |  4 ++++
>  target/mips/kvm.c    |  4 ++++
>  target/ppc/kvm.c     |  4 ++++
>  target/s390x/kvm.c   |  4 ++++
>  8 files changed, 35 insertions(+)
> 

> @@ -431,6 +433,8 @@ void kvm_arch_remove_all_hw_breakpoints(void);
>  
>  void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
>  
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);

Might be useful to add a comment here that describes what common code
expects the arch-specific function to do here so they don't step on
each others toes.

> +
>  bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
>  
>  int kvm_check_extension(KVMState *s, unsigned int extension);
