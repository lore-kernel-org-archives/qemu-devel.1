Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B098C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBE82054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBE82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLVs-0003ms-4m
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hfLUi-0003F8-D6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hfLUh-0001OU-44
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hfLUg-0001NL-UH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA2F1308FED5;
 Mon, 24 Jun 2019 09:42:25 +0000 (UTC)
Received: from xz-x1 (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E29F608E4;
 Mon, 24 Jun 2019 09:42:21 +0000 (UTC)
Date: Mon, 24 Jun 2019 17:42:16 +0800
From: Peter Xu <peterx@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190624094216.GI6279@xz-x1>
References: <20190622002119.126834-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190622002119.126834-1-liq3ea@163.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 24 Jun 2019 09:42:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: use irq number instead of
 vector in ioapic_eoi_broadcast
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
Cc: pbonzini@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 05:21:19PM -0700, Li Qiang wrote:
> When emulating irqchip in qemu, such as following command:
> 
> x86_64-softmmu/qemu-system-x86_64 -m 1024 -smp 4 -hda /home/test/test.img
> -machine kernel-irqchip=off --enable-kvm -vnc :0 -device edu -monitor stdio
> 
> We will get a crash with following asan output:
> 
> (qemu) /home/test/qemu5/qemu/hw/intc/ioapic.c:266:27: runtime error: index 35 out of bounds for type 'int [24]'
> =================================================================
> ==113504==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61b000003114 at pc 0x5579e3c7a80f bp 0x7fd004bf8c10 sp 0x7fd004bf8c00
> WRITE of size 4 at 0x61b000003114 thread T4
>     #0 0x5579e3c7a80e in ioapic_eoi_broadcast /home/test/qemu5/qemu/hw/intc/ioapic.c:266
>     #1 0x5579e3c6f480 in apic_eoi /home/test/qemu5/qemu/hw/intc/apic.c:428
>     #2 0x5579e3c720a7 in apic_mem_write /home/test/qemu5/qemu/hw/intc/apic.c:802
>     #3 0x5579e3b1e31a in memory_region_write_accessor /home/test/qemu5/qemu/memory.c:503
>     #4 0x5579e3b1e6a2 in access_with_adjusted_size /home/test/qemu5/qemu/memory.c:569
>     #5 0x5579e3b28d77 in memory_region_dispatch_write /home/test/qemu5/qemu/memory.c:1497
>     #6 0x5579e3a1b36b in flatview_write_continue /home/test/qemu5/qemu/exec.c:3323
>     #7 0x5579e3a1b633 in flatview_write /home/test/qemu5/qemu/exec.c:3362
>     #8 0x5579e3a1bcb1 in address_space_write /home/test/qemu5/qemu/exec.c:3452
>     #9 0x5579e3a1bd03 in address_space_rw /home/test/qemu5/qemu/exec.c:3463
>     #10 0x5579e3b8b979 in kvm_cpu_exec /home/test/qemu5/qemu/accel/kvm/kvm-all.c:2045
>     #11 0x5579e3ae4499 in qemu_kvm_cpu_thread_fn /home/test/qemu5/qemu/cpus.c:1287
>     #12 0x5579e4cbdb9f in qemu_thread_start util/qemu-thread-posix.c:502
>     #13 0x7fd0146376da in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76da)
>     #14 0x7fd01436088e in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x12188e
> 
> This is because in ioapic_eoi_broadcast function, we uses 'vector' to
> index the 's->irq_eoi'. To fix this, we should uses the irq number.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Maybe also add:

Fixes: 958a01dab8 ("ioapic: allow buggy guests mishandling ...")

Should we better clear irq_eoi when the entries are updated in
ioapic_mem_write()?

Regards,

-- 
Peter Xu

