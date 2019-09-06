Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FFB206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="Mor3fLI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FFB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fnarfbargle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FRg-0006V1-T0
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6FQz-00066c-4h
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6FQx-0005E7-U7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:41:57 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:36048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6FQx-0005DC-CA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:41:55 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh31992)
 by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6FQE-0005Ch-NT
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 22:41:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fnarfbargle.com; s=mail; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject;
 bh=VehvyU7qaGLmxLpGq4zzID+CmfrQktvjuFRvU5005ZI=; 
 b=Mor3fLI+0zLXFa6OXun1PDW2GKdp9eaMrE3GKIQy1r8aIcpsV6Cpn9n7peeJfDB3BLunT9X9cQ75tQbVuJ95YonPdAqKzFtLZojn6pz/+i+9Wq++L++SrWQL0X3G/8u+s6YeCKnzoV3kNK+P+5uGr4qb/gsrIo72ByMoLJeAK0M=;
To: qemu-devel@nongnu.org
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
 <7da75f0a-aa48-a9db-d2f8-fe74031ecf58@fnarfbargle.com>
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <49b5d60f-b0cd-8d47-5e0f-75fc76b3ee47@fnarfbargle.com>
Date: Fri, 6 Sep 2019 22:41:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7da75f0a-aa48-a9db-d2f8-fe74031ecf58@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 103.4.19.87
Subject: Re: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
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

On 6/9/19 21:38, Brad Campbell wrote:
> 7022@1567775824.002106:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970
> 7022@1567775824.002115:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c980
> 7022@1567775824.003122:kvm_vm_ioctl type 0xc008ae67, arg 0x7ffe13b0c970

> 
> Does this look familiar to anyone?

Ugh. System timer.

So with the timer interrupt removed and an added trace on IRQ > 0:

qxl/guest-0: 79096403248: qxldd: DrvCopyBits
14955@1567780063.149527:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
14956@1567780063.150291:qxl_ring_res_put 0 #res=1
14955@1567780063.163672:kvm_run_exit cpu_index 2, reason 2
14955@1567780063.163688:qxl_io_write 0 native addr=4 (QXL_IO_NOTIFY_OOM) val=0 size=1 async=0
14955@1567780063.163704:qxl_spice_oom 0
14955@1567780063.163720:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
14956@1567780063.163755:qxl_ring_command_check 0 native
14956@1567780063.163779:qxl_ring_res_push 0 native s#=0 res#=1 last=0x7f3c0d44b6e0 notify=yes
14956@1567780063.163816:qxl_ring_res_push_rest 0 ring 1/8 [326,325]
14956@1567780063.163841:qxl_send_events 0 1
14956@1567780063.163868:qxl_ring_cursor_check 0 native
14956@1567780063.163888:qxl_ring_command_check 0 native
14924@1567780063.163879:kvm_set_irq irq 11, level 1, status 1
14954@1567780063.163895:kvm_run_exit cpu_index 1, reason 2
14954@1567780063.163965:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
14954@1567780063.164006:kvm_set_irq irq 11, level 0, status 1
14954@1567780063.164029:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
14954@1567780063.164065:kvm_run_exit cpu_index 1, reason 2
14954@1567780063.164080:qxl_io_write 0 native addr=3 (QXL_IO_UPDATE_IRQ) val=0 size=1 async=0
14954@1567780063.164104:kvm_vcpu_ioctl cpu_index 1, type 0xae80, arg (nil)
14955@1567780063.266778:kvm_run_exit cpu_index 2, reason 2
14955@1567780063.266790:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
14955@1567780063.266809:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)
14956@1567780063.266822:qxl_ring_cursor_check 0 native
14956@1567780063.266842:qxl_ring_command_check 0 native
79213750625 qxl-0/cmd: cmd @ 0x10000000104b598 draw: surface_id 0 type copy effect opaque src 100000001fecbf8 (id 9fe0870780 type 0 flags 0 width 1920 height 1080, fmt 8 flags 0 x 1920 y 1080 stride 7680 palette 0 data 100000001fecc28) area 1920x1080+0+0 rop 8
14956@1567780063.266983:qxl_ring_command_get 0 native
14956@1567780063.267044:qxl_ring_command_check 0 native
14956@1567780063.267070:qxl_ring_cursor_check 0 native
14956@1567780063.267087:qxl_ring_command_check 0 native
14956@1567780063.267109:qxl_ring_command_req_notification 0
14955@1567780063.267967:kvm_run_exit cpu_index 2, reason 2
14955@1567780063.267987:qxl_io_write 0 native addr=7 (QXL_IO_LOG) val=0 size=1 async=0
14955@1567780063.268015:qxl_io_log 0 qxldd: DrvCopyBits

So if I'm not mistaken (for the nth time), we have KVM_RUN on cpu index 2 here:

14955@1567780063.163720:kvm_vcpu_ioctl cpu_index 2, type 0xae80, arg (nil)

And it returns here :

14955@1567780063.266778:kvm_run_exit cpu_index 2, reason 2

Does that imply guest code is running for ~100ms on that vcpu?

Brad
-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr

