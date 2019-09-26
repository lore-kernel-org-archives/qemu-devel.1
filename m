Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65383C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A555222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A555222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQDc-0007Ws-9k
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQBs-0006Qi-4e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDQBr-0004hQ-1b
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iDQBq-0004fN-Ow
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A4F910C094B;
 Thu, 26 Sep 2019 09:35:58 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D446092D;
 Thu, 26 Sep 2019 09:35:56 +0000 (UTC)
Message-ID: <d9924ad4b5df6228c924548f364069ff43c36286.camel@redhat.com>
Subject: Re: Questions about the real mode in kvm/qemu
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, Qemu
 Developers <qemu-devel@nongnu.org>
Date: Thu, 26 Sep 2019 12:35:56 +0300
In-Reply-To: <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 26 Sep 2019 09:35:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-26 at 11:15 +0200, Paolo Bonzini wrote:
> On 26/09/19 09:52, Li Qiang wrote:
> > Hi Paolo and all,
> > 
> > There are some question about the emulation for real mode in kvm/qemu.
> > For all the 
> > question I suppose the 'unstrict guest' is not enabled. 
> > 
> > 1. how the protected mode CPU emulate the real mode? It seems it uses
> > vm86, however, vm86 is not available in x86_64 CPU? So what's the
> > 'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?
> 
> vm86 mode is available in 64-bit CPUs; it is not available in 64-bit
> mode (EFER.LMA=1).
> 
> Once KVM places the processor in VMX non-root mode (VMLAUNCH/VMRESUME),
> the processor can leave 64-bit mode and run in vm86 mode.  And that's
> exactly what KVM does on processors without unrestricted guest support.
> 
> In that mode, KVM will start trapping all exceptions and send them to
> handle_rmode_exception.  This in turn will either emulate privileged
> instructions (for #GP or #SS) or inject them as realmode exceptions.
Ah, so you run vm86 inside the guest, to emulate the real mode.
That is clever :-)

> 
> However...
> 
> > 2. Does the guest's real mode code run directly in native CPU? It seems
> > 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do
> > a switch to guest.
> 
> ... as soon as the guest tries to enter protected mode, it will get into
> a situation which is not real mode but doesn't have the segment
> registers properly loaded with selectors.  Therefore, it will either
> hack things together (enter_pmode) or emulate instructions until the
> state is accepted even without unrestricted guest support.
> 
> The "hacking things together" part however does not work for big real
> mode (where you enter 32-bit mode, load segment registers with a flat 4G
> segment, and go back to real mode with the 4G segments).  In big real
> mode, therefore, KVM cannot use vm86 and will keep emulating (slowly -
> up to 1000x slower than unrestricted guest).
That is also understandable.

> 
> > 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA,
> > however there is no GVA, seems the identity mapping does something. But
> > there also some confusion for me. For example the real mode uses CS*4 +
> > IP to address the code.  Who does this calculation? In the kernel emulator? 
> 
> Right, and in fact the CR0.PG and CR0.PE bits must be 1 when running in
> VMX non-root mode with unrestricted guest disabled.
> 
> Therefore, KVM places a 4 KiB identity map at an address provided by
> userspace (with KVM_SET_IDENTITY_MAP_ADDR).  When 1) EPT is enabled 2)
> unrestricted guest isn't 3) CR0.PG=0, KVM points CR3 to it and runs the
> guest with CR0.PG=1, CR4.PAE=0, CR4.PSE=1.  This CR4 setup enables 4 MiB
> huge pages so that a 4 GiB identity map fits in 4 KiB.  This is the only
> case where EPT is enabled but CR3 loads and stores will trap to the
> hypervisor.  This way, the guest CR3 value is faked in the vmexit
> handler, but the processor always uses the identity GVA->GPA mapping.

Ah, so you fake the guest's paging table, not the EPT table. That makes
sense.

Thankfully all of this is not needed when unrestricted guest is available.

Best regards,
	Maxim Levitsky


