Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B7C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159B42075C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lWctitsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159B42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShzr-00070N-WE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iShwH-0005Px-P1
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iShwE-0003La-J7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:35:05 -0500
Received: from mout.web.de ([212.227.15.4]:57817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iShwE-0003Jl-3s
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573133697;
 bh=KqcMqftxoTqCa+lzx4dHdb6NLkmNz4s1JHc4uxrq9KE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lWctitsmC0uyHP+3gcovMpDCnLSbvmRRCCoLTf725YHSb1FJa/D6Qq6TifLKftbcl
 YIsSxiGDmvm2WMToLbNl6QGI+5/1AfuiDvQsjBxUDRoiRp9cmQp+Fi3+2nCwshDseB
 h3PNfvaCHNLU9PbOdHnnfFAwokcLOzfI7K1K4RMs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.221]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTzc-1iMCeP3D9U-00ShSc; Thu, 07
 Nov 2019 14:34:57 +0100
Date: Thu, 7 Nov 2019 14:34:56 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Daniel Cho <danielcho@qnap.com>
Subject: Re: The problems about COLO
Message-ID: <20191107143456.585fabcb@luklap>
In-Reply-To: <CA+XQNE6nXFHTS2vj84U=soFa18idHte2p5u03Sba1k0OnTj1Gg@mail.gmail.com>
References: <CA+XQNE5xLXSNUEEd9n_=Hcgu=8QXvwFNuZ4B5WunSmiqM_tnrg@mail.gmail.com>
 <20191104193719.665f6b3c@luklap>
 <CA+XQNE6nXFHTS2vj84U=soFa18idHte2p5u03Sba1k0OnTj1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:otMxc+SMi89w9rr3P+eviSUY33gXdNPChNrNJNvAE79+LMi3O4g
 5QOiMrV4fZr3tUbWP06N3OGgaF2ysOQtd7SWu3sxcHRzVtaWQlIjuEP6kXzol4bftLJf4Va
 nWVk+EfxQLoIQc1cLDUGj8sDBJOjlfsuwb1y/cvURjCeiin4WWmRVYDKsDCOC9lMflwP/k2
 0Z/waEq1F7vmlbakcQUKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2aJlUilWAk=:S6P1H/vL7evJsv9/HMyrxf
 wCvA8Qk1qA7UDeXkujPEtNXmvtch7Cy8EZl327zFUEXtjkeOtdhlfGu6eBVhRwrw12MNejZ6L
 Q7YKsU4DXYXz/0eYEQsUmD1tiN+24A+fFwNhq+5ZMD1DhRqH0yZ0z06CGIhOj1TOn+s7Q7hh+
 kJgnWAN/GqIci3fCa6fH/H36zRFqdnNNsLFOOACxs+l0o+yHW4jD7la/oIwQSKALSmgvDkLY9
 224RxvFo1FaV7xMlV0vY4E58vkNEjN0S/8TBDggJ2ucdAIyzTZMzaie0HTG2+H3jbk3P+b68n
 wCntuiEiVC4iVSuh5QRZbKuVc7Y8rxjB+4y3FMDZ9anCqwPhCuaCYxktExeTF81jEp+jsD3zp
 ijAAovHa+nluNAA2A0U/FYvABS5VyKfeTclLBtwM8vkbpdg/j7FNmC8hK2lepTWRMPBy45ZPN
 kEtD8Vl983HtSm0A6JeAX5b3zuc0HOigCRqMHa3E5F5lBlrf75m8ygvuQIhDbmifldOsN47m0
 GEq5O5IL7pCSdsSZlXn7jSyI2eYFkCo1yiyf8pFJilITv3QiBgXGf191Aujm1f54AiIkhbUhw
 hlmE8fgBVPDxCg1wMCCNsjWSPRVdBXsrsDA790H+F0jlQ00KPWkgaQlnoz4tRRgt+bVmn3bRb
 +rb+IvEAFezlp7YXNvxNBk3Q8gLJ4hEcDgK6bq/KVpeI59RSayNqig1S5CthGQ7YOCTDle8TG
 8hRCvYYg93MszG9ZQAav/LE12ekQpk2ZsY906+4PrT7t0q097JB2NfbfZwC1KzYYx2WTf7itV
 ErPwro+UONpV3s7zUFNM80w2YZiwxUf81pzakFAEb9oiMcCrTWo3TGr3wE+WDdNGnZHnXoNfb
 F1q3v4jPilkJk57gHcGvEdIt9rjWHcXYJWAEs3P1AxrPZolOdV29VdJf8eDyYPiJUrmwCnbEm
 U0HqZV19VaJ3NE0wbJou/wgCRRqOswX1LmmFaLCbagPznzRe+CNtCImYLCcRVsW1QOlMpBRj0
 PT2MB+kpLwqx+tnpkmGan8cRnouMvL+kBezy9eEHut3cE8Lin6PdvY898LEz6xMqFjmNLw5A1
 5oAT4vjN4P0DCJbcQQAHgkeCFNDLI03BYLVnDWyLfe7atw/AfTSnh4EJq4QWXAPAjE3HeEWNc
 j8w3WaJ92CUKVX8z0+M1fhbqsriHr0o0keAVThzCFspAydu5NBFeNHpLeREbu/twi3jCCJxiE
 32vlccIi1WfKmMYa5Pgbqj6xZ/Qod+yytieNhp31T7o5LcT5Wt5Pe2e2JZ9k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.4
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

On Thu, 7 Nov 2019 16:14:43 +0800
Daniel Cho <danielcho@qnap.com> wrote:

> Hi  Lukas,
> Thanks for your reply.
>
> However, we test the question 1 with steps below the error message, we
> notice the secondary VM's image
> will break  while it reboots.
> Here is the error message.
> -------------------------------------------------------------------
> [    1.280299] XFS (sda1): Mounting V5 Filesystem
> [    1.428418] input: ImExPS/2 Generic Explorer Mouse as
> /devices/platform/i8042/serio1/input/input2
> [    1.501320] XFS (sda1): Starting recovery (logdev: internal)
> [    1.504076] tsc: Refined TSC clocksource calibration: 3492.211 MHz
> [    1.505534] Switched to clocksource tsc
> [    2.031027] XFS (sda1): Internal error XFS_WANT_CORRUPTED_GOTO at lin=
e
> 1635 of file fs/xfs/libxfs/xfs_alloc.c.  Caller xfs_free_extent+0xfc/0x1=
30
> [xfs]
> [    2.032743] CPU: 0 PID: 300 Comm: mount Not tainted
> 3.10.0-693.11.6.el7.x86_64 #1
> [    2.033982] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [    2.035882] Call Trace:
> [    2.036494]  [<ffffffff816a5ea1>] dump_stack+0x19/0x1b
> [    2.037315]  [<ffffffffc01794eb>] xfs_error_report+0x3b/0x40 [xfs]
> [    2.038150]  [<ffffffffc0138e6c>] ? xfs_free_extent+0xfc/0x130 [xfs]
> [    2.039046]  [<ffffffffc01362da>] xfs_free_ag_extent+0x20a/0x780 [xfs=
]
> [    2.039920]  [<ffffffffc0138e6c>] xfs_free_extent+0xfc/0x130 [xfs]
> [    2.040768]  [<ffffffffc01a7736>] xfs_trans_free_extent+0x26/0x60 [xf=
s]
> [    2.041642]  [<ffffffffc019fade>] xlog_recover_process_efi+0x17e/0x1c=
0
> [xfs]
> [    2.042558]  [<ffffffffc01a1e37>]
> xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]
> [    2.043771]  [<ffffffffc01a5761>] xlog_recover_finish+0x21/0xb0 [xfs]
> [    2.044650]  [<ffffffffc0198894>] xfs_log_mount_finish+0x34/0x50 [xfs=
]
> [    2.045518]  [<ffffffffc018ef21>] xfs_mountfs+0x5d1/0x8b0 [xfs]
> [    2.046341]  [<ffffffffc017d220>] ? xfs_filestream_get_parent+0x80/0x=
80
> [xfs]
> [    2.047260]  [<ffffffffc0191d6b>] xfs_fs_fill_super+0x3bb/0x4d0 [xfs]
> [    2.048116]  [<ffffffff81206ad0>] mount_bdev+0x1b0/0x1f0
> [    2.048881]  [<ffffffffc01919b0>] ?
> xfs_test_remount_options.isra.11+0x70/0x70 [xfs]
> [    2.050105]  [<ffffffffc01906d5>] xfs_fs_mount+0x15/0x20 [xfs]
> [    2.050906]  [<ffffffff81207349>] mount_fs+0x39/0x1b0
> [    2.051963]  [<ffffffff811a7d45>] ? __alloc_percpu+0x15/0x20
> [    2.059431]  [<ffffffff81223f77>] vfs_kern_mount+0x67/0x110
> [    2.060283]  [<ffffffff81226483>] do_mount+0x233/0xaf0
> [    2.061081]  [<ffffffff811a2cfb>] ? strndup_user+0x4b/0xa0
> [    2.061844]  [<ffffffff812270c6>] SyS_mount+0x96/0xf0
> [    2.062619]  [<ffffffff816b89fd>] system_call_fastpath+0x16/0x1b
> [    2.063512] XFS (sda1): Internal error xfs_trans_cancel at line 984 o=
f
> file fs/xfs/xfs_trans.c.  Caller xlog_recover_process_efi+0x18e/0x1c0 [x=
fs]
> [    2.065260] CPU: 0 PID: 300 Comm: mount Not tainted
> 3.10.0-693.11.6.el7.x86_64 #1
> [    2.066489] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [    2.068023] Call Trace:
> [    2.068590]  [<ffffffff816a5ea1>] dump_stack+0x19/0x1b
> [    2.069403]  [<ffffffffc01794eb>] xfs_error_report+0x3b/0x40 [xfs]
> [    2.070318]  [<ffffffffc019faee>] ? xlog_recover_process_efi+0x18e/0x=
1c0
> [xfs]
> [    2.071538]  [<ffffffffc019594d>] xfs_trans_cancel+0xbd/0xe0 [xfs]
> [    2.072429]  [<ffffffffc019faee>] xlog_recover_process_efi+0x18e/0x1c=
0
> [xfs]
> [    2.073339]  [<ffffffffc01a1e37>]
> xlog_recover_process_efis.isra.30+0x77/0xe0 [xfs]
> [    2.074561]  [<ffffffffc01a5761>] xlog_recover_finish+0x21/0xb0 [xfs]
> [    2.075421]  [<ffffffffc0198894>] xfs_log_mount_finish+0x34/0x50 [xfs=
]
> [    2.076301]  [<ffffffffc018ef21>] xfs_mountfs+0x5d1/0x8b0 [xfs]
> [    2.077128]  [<ffffffffc017d220>] ? xfs_filestream_get_parent+0x80/0x=
80
> [xfs]
> [    2.078049]  [<ffffffffc0191d6b>] xfs_fs_fill_super+0x3bb/0x4d0 [xfs]
> [    2.078900]  [<ffffffff81206ad0>] mount_bdev+0x1b0/0x1f0
> [    2.079667]  [<ffffffffc01919b0>] ?
> xfs_test_remount_options.isra.11+0x70/0x70 [xfs]
> [    2.080883]  [<ffffffffc01906d5>] xfs_fs_mount+0x15/0x20 [xfs]
> [    2.081687]  [<ffffffff81207349>] mount_fs+0x39/0x1b0
> [    2.082457]  [<ffffffff811a7d45>] ? __alloc_percpu+0x15/0x20
> [    2.083258]  [<ffffffff81223f77>] vfs_kern_mount+0x67/0x110
> [    2.084057]  [<ffffffff81226483>] do_mount+0x233/0xaf0
> [    2.084797]  [<ffffffff811a2cfb>] ? strndup_user+0x4b/0xa0
> [    2.085568]  [<ffffffff812270c6>] SyS_mount+0x96/0xf0
> [    2.086324]  [<ffffffff816b89fd>] system_call_fastpath+0x16/0x1b
> [    2.087161] XFS (sda1): xfs_do_force_shutdown(0x8) called from line 9=
85
> of file fs/xfs/xfs_trans.c.  Return address =3D 0xffffffffc0195966
> [    2.088795] XFS (sda1): Corruption of in-memory data detected.  Shutt=
ing
> down filesystem
> [    2.090273] XFS (sda1): Please umount the filesystem and rectify the
> problem(s)
> [    2.091519] XFS (sda1): Failed to recover EFIs
> [    2.092299] XFS (sda1): log mount finish failed
> [FAILED] Failed to mount /sysroot.
> .
> .
> .
> Generating "/run/initramfs/rdsosreport.txt"
> [    2.178103] blk_update_request: I/O error, dev fd0, sector 0
> [    2.246106] blk_update_request: I/O error, dev fd0, sector 0
>   -------------------------------------------------------------------
>
> Here is the replicated steps:
> *1. Start primary VM with command, and do every thing you want on PVM*
>         qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -qm=
p
> stdio -vnc :5 \
>   -device piix3-usb-uhci,id=3Dpuu -device usb-tablet,id=3Dut -name prima=
ry \
>   -netdev
> tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-he=
lper \
>   -device rtl8139,id=3De0,netdev=3Dhn0 \
>   -drive
> if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thresh=
old=3D1,children.0.file.filename=3D$image_path,children.0.driver=3Dqcow2
> *2. Add the device and object to PVM with qmp command*
>       {'execute':'qmp_capabilities'}
>       {"execute":"chardev-add", "arguments":{ "id" : "mirror0", "backend=
" :
> { "type" : "socket", "data" : { "server": true, "wait": false, "addr": {
> "type": "inet", "data":{ "host": "127.0.0.1", "port": "9003" } } } } }}
>       {"execute":"chardev-add", "arguments":{ "id" : "compare1", "backen=
d"
> : { "type" : "socket", "data" : { "server": true, "wait": true, "addr": =
{
> "type": "inet", "data":{ "host": "127.0.0.1", "port": "9004" } } } } }}
>       {"execute":"chardev-add", "arguments":{ "id" : "compare0", "backen=
d"
> : { "type" : "socket", "data" : { "server": true, "wait": false, "addr":=
 {
> "type": "inet", "data":{ "host": "127.0.0.1", "port": "9001" } } } } }}
>       {"execute":"chardev-add", "arguments":{ "id" : "compare0-0",
> "backend" : { "type" : "socket", "data" : { "server": false, "addr": {
> "type": "inet", "data":{ "host": "127.0.0.1", "port": "9001" } } } } }}
>       {"execute":"chardev-add", "arguments":{ "id" : "compare_out",
> "backend" : { "type" : "socket", "data" : { "server": true, "wait": fals=
e,
> "addr": { "type": "inet", "data":{ "host": "127.0.0.1", "port": "9005" }=
 }
> } } }}
>       {"execute":"chardev-add", "arguments":{ "id" : "compare_out0",
> "backend" : { "type" : "socket", "data" : { "server": false, "addr": {
> "type": "inet", "data":{ "host": "127.0.0.1", "port": "9005" } } } } } }
>       {"execute":"object-add", "arguments":{ "qom-type" : "filter-mirror=
",
> "id" : "m0", "props": { "netdev": "hn0", "outdev" : "mirror0", "queue" :
> "tx" } } }
>       {"execute":"object-add", "arguments":{ "qom-type" :
> "filter-redirector", "id" : "redire0", "props": { "netdev": "hn0", "inde=
v"
> : "compare_out", "queue" : "rx" } } }
>       {"execute":"object-add", "arguments":{ "qom-type" :
> "filter-redirector", "id" : "redire1", "props": { "netdev": "hn0", "outd=
ev"
> : "compare0", "queue" : "rx" } } }
>       {"execute":"object-add", "arguments":{ "qom-type" : "iothread", "i=
d"
> : "iothread1", "props": {} } }
>       {"execute":"object-add", "arguments":{ "qom-type" : "colo-compare"=
,
> "id" : "comp0", "props": { "primary_in" : "compare0-0", "secondary_in" :
> "compare1", "outdev" : "compare_out0", "iothread" : "iothread1"} } }
> *3. Start the secondary VM with command*
>         qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 2048 -qm=
p
> stdio \
>   -vnc :6 -device piix3-usb-uhci -device usb-tablet -name secondary \
>   -netdev
> tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/ceph/libexec/qemu-bridge-he=
lper \
>   -device rtl8139,id=3De0,netdev=3Dhn0 \
>   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D1 \
>   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D1 \
>   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0=
 \
>   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred=
1 \
>   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
>   -drive if=3Dnone,id=3Dcolo-disk0,file.filename=3D$image_path,driver=3D=
qcow2,\
> node-name=3Dnode1 \
>   -drive
> if=3Dide,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsecondary,file.dr=
iver=3Dqcow2,\
> top-id=3Dactive-disk0,file.file.filename=3Dactive-disk.qcow2,\
> file.backing.driver=3Dqcow2,file.backing.file.filename=3Dhidden-disk.qco=
w2,\
> file.backing.backing=3Dcolo-disk0,node-name=3Dnode2 \
>   -incoming tcp:0:9998
> *4. As the document create rbd server and do migrate with qmp command*
> [image: image.png]
> *5. Kill the PVM and failover to SVM*
> [image: image.png]
> *6. Reboot the secondary VM, then we will get the error.*
> It is high possibility to occur this error.
>
> Therefore, we can solve the image problem by *xfs_repair*, then reboot t=
he
> VM it will work.
> Command:
> xfs_repair -L /dev/sda1
>
> Do you have any idea to occur this problem?

Hi Daniel,
The disks have to be synchronized before you can start COLO. So try someth=
ing like this:

{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 'job-id'=
: 'resync', 'target': 'nbd://SECONDARY:?/colo-disk0', 'mode': 'existing', =
'format': 'raw', 'sync': 'full'} }

Then, after the job is ready:
{'execute': 'stop'}
{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }

And then you can add the replication driver and start colo.

Regards,
Lukas Straub

