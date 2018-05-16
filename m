Received: from eggs.gnu.org ([2001:4830:134:3::10]:52036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIy7G-0004NC-2W
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIy7C-0001Kd-Ok
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:13:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIy7C-0001KT-K2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:13:18 -0400
Date: Wed, 16 May 2018 18:13:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180516180847-mutt-send-email-mst@kernel.org>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417205913.GC29865@localhost.localdomain>
	<02887fa6-d7c8-bc39-6e65-3c3caec5b903@redhat.com>
	<20180419195610.GA29865@localhost.localdomain>
	<98f48c44-e55a-2bd2-0d41-5643f35bce68@redhat.com>
	<20180419215320.GC29865@localhost.localdomain>
	<20180512010007-mutt-send-email-mst@kernel.org>
	<c4f7f4bd-80ce-3d84-fb0d-a7ac22333afd@redhat.com>
	<20180516172121-mutt-send-email-mst@kernel.org>
	<2871c099-79fe-8432-12c9-637e743cc89c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2871c099-79fe-8432-12c9-637e743cc89c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, May 16, 2018 at 05:04:41PM +0200, Paolo Bonzini wrote:
> On 16/05/2018 16:22, Michael S. Tsirkin wrote:
> >> kvm-hint-dedicated=on only sets the CPUID bit, which Linux for example
> >> uses that to disable pv spinlocks.  "-realtime dedicated-cpus=on" only
> >> disables the vmexits.  You can use the two independently.
> >
> > But when would you want to use the two independently?
> 
> 1) For testing
> 
> 2) When some of your QEMUs are too old to support kvm-hint-dedicated=on,
> you may still want to use -realtime dedicated-cpus=on to get better
> performance on the new one.
> 
> Paolo

For the second purpose, can't we handle this using machine types?

-- 
MST
