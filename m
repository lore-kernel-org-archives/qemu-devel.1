Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF62C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA02E2137B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIPBEV5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA02E2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyx2-0002Hv-Uu
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jack.wang.usish@gmail.com>)
 id 1kNyw9-0001p6-9a
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:47:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jack.wang.usish@gmail.com>)
 id 1kNyw5-0002r0-Pf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:47:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id h17so5440105otr.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=luzrohihsebckLnZy+IdRfpxBmKdKnt57hLt2DXtzO4=;
 b=NIPBEV5e7tHONbv6NqS6BeLsrRTyKLpbxr1XQlNmtGl01k8rFH0rsk2yo7FutmZ2Mh
 IJpu7PBPaa6oTb0jCPyNz57xmdOumlA4x/6nxkVerCfJjbQVkAY8hiYO0obRF358YPnF
 8x18vOxiHfhVwaKTxEcfwGuZVedpUr1hhysb0kmB00FW5kZwNIqTQd5E8pDq0pMP+xTC
 7G5My2oEBSGYeBm5Jq/SCqiZyVfz2uv1Kxeyd/ceTHdTc6gCjR44vsmHJJ41xGQSlq4f
 I89LdpzdxpuNdgkCWQh5FuaFFgBMMaHQPRC8pVAfPC45RUtFUMNg+Pp9IsQpo/+V/HF3
 PAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=luzrohihsebckLnZy+IdRfpxBmKdKnt57hLt2DXtzO4=;
 b=K22npG3t6D2UuaNsZZ7wIsmu26ADDW5JgVxG0qhGxg5XUJ4ogBlXiaTJVCQgfnwE//
 GxbwBaehH1gKqSJDUO5eI30rzMZkcSWtGREQH6v6ASCAxpxVgIsPeM4JiCk2rF4iodbv
 pADpRX9pdhL6ya5t81tdfH+nVSzY5EkSfYYDXfZqd982CLFFN5RSjKORMxiX8YDGtqCu
 eflPHGQXmfnkTcGvq7/Kn/ZNJxAIJMeZ1JfY8UY0XG/snxEWMp5uLGtUKSbm42mFjp5r
 jFYdw34dmuE0oReSV5ncMEccVU76n98/5ANLhHXN8QJlhIpWLL9JaJOODETPxYIIArb6
 /Ylw==
X-Gm-Message-State: AOAM531dfdv5YY8umC3QIri7WDAUFMzDs2zaosiFiVrznd2c4KoInM7R
 US5NA8VboVjGvJW9J9E+E6pR01ZkV0pgva9yWPw=
X-Google-Smtp-Source: ABdhPJzshuiWoD/T2FXIf+V5dBCV8qkc5wWvgCo/xxzOi8H1gSllZap0k7F7/srWI3cBYVAyHfghIYW9UHczsGDzyZ0=
X-Received: by 2002:a9d:621a:: with SMTP id g26mr5260892otj.209.1601560070650; 
 Thu, 01 Oct 2020 06:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
 <20201001085900.ms5ix2zyoid7v3ra@steredhat>
In-Reply-To: <20201001085900.ms5ix2zyoid7v3ra@steredhat>
From: Jack Wang <jack.wang.usish@gmail.com>
Date: Thu, 1 Oct 2020 15:47:39 +0200
Message-ID: <CA+res+SW8GLrcK_fbZW09m7QDwMRgGGgaO3pY80iO2Lw5tHSDw@mail.gmail.com>
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=jack.wang.usish@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Ju Hyung Park <qkrwngud825@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:59=E5=86=99=E9=81=93=EF=BC=
=9A
>
> +Cc: qemu-devel@nongnu.org
>
> Hi,
>
> On Thu, Oct 01, 2020 at 01:26:51AM +0900, Ju Hyung Park wrote:
> > Hi everyone.
> >
> > I have recently switched to a setup running QEMU 5.0(which supports
> > io_uring) for a Windows 10 guest on Linux v5.4.63.
> > The QEMU hosts /dev/nvme0n1p3 to the guest with virtio-blk with
> > discard/unmap enabled.
>
> Please, can you share the qemu command line that you are using?
> This can be useful for the analysis.
>
> Thanks,
> Stefano
>
> >
> > I've been having a weird issue where the system would randomly hang
> > whenever I turn on or shutdown the guest. The host will stay up for a
> > bit and then just hang. No response on SSH, etc. Even ping doesn't
> > work.
> >
> > It's been hard to even get a log to debug the issue, but I've been
> > able to get a show-backtrace-all-active-cpus sysrq dmesg on the most
> > recent encounter with the issue and it's showing some io_uring
> > functions.
> >
> > Since I've been encountering the issue ever since I switched to QEMU
> > 5.0, I suspect io_uring may be the culprit to the issue.
> >
> > While I'd love to try out the mainline kernel, it's currently not
> > feasible at the moment as I have to stay in linux-5.4.y. Backporting
> > mainline's io_uring also seems to be a non-trivial job.
> >
> > Any tips would be appreciated. I can build my own kernel and I'm
> > willing to try out (backported) patches.
> >
> > Thanks.
> >
> > [243683.539303] NMI backtrace for cpu 1
> > [243683.539303] CPU: 1 PID: 1527 Comm: qemu-system-x86 Tainted: P
> >   W  O      5.4.63+ #1
> > [243683.539303] Hardware name: System manufacturer System Product
> > Name/PRIME Z370-A, BIOS 2401 07/12/2019
> > [243683.539304] RIP: 0010:io_uring_flush+0x98/0x140
> > [243683.539304] Code: e4 74 70 48 8b 93 e8 02 00 00 48 8b 32 48 8b 4a
> > 08 48 89 4e 08 48 89 31 48 89 12 48 89 52 08 48 8b 72 f8 81 4a a8 00
> > 40 00 00 <48> 85 f6 74 15 4c 3b 62 c8 75 0f ba 01 00 00 00 bf 02 00 00
> > 00 e8
> > [243683.539304] RSP: 0018:ffff8881f20c3e28 EFLAGS: 00000006
> > [243683.539305] RAX: ffff888419cd94e0 RBX: ffff88842ba49800 RCX:
> > ffff888419cd94e0
> > [243683.539305] RDX: ffff888419cd94e0 RSI: ffff888419cd94d0 RDI:
> > ffff88842ba49af8
> > [243683.539306] RBP: ffff88842ba49af8 R08: 0000000000000001 R09:
> > ffff88840d17aaf8
> > [243683.539306] R10: 0000000000000001 R11: 00000000ffffffec R12:
> > ffff88843c68c080
> > [243683.539306] R13: ffff88842ba49ae8 R14: 0000000000000001 R15:
> > 0000000000000000
> > [243683.539307] FS:  0000000000000000(0000) GS:ffff88843ea80000(0000)
> > knlGS:0000000000000000
> > [243683.539307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [243683.539307] CR2: 00007f3234b31f90 CR3: 0000000002608001 CR4:
> > 00000000003726e0
> > [243683.539307] Call Trace:
> > [243683.539308]  ? filp_close+0x2a/0x60
> > [243683.539308]  ? put_files_struct.part.0+0x57/0xb0
> > [243683.539309]  ? do_exit+0x321/0xa70
> > [243683.539309]  ? do_group_exit+0x35/0x90
> > [243683.539309]  ? __x64_sys_exit_group+0xf/0x10
> > [243683.539309]  ? do_syscall_64+0x41/0x160
> > [243683.539309]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [243684.753272] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [243684.753278] rcu: 1-...0: (1 GPs behind)
> > idle=3Da5e/1/0x4000000000000000 softirq=3D7893711/7893712 fqs=3D2955
> > [243684.753280] (detected by 3, t=3D6002 jiffies, g=3D17109677, q=3D117=
817)
> > [243684.753282] Sending NMI from CPU 3 to CPUs 1:
> > [243684.754285] NMI backtrace for cpu 1
> > [243684.754285] CPU: 1 PID: 1527 Comm: qemu-system-x86 Tainted: P
> >   W  O      5.4.63+ #1
> > [243684.754286] Hardware name: System manufacturer System Product
> > Name/PRIME Z370-A, BIOS 2401 07/12/2019
> > [243684.754286] RIP: 0010:io_uring_flush+0x83/0x140
> > [243684.754287] Code: 89 ef e8 00 36 92 00 48 8b 83 e8 02 00 00 49 39
> > c5 74 52 4d 85 e4 74 70 48 8b 93 e8 02 00 00 48 8b 32 48 8b 4a 08 48
> > 89 4e 08 <48> 89 31 48 89 12 48 89 52 08 48 8b 72 f8 81 4a a8 00 40 00
> > 00 48
> > [243684.754287] RSP: 0018:ffff8881f20c3e28 EFLAGS: 00000002
> > [243684.754288] RAX: ffff888419cd94e0 RBX: ffff88842ba49800 RCX:
> > ffff888419cd94e0
> > [243684.754288] RDX: ffff888419cd94e0 RSI: ffff888419cd94e0 RDI:
> > ffff88842ba49af8
> > [243684.754289] RBP: ffff88842ba49af8 R08: 0000000000000001 R09:
> > ffff88840d17aaf8
> > [243684.754289] R10: 0000000000000001 R11: 00000000ffffffec R12:
> > ffff88843c68c080
> > [243684.754289] R13: ffff88842ba49ae8 R14: 0000000000000001 R15:
> > 0000000000000000
> > [243684.754290] FS:  0000000000000000(0000) GS:ffff88843ea80000(0000)
> > knlGS:0000000000000000
> > [243684.754290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [243684.754291] CR2: 00007f3234b31f90 CR3: 0000000002608001 CR4:
> > 00000000003726e0
> > [243684.754291] Call Trace:
> > [243684.754291]  ? filp_close+0x2a/0x60
> > [243684.754291]  ? put_files_struct.part.0+0x57/0xb0
> > [243684.754292]  ? do_exit+0x321/0xa70
> > [243684.754292]  ? do_group_exit+0x35/0x90
> > [243684.754292]  ? __x64_sys_exit_group+0xf/0x10
> > [243684.754293]  ? do_syscall_64+0x41/0x160
> > [243684.754293]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
>
>
I got something similar
[250145.410520] general protection fault: 0000 [#1] SMP

[250145.410868] CPU: 5 PID: 39269 Comm: qemu-5.0 Kdump: loaded
Tainted: G           O      5.4.61-pserver
#5.4.61-1+develop20200831.1341+7430880~deb10

[250145.411468] Hardware name: Supermicro Super Server/X11DDW-L, BIOS
3.3 02/21/2020

[250145.412051] RIP: 0010:io_cancel_async_work+0x48/0xa0

[250145.412386] Code: fb 48 8d bf f8 02 00 00 48 89 f5 e8 02 f1 69 00
48 8b 83 e8 02 00 00 49 39 c4 74 52 48 8b 83 e8 02 00 00 48 8b 08 48
8b 50 08 <48> 89 51 08 48 8

9 0a 48 8b 70 f8 48 89 00 48 89 40 08 81 48 a8 00

[250145.413239] RSP: 0018:ffffc2d34efb7cf8 EFLAGS: 00010083

[250145.413576] RAX: ffffec9879729a80 RBX: ffff9fa2740ac400 RCX:
06ffff8000000000

[250145.414153] RDX: ffff9fa2740ac6e8 RSI: ffffec9879729a40 RDI:
ffff9fa2740ac6f8

[250145.414729] RBP: ffff9fa1cf86c080 R08: ffff9fa199ccecf8 R09:
8000002f724b7067

[250145.415307] R10: ffffc2d34efb7b8c R11: 0000000000000003 R12:
ffff9fa2740ac6e8

[250145.415884] R13: 0000000000000000 R14: 000000000000000d R15:
ffff9fa1af48e068

[250145.416461] FS:  0000000000000000(0000) GS:ffff9fa280940000(0000)
knlGS:0000000000000000

[250145.417042] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[250145.417380] CR2: 00007f5f14188000 CR3: 0000002f0c408005 CR4:
00000000007626e0

[250145.417957] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[250145.418535] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

[250145.419112] PKRU: 55555554

[250145.419438] Call Trace:

[250145.419768]  io_uring_flush+0x34/0x50

[250145.420101]  filp_close+0x31/0x60

[250145.420432]  put_files_struct+0x6c/0xc0

[250145.420767]  do_exit+0x347/0xa50

[250145.421097]  do_group_exit+0x3a/0x90

[250145.421429]  get_signal+0x125/0x7d0

[250145.421761]  do_signal+0x36/0x640

[250145.422090]  ? do_send_sig_info+0x5c/0x90

[250145.422423]  ? recalc_sigpending+0x17/0x50

[250145.422757]  exit_to_usermode_loop+0x61/0xd0

[250145.423090]  do_syscall_64+0xe6/0x120

[250145.423424]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[250145.423761] RIP: 0033:0x7f5f176997bb

