Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA1820730
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX9RgirV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA1820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXkq-0007WA-Rv
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jMXjq-000738-6w
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jMXjn-0000z4-Ae
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:01:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jMXjn-0000ye-6d
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586440858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/yydDbbDBzd89SJj19EC0vdO3nAxFL0aNMhSPc3Z0w=;
 b=PX9RgirV2o4v50FpzLcS/bAUrkAExAtkj1kz1PedZEgc/ypf9DDHZF4TOFaaSjhIeAgkdj
 MCGWnKTbd4MWvW6YEVXKwD4Simv3yykZzk60Uwuu3fVR1sbUajJUtFPoNKI00uYal4KHLt
 E6JM7dQOLmCSnaH75mpZ4RdwxeiAjTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-jw3VxnBAN2ODhKsPNTWvQA-1; Thu, 09 Apr 2020 10:00:42 -0400
X-MC-Unique: jw3VxnBAN2ODhKsPNTWvQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95298DB60;
 Thu,  9 Apr 2020 14:00:41 +0000 (UTC)
Received: from localhost (unknown [10.40.208.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56F9E272C4;
 Thu,  9 Apr 2020 14:00:39 +0000 (UTC)
Date: Thu, 9 Apr 2020 16:00:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philipp Eppelt <1871842@bugs.launchpad.net>
Subject: Re: [Bug 1871842] [NEW] AMD CPUID leaf 0x8000'0008 reported number
 of cores inconsistent with ACPI.MADT
Message-ID: <20200409160037.431ec776@redhat.com>
In-Reply-To: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
References: <158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 09 Apr 2020 12:58:11 -0000
Philipp Eppelt <1871842@bugs.launchpad.net> wrote:

> Public bug reported:
> 
> Setup:
> CPU: AMD EPYC-v2 or host's EPYC cpu
> Linux 64-bit fedora host; Kernel version 5.5.15-200.fc31
> qemu version: self build
> git-head: f3bac27cc1e303e1860cc55b9b6889ba39dee587
> config: Configured with: '../configure' '--target-list=x86_64-softmmu,mips64el-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu' '--prefix=/opt/qemu-master'
> 
> Cmdline: 
> qemu-system-x86_64 -kernel /home/peppelt/code/l4/internal/.build-x86_64/bin/amd64_gen/bootstrap -append "" -initrd "./fiasco/.build-x86_64/fiasco , ... " -serial stdio -nographic -monitor none -nographic -monitor none -cpu EPYC-v2 -m 4G -smp 4 
> 
> Issue:
> We are developing an microkernel operating system called L4Re. We recently got an AMD EPYC server for testing and we couldn't execute SMP tests of our system when running Linux + qemu + VM w/ L4Re.
> In fact, the kernel did not recognize any APs at all. On AMD CPUs the kernel checks for the number of cores reported in CPUID leaf 0x8000_0008.ECX[NC] or [ApicIdSize].  [0][1]
> 
> The physical machine reports for leaf 0x8000_0008:  EAX: 0x3030 EBX: 0x18cf757 ECX: 0x703f EDX: 0x1000
> The lower four bits of ECX are the [NC] field and all set.
> 
> When querying inside qemu with -enable-kvm -cpu host -smp 4 (basically as replacement and addition to the above cmdline) the CPUID leaf shows: EAX: 0x3024, EBX: 0x1001000, ECX: 0x0, EDX: 0x0
> Note, ECX is zero. Indicating that this is no SMP capabale CPU.
> 
> I'm debugging it using my local machine and the QEMU provided EPYC-v2
> CPU model and it is reproducible there as well and reports:  EAX:
> 0x3028, EBX: 0x0, ECX: 0x0, EDX: 0x0
> 
> I checked other AMD based CPU models (phenom, opteron_g3/g5) and they behave the same. [2] shows the CPUID 0x8000'0008 handling in the QEMU source.
> I believe that behavior here is wrong as ECX[NC] should report the number of cores per processor, as stated in the AMD manual [2] p.584. In my understanding -smp 4 should then lead to ECX[NC] = 0x3.
> 
> The following table shows my findings with the -smp option:
> Option | Qemu guest observed ECX value
> -smp 4 | 0x0
> -smp 4,cores=4  | 0x3
> -smp 4,cores=2,thread=2 | 0x3
> -smp 4,cores=4,threads=2 | QEMU boot error: topology false.
> 
> Now, I'm asking myself how the terminology of the AMD manual maps to QEMU's -smp option.
> Obviously, nr_cores and nr_threads correspond to the cores and threads options on the cmdline and cores * threads <= 4 (in this example), but what corresponds the X in -smp X to?
I'd say X corresponds to number of logical CPUs.
Depending on presence of other options these are distributed among them in magical manner
(see pc_smp_parse() for starters)

> Querying 0x8000'0008 on the physical processor results in different
> reports than quering QEMU's model as does it with -enable-kvm -cpu host.
> 
> Furthermore, the ACPI.MADT shows 4 local APICs to be present while the
> CPU leave reports a single core processor.
it matches -smp X as it should be.

> 
> This leads me to the conclusion that CPUID 0x8000'0008.ECX reports the
> wrong number.
CCed author of recent epyc patches who might know how AMD should work better than me.

> 
> Please let me know, if you need more information from my side.
> 
> 
> [0] https://github.com/kernkonzept/fiasco/blob/522ccc5f29ab120213cf02d71328e2b879cbbd19/src/kern/ia32/kernel_thread-ia32.cpp#L109
> [1] https://github.com/kernkonzept/fiasco/blob/522ccc5f29ab120213cf02d71328e2b879cbbd19/src/kern/ia32/cpu-ia32.cpp#L1120
> [2] https://github.com/qemu/qemu/blob/f2a8261110c32c4dccd84e774d8dd7a0524e00fb/target/i386/cpu.c#L5835
> [3] https://www.amd.com/system/files/TechDocs/24594.pdf
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 


