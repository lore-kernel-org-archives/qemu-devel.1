Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E01BC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F07207FB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6rzg3HZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F07207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzdw-0002do-2e
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kNzcl-000247-Up
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kNzcj-0000qx-Ob
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601562716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=loi6TnVq2iqiwh8MBD4G5+J+KVJqokAmn1fh30h4Auw=;
 b=g6rzg3HZlNWLdVXGRMBumG6TiYhodyPMwSV1CT49UMttJKLcOV8FqNcWJDvEMClPK4f3Ak
 8I00LBLhOIjGLVfDt4HB/IumbS+iJOvHdHNk3zc4PxgFgO7zjObhoQlAV0MQQzyT5ireta
 hVZkvQ2j/Z0y9UL1uj6y+5ACdAVihmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-YoZz7ss_ML23W1rap9sdlQ-1; Thu, 01 Oct 2020 10:31:54 -0400
X-MC-Unique: YoZz7ss_ML23W1rap9sdlQ-1
Received: by mail-wm1-f70.google.com with SMTP id 73so1250247wma.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=loi6TnVq2iqiwh8MBD4G5+J+KVJqokAmn1fh30h4Auw=;
 b=kqA+oyMFLAOsteK5KP46ZkHGpxS4jrrUaN7Ryqcp5/gwZOFy9lapJEX8Y9Ckxu9peB
 9qrGh429AhuoBDAskCW41qjsu/mileycR7MUJFQiA5wfDz6u7N82DOKPU21JIZ4gWWxI
 sYiahZF6al6xnqRaKXWde7KNQnmAIBLZ8iRU+6rZMi5K4KNrimEwXezVrFqcF3vLkt5V
 kDuoMz9N7qJ/Hd4CmQ19PCugpreCEtXIEseFMZVCGXFUUCdYIQak5CoZBs6rvUeQxY1q
 QZLHDs3n3lO1WmKq+PDHBXkgu+eplddQTTEQevxBEdLEMGoMmwYza2xGCyHvkyEPqYkD
 o54Q==
X-Gm-Message-State: AOAM530aaKGv+8wbU6CI68LLzEughNdZttRGTdPVoHSAQlQbAEq3eSJF
 EIciQ0TYjDjK5FOETSWY4hqqefE7afSXCmxhEnSrQxgVrm46W8MIPeFwQA8wYm4R/Y6wEiIciUu
 6xi0+6Bpbb8klRJo=
X-Received: by 2002:a1c:9695:: with SMTP id y143mr292037wmd.146.1601562712498; 
 Thu, 01 Oct 2020 07:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoLdganKjFMw1ADcJVdaIapHPhCRIoSZxtg7lHWrBVEUBEWVZe+IFQD0W2fpSl58KzCxdiWQ==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr292011wmd.146.1601562712175; 
 Thu, 01 Oct 2020 07:31:52 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id h1sm9488603wrx.33.2020.10.01.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:31:51 -0700 (PDT)
Date: Thu, 1 Oct 2020 16:31:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Subject: scripts/gdb: issues when loading modules after lx-symbols
Message-ID: <CAGxU2F7+Tf+hJxxadT_Rw01O43RU9RsasJiVLpukbhvo1w++fA@mail.gmail.com>
MIME-Version: 1.0
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
I had some issues with gdb scripts and kernel modules in Linux 5.9-rc7.

If the modules are already loaded, and I do 'lx-symbols', all work fine.
But, if I load a kernel module after 'lx-symbols', I had this issue:

[ 5093.393940] invalid opcode: 0000 [#1] SMP PTI
[ 5093.395134] CPU: 0 PID: 576 Comm: modprobe Not tainted 5.9.0-rc7-ste-00010-gf0b671d9608d-dirty #2
[ 5093.397566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
[ 5093.400761] RIP: 0010:do_init_module+0x1/0x270
[ 5093.402553] Code: ff ff e9 cf fe ff ff 0f 0b 49 c7 c4 f2 ff ff ff e9 c1 fe ff ff e8 5f b2 65 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 cc <1f> 44 00 00 55 ba 10 00 00 00 be c0 0c 00 00 48 89 e5 41 56 41 55
[ 5093.409505] RSP: 0018:ffffc90000563d18 EFLAGS: 00010246
[ 5093.412056] RAX: 0000000000000000 RBX: ffffffffc010a0c0 RCX: 0000000000004ee3
[ 5093.414472] RDX: 0000000000004ee2 RSI: ffffea0001efe188 RDI: ffffffffc010a0c0
[ 5093.416349] RBP: ffffc90000563e50 R08: 0000000000000000 R09: 0000000000000002
[ 5093.418044] R10: 0000000000000096 R11: 00000000000008a4 R12: ffff88807a0d1280
[ 5093.424721] R13: ffffffffc010a110 R14: ffff88807a0d1300 R15: ffffc90000563e70
[ 5093.427138] FS:  00007f018f632740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[ 5093.430037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5093.432279] CR2: 000055fbe282b239 CR3: 000000007922a006 CR4: 0000000000170ef0
[ 5093.435096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5093.436765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5093.439689] Call Trace:
[ 5093.440954]  ? load_module+0x24b6/0x27d0
[ 5093.443212]  ? __kernel_read+0xd6/0x150
[ 5093.445140]  __do_sys_finit_module+0xd3/0xf0
[ 5093.446877]  __x64_sys_finit_module+0x1a/0x20
[ 5093.449098]  do_syscall_64+0x38/0x50
[ 5093.450877]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5093.456153] RIP: 0033:0x7f018f75c43d
[ 5093.457728] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 6a 0c 00 f7 d8 64 89 01 48
[ 5093.466349] RSP: 002b:00007ffd7f080368 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 5093.470613] RAX: ffffffffffffffda RBX: 0000557e5c96f9c0 RCX: 00007f018f75c43d
[ 5093.474747] RDX: 0000000000000000 RSI: 0000557e5c964288 RDI: 0000000000000003
[ 5093.478049] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[ 5093.481298] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[ 5093.483725] R13: 0000557e5c964288 R14: 0000557e5c96f950 R15: 0000557e5c9775c0
[ 5093.485778] Modules linked in: virtio_vdpa(+) vdpa sunrpc kvm_intel kvm irqbypass virtio_blk virtio_rng rng_core [last unloaded: virtio_vdpa]
[ 5093.488695] ---[ end trace 23712ecebc11f53c ]---

Guest kernel: Linux 5.9-rc7
gdb: GNU gdb (GDB) Fedora 9.1-6.fc32
I tried with QEMU 4.2.1 and the latest master branch: same issue.


I did some digging, and skipping the gdb 'add-symbol-file' command in symbol.py
avoid the issue, but of course I don't have the symbols loaded:

    diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
    index 1be9763cf8bb..eadfaa4d4907 100644
    --- a/scripts/gdb/linux/symbols.py
    +++ b/scripts/gdb/linux/symbols.py
    @@ -129,7 +129,7 @@ lx-symbols command."""
                     filename=module_file,
                     addr=module_addr,
                     sections=self._section_arguments(module))
    -            gdb.execute(cmdline, to_string=True)
    +            #gdb.execute(cmdline, to_string=True)
                 if module_name not in self.loaded_modules:
                     self.loaded_modules.append(module_name)
             else:

I tried several modules and this happens every time after '(gdb) lx-symbols'.

Do you have any hints?


Thanks,
Stefano


