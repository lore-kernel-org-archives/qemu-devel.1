Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F2DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD97A20B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bajOkita"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD97A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuRY-00050S-It
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kNuQk-0004H3-NM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kNuQi-0006FY-00
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:59:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601542750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JwMSHGZnSNtQNCK68FP5CoWj75RnPhMMG/QFSbLLBQM=;
 b=bajOkitaK0zEuOMxbCXr3DzBrG6G/mcgnnCA5+ORO159uSWER2KwzZfqk+a+p7KjiKuRk3
 qeUdFlDnlmqXE9fo33w+vd+F5axelG8t8C4ZxPWSlm4aoKDlUn/e+aWPJT+5YRIg0qw1cn
 Gp6qlYU/0zBdTTw08gdgfdTPDL/tAUc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-se4xB5muNYy44409qKm-tQ-1; Thu, 01 Oct 2020 04:59:05 -0400
X-MC-Unique: se4xB5muNYy44409qKm-tQ-1
Received: by mail-wr1-f72.google.com with SMTP id v5so1800315wrr.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 01:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JwMSHGZnSNtQNCK68FP5CoWj75RnPhMMG/QFSbLLBQM=;
 b=YX/uvtRB+TioWAfpZpRGteWFLZWn3BqQRju/e28ZXjKms2ig3EK4dhJoJcnH2/RBIY
 7mYUBYLMjmFV3VqdyYAMK1S5+3oiHmkOvTJYOCVfP/If2AjUpGzD0AveSIzRP+0HqBMw
 LPNTRw97py+1l+djApxMZeQI6NOjve4qCRMH5NXA7HU2j3RQx0xM5KEnNt071ObFqv+g
 LHnLagM+TvNNHdpWWn9pAjYvZjDc39ygsUAYhamr0ToQJEk+cIJD3mzEzZp2yWBC41LJ
 5gMrGrOGHFa81l0hucZmFSI97SY9N/UsUSMQGU4/I+0mQpKAE+GEzxz88coOcqK40mWf
 IDaA==
X-Gm-Message-State: AOAM530Csw/7SX6KrgCoy2q3haqsjM/ALdujPZitKeL9QPiWSl8od9u/
 li02voZGEdm+5/NDtF0Ek+10/tIKPR1Lrda/RGlhINWmtHXhf+gAFa20fT8fn6LQYmHQhfv+1xQ
 jRMGHirosvi52mZQ=
X-Received: by 2002:adf:aadb:: with SMTP id i27mr7569860wrc.258.1601542743975; 
 Thu, 01 Oct 2020 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+JTPJeTK41KiqBd7vRDGwFs/s8llUIYK6tPTqJHnzW3LSmvsrtXqQAHYONbNKsLJNhetsvA==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr7569831wrc.258.1601542743657; 
 Thu, 01 Oct 2020 01:59:03 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id n3sm7745581wmn.28.2020.10.01.01.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 01:59:03 -0700 (PDT)
Date: Thu, 1 Oct 2020 10:59:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
Message-ID: <20201001085900.ms5ix2zyoid7v3ra@steredhat>
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Cc: qemu-devel@nongnu.org

Hi,

On Thu, Oct 01, 2020 at 01:26:51AM +0900, Ju Hyung Park wrote:
> Hi everyone.
> 
> I have recently switched to a setup running QEMU 5.0(which supports
> io_uring) for a Windows 10 guest on Linux v5.4.63.
> The QEMU hosts /dev/nvme0n1p3 to the guest with virtio-blk with
> discard/unmap enabled.

Please, can you share the qemu command line that you are using?
This can be useful for the analysis.

Thanks,
Stefano

> 
> I've been having a weird issue where the system would randomly hang
> whenever I turn on or shutdown the guest. The host will stay up for a
> bit and then just hang. No response on SSH, etc. Even ping doesn't
> work.
> 
> It's been hard to even get a log to debug the issue, but I've been
> able to get a show-backtrace-all-active-cpus sysrq dmesg on the most
> recent encounter with the issue and it's showing some io_uring
> functions.
> 
> Since I've been encountering the issue ever since I switched to QEMU
> 5.0, I suspect io_uring may be the culprit to the issue.
> 
> While I'd love to try out the mainline kernel, it's currently not
> feasible at the moment as I have to stay in linux-5.4.y. Backporting
> mainline's io_uring also seems to be a non-trivial job.
> 
> Any tips would be appreciated. I can build my own kernel and I'm
> willing to try out (backported) patches.
> 
> Thanks.
> 
> [243683.539303] NMI backtrace for cpu 1
> [243683.539303] CPU: 1 PID: 1527 Comm: qemu-system-x86 Tainted: P
>   W  O      5.4.63+ #1
> [243683.539303] Hardware name: System manufacturer System Product
> Name/PRIME Z370-A, BIOS 2401 07/12/2019
> [243683.539304] RIP: 0010:io_uring_flush+0x98/0x140
> [243683.539304] Code: e4 74 70 48 8b 93 e8 02 00 00 48 8b 32 48 8b 4a
> 08 48 89 4e 08 48 89 31 48 89 12 48 89 52 08 48 8b 72 f8 81 4a a8 00
> 40 00 00 <48> 85 f6 74 15 4c 3b 62 c8 75 0f ba 01 00 00 00 bf 02 00 00
> 00 e8
> [243683.539304] RSP: 0018:ffff8881f20c3e28 EFLAGS: 00000006
> [243683.539305] RAX: ffff888419cd94e0 RBX: ffff88842ba49800 RCX:
> ffff888419cd94e0
> [243683.539305] RDX: ffff888419cd94e0 RSI: ffff888419cd94d0 RDI:
> ffff88842ba49af8
> [243683.539306] RBP: ffff88842ba49af8 R08: 0000000000000001 R09:
> ffff88840d17aaf8
> [243683.539306] R10: 0000000000000001 R11: 00000000ffffffec R12:
> ffff88843c68c080
> [243683.539306] R13: ffff88842ba49ae8 R14: 0000000000000001 R15:
> 0000000000000000
> [243683.539307] FS:  0000000000000000(0000) GS:ffff88843ea80000(0000)
> knlGS:0000000000000000
> [243683.539307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [243683.539307] CR2: 00007f3234b31f90 CR3: 0000000002608001 CR4:
> 00000000003726e0
> [243683.539307] Call Trace:
> [243683.539308]  ? filp_close+0x2a/0x60
> [243683.539308]  ? put_files_struct.part.0+0x57/0xb0
> [243683.539309]  ? do_exit+0x321/0xa70
> [243683.539309]  ? do_group_exit+0x35/0x90
> [243683.539309]  ? __x64_sys_exit_group+0xf/0x10
> [243683.539309]  ? do_syscall_64+0x41/0x160
> [243683.539309]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [243684.753272] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [243684.753278] rcu: 1-...0: (1 GPs behind)
> idle=a5e/1/0x4000000000000000 softirq=7893711/7893712 fqs=2955
> [243684.753280] (detected by 3, t=6002 jiffies, g=17109677, q=117817)
> [243684.753282] Sending NMI from CPU 3 to CPUs 1:
> [243684.754285] NMI backtrace for cpu 1
> [243684.754285] CPU: 1 PID: 1527 Comm: qemu-system-x86 Tainted: P
>   W  O      5.4.63+ #1
> [243684.754286] Hardware name: System manufacturer System Product
> Name/PRIME Z370-A, BIOS 2401 07/12/2019
> [243684.754286] RIP: 0010:io_uring_flush+0x83/0x140
> [243684.754287] Code: 89 ef e8 00 36 92 00 48 8b 83 e8 02 00 00 49 39
> c5 74 52 4d 85 e4 74 70 48 8b 93 e8 02 00 00 48 8b 32 48 8b 4a 08 48
> 89 4e 08 <48> 89 31 48 89 12 48 89 52 08 48 8b 72 f8 81 4a a8 00 40 00
> 00 48
> [243684.754287] RSP: 0018:ffff8881f20c3e28 EFLAGS: 00000002
> [243684.754288] RAX: ffff888419cd94e0 RBX: ffff88842ba49800 RCX:
> ffff888419cd94e0
> [243684.754288] RDX: ffff888419cd94e0 RSI: ffff888419cd94e0 RDI:
> ffff88842ba49af8
> [243684.754289] RBP: ffff88842ba49af8 R08: 0000000000000001 R09:
> ffff88840d17aaf8
> [243684.754289] R10: 0000000000000001 R11: 00000000ffffffec R12:
> ffff88843c68c080
> [243684.754289] R13: ffff88842ba49ae8 R14: 0000000000000001 R15:
> 0000000000000000
> [243684.754290] FS:  0000000000000000(0000) GS:ffff88843ea80000(0000)
> knlGS:0000000000000000
> [243684.754290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [243684.754291] CR2: 00007f3234b31f90 CR3: 0000000002608001 CR4:
> 00000000003726e0
> [243684.754291] Call Trace:
> [243684.754291]  ? filp_close+0x2a/0x60
> [243684.754291]  ? put_files_struct.part.0+0x57/0xb0
> [243684.754292]  ? do_exit+0x321/0xa70
> [243684.754292]  ? do_group_exit+0x35/0x90
> [243684.754292]  ? __x64_sys_exit_group+0xf/0x10
> [243684.754293]  ? do_syscall_64+0x41/0x160
> [243684.754293]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 


