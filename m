Received: from eggs.gnu.org ([2001:4830:134:3::10]:58506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fmwgn-0007u3-SE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fmwgm-0007nL-Li
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:45:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1fmwgm-0007n9-FH
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:45:56 -0400
Received: by mail-oi0-x242.google.com with SMTP id s198-v6so26784883oih.11
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 00:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
	<20180702214315.GH7451@localhost.localdomain>
In-Reply-To: <20180702214315.GH7451@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 7 Aug 2018 15:45:51 +0800
Message-ID: <CANRm+CwMPca05ZEwwVSJ93NC-Z=OegoiF9Fq9A+0c0ROppt-aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

Hi Eduardo,
On Tue, 3 Jul 2018 at 05:43, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Jul 02, 2018 at 06:22:51PM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Adds PV_SEND_IPI CPUID feature bit.
> >
>
> Thanks!
>
> Paolo, Radim: can I assume the bit is already reserved and queue
> this patch, or should I wait until the KVM patch is merged into
> kvm.git?

I guess you can apply the qemu patch now since the kvm part is merged.
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=4180bf1b655a791a0a6ef93a2ffffc762722c782

Regards,
Wanpeng Li
