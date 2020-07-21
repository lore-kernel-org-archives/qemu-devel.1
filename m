Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9706DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E642080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E642080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxmbP-0002qf-LV
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 03:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jxmao-0002Pf-P4
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:21:38 -0400
Received: from gecko.sbs.de ([194.138.37.40]:38424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jxmaj-0004L8-1r
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:21:38 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06L7LSfE009624
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:21:29 +0200
Received: from [167.87.32.116] ([167.87.32.116])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06L7LSou027724
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:21:28 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: aarch64: Crash with qemu master when starting Jailhouse
Message-ID: <b19e8210-7cac-e1b5-f89b-ae73ec21d8cb@siemens.com>
Date: Tue, 21 Jul 2020 09:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=194.138.37.40;
 envelope-from=jan.kiszka@siemens.com; helo=gecko.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:21:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I've seen this first a couple of weeks ago, ignored it, but it's still there today with master:

Thread 13 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f90e2ffd700 (LWP 26883)]
0x0000560ef0bddda7 in get_phys_addr_lpae (env=<optimized out>, address=address@entry=1095261192, access_type=access_type@entry=MMU_DATA_LOAD, mmu_idx=mmu_idx@entry=ARMMMUIdx_Stage2, s1_is_el0=s1_is_el0@entry=false, 
    phys_ptr=phys_ptr@entry=0x7f90e2ffc200, txattrs=0x7f90e2ffc1ec, prot=0x7f90e2ffc1f0, page_size_ptr=0x7f90e2ffc1f8, fi=0x7f90e2ffc530, cacheattrs=0x0) at /data/qemu/target/arm/helper.c:11106
11106           cacheattrs->attrs = convert_stage2_attrs(env, extract32(attrs, 0, 4));
(gdb) bt
#0  0x0000560ef0bddda7 in get_phys_addr_lpae
    (env=<optimized out>, address=address@entry=1095261192, access_type=access_type@entry=MMU_DATA_LOAD, mmu_idx=mmu_idx@entry=ARMMMUIdx_Stage2, s1_is_el0=s1_is_el0@entry=false, phys_ptr=phys_ptr@entry=0x7f90e2ffc200, txattrs=0x7f90e2ffc1ec, prot=0x7f90e2ffc1f0, page_size_ptr=0x7f90e2ffc1f8, fi=0x7f90e2ffc530, cacheattrs=0x0) at /data/qemu/target/arm/helper.c:11106
#1  0x0000560ef0bde3c6 in S1_ptw_translate (env=env@entry=0x560ef32742b0, mmu_idx=mmu_idx@entry=ARMMMUIdx_Stage1_E1, addr=1095261192, txattrs=..., fi=fi@entry=0x7f90e2ffc530) at /data/qemu/target/arm/helper.c:10218
#2  0x0000560ef0bdd7f0 in arm_ldq_ptw (fi=0x7f90e2ffc530, mmu_idx=ARMMMUIdx_Stage1_E1, is_secure=false, addr=<optimized out>, cs=0x560ef326ac10) at /data/qemu/target/arm/helper.c:10284
#3  0x0000560ef0bdd7f0 in get_phys_addr_lpae
    (env=env@entry=0x560ef32742b0, address=address@entry=18446674270391351284, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=mmu_idx@entry=ARMMMUIdx_Stage1_E1, s1_is_el0=s1_is_el0@entry=false, phys_ptr=phys_ptr@entry=0x7f90e2ffc490, txattrs=0x7f90e2ffc518, prot=0x7f90e2ffc514, page_size_ptr=0x7f90e2ffc528, fi=0x7f90e2ffc530, cacheattrs=0x7f90e2ffc51c) at /data/qemu/target/arm/helper.c:11014
#4  0x0000560ef0bdfacb in get_phys_addr (env=env@entry=0x560ef32742b0, address=<optimized out>, address@entry=18446674270391351284, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=<optimized out>, 
    mmu_idx@entry=ARMMMUIdx_Stage1_E1, phys_ptr=phys_ptr@entry=0x7f90e2ffc490, attrs=attrs@entry=0x7f90e2ffc518, prot=0x7f90e2ffc514, page_size=0x7f90e2ffc528, fi=0x7f90e2ffc530, cacheattrs=0x7f90e2ffc51c)
    at /data/qemu/target/arm/helper.c:12115
#5  0x0000560ef0bdf5ca in get_phys_addr
    (env=env@entry=0x560ef32742b0, address=address@entry=18446674270391351284, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=<optimized out>, phys_ptr=phys_ptr@entry=0x7f90e2ffc520, attrs=attrs@entry=0x7f90e2ffc518, prot=0x7f90e2ffc514, page_size=0x7f90e2ffc528, fi=0x7f90e2ffc530, cacheattrs=0x7f90e2ffc51c) at /data/qemu/target/arm/helper.c:11950
#6  0x0000560ef0bef669 in arm_cpu_tlb_fill (cs=0x560ef326ac10, address=18446674270391351284, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=2, probe=<optimized out>, retaddr=0) at /data/qemu/target/arm/tlb_helper.c:177
#7  0x0000560ef0adbd85 in tlb_fill (cpu=0x560ef326ac10, addr=18446674270391351284, size=0, access_type=MMU_INST_FETCH, mmu_idx=2, retaddr=0) at /data/qemu/accel/tcg/cputlb.c:1032
#8  0x0000560ef0adf216 in get_page_addr_code_hostp (env=<optimized out>, addr=addr@entry=18446674270391351284, hostp=hostp@entry=0x0) at /data/qemu/accel/tcg/cputlb.c:1211
#9  0x0000560ef0adf287 in get_page_addr_code (env=<optimized out>, addr=addr@entry=18446674270391351284) at /data/qemu/accel/tcg/cputlb.c:1243
#10 0x0000560ef0af21c4 in tb_htable_lookup (cpu=cpu@entry=0x560ef326ac10, pc=18446674270391351284, cs_base=<optimized out>, flags=2182107137, cf_mask=4278714368) at /data/qemu/accel/tcg/cpu-exec.c:337
#11 0x0000560ef0af2fd6 in tb_lookup__cpu_state (cf_mask=<optimized out>, flags=0x7f90e2ffc718, cs_base=0x7f90e2ffc720, pc=0x7f90e2ffc728, cpu=0x0) at /data/qemu/include/exec/tb-lookup.h:43
#12 0x0000560ef0af2fd6 in tb_find (cf_mask=524288, tb_exit=0, last_tb=0x0, cpu=0x0) at /data/qemu/accel/tcg/cpu-exec.c:404
#13 0x0000560ef0af2fd6 in cpu_exec (cpu=cpu@entry=0x560ef326ac10) at /data/qemu/accel/tcg/cpu-exec.c:748
#14 0x0000560ef0bb779f in tcg_cpu_exec (cpu=0x560ef326ac10) at /data/qemu/softmmu/cpus.c:1356
#15 0x0000560ef0bb980b in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x560ef326ac10) at /data/qemu/softmmu/cpus.c:1664
#16 0x0000560ef10aaf76 in qemu_thread_start (args=<optimized out>) at /data/qemu/util/qemu-thread-posix.c:521
#17 0x00007f919e9434f9 in start_thread () at /lib64/libpthread.so.0
#18 0x00007f919e67bf2f in clone () at /lib64/libc.so.6

I've reproduced that with a local Jailhouse installation, but I suspect 
(do not have the time right now to check) that a vanilla jailhouse-
images [1] build for qemu-arm64 will trigger it as well. Once time 
permits, I could try to generate and share such an image.

qemu 3.1.1.1 of my distro is fine, also f4d8cf148e43.

Any ideas?

Jan

[1] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

