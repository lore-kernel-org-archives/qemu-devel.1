Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC0C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF16222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF16222BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPEB-0001qD-VS
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDPBe-0000F1-QJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDPBa-00051Y-2v
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iDPBZ-00050C-Lt
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EE6381F2F;
 Thu, 26 Sep 2019 08:31:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 653455D9C3;
 Thu, 26 Sep 2019 08:31:34 +0000 (UTC)
Message-ID: <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
Subject: Re: Questions about the real mode in kvm/qemu
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Qemu
 Developers <qemu-devel@nongnu.org>
Date: Thu, 26 Sep 2019 11:31:32 +0300
In-Reply-To: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 26 Sep 2019 08:31:35 +0000 (UTC)
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

On Thu, 2019-09-26 at 15:52 +0800, Li Qiang wrote:
> Hi Paolo and all,
> 
> There are some question about the emulation for real mode in kvm/qemu. For all the 
> question I suppose the 'unstrict guest' is not enabled. 
> 
> 1. how the protected mode CPU emulate the real mode? It seems it uses vm86, however, vm86 is not available in x86_64 CPU? So what's the 'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?
> 

As far as I know it, modern intel's cpus support so called unrestricted guest mode, which allows guest to be basically in any mode,
as long as EPT paging is used (that is guest can be in real mode with
no paging, but EPT has to be enabled).
The 'vm86_active' is probably lefover support for cpus that don't support EPT and/or the unrestricted guest mode,
where KVM tried to use the good old vm86 mode to
for real mode virtualization.


> 2. Does the guest's real mode code run directly in native CPU? It seems 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do a switch to guest.

Same as above

> 
> 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA, however there is no GVA, seems the identity mapping does something. But there also some confusion for me. For example the real
> mode uses CS*4 + IP to address the code.  Who does this calculation? In the kernel emulator? 

EPT sits underneath the guest's paging mode, which in case of real mode is 1:1 mapping.
Thus CS<<4 + IP would be the guest physical address and it will be looked up in the EPT to translate to the real physical address.



Best regards,
	Maxim Levitsky


