Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B23C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 03:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59AB21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 03:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="PlIK5aHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59AB21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSvCW-0003pS-W2
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 22:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1iSvBN-0003ET-EW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1iSvBK-0005N8-40
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:43:33 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30]:36693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1iSvBJ-0005Mb-Se
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 22:43:30 -0500
Received: by mail-yb1-xb30.google.com with SMTP id v17so2115509ybs.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 19:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5tGkQW8ch6v9XOjgyasqSMiCr7odk+kJu3mb0C0fNUo=;
 b=PlIK5aHdwc2bxe03yk0ftn0IxWiDydWxKB2dIm1oSh3k+gv/Rw24aJt07hgnOm9Bgr
 ao+2CB3Jw4tbyjW0mXi4U+xiD4EbWqgyim6tZsUdki/zLSkOL4hFcpCDkAc1x9Z0Ls2x
 eDscaU44VcYo4YNaVr4eUVCZLAmTamWDz38yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5tGkQW8ch6v9XOjgyasqSMiCr7odk+kJu3mb0C0fNUo=;
 b=D7B2gN8poie7PkwBsvq65BMYY8Z4WGwhT5TMjvivCaiwkc1T6mt8+sx3V8A91bFb2V
 eatMSIF1TFIa3yq9+a3Z0QRLPM/cIH63UQg1NOIfYiM5VXykQE8BaXQldfOr52XYQKnT
 krMyTHRAQzwZ378c2YbWhjkmQFg+IsEbKIeBf3a3oZ0uDeRHQw5Sh5L09g0WbBf2u+Bw
 dIlFQgkM22t14w8yr2rH76bm8gu0V8QOGAvm0TnTr8Pkgj5nfHgMayC+R9/KJ3rh3k0e
 0xnyPuK3aPgIVmi+hakGX2CJN+J2CD8zG3tTBV1IEKPqnkb4Kcj5hyvUDHzdkNd0uRKt
 5giA==
X-Gm-Message-State: APjAAAU/S4cgB6WcJK3wcf/Exq8MocDHXMpfg7cSqd7pKEzsC91TPeFI
 8xMPTv7NU3VM8F8paQJlIsiiHbAFX61Eqq74YjZFBA==
X-Google-Smtp-Source: APXvYqwGmnShiRfDkI4E5FLRbLVMF31fRBi+q2GGm1YcHWoO1ICBfo4tSWONygLi/MgDOmHzhbWu/UcG37mbomJ6Ybw=
X-Received: by 2002:a25:4292:: with SMTP id p140mr6963460yba.455.1573184608715; 
 Thu, 07 Nov 2019 19:43:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE5xLXSNUEEd9n_=Hcgu=8QXvwFNuZ4B5WunSmiqM_tnrg@mail.gmail.com>
 <20191104193719.665f6b3c@luklap>
 <CA+XQNE6nXFHTS2vj84U=soFa18idHte2p5u03Sba1k0OnTj1Gg@mail.gmail.com>
 <20191107143456.585fabcb@luklap>
In-Reply-To: <20191107143456.585fabcb@luklap>
From: Daniel Cho <danielcho@qnap.com>
Date: Fri, 8 Nov 2019 11:43:17 +0800
Message-ID: <CA+XQNE7eK3A-oDnVtJx5dYG5U-pv--Kd6jHUPsyJHKxiUrQM2A@mail.gmail.com>
Subject: Re: The problems about COLO
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: multipart/alternative; boundary="000000000000c4dee30596cd955b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b30
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4dee30596cd955b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Straub <lukasstraub2@web.de> =E6=96=BC 2019=E5=B9=B411=E6=9C=887=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:34=E5=AF=AB=E9=81=93=EF=BC=9A

> On Thu, 7 Nov 2019 16:14:43 +0800
> Daniel Cho <danielcho@qnap.com> wrote:
>
> > Hi  Lukas,
> > Thanks for your reply.
> >
> > However, we test the question 1 with steps below the error message, we
> > notice the secondary VM's image
> > will break  while it reboots.
> > Here is the error message.
> > -------------------------------------------------------------------
> > [    1.280299] XFS (sda1): Mounting V5 Filesystem
> > [    1.428418] input: ImExPS/2 Generic Explorer Mouse as
> > /devices/platform/i8042/serio1/input/input2
> > [    1.501320] XFS (sda1): Starting recovery (logdev: internal)
> > [    1.504076] tsc: Refined TSC clocksource calibration: 3492.211 MHz
> > [    1.505534] Switched to clocksource tsc
> > [    2.031027] XFS (sda1): Internal error XFS_WANT_CORRUPTED_GOTO at li=
ne
> > 1635 of file fs/xfs/libxfs/xfs_alloc.c.  Caller
> xfs_free_extent+0xfc/0x130
> > [xfs]
> > [    2.032743] CPU: 0 PID: 300 Comm: mount Not tainted
> > 3.10.0-693.11.6.el7.x86_64 #1
> > [    2.033982] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS
> > rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > [    2.035882] Call Trace:
> > [    2.036494]  [<ffffffff816a5ea1>] dump_stack+0x19/0x1b
> > [    2.037315]  [<ffffffffc01794eb>] xfs_error_report+0x3b/0x40 [xfs]
> > [    2.038150]  [<ffffffffc0138e6c>] ? xfs_free_extent+0xfc/0x130 [xfs]
> > [    2.039046]  [<ffffffffc01362da>] xfs_free_ag_extent+0x20a/0x780 [xf=
s]
> > [    2.039920]  [<ffffffffc0138e6c>] xfs_free_extent+0xfc/0x130 [xfs]
> > [    2.040768]  [<ffffffffc01a7736>] xfs_trans_free_extent+0x26/0x60
> [xfs]
> > [    2.041642]  [<ffffffffc019fade>] xlog_recover_process_efi+0x17e/0x1=
c0
> > [xfs]
> > [    2.042558]  [<ffffffffc01a1e37>]
> > xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]
> > [    2.043771]  [<ffffffffc01a5761>] xlog_recover_finish+0x21/0xb0 [xfs=
]
> > [    2.044650]  [<ffffffffc0198894>] xfs_log_mount_finish+0x34/0x50 [xf=
s]
> > [    2.045518]  [<ffffffffc018ef21>] xfs_mountfs+0x5d1/0x8b0 [xfs]
> > [    2.046341]  [<ffffffffc017d220>] ?
> xfs_filestream_get_parent+0x80/0x80
> > [xfs]
> > [    2.047260]  [<ffffffffc0191d6b>] xfs_fs_fill_super+0x3bb/0x4d0 [xfs=
]
> > [    2.048116]  [<ffffffff81206ad0>] mount_bdev+0x1b0/0x1f0
> > [    2.048881]  [<ffffffffc01919b0>] ?
> > xfs_test_remount_options.isra.11+0x70/0x70 [xfs]
> > [    2.050105]  [<ffffffffc01906d5>] xfs_fs_mount+0x15/0x20 [xfs]
> > [    2.050906]  [<ffffffff81207349>] mount_fs+0x39/0x1b0
> > [    2.051963]  [<ffffffff811a7d45>] ? __alloc_percpu+0x15/0x20
> > [    2.059431]  [<ffffffff81223f77>] vfs_kern_mount+0x67/0x110
> > [    2.060283]  [<ffffffff81226483>] do_mount+0x233/0xaf0
> > [    2.061081]  [<ffffffff811a2cfb>] ? strndup_user+0x4b/0xa0
> > [    2.061844]  [<ffffffff812270c6>] SyS_mount+0x96/0xf0
> > [    2.062619]  [<ffffffff816b89fd>] system_call_fastpath+0x16/0x1b
> > [    2.063512] XFS (sda1): Internal error xfs_trans_cancel at line 984 =
of
> > file fs/xfs/xfs_trans.c.  Caller xlog_recover_process_efi+0x18e/0x1c0
> [xfs]
> > [    2.065260] CPU: 0 PID: 300 Comm: mount Not tainted
> > 3.10.0-693.11.6.el7.x86_64 #1
> > [    2.066489] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS
> > rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > [    2.068023] Call Trace:
> > [    2.068590]  [<ffffffff816a5ea1>] dump_stack+0x19/0x1b
> > [    2.069403]  [<ffffffffc01794eb>] xfs_error_report+0x3b/0x40 [xfs]
> > [    2.070318]  [<ffffffffc019faee>] ?
> xlog_recover_process_efi+0x18e/0x1c0
> > [xfs]
> > [    2.071538]  [<ffffffffc019594d>] xfs_trans_cancel+0xbd/0xe0 [xfs]
> > [    2.072429]  [<ffffffffc019faee>] xlog_recover_process_efi+0x18e/0x1=
c0
> > [xfs]
> > [    2.073339]  [<ffffffffc01a1e37>]
> > xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]
> > [    2.074561]  [<ffffffffc01a5761>] xlog_recover_finish+0x21/0xb0 [xfs=
]
> > [    2.075421]  [<ffffffffc0198894>] xfs_log_mount_finish+0x34/0x50 [xf=
s]
> > [    2.076301]  [<ffffffffc018ef21>] xfs_mountfs+0x5d1/0x8b0 [xfs]
> > [    2.077128]  [<ffffffffc017d220>] ?
> xfs_filestream_get_parent+0x80/0x80
> > [xfs]
> > [    2.078049]  [<ffffffffc0191d6b>] xfs_fs_fill_super+0x3bb/0x4d0 [xfs=
]
> > [    2.078900]  [<ffffffff81206ad0>] mount_bdev+0x1b0/0x1f0
> > [    2.079667]  [<ffffffffc01919b0>] ?
> > xfs_test_remount_options.isra.11+0x70/0x70 [xfs]
> > [    2.080883]  [<ffffffffc01906d5>] xfs_fs_mount+0x15/0x20 [xfs]
> > [    2.081687]  [<ffffffff81207349>] mount_fs+0x39/0x1b0
> > [    2.082457]  [<ffffffff811a7d45>] ? __alloc_percpu+0x15/0x20
> > [    2.083258]  [<ffffffff81223f77>] vfs_kern_mount+0x67/0x110
> > [    2.084057]  [<ffffffff81226483>] do_mount+0x233/0xaf0
> > [    2.084797]  [<ffffffff811a2cfb>] ? strndup_user+0x4b/0xa0
> > [    2.085568]  [<ffffffff812270c6>] SyS_mount+0x96/0xf0
> > [    2.086324]  [<ffffffff816b89fd>] system_call_fastpath+0x16/0x1b
> > [    2.087161] XFS (sda1): xfs_do_force_shutdown(0x8) called from line
> 985
> > of file fs/xfs/xfs_trans.c.  Return address =3D 0xffffffffc0195966
> > [    2.088795] XFS (sda1): Corruption of in-memory data detected.
> Shutting
> > down filesystem
> > [    2.090273] XFS (sda1): Please umount the filesystem and rectify the
> > problem(s)
> > [    2.091519] XFS (sda1): Failed to recover EFIs
> > [    2.092299] XFS (sda1): log mount finish failed
> > [FAILED] Failed to mount /sysroot.
> > .
> > .
> > .
> > Generating "/run/initramfs/rdsosreport.txt"
> > [    2.178103] blk_update_request: I/O error, dev fd0, sector 0
> > [    2.246106] blk_update_request: I/O error, dev fd0, sector 0
> >   -------------------------------------------------------------------
> >
> > Here is the replicated steps:
> > *1. Start primary VM with command, and do every thing you want on PVM*
> >         qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -q=
mp
> > stdio -vnc :5 \
> >   -device piix3-usb-uhci,id=3Dpuu -device usb-tablet,id=3Dut -name prim=
ary \
> >   -netdev
> > tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-h=
elper \
> >   -device rtl8139,id=3De0,netdev=3Dhn0 \
> >   -drive
> >
> if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thresho=
ld=3D1,children.0.file.filename=3D$image_path,children.0.driver=3Dqcow2
> > *2. Add the device and object to PVM with qmp command*
> >       {'execute':'qmp_capabilities'}
> >       {"execute":"chardev-add", "arguments":{ "id" : "mirror0",
> "backend" :
> > { "type" : "socket", "data" : { "server": true, "wait": false, "addr": =
{
> > "type": "inet", "data":{ "host": "127.0.0.1", "port": "9003" } } } } }}
> >       {"execute":"chardev-add", "arguments":{ "id" : "compare1",
> "backend"
> > : { "type" : "socket", "data" : { "server": true, "wait": true, "addr":=
 {
> > "type": "inet", "data":{ "host": "127.0.0.1", "port": "9004" } } } } }}
> >       {"execute":"chardev-add", "arguments":{ "id" : "compare0",
> "backend"
> > : { "type" : "socket", "data" : { "server": true, "wait": false, "addr"=
:
> {
> > "type": "inet", "data":{ "host": "127.0.0.1", "port": "9001" } } } } }}
> >       {"execute":"chardev-add", "arguments":{ "id" : "compare0-0",
> > "backend" : { "type" : "socket", "data" : { "server": false, "addr": {
> > "type": "inet", "data":{ "host": "127.0.0.1", "port": "9001" } } } } }}
> >       {"execute":"chardev-add", "arguments":{ "id" : "compare_out",
> > "backend" : { "type" : "socket", "data" : { "server": true, "wait":
> false,
> > "addr": { "type": "inet", "data":{ "host": "127.0.0.1", "port": "9005" =
}
> }
> > } } }}
> >       {"execute":"chardev-add", "arguments":{ "id" : "compare_out0",
> > "backend" : { "type" : "socket", "data" : { "server": false, "addr": {
> > "type": "inet", "data":{ "host": "127.0.0.1", "port": "9005" } } } } } =
}
> >       {"execute":"object-add", "arguments":{ "qom-type" :
> "filter-mirror",
> > "id" : "m0", "props": { "netdev": "hn0", "outdev" : "mirror0", "queue" =
:
> > "tx" } } }
> >       {"execute":"object-add", "arguments":{ "qom-type" :
> > "filter-redirector", "id" : "redire0", "props": { "netdev": "hn0",
> "indev"
> > : "compare_out", "queue" : "rx" } } }
> >       {"execute":"object-add", "arguments":{ "qom-type" :
> > "filter-redirector", "id" : "redire1", "props": { "netdev": "hn0",
> "outdev"
> > : "compare0", "queue" : "rx" } } }
> >       {"execute":"object-add", "arguments":{ "qom-type" : "iothread",
> "id"
> > : "iothread1", "props": {} } }
> >       {"execute":"object-add", "arguments":{ "qom-type" : "colo-compare=
",
> > "id" : "comp0", "props": { "primary_in" : "compare0-0", "secondary_in" =
:
> > "compare1", "outdev" : "compare_out0", "iothread" : "iothread1"} } }
> > *3. Start the secondary VM with command*
> >         qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -q=
mp
> > stdio \
> >   -vnc :6 -device piix3-usb-uhci -device usb-tablet -name secondary \
> >   -netdev
> > tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-h=
elper \
> >   -device rtl8139,id=3De0,netdev=3Dhn0 \
> >   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D1 =
\
> >   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D1 =
\
> >   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred=
0 \
> >   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dre=
d1 \
> >   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> >   -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D$image_path,driver=
=3Dqcow2,\
> > node-name=3Dnode1 \
> >   -drive
> >
> if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary,file.dri=
ver=3Dqcow2,\
> > top-id=3Dactive-disk0,file.file.filename=3Dactive-disk.qcow2,\
> > file.backing.driver=3Dqcow2,file.backing.file.filename=3Dhidden-disk.qc=
ow2,\
> > file.backing.backing=3Dcolo-disk0,node-name=3Dnode2 \
> >   -incoming tcp:0:9998
> > *4. As the document create rbd server and do migrate with qmp command*
> > [image: image.png]
> > *5. Kill the PVM and failover to SVM*
> > [image: image.png]
> > *6. Reboot the secondary VM, then we will get the error.*
> > It is high possibility to occur this error.
> >
> > Therefore, we can solve the image problem by *xfs_repair*, then reboot
> the
> > VM it will work.
> > Command:
> > xfs_repair -L /dev/sda1
> >
> > Do you have any idea to occur this problem?
>
> Hi Daniel,
> The disks have to be synchronized before you can start COLO. So try
> something like this:
>
> {'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> 'job-id': 'resync', 'target': 'nbd://SECONDARY:?/colo-disk0', 'mode':
> 'existing', 'format': 'raw', 'sync': 'full'} }
>
> Then, after the job is ready:
> {'execute': 'stop'}
> {'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
>
> And then you can add the replication driver and start colo.
>
> Regards,
> Lukas Straub
>

Hi Lukas,
      It works well, thanks for your help.

Otherwise, could we change the secondary VM's *replication* driver to *quor=
um
*driver
to realize  continuously VM replication ?

Here is the start command.
Original :
qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -qmp stdio \
   -vnc :6 -device piix3-usb-uhci -device usb-tablet -name secondary \

 -netdev  tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-br=
idge-helper
\
   -device rtl8139,id=3De0,netdev=3Dhn0 \
   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D1 \
   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D1 \
   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 =
\
   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
   -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D$image_path,driver=3Dqc=
ow2,\
 node-name=3Dnode1 \

 -drive if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary,fi=
le.driver=3Dqcow2,\
 top-id=3Dactive-disk0,file.file.filename=3Dactive-disk.qcow2,\
 file.backing.driver=3Dqcow2,file.backing.file.filename=3Dhidden-disk.qcow2=
,\
 file.backing.backing=3Dcolo-disk0,node-name=3Dnode2 \
   -incoming tcp:0:9998

Modify :
  qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -qmp stdio \
   -vnc :6 -device piix3-usb-uhci -device usb-tablet -name secondary \

 -netdev  tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-br=
idge-helper
\
   -device rtl8139,id=3De0,netdev=3Dhn0 \
   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D1 \
   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D1 \
   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 =
\
   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
   -drive
if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-threshold=
=3D1,\
children.0.file.filename=3D$image_path,children.0.driver=3Dqcow2 \
   -incoming tcp:0:9998

Best regard,
Daniel Cho

--000000000000c4dee30596cd955b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Lukas Straub &lt;<a href=3D"mailto:lukass=
traub2@web.de">lukasstraub2@web.de</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=9C=
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:34=E5=AF=AB=E9=81=93=
=EF=BC=9A<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Thu, 7 Nov 2019 16:14:43 +0800<br>
Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">dani=
elcho@qnap.com</a>&gt; wrote:<br>
<br>
&gt; Hi=C2=A0 Lukas,<br>
&gt; Thanks for your reply.<br>
&gt;<br>
&gt; However, we test the question 1 with steps below the error message, we=
<br>
&gt; notice the secondary VM&#39;s image<br>
&gt; will break=C2=A0 while it reboots.<br>
&gt; Here is the error message.<br>
&gt; -------------------------------------------------------------------<br=
>
&gt; [=C2=A0 =C2=A0 1.280299] XFS (sda1): Mounting V5 Filesystem<br>
&gt; [=C2=A0 =C2=A0 1.428418] input: ImExPS/2 Generic Explorer Mouse as<br>
&gt; /devices/platform/i8042/serio1/input/input2<br>
&gt; [=C2=A0 =C2=A0 1.501320] XFS (sda1): Starting recovery (logdev: intern=
al)<br>
&gt; [=C2=A0 =C2=A0 1.504076] tsc: Refined TSC clocksource calibration: 349=
2.211 MHz<br>
&gt; [=C2=A0 =C2=A0 1.505534] Switched to clocksource tsc<br>
&gt; [=C2=A0 =C2=A0 2.031027] XFS (sda1): Internal error XFS_WANT_CORRUPTED=
_GOTO at line<br>
&gt; 1635 of file fs/xfs/libxfs/xfs_alloc.c.=C2=A0 Caller xfs_free_extent+0=
xfc/0x130<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.032743] CPU: 0 PID: 300 Comm: mount Not tainted<br>
&gt; 3.10.0-693.11.6.el7.x86_64 #1<br>
&gt; [=C2=A0 =C2=A0 2.033982] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS<br>
&gt; <a href=3D"http://rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org" rel=3D=
"noreferrer" target=3D"_blank">rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org=
</a> 04/01/2014<br>
&gt; [=C2=A0 =C2=A0 2.035882] Call Trace:<br>
&gt; [=C2=A0 =C2=A0 2.036494]=C2=A0 [&lt;ffffffff816a5ea1&gt;] dump_stack+0=
x19/0x1b<br>
&gt; [=C2=A0 =C2=A0 2.037315]=C2=A0 [&lt;ffffffffc01794eb&gt;] xfs_error_re=
port+0x3b/0x40 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.038150]=C2=A0 [&lt;ffffffffc0138e6c&gt;] ? xfs_free_e=
xtent+0xfc/0x130 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.039046]=C2=A0 [&lt;ffffffffc01362da&gt;] xfs_free_ag_=
extent+0x20a/0x780 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.039920]=C2=A0 [&lt;ffffffffc0138e6c&gt;] xfs_free_ext=
ent+0xfc/0x130 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.040768]=C2=A0 [&lt;ffffffffc01a7736&gt;] xfs_trans_fr=
ee_extent+0x26/0x60 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.041642]=C2=A0 [&lt;ffffffffc019fade&gt;] xlog_recover=
_process_efi+0x17e/0x1c0<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.042558]=C2=A0 [&lt;ffffffffc01a1e37&gt;]<br>
&gt; xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.043771]=C2=A0 [&lt;ffffffffc01a5761&gt;] xlog_recover=
_finish+0x21/0xb0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.044650]=C2=A0 [&lt;ffffffffc0198894&gt;] xfs_log_moun=
t_finish+0x34/0x50 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.045518]=C2=A0 [&lt;ffffffffc018ef21&gt;] xfs_mountfs+=
0x5d1/0x8b0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.046341]=C2=A0 [&lt;ffffffffc017d220&gt;] ? xfs_filest=
ream_get_parent+0x80/0x80<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.047260]=C2=A0 [&lt;ffffffffc0191d6b&gt;] xfs_fs_fill_=
super+0x3bb/0x4d0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.048116]=C2=A0 [&lt;ffffffff81206ad0&gt;] mount_bdev+0=
x1b0/0x1f0<br>
&gt; [=C2=A0 =C2=A0 2.048881]=C2=A0 [&lt;ffffffffc01919b0&gt;] ?<br>
&gt; xfs_test_remount_options.isra.11+0x70/0x70 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.050105]=C2=A0 [&lt;ffffffffc01906d5&gt;] xfs_fs_mount=
+0x15/0x20 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.050906]=C2=A0 [&lt;ffffffff81207349&gt;] mount_fs+0x3=
9/0x1b0<br>
&gt; [=C2=A0 =C2=A0 2.051963]=C2=A0 [&lt;ffffffff811a7d45&gt;] ? __alloc_pe=
rcpu+0x15/0x20<br>
&gt; [=C2=A0 =C2=A0 2.059431]=C2=A0 [&lt;ffffffff81223f77&gt;] vfs_kern_mou=
nt+0x67/0x110<br>
&gt; [=C2=A0 =C2=A0 2.060283]=C2=A0 [&lt;ffffffff81226483&gt;] do_mount+0x2=
33/0xaf0<br>
&gt; [=C2=A0 =C2=A0 2.061081]=C2=A0 [&lt;ffffffff811a2cfb&gt;] ? strndup_us=
er+0x4b/0xa0<br>
&gt; [=C2=A0 =C2=A0 2.061844]=C2=A0 [&lt;ffffffff812270c6&gt;] SyS_mount+0x=
96/0xf0<br>
&gt; [=C2=A0 =C2=A0 2.062619]=C2=A0 [&lt;ffffffff816b89fd&gt;] system_call_=
fastpath+0x16/0x1b<br>
&gt; [=C2=A0 =C2=A0 2.063512] XFS (sda1): Internal error xfs_trans_cancel a=
t line 984 of<br>
&gt; file fs/xfs/xfs_trans.c.=C2=A0 Caller xlog_recover_process_efi+0x18e/0=
x1c0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.065260] CPU: 0 PID: 300 Comm: mount Not tainted<br>
&gt; 3.10.0-693.11.6.el7.x86_64 #1<br>
&gt; [=C2=A0 =C2=A0 2.066489] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS<br>
&gt; <a href=3D"http://rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org" rel=3D=
"noreferrer" target=3D"_blank">rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org=
</a> 04/01/2014<br>
&gt; [=C2=A0 =C2=A0 2.068023] Call Trace:<br>
&gt; [=C2=A0 =C2=A0 2.068590]=C2=A0 [&lt;ffffffff816a5ea1&gt;] dump_stack+0=
x19/0x1b<br>
&gt; [=C2=A0 =C2=A0 2.069403]=C2=A0 [&lt;ffffffffc01794eb&gt;] xfs_error_re=
port+0x3b/0x40 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.070318]=C2=A0 [&lt;ffffffffc019faee&gt;] ? xlog_recov=
er_process_efi+0x18e/0x1c0<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.071538]=C2=A0 [&lt;ffffffffc019594d&gt;] xfs_trans_ca=
ncel+0xbd/0xe0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.072429]=C2=A0 [&lt;ffffffffc019faee&gt;] xlog_recover=
_process_efi+0x18e/0x1c0<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.073339]=C2=A0 [&lt;ffffffffc01a1e37&gt;]<br>
&gt; xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.074561]=C2=A0 [&lt;ffffffffc01a5761&gt;] xlog_recover=
_finish+0x21/0xb0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.075421]=C2=A0 [&lt;ffffffffc0198894&gt;] xfs_log_moun=
t_finish+0x34/0x50 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.076301]=C2=A0 [&lt;ffffffffc018ef21&gt;] xfs_mountfs+=
0x5d1/0x8b0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.077128]=C2=A0 [&lt;ffffffffc017d220&gt;] ? xfs_filest=
ream_get_parent+0x80/0x80<br>
&gt; [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.078049]=C2=A0 [&lt;ffffffffc0191d6b&gt;] xfs_fs_fill_=
super+0x3bb/0x4d0 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.078900]=C2=A0 [&lt;ffffffff81206ad0&gt;] mount_bdev+0=
x1b0/0x1f0<br>
&gt; [=C2=A0 =C2=A0 2.079667]=C2=A0 [&lt;ffffffffc01919b0&gt;] ?<br>
&gt; xfs_test_remount_options.isra.11+0x70/0x70 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.080883]=C2=A0 [&lt;ffffffffc01906d5&gt;] xfs_fs_mount=
+0x15/0x20 [xfs]<br>
&gt; [=C2=A0 =C2=A0 2.081687]=C2=A0 [&lt;ffffffff81207349&gt;] mount_fs+0x3=
9/0x1b0<br>
&gt; [=C2=A0 =C2=A0 2.082457]=C2=A0 [&lt;ffffffff811a7d45&gt;] ? __alloc_pe=
rcpu+0x15/0x20<br>
&gt; [=C2=A0 =C2=A0 2.083258]=C2=A0 [&lt;ffffffff81223f77&gt;] vfs_kern_mou=
nt+0x67/0x110<br>
&gt; [=C2=A0 =C2=A0 2.084057]=C2=A0 [&lt;ffffffff81226483&gt;] do_mount+0x2=
33/0xaf0<br>
&gt; [=C2=A0 =C2=A0 2.084797]=C2=A0 [&lt;ffffffff811a2cfb&gt;] ? strndup_us=
er+0x4b/0xa0<br>
&gt; [=C2=A0 =C2=A0 2.085568]=C2=A0 [&lt;ffffffff812270c6&gt;] SyS_mount+0x=
96/0xf0<br>
&gt; [=C2=A0 =C2=A0 2.086324]=C2=A0 [&lt;ffffffff816b89fd&gt;] system_call_=
fastpath+0x16/0x1b<br>
&gt; [=C2=A0 =C2=A0 2.087161] XFS (sda1): xfs_do_force_shutdown(0x8) called=
 from line 985<br>
&gt; of file fs/xfs/xfs_trans.c.=C2=A0 Return address =3D 0xffffffffc019596=
6<br>
&gt; [=C2=A0 =C2=A0 2.088795] XFS (sda1): Corruption of in-memory data dete=
cted.=C2=A0 Shutting<br>
&gt; down filesystem<br>
&gt; [=C2=A0 =C2=A0 2.090273] XFS (sda1): Please umount the filesystem and =
rectify the<br>
&gt; problem(s)<br>
&gt; [=C2=A0 =C2=A0 2.091519] XFS (sda1): Failed to recover EFIs<br>
&gt; [=C2=A0 =C2=A0 2.092299] XFS (sda1): log mount finish failed<br>
&gt; [FAILED] Failed to mount /sysroot.<br>
&gt; .<br>
&gt; .<br>
&gt; .<br>
&gt; Generating &quot;/run/initramfs/rdsosreport.txt&quot;<br>
&gt; [=C2=A0 =C2=A0 2.178103] blk_update_request: I/O error, dev fd0, secto=
r 0<br>
&gt; [=C2=A0 =C2=A0 2.246106] blk_update_request: I/O error, dev fd0, secto=
r 0<br>
&gt;=C2=A0 =C2=A0----------------------------------------------------------=
---------<br>
&gt;<br>
&gt; Here is the replicated steps:<br>
&gt; *1. Start primary VM with command, and do every thing you want on PVM*=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-x86_64 -enable-kvm -cpu q=
emu64,+kvmclock -m 2048 -qmp<br>
&gt; stdio -vnc :5 \<br>
&gt;=C2=A0 =C2=A0-device piix3-usb-uhci,id=3Dpuu -device usb-tablet,id=3Dut=
 -name primary \<br>
&gt;=C2=A0 =C2=A0-netdev<br>
&gt; tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-=
helper \<br>
&gt;=C2=A0 =C2=A0-device rtl8139,id=3De0,netdev=3Dhn0 \<br>
&gt;=C2=A0 =C2=A0-drive<br>
&gt; if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thre=
shold=3D1,children.0.file.filename=3D$image_path,children.0.driver=3Dqcow2<=
br>
&gt; *2. Add the device and object to PVM with qmp command*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&#39;execute&#39;:&#39;qmp_capabilities&#39=
;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;mirror0&quot;, &quot;backe=
nd&quot; :<br>
&gt; { &quot;type&quot; : &quot;socket&quot;, &quot;data&quot; : { &quot;se=
rver&quot;: true, &quot;wait&quot;: false, &quot;addr&quot;: {<br>
&gt; &quot;type&quot;: &quot;inet&quot;, &quot;data&quot;:{ &quot;host&quot=
;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9003&quot; } } } } }}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;compare1&quot;, &quot;back=
end&quot;<br>
&gt; : { &quot;type&quot; : &quot;socket&quot;, &quot;data&quot; : { &quot;=
server&quot;: true, &quot;wait&quot;: true, &quot;addr&quot;: {<br>
&gt; &quot;type&quot;: &quot;inet&quot;, &quot;data&quot;:{ &quot;host&quot=
;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9004&quot; } } } } }}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;compare0&quot;, &quot;back=
end&quot;<br>
&gt; : { &quot;type&quot; : &quot;socket&quot;, &quot;data&quot; : { &quot;=
server&quot;: true, &quot;wait&quot;: false, &quot;addr&quot;: {<br>
&gt; &quot;type&quot;: &quot;inet&quot;, &quot;data&quot;:{ &quot;host&quot=
;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9001&quot; } } } } }}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;compare0-0&quot;,<br>
&gt; &quot;backend&quot; : { &quot;type&quot; : &quot;socket&quot;, &quot;d=
ata&quot; : { &quot;server&quot;: false, &quot;addr&quot;: {<br>
&gt; &quot;type&quot;: &quot;inet&quot;, &quot;data&quot;:{ &quot;host&quot=
;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9001&quot; } } } } }}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;compare_out&quot;,<br>
&gt; &quot;backend&quot; : { &quot;type&quot; : &quot;socket&quot;, &quot;d=
ata&quot; : { &quot;server&quot;: true, &quot;wait&quot;: false,<br>
&gt; &quot;addr&quot;: { &quot;type&quot;: &quot;inet&quot;, &quot;data&quo=
t;:{ &quot;host&quot;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9005&=
quot; } }<br>
&gt; } } }}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;chardev-add&quot;=
, &quot;arguments&quot;:{ &quot;id&quot; : &quot;compare_out0&quot;,<br>
&gt; &quot;backend&quot; : { &quot;type&quot; : &quot;socket&quot;, &quot;d=
ata&quot; : { &quot;server&quot;: false, &quot;addr&quot;: {<br>
&gt; &quot;type&quot;: &quot;inet&quot;, &quot;data&quot;:{ &quot;host&quot=
;: &quot;127.0.0.1&quot;, &quot;port&quot;: &quot;9005&quot; } } } } } }<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;object-add&quot;,=
 &quot;arguments&quot;:{ &quot;qom-type&quot; : &quot;filter-mirror&quot;,<=
br>
&gt; &quot;id&quot; : &quot;m0&quot;, &quot;props&quot;: { &quot;netdev&quo=
t;: &quot;hn0&quot;, &quot;outdev&quot; : &quot;mirror0&quot;, &quot;queue&=
quot; :<br>
&gt; &quot;tx&quot; } } }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;object-add&quot;,=
 &quot;arguments&quot;:{ &quot;qom-type&quot; :<br>
&gt; &quot;filter-redirector&quot;, &quot;id&quot; : &quot;redire0&quot;, &=
quot;props&quot;: { &quot;netdev&quot;: &quot;hn0&quot;, &quot;indev&quot;<=
br>
&gt; : &quot;compare_out&quot;, &quot;queue&quot; : &quot;rx&quot; } } }<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;object-add&quot;,=
 &quot;arguments&quot;:{ &quot;qom-type&quot; :<br>
&gt; &quot;filter-redirector&quot;, &quot;id&quot; : &quot;redire1&quot;, &=
quot;props&quot;: { &quot;netdev&quot;: &quot;hn0&quot;, &quot;outdev&quot;=
<br>
&gt; : &quot;compare0&quot;, &quot;queue&quot; : &quot;rx&quot; } } }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;object-add&quot;,=
 &quot;arguments&quot;:{ &quot;qom-type&quot; : &quot;iothread&quot;, &quot=
;id&quot;<br>
&gt; : &quot;iothread1&quot;, &quot;props&quot;: {} } }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;execute&quot;:&quot;object-add&quot;,=
 &quot;arguments&quot;:{ &quot;qom-type&quot; : &quot;colo-compare&quot;,<b=
r>
&gt; &quot;id&quot; : &quot;comp0&quot;, &quot;props&quot;: { &quot;primary=
_in&quot; : &quot;compare0-0&quot;, &quot;secondary_in&quot; :<br>
&gt; &quot;compare1&quot;, &quot;outdev&quot; : &quot;compare_out0&quot;, &=
quot;iothread&quot; : &quot;iothread1&quot;} } }<br>
&gt; *3. Start the secondary VM with command*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-x86_64 -enable-kvm -cpu q=
emu64,+kvmclock -m 2048 -qmp<br>
&gt; stdio \<br>
&gt;=C2=A0 =C2=A0-vnc :6 -device piix3-usb-uhci -device usb-tablet -name se=
condary \<br>
&gt;=C2=A0 =C2=A0-netdev<br>
&gt; tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-=
helper \<br>
&gt;=C2=A0 =C2=A0-device rtl8139,id=3De0,netdev=3Dhn0 \<br>
&gt;=C2=A0 =C2=A0-chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,rec=
onnect=3D1 \<br>
&gt;=C2=A0 =C2=A0-chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,rec=
onnect=3D1 \<br>
&gt;=C2=A0 =C2=A0-object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,=
indev=3Dred0 \<br>
&gt;=C2=A0 =C2=A0-object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,=
outdev=3Dred1 \<br>
&gt;=C2=A0 =C2=A0-object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall=
 \<br>
&gt;=C2=A0 =C2=A0-drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D$image_pa=
th,driver=3Dqcow2,\<br>
&gt; node-name=3Dnode1 \<br>
&gt;=C2=A0 =C2=A0-drive<br>
&gt; if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary,file.=
driver=3Dqcow2,\<br>
&gt; top-id=3Dactive-disk0,file.file.filename=3Dactive-disk.qcow2,\<br>
&gt; file.backing.driver=3Dqcow2,file.backing.file.filename=3Dhidden-disk.q=
cow2,\<br>
&gt; file.backing.backing=3Dcolo-disk0,node-name=3Dnode2 \<br>
&gt;=C2=A0 =C2=A0-incoming tcp:0:9998<br>
&gt; *4. As the document create rbd server and do migrate with qmp command*=
<br>
&gt; [image: image.png]<br>
&gt; *5. Kill the PVM and failover to SVM*<br>
&gt; [image: image.png]<br>
&gt; *6. Reboot the secondary VM, then we will get the error.*<br>
&gt; It is high possibility to occur this error.<br>
&gt;<br>
&gt; Therefore, we can solve the image problem by *xfs_repair*, then reboot=
 the<br>
&gt; VM it will work.<br>
&gt; Command:<br>
&gt; xfs_repair -L /dev/sda1<br>
&gt;<br>
&gt; Do you have any idea to occur this problem?<br>
<br>
Hi Daniel,<br>
The disks have to be synchronized before you can start COLO. So try somethi=
ng like this:<br>
<br>
{&#39;execute&#39;: &#39;drive-mirror&#39;, &#39;arguments&#39;:{ &#39;devi=
ce&#39;: &#39;colo-disk0&#39;, &#39;job-id&#39;: &#39;resync&#39;, &#39;tar=
get&#39;: &#39;nbd://SECONDARY:?/colo-disk0&#39;, &#39;mode&#39;: &#39;exis=
ting&#39;, &#39;format&#39;: &#39;raw&#39;, &#39;sync&#39;: &#39;full&#39;}=
 }<br>
<br>
Then, after the job is ready:<br>
{&#39;execute&#39;: &#39;stop&#39;}<br>
{&#39;execute&#39;: &#39;block-job-cancel&#39;, &#39;arguments&#39;:{ &#39;=
device&#39;: &#39;resync&#39;} }<br>
<br>
And then you can add the replication driver and start colo.<br>
<br>
Regards,<br>
Lukas Straub<br></blockquote><div><br></div><div>Hi Lukas,=C2=A0</div><div>=
=C2=A0 =C2=A0 =C2=A0 It works well, thanks for your help.</div><div><br></d=
iv><div>Otherwise, could we change the secondary VM&#39;s <b>replication</b=
> driver to <b>quorum </b>driver=C2=A0</div><div>to realize=C2=A0

<span style=3D"color:rgb(37,37,37);font-family:sans-serif;font-size:14px">c=
ontinuously VM replication</span>=C2=A0?</div><div><br></div><div>Here is t=
he start command.</div><div>Original :</div><div>qemu-system-x86_64 -enable=
-kvm -cpu qemu64,+kvmclock -m 2048 -qmp=C2=A0stdio \<br>=C2=A0 =C2=A0-vnc :=
6 -device piix3-usb-uhci -device usb-tablet -name secondary \<br>=C2=A0 =C2=
=A0-netdev=C2=A0=C2=A0tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/lib=
exec/qemu-bridge-helper \<br>=C2=A0 =C2=A0-device rtl8139,id=3De0,netdev=3D=
hn0 \<br>=C2=A0 =C2=A0-chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D900=
3,reconnect=3D1 \<br>=C2=A0 =C2=A0-chardev socket,id=3Dred1,host=3D127.0.0.=
1,port=3D9004,reconnect=3D1 \<br>=C2=A0 =C2=A0-object filter-redirector,id=
=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \<br>=C2=A0 =C2=A0-object filter=
-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 \<br>=C2=A0 =C2=
=A0-object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \<br>=C2=A0 =
=C2=A0<font color=3D"#ff0000">-drive if=3Dnone,id=3Dcolo-disk0,file.filenam=
e=3D$image_path,driver=3Dqcow2,\<br>=C2=A0node-name=3Dnode1 \</font><br><fo=
nt color=3D"#ff0000" style=3D"background-color:rgb(243,243,243)">=C2=A0</fo=
nt><font color=3D"#ff0000" style=3D"background-color:rgb(255,255,255)"> =C2=
=A0-drive=C2=A0if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecon=
dary,file.driver=3Dqcow2,\<br>=C2=A0top-id=3Dactive-disk0,file.file.filenam=
e=3Dactive-disk.qcow2,\<br>=C2=A0file.backing.driver=3Dqcow2,file.backing.f=
ile.filename=3Dhidden-disk.qcow2,\<br>=C2=A0file.backing.backing=3Dcolo-dis=
k0,node-name=3Dnode2 \</font><br>=C2=A0 =C2=A0-incoming tcp:0:9998=C2=A0=C2=
=A0<br></div><div>=C2=A0</div><div>Modify :</div><div>=C2=A0 qemu-system-x8=
6_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -qmp=C2=A0stdio \<br>=C2=A0 =
=C2=A0-vnc :6 -device piix3-usb-uhci -device usb-tablet -name secondary \<b=
r>=C2=A0 =C2=A0-netdev=C2=A0=C2=A0tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lo=
cal/ceph/libexec/qemu-bridge-helper \<br>=C2=A0 =C2=A0-device rtl8139,id=3D=
e0,netdev=3Dhn0 \<br>=C2=A0 =C2=A0-chardev socket,id=3Dred0,host=3D127.0.0.=
1,port=3D9003,reconnect=3D1 \<br>=C2=A0 =C2=A0-chardev socket,id=3Dred1,hos=
t=3D127.0.0.1,port=3D9004,reconnect=3D1 \<br>=C2=A0 =C2=A0-object filter-re=
director,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \<br>=C2=A0 =C2=A0-ob=
ject filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 \<br>=
=C2=A0 =C2=A0-object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \<b=
r>=C2=A0 =C2=A0<font color=3D"#ff0000">-drive if=3Dide,id=3Dcolo-disk0,driv=
er=3Dquorum,read-pattern=3Dfifo,vote-threshold=3D1,\<br>children.0.file.fil=
ename=3D$image_path,children.0.driver=3Dqcow2 \</font><br>=C2=A0 =C2=A0-inc=
oming tcp:0:9998=C2=A0 =C2=A0=C2=A0<br></div><div><br></div><div>Best regar=
d,=C2=A0</div><div>Daniel Cho</div></div></div>

--000000000000c4dee30596cd955b--

