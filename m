Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FDCC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407E620659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKEGQZCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407E620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXxL-000701-Ia
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hgXtM-0002bQ-EL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hgXtL-0001ZH-7R
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:09:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:37215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hgXtK-0001Vl-W1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id 19so1549096pfa.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=56wknDl+R2vKfvzxJbN295cnSaF5a32O16CX74OuF98=;
 b=LKEGQZCrdOY4i5pOtGMJ2boqRAJMM+s1A2dRMgegAwpHzGIDAxmLFLNh+W450iFdNI
 5qStCZQHYu9G5JwX/z+4aj17ut8HhKL0cjtrZf9UCnHapJEaHQZSn36DhOURRm0BaRiF
 Mpkdr12n0TfbZT/GWpOC/XePXccTLxlrbi8mw0JLiolfz3aRyT7mKQmm1UTfmo456SBT
 jr9XzuwS+be9OmHSutlsONp8uw1IFLM39ilDEW7chpeknZ3hu+IOSTEm37veleNh1fDD
 zfmN8aTJ4tTc1xSjCtipj1Icy2Nmw9XrULYq/rMfFcdhsyNy3i96XjGNVPGPEPqJqS2m
 g9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=56wknDl+R2vKfvzxJbN295cnSaF5a32O16CX74OuF98=;
 b=aCFerdqQOAvw1p5MLGGYJnMU2oDytjBrY9fV3tMf7CYdeQ2+ajxjKJ61Ya6sUR5kMm
 wQlThzRGovPzwuKNit6XKOsj6GVOScD2OPFTOFjweTAgV23CNV+XqxeowNzJd0jN4Hv7
 4rUc0rZsHyqp+UDIt1T20vuaHRiBDn8BNW19GbdpTxfwmVao07JblQFxqhjN5CltXbU+
 swGSStYklAgIcFhy1tzGj23trKognlgY7v8JJrzhgfTXynV53Sn5i2K9iP61/EF1XEv+
 UmrUbr1tNfKsbUOPFkjwxKHuLqm77PgOfErjIVmbjMk9MS3Iqcav6XWC1eNetPpBqpsz
 eDfQ==
X-Gm-Message-State: APjAAAWuUksnVpBn0zKE1MrhQb1giRegExAdC+vpnbyiVXZJ1hs9apLd
 4383+nHsJaxZg8R4+DByH5XIpb45
X-Google-Smtp-Source: APXvYqzsFf/V7BB9uIqRSk/vG8UAPQOi2ckqKYaDVKmP4E+K1aO6Db+4gJ/lz+23dzQPcNAZXNbSnQ==
X-Received: by 2002:a63:f807:: with SMTP id n7mr4908739pgh.119.1561655334423; 
 Thu, 27 Jun 2019 10:08:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l13sm5763350pjq.20.2019.06.27.10.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:08:53 -0700 (PDT)
Date: Thu, 27 Jun 2019 10:08:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Message-ID: <20190627170851.GA24222@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] qemu-system-{x86,x86_64} crash in io_writex
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

I see random crashes when running qemu-system-{x86, x86_64}.
The problem started happening several releases ago, but I finally
have been able to capture some core dumps. This is with qemu v4.0.

The crash always happens in io_writex(), and the reason is that 'mr'
is NULL. I attached some gdb information below. The crash is seen
maybe once every ~100 boots, and it seems to happen during PCI
enumeration.

[    2.044504] PCI host bridge to bus 0000:00
[    2.044836] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.045142] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    2.045286] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    2.045436] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    2.045583] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfebfffff]
[    2.045747] pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff]
^^^ crash here

[    2.732815] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.733081] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.733301] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.733509] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfebfffff window]
[    2.733716] pci_bus 0000:00: root bus resource [mem 0x800000000-0xfffffffff window]
[    2.734187] pci_bus 0000:00: root bus resource [bus 00-ff]
^^^ crash here

Has anyone else seen this problem ? Any idea what I can do to help
tracking it down ?

Thanks,
Guenter

---
(gdb) info stack
#0  io_writex (env=env@entry=0x5555567982c0, iotlbentry=0x7fffb006d5d0, mmu_idx=mmu_idx@entry=2, val=val@entry=2301, 
    addr=addr@entry=18446744073699050240, retaddr=retaddr@entry=140736404017834, recheck=false, size=4)
    at /opt/buildbot/qemu/qemu/accel/tcg/cputlb.c:971
#1  0x000055555588e75f in io_writel (recheck=<optimized out>, retaddr=140736404017834, addr=18446744073699050240, val=2301, 
    index=<optimized out>, mmu_idx=2, env=0x5555567982c0) at /opt/buildbot/qemu/qemu/accel/tcg/softmmu_template.h:277
#2  helper_le_stl_mmu (env=0x5555567982c0, addr=18446744073699050240, val=2301, oi=34, retaddr=140736404017834)
    at /opt/buildbot/qemu/qemu/accel/tcg/softmmu_template.h:316
#3  0x00007fffbf5e52aa in code_gen_buffer ()
#4  0x00005555558a3c70 in cpu_tb_exec (itb=<optimized out>, cpu=0x7fffbf186800 <code_gen_buffer+51931091>)
    at /opt/buildbot/qemu/qemu/accel/tcg/cpu-exec.c:171
#5  cpu_loop_exec_tb (tb_exit=<synthetic pointer>, last_tb=<synthetic pointer>, tb=<optimized out>, 
    cpu=0x7fffbf186800 <code_gen_buffer+51931091>) at /opt/buildbot/qemu/qemu/accel/tcg/cpu-exec.c:618
#6  cpu_exec (cpu=cpu@entry=0x555556790010) at /opt/buildbot/qemu/qemu/accel/tcg/cpu-exec.c:729
#7  0x000055555585d4af in tcg_cpu_exec (cpu=0x555556790010) at /opt/buildbot/qemu/qemu/cpus.c:1430
#8  0x000055555585f818 in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x555556790010) at /opt/buildbot/qemu/qemu/cpus.c:1734
#9  0x0000555555c5c676 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:502
#10 0x00007ffff270b6db in __gettimeofday@plt () from /lib/x86_64-linux-gnu/libpthread.so.0
#11 0x00007fffd37fe700 in ?? ()
#12 0x00007fffd37fe700 in ?? ()
#13 0x544ac8b6bb8ba609 in ?? ()
#14 0x00007fffd37fb300 in ?? ()
#15 0x0000000000000000 in ?? ()
(gdb) p *iotlbentry
$14 = {addr = 10502175, attrs = {unspecified = 0, secure = 0, user = 0, requester_id = 0, target_tlb_bit0 = 0, target_tlb_bit1 = 0, 
    target_tlb_bit2 = 0}}
(gdb) p mr
$15 = (MemoryRegion *) 0x0
(gdb) p *section
$16 = {mr = 0x0, fv = 0x0, offset_within_region = 0, size = 0, offset_within_address_space = 0, readonly = false, nonvolatile = false}
(gdb) l /opt/buildbot/qemu/qemu/accel/tcg/cputlb.c:971
966	        cpu_io_recompile(cpu, retaddr);
967	    }
968	    cpu->mem_io_vaddr = addr;
969	    cpu->mem_io_pc = retaddr;
970	
971	    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
972	        qemu_mutex_lock_iothread();
973	        locked = true;
974	    }
975	    r = memory_region_dispatch_write(mr, mr_offset,

