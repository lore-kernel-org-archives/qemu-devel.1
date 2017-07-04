Received: from eggs.gnu.org ([2001:4830:134:3::10]:58063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dSDbf-0006SH-HO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dSDbc-00020F-EB
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:30:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:51721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dSDbc-0001yd-5O
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:30:24 -0400
Date: Tue, 4 Jul 2017 10:30:19 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170704023019.ng6gftsd5pkawh6j@hz-desktop>
References: <20170703152338.20024-1-haozhong.zhang@intel.com>
	<c016d0d6-1a89-6455-6b9c-c09769dcd1af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c016d0d6-1a89-6455-6b9c-c09769dcd1af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: mask MSR_IA32_BNDCFGS if MPX is
 not enabled in guest cpuid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 07/03/17 17:45 +0200, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 17:23, Haozhong Zhang wrote:
> > Otherwise, QEMU on a host with MPX support will try to set guest
> > MSR_IA32_BNDCFGS although guest MPX is not enabled, and result in
> > abort.
> > 
> > For example,
> >    qemu-system-x86_64 -enable-kvm -cpu qemu64,-mpx ...
> > aborts with messages:
> >    qemu-system-x86_64: error: failed to set MSR 0xd90 to 0x0
> >    qemu-system-x86_64: /root/qemu.git/target/i386/kvm.c:1832: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed
> 
> I think the fix should be in KVM, allowing BNDCFGS = 0 if
> host_initiated, even if MPX is not enabled.
> 

Agree. I've sent a KVM patch to fix this issue.

Thanks,
Haozhong
