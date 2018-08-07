Received: from eggs.gnu.org ([2001:4830:134:3::10]:43316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fn2qH-0002Mr-Ev
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fn2qE-0002fw-QL
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fn2qE-0002fi-Kk
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:20:06 -0400
Date: Tue, 7 Aug 2018 11:20:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180807142003.GI23195@localhost.localdomain>
References: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
	<20180702214315.GH7451@localhost.localdomain>
	<CANRm+CwMPca05ZEwwVSJ93NC-Z=OegoiF9Fq9A+0c0ROppt-aQ@mail.gmail.com>
	<975c43e0-c130-4163-b2d6-b3d6b8d5ebb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975c43e0-c130-4163-b2d6-b3d6b8d5ebb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_SEND_IPI CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Tue, Aug 07, 2018 at 12:07:37PM +0200, Paolo Bonzini wrote:
> On 07/08/2018 09:45, Wanpeng Li wrote:
> >>
> >> Paolo, Radim: can I assume the bit is already reserved and queue
> >> this patch, or should I wait until the KVM patch is merged into
> >> kvm.git?
> > I guess you can apply the qemu patch now since the kvm part is merged.
> > https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=4180bf1b655a791a0a6ef93a2ffffc762722c782
> 
> QEMU is in freeze, so it will have to wait for the next release.  Thanks!

I'm queueing for 3.1, thanks!

-- 
Eduardo
