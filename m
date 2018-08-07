Received: from eggs.gnu.org ([2001:4830:134:3::10]:57983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmytx-0000fD-MG
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmytw-0003hK-N2
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fmytw-0003hE-GF
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:40 -0400
References: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
	<20180702214315.GH7451@localhost.localdomain>
	<CANRm+CwMPca05ZEwwVSJ93NC-Z=OegoiF9Fq9A+0c0ROppt-aQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <975c43e0-c130-4163-b2d6-b3d6b8d5ebb4@redhat.com>
Date: Tue, 7 Aug 2018 12:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <CANRm+CwMPca05ZEwwVSJ93NC-Z=OegoiF9Fq9A+0c0ROppt-aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Wanpeng Li <kernellwp@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On 07/08/2018 09:45, Wanpeng Li wrote:
>>
>> Paolo, Radim: can I assume the bit is already reserved and queue
>> this patch, or should I wait until the KVM patch is merged into
>> kvm.git?
> I guess you can apply the qemu patch now since the kvm part is merged.
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=4180bf1b655a791a0a6ef93a2ffffc762722c782

QEMU is in freeze, so it will have to wait for the next release.  Thanks!

Paolo
