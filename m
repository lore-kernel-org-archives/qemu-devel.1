Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6218C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767C520714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkMWuzp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767C520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxngq-0008Kx-KW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxnfy-0007cV-Mf
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:31:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxnfv-0007aZ-Qo
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595320258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZFf+V9uxODQf1HYAapGFYicomExMNLU+pf8rDfAAYw=;
 b=EkMWuzp75iR1dFQgA/8WPmSQ1y0nbgGUykvcNu7SVGL+Gb2TfF0/+P85xp3QgV/Hjp/op1
 FE9suv0r7Y/7ca3zGqrnCezfyPfoYVWsTaseYL+x7gmNOUky8cbf+rfoL80Qjf/H3CRQSF
 2BiYGfP6pSeBeB4jD6lsnLsQHBhCacs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29--Xiv4oB_PGGMYpYMViP0Cg-1; Tue, 21 Jul 2020 04:30:51 -0400
X-MC-Unique: -Xiv4oB_PGGMYpYMViP0Cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66CD091271;
 Tue, 21 Jul 2020 08:30:50 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B89F05C1BD;
 Tue, 21 Jul 2020 08:30:49 +0000 (UTC)
Date: Tue, 21 Jul 2020 09:30:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Subject: Re: Testing the virtio-vhost-user QEMU patch
Message-ID: <20200721083048.GB144170@stefanha-x1.localdomain>
References: <87h7u1s5k1.fsf@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <87h7u1s5k1.fsf@alyssa.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Nikos Dragazis <ndragazis@arrikto.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 07:14:38AM +0000, Alyssa Ross wrote:
> Hi -- I hope it's okay me reaching out like this.
>=20
> I've been trying to test out the virtio-vhost-user implementation that's
> been posted to this list a couple of times, but have been unable to get
> it to boot a kernel following the steps listed either on
> <https://wiki.qemu.org/Features/VirtioVhostUser> or
> <https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.
>=20
> Specifically, the kernel appears to be unable to write to the
> virtio-vhost-user device's PCI registers.  I've included the full panic
> output from the kernel at the end of this message.  The panic is
> reproducible with two different kernels I tried (with different configs
> and versions).  I tried both versions of the virtio-vhost-user I was
> able to find[1][2], and both exhibited the same behaviour.
>=20
> Is this a known issue?  Am I doing something wrong?

Hi,
Unfortunately I'm not sure what the issue is. This is an early
virtio-pci register access before a driver for any specific device type
(net, blk, vhost-user, etc) comes into play.

Did you test the git trees linked below or did you rebase the commits
on top of your own QEMU tree?

Is your guest kernel a stock kernel.org/distro kernel or has it been
modified (especially with security patches)?

If no one else knows what is wrong here then it will be necessary to
check the Intel manuals to figure out the exact meaning of
"error_code(0x000b) - reserved bit violation" and why Linux triggers it
with "PGD 3b128067 P4D 3b128067 PUD 3b129067 PMD 3b12a067 PTE
8000002000000073".

Stefan

>=20
> Thanks in advance -- I'm excitedly following the progress of this
> feature.
>=20
> Alyssa Ross
>=20
> [1]: https://github.com/ndragazis/qemu/commits/virtio-vhost-user
> [2]: https://github.com/stefanha/qemu/commits/virtio-vhost-user
>=20
>=20
> [    1.287979] BUG: unable to handle page fault for address: ffffb8ca4002=
5014
> [    1.288311] #PF: supervisor write access in kernel mode
> [    1.288311] #PF: error_code(0x000b) - reserved bit violation
> [    1.288311] PGD 3b128067 P4D 3b128067 PUD 3b129067 PMD 3b12a067 PTE 80=
00002000000073
> [    1.288311] Oops: 000b [#1] SMP PTI
> [    1.288311] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.28 #1-NixOS
> [    1.288311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
> [    1.288311] RIP: 0010:iowrite8+0xe/0x30
> [    1.288311] Code: fe ff ff 48 c7 c0 ff ff ff ff c3 48 8b 3f 48 89 f8 c=
3 66 2e 0f 1f 84 00 00 00 00 00 89 f8 48 89 f7 48 81 fe ff ff 3
> [    1.288311] RSP: 0000:ffffb8ca40013cd8 EFLAGS: 00010292
> [    1.288311] RAX: 0000000000000000 RBX: ffffb8ca40013d60 RCX: 000000000=
0000000
> [    1.288311] RDX: 000000000000002f RSI: ffffb8ca40025014 RDI: ffffb8ca4=
0025014
> [    1.288311] RBP: ffff9c742ea20400 R08: ffff9c742f0a60af R09: 000000000=
0000000
> [    1.288311] R10: 0000000000000018 R11: ffff9c742f0a60af R12: 000000000=
0000000
> [    1.288311] R13: ffff9c742ea20410 R14: 0000000000000000 R15: 000000000=
0000000
> [    1.288311] FS:  0000000000000000(0000) GS:ffff9c743b700000(0000) knlG=
S:0000000000000000
> [    1.288311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.288311] CR2: ffffb8ca40025014 CR3: 0000000037a0a001 CR4: 000000000=
0060ee0
> [    1.288311] Call Trace:
> [    1.288311]  vp_reset+0x1b/0x50
> [    1.288311]  register_virtio_device+0x74/0xe0
> [    1.288311]  virtio_pci_probe+0xaf/0x140
> [    1.288311]  local_pci_probe+0x42/0x80
> [    1.288311]  pci_device_probe+0x104/0x1b0
> [    1.288311]  really_probe+0x147/0x3c0
> [    1.288311]  driver_probe_device+0xb6/0x100
> [    1.288311]  device_driver_attach+0x53/0x60
> [    1.288311]  __driver_attach+0x8a/0x150
> [    1.288311]  ? device_driver_attach+0x60/0x60
> [    1.288311]  bus_for_each_dev+0x78/0xc0
> [    1.288311]  bus_add_driver+0x14d/0x1f0
> [    1.288311]  driver_register+0x6c/0xc0
> [    1.288311]  ? dma_bus_init+0xbf/0xbf
> [    1.288311]  do_one_initcall+0x46/0x1f4
> [    1.288311]  kernel_init_freeable+0x176/0x200
> [    1.288311]  ? rest_init+0xab/0xab
> [    1.288311]  kernel_init+0xa/0x105
> [    1.288311]  ret_from_fork+0x35/0x40
> [    1.288311] Modules linked in:
> [    1.288311] CR2: ffffb8ca40025014
> [    1.288311] ---[ end trace 5164b2fa531e028f ]---
> [    1.288311] RIP: 0010:iowrite8+0xe/0x30
> [    1.288311] Code: fe ff ff 48 c7 c0 ff ff ff ff c3 48 8b 3f 48 89 f8 c=
3 66 2e 0f 1f 84 00 00 00 00 00 89 f8 48 89 f7 48 81 fe ff ff 3
> [    1.288311] RSP: 0000:ffffb8ca40013cd8 EFLAGS: 00010292
> [    1.288311] RAX: 0000000000000000 RBX: ffffb8ca40013d60 RCX: 000000000=
0000000
> [    1.288311] RDX: 000000000000002f RSI: ffffb8ca40025014 RDI: ffffb8ca4=
0025014
> [    1.288311] RBP: ffff9c742ea20400 R08: ffff9c742f0a60af R09: 000000000=
0000000
> [    1.288311] R10: 0000000000000018 R11: ffff9c742f0a60af R12: 000000000=
0000000
> [    1.288311] R13: ffff9c742ea20410 R14: 0000000000000000 R15: 000000000=
0000000
> [    1.288311] FS:  0000000000000000(0000) GS:ffff9c743b700000(0000) knlG=
S:0000000000000000
> [    1.288311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.288311] CR2: ffffb8ca40025014 CR3: 0000000037a0a001 CR4: 000000000=
0060ee0
> [    1.288311] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000009
> [    1.288311] Kernel Offset: 0x21200000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [    1.288311] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---
>=20

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Wp7gACgkQnKSrs4Gr
c8ijCgf/R+DhVBQZ1LnVeahtuPAtSJw/mnSB5NI21v2ySU6X7k3HnTB7Ik2yevD7
1zzSYue3Y+SSWSJ1nScQq9AepPm+tqx9FoyFlSrQ8WS2rjjCB+4dAJ7x26StUbTT
1WUWekayDN59svdkfGqNUmtwxcmLJypphaxxMW831Gpn3jA8iQI+GnfOUi7Mq97q
TzJ04zrgv5/tSfMrjlNZn149ZvUstzL5fdGSavp13254e6PCfG6DFdingpccYQt/
FuFIdLHu4tsP5KhECHKxq2qgrVKOMuiB1kXc3jgNRtf33f5/6lm81bnsmBHjo+8E
icbHlqa/mMAA+ES4xTKUgv5vAX+OFw==
=jre2
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


