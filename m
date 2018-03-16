Received: from eggs.gnu.org ([2001:4830:134:3::10]:33193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewrBX-00077G-Uf
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewrBT-0006D9-20
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:22:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewrBS-0006Co-TT
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:22:18 -0400
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
	<152121128086.66.14391574185954997530@71c20359a636>
	<CANRm+CycYFoaB0pgF_43S6hcPoPx9p_boCu8xZxuniHasAGyvg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88db907d-641a-ffad-f837-9ca593d2151e@redhat.com>
Date: Fri, 16 Mar 2018 16:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+CycYFoaB0pgF_43S6hcPoPx9p_boCu8xZxuniHasAGyvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, kvm <kvm@vger.kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On 16/03/2018 15:58, Wanpeng Li wrote:
>> WARNING: line over 80 characters
>> #52: FILE: target/i386/kvm.c:1003:
>> +        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
>>
>> ERROR: line over 90 characters
>> #58: FILE: target/i386/kvm.c:1009:
>> +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS, 0, disable_exits)) {
>>
>> total: 1 errors, 1 warnings, 36 lines checked
> I think it's fine, otherwise the format looks mess, anyway, please let
> me know if they still need to be less than 80 characters here.

Yes, it's okay.

Paolo
