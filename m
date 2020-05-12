Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5432492B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5432492B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYaI6-0006Dp-FN
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYaHM-00058l-8Y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:09:24 -0400
Received: from relay68.bu.edu ([128.197.228.73]:36450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYaHK-0005tu-Lr
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:09:23 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04CJ83PH015763
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 12 May 2020 15:08:07 -0400
Date: Tue, 12 May 2020 15:08:03 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
Message-ID: <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 15:09:21
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ren Ding <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Prasad,
I noticed this since I found a similar issue recently, using a fuzzer.
I applied your patches, but I can still reproduce the heap-overflow,
unless I'm missing something:

==20527==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f79f968a5e0 at pc 0x55b6bb84ce28 bp 0x7ffcbca04eb0 sp 0x7ffcbca04ea8
READ of size 8 at 0x7f79f968a5e0 thread T0
    #0 0x55fbeb2bdafc in megasas_lookup_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:449:30
    #0 0x55b6bb84ce27 in megasas_lookup_frame (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1c1fe27)
    #1 0x55b6bb82f3e4 in megasas_handle_abort (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1c023e4)
    #2 0x55b6bb8293df in megasas_handle_frame (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1bfc3df)
    #3 0x55b6bb8275eb in megasas_mmio_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x1bfa5eb)
    #4 0x55b6bab5c864 in memory_region_write_accessor (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2f864)
    #5 0x55b6bab5c239 in access_with_adjusted_size (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2f239)
    #6 0x55b6bab5ada5 in memory_region_dispatch_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xf2dda5)
    #7 0x55b6ba994bf3 in flatview_write_continue (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xd67bf3)
    #8 0x55b6ba984ad8 in flatview_write (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0xd57ad8)
    #1 0x55fbeb27caa9 in megasas_handle_abort /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1904:17
    #2 0x55fbeb26cb77 in megasas_handle_frame /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:1961:24
    #3 0x55fbeb267b78 in megasas_mmio_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/hw/scsi/megasas.c:2122:9
    #4 0x55fbe90b117b in memory_region_write_accessor /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:496:5
    #5 0x55fbe90b05e4 in access_with_adjusted_size /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:557:18
    #6 0x55fbe90ae177 in memory_region_dispatch_write /home/alxndr/Development/qemu-bugs/qemu2/qemu/memory.c:1488:16
    #7 0x55fbe8d97325 in flatview_write_continue /home/alxndr/Development/qemu-bugs/qemu2/qemu/exec.c:3174:23

To reproduce:
cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtest stdio -nographic -monitor none -serial none  -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
outl 0xcf8 0x80001814
outl 0xcfc 0xc021
outl 0xcf8 0x80001818
outl 0xcf8 0x80001804
outw 0xcfc 0x7
outl 0xcf8 0x80001810
outl 0xcfc 0xe10c0000
outl 0xcf8 0x8000f810
write 0x0 0x18 0x060017e1ff00f8ffffffff60efffffffffffffffffffffff
write 0xff00 0x1 0x06
write 0xc021e10c0040 0x81 0x755e08ff0000845e08ff0000935e08ff0000a25e08ff0000b15e08ff0000c05e08ff0000cf5e08ff0000de5e08ff0000ed5e08ff0000fc5e08ff00000b5e08ff00001a5e08ff0000295e08ff0000385e08ff0000475e08ff0000565e08ff0000655e08ff0000745e08ff0000835e08ff0000925e08ff0000a15e08ff0000b05e08
-M pc-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
EOF

-Alex

On 200513 0007, P J P wrote:
> +-- On Tue, 12 May 2020, Philippe Mathieu-Daudé wrote --+
> | Cc'ing Marc-André our signed/unsigned conversion expert (with Paolo).
> 
>   megasas_init_firmware
>     pa_lo = le32_to_cpu(initq->pi_addr_lo);
>     pa_hi = le32_to_cpu(initq->pi_addr_hi);
>     s->producer_pa = ((uint64_t) pa_hi << 32) | pa_lo;
>     s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);
> 
> IIUC, here ldl_le_pci_dma() returns an 'uint32_t' type, but since 
> 'reply_queue_head' is a signed int, large 'uint32_t' value turns negative.
> 
> | Do you have a reproducer?
> 
>   Yes, there is a reproducer with ASAN, though it did not work for me. 
> Ren(CC'd) had shared this trace:
> 
> AddressSanitizer: heap-buffer-overflow on address 0x7f9159054058 at pc 0x55763514b5cd bp 0x7f9179bd6d90 sp 0x7f9179bd6d88
> READ of size 8 at 0x7f9159054058 thread T2
>   #0 0x55763514b5cc in megasas_lookup_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:449:30
>   #1 0x55763513205c in megasas_handle_abort /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1904:17
>   #2 0x55763512d0f8 in megasas_handle_frame /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:1961:24
>   #3 0x55763512ba7d in megasas_mmio_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2122:9
>   #4 0x55763515247c in megasas_port_write /home/ren/tmp/redacted-dbg/qemu/hw/scsi/megasas.c:2173:5
>   #5 0x557634621b3b in memory_region_write_accessor /home/ren/tmp/redacted-dbg/qemu/memory.c:483:5
>   #6 0x557634621741 in access_with_adjusted_size /home/ren/tmp/redacted-dbg/qemu/memory.c:544:18
>   #7 0x557634620498 in memory_region_dispatch_write /home/ren/tmp/redacted-dbg/qemu/memory.c:1482:16
>   #8 0x5576344b6b6c in flatview_write_continue /home/ren/tmp/redacted-dbg/qemu/exec.c:3161:23
>   #9 0x5576344a87d9 in flatview_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3201:14
>   #10 0x5576344a8376 in address_space_write /home/ren/tmp/redacted-dbg/qemu/exec.c:3291:18
>   #11 0x5576344a8af4 in address_space_rw /home/ren/tmp/redacted-dbg/qemu/exec.c:3301:16
>   #12 0x557634689e10 in kvm_handle_io /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2086:9
>   #13 0x557634688a45 in kvm_cpu_exec /home/ren/tmp/redacted-dbg/qemu/accel/kvm/kvm-all.c:2332:13
>   #14 0x5576345ee7aa in qemu_kvm_cpu_thread_fn /home/ren/tmp/redacted-dbg/qemu/cpus.c:1299:17
>   #15 0x557635a11509 in qemu_thread_start /home/ren/tmp/redacted-dbg/qemu/util/qemu-thread-posix.c:519:9
>   #16 0x7f918cec26b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
>   #17 0x7f918c5d441c in clone /build/glibc-LK5gWL/glibc-2.23/misc/../sysdeps/unix/sysv/linux/x86_64/clone.S:109
> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


