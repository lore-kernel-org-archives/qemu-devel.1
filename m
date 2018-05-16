Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIxz1-0000Yq-Pg
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIxyx-0004z5-RU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:04:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIxyx-0004yu-Lu
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:04:47 -0400
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417205913.GC29865@localhost.localdomain>
	<02887fa6-d7c8-bc39-6e65-3c3caec5b903@redhat.com>
	<20180419195610.GA29865@localhost.localdomain>
	<98f48c44-e55a-2bd2-0d41-5643f35bce68@redhat.com>
	<20180419215320.GC29865@localhost.localdomain>
	<20180512010007-mutt-send-email-mst@kernel.org>
	<c4f7f4bd-80ce-3d84-fb0d-a7ac22333afd@redhat.com>
	<20180516172121-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2871c099-79fe-8432-12c9-637e743cc89c@redhat.com>
Date: Wed, 16 May 2018 17:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180516172121-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 16/05/2018 16:22, Michael S. Tsirkin wrote:
>> kvm-hint-dedicated=on only sets the CPUID bit, which Linux for example
>> uses that to disable pv spinlocks.  "-realtime dedicated-cpus=on" only
>> disables the vmexits.  You can use the two independently.
>
> But when would you want to use the two independently?

1) For testing

2) When some of your QEMUs are too old to support kvm-hint-dedicated=on,
you may still want to use -realtime dedicated-cpus=on to get better
performance on the new one.

Paolo
