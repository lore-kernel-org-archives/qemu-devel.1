Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B9C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884F72068D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884F72068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP98w-0000qE-NP
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1kP97q-00009c-77
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:52:50 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1kP97m-0005HV-B9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:52:48 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 094Iqc3F027724
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 4 Oct 2020 20:52:38 +0200
Received: from [167.87.242.108] ([167.87.242.108])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 094Iqb1u011919;
 Sun, 4 Oct 2020 20:52:38 +0200
Subject: Re: scripts/gdb: issues when loading modules after lx-symbols
To: Stefano Garzarella <sgarzare@redhat.com>,
 Kieran Bingham <kbingham@kernel.org>
References: <CAGxU2F7+Tf+hJxxadT_Rw01O43RU9RsasJiVLpukbhvo1w++fA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9e247182-2cc3-9fac-e12e-9743ef24ec43@siemens.com>
Date: Sun, 4 Oct 2020 20:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7+Tf+hJxxadT_Rw01O43RU9RsasJiVLpukbhvo1w++fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=194.138.37.39;
 envelope-from=jan.kiszka@siemens.com; helo=lizzard.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 14:52:40
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.10.20 16:31, Stefano Garzarella wrote:
> Hi,
> I had some issues with gdb scripts and kernel modules in Linux 5.9-rc7.
> 
> If the modules are already loaded, and I do 'lx-symbols', all work fine.
> But, if I load a kernel module after 'lx-symbols', I had this issue:
> 
> [ 5093.393940] invalid opcode: 0000 [#1] SMP PTI
> [ 5093.395134] CPU: 0 PID: 576 Comm: modprobe Not tainted 5.9.0-rc7-ste-00010-gf0b671d9608d-dirty #2
> [ 5093.397566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> [ 5093.400761] RIP: 0010:do_init_module+0x1/0x270
> [ 5093.402553] Code: ff ff e9 cf fe ff ff 0f 0b 49 c7 c4 f2 ff ff ff e9 c1 fe ff ff e8 5f b2 65 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 cc <1f> 44 00 00 55 ba 10 00 00 00 be c0 0c 00 00 48 89 e5 41 56 41 55
> [ 5093.409505] RSP: 0018:ffffc90000563d18 EFLAGS: 00010246
> [ 5093.412056] RAX: 0000000000000000 RBX: ffffffffc010a0c0 RCX: 0000000000004ee3
> [ 5093.414472] RDX: 0000000000004ee2 RSI: ffffea0001efe188 RDI: ffffffffc010a0c0
> [ 5093.416349] RBP: ffffc90000563e50 R08: 0000000000000000 R09: 0000000000000002
> [ 5093.418044] R10: 0000000000000096 R11: 00000000000008a4 R12: ffff88807a0d1280
> [ 5093.424721] R13: ffffffffc010a110 R14: ffff88807a0d1300 R15: ffffc90000563e70
> [ 5093.427138] FS:  00007f018f632740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [ 5093.430037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5093.432279] CR2: 000055fbe282b239 CR3: 000000007922a006 CR4: 0000000000170ef0
> [ 5093.435096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5093.436765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5093.439689] Call Trace:
> [ 5093.440954]  ? load_module+0x24b6/0x27d0
> [ 5093.443212]  ? __kernel_read+0xd6/0x150
> [ 5093.445140]  __do_sys_finit_module+0xd3/0xf0
> [ 5093.446877]  __x64_sys_finit_module+0x1a/0x20
> [ 5093.449098]  do_syscall_64+0x38/0x50
> [ 5093.450877]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5093.456153] RIP: 0033:0x7f018f75c43d
> [ 5093.457728] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 6a 0c 00 f7 d8 64 89 01 48
> [ 5093.466349] RSP: 002b:00007ffd7f080368 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [ 5093.470613] RAX: ffffffffffffffda RBX: 0000557e5c96f9c0 RCX: 00007f018f75c43d
> [ 5093.474747] RDX: 0000000000000000 RSI: 0000557e5c964288 RDI: 0000000000000003
> [ 5093.478049] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
> [ 5093.481298] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [ 5093.483725] R13: 0000557e5c964288 R14: 0000557e5c96f950 R15: 0000557e5c9775c0
> [ 5093.485778] Modules linked in: virtio_vdpa(+) vdpa sunrpc kvm_intel kvm irqbypass virtio_blk virtio_rng rng_core [last unloaded: virtio_vdpa]
> [ 5093.488695] ---[ end trace 23712ecebc11f53c ]---
> 
> Guest kernel: Linux 5.9-rc7
> gdb: GNU gdb (GDB) Fedora 9.1-6.fc32
> I tried with QEMU 4.2.1 and the latest master branch: same issue.
> 
> 
> I did some digging, and skipping the gdb 'add-symbol-file' command in symbol.py
> avoid the issue, but of course I don't have the symbols loaded:
> 
>     diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
>     index 1be9763cf8bb..eadfaa4d4907 100644
>     --- a/scripts/gdb/linux/symbols.py
>     +++ b/scripts/gdb/linux/symbols.py
>     @@ -129,7 +129,7 @@ lx-symbols command."""
>                      filename=module_file,
>                      addr=module_addr,
>                      sections=self._section_arguments(module))
>     -            gdb.execute(cmdline, to_string=True)
>     +            #gdb.execute(cmdline, to_string=True)
>                  if module_name not in self.loaded_modules:
>                      self.loaded_modules.append(module_name)
>              else:
> 
> I tried several modules and this happens every time after '(gdb) lx-symbols'.
> 
> Do you have any hints?
> 
I assume you are debugging a kernel inside QEMU/KVM, right? Does it work
without -enable-kvm?

Debugging guests in KVM mode at least was unstable for a long time. I
avoided setting soft-BPs - which is what the script does for the sake of
tracking modules loading -, falling back to hw-BPs, as I had no time to
debug that further. /Maybe/ that's the issue here.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

