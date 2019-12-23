Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC04C2D0CF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6AE20715
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 11:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXN760tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6AE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijLu7-00029d-0k
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 06:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ijLtV-0001jt-NW
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ijLtT-0005cZ-Nz
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:29:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ijLtT-0005br-JP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 06:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577100538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WENHD1IhJnsaFaLa8s1APUyigw5JkM2nGFpistcENMM=;
 b=ZXN760tvWoSnnFr4yqSPFKo4A6wbTup+4O+bZOab3bxkyHCiHfNUTw0Jc2fuIAdE/s9swo
 i9hN5jfY8GRTgM6Cv8o/RHeSapAmdDAKvrmDKoDAQpnZBB8/ePPg5yHDqUOFRtKY1AJfCA
 eU0k0C7oKi/kInc2U+DFjMV28+9RB6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-kdsgpSnkNGSrEda5VXObXQ-1; Mon, 23 Dec 2019 06:28:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35C3DDB20
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 11:28:46 +0000 (UTC)
Received: from [10.40.204.49] (ovpn-204-49.brq.redhat.com [10.40.204.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E8C51;
 Mon, 23 Dec 2019 11:28:45 +0000 (UTC)
Subject: Re: [PULL 48/87] x86: move SMM property to X86MachineState
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-49-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <8e6af403-173f-ff15-11c7-5dad511795a1@redhat.com>
Date: Mon, 23 Dec 2019 12:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576670573-48048-49-git-send-email-pbonzini@redhat.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kdsgpSnkNGSrEda5VXObXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 12/18/19 1:02 PM, Paolo Bonzini wrote:
> Add it to microvm as well, it is a generic property of the x86
> architecture.
> 
> Suggested-by: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc.c          | 49 -------------------------------------------------
>  hw/i386/pc_piix.c     |  6 +++---
>  hw/i386/pc_q35.c      |  2 +-
>  hw/i386/x86.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/i386/pc.h  |  3 ---
>  include/hw/i386/x86.h |  5 +++++
>  target/i386/kvm.c     |  3 +--
>  7 files changed, 59 insertions(+), 59 deletions(-)
> 


> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ef63f3a..c7ff67a 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2173,8 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      }
>  
>      if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> -        object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
> -        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
> +        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>          smram_machine_done.notify = register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }
> 

Sorry for not catching this earlier, but I don't think this is right.
The @ms is not instance of X


After I refreshed my qemu master I realized that libvirt is unable to
fetch capabilities. Libvirt runs the following command:

  qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 -S -no-user-config
-nodefaults -nographic -machine none,accel=kvm:tcg

plus some other (for now) irrelevant args. But qemu fails to initialize:

  qemu.git/target/i386/kvm.c:2176:kvm_arch_init: Object 0x563493f306b0
is not an instance of type x86-machine

and indeed it is not:

#0  0x00007ffff50acd21 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:50
#1  0x00007ffff5096535 in __GI_abort () at abort.c:79
#2  0x0000555555d23275 in object_dynamic_cast_assert
(obj=0x5555567846b0, typename=0x555555fd42f7 "x86-machine",
file=0x555555fd3878 "/home/zippy/work/qemu/qemu.git/target/i386/kvm.c",
line=2176, func=0x555555fd4eb0 <__func__.31258> "kvm_arch_init") at
qom/object.c:815
#3  0x0000555555a1c3fb in kvm_arch_init (ms=0x5555567846b0,
s=0x5555568a8430) at /home/zippy/work/qemu/qemu.git/target/i386/kvm.c:2176
#4  0x00005555558b4ad7 in kvm_init (ms=0x5555567846b0) at
/home/zippy/work/qemu/qemu.git/accel/kvm/kvm-all.c:2068
#5  0x0000555555a44f0a in accel_init_machine (accel=0x5555568a8430,
ms=0x5555567846b0) at accel/accel.c:55
#6  0x0000555555a3e28d in do_configure_accelerator
(opaque=0x7fffffffd6c2, opts=0x5555568a8290, errp=0x5555566f34f0
<error_fatal>) at vl.c:2737
#7  0x0000555555e9b773 in qemu_opts_foreach (list=0x55555654ffe0
<qemu_accel_opts>, func=0x555555a3e1a8 <do_configure_accelerator>,
opaque=0x7fffffffd6c2, errp=0x5555566f34f0 <error_fatal>) at
util/qemu-option.c:1170
#8  0x0000555555a3e4cb in configure_accelerators
(progname=0x7fffffffdde1
"/home/zippy/work/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_64") at
vl.c:2798
#9  0x0000555555a417a8 in main (argc=7, argv=0x7fffffffda08,
envp=0x7fffffffda48) at vl.c:4121


#2  0x0000555555d23275 in object_dynamic_cast_assert
(obj=0x5555567846b0, typename=0x555555fd42f7 "x86-machine",
file=0x555555fd3878 "/home/zippy/work/qemu/qemu.git/target/i386/kvm.c",
line=2176, func=0x555555fd4eb0 <__func__.31258> "kvm_arch_init") at
qom/object.c:815
815             abort();
object_dynamic_cast_assert 1 $ p obj->class->type->name
$4 = 0x5555567ad720 "none-machine"


Michal


