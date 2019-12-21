Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C8C2D0C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 22:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF29206A5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 22:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NNGscszr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF29206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iinDx-0004VV-VV
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 17:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iinAS-00036P-2t
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iinAR-00084m-5z
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:24:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:49427)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iinAQ-0007yM-O8
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 17:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1576967045;
 bh=9s6etU6voV0ppQv8houpUqqJrZiTMkJWUK48RH7OgDM=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=NNGscszrdm0A/l+A0x3cW+Rn47oB3Fj1mAE9rwzASTHhyvohMAze63BVAqeduM/mb
 fTyb657eqIGn+FLViGtDZlk5qjtYLUwS412Aqm7iUfkHGNA3ju1zEpe2x7oWviRYgS
 IrH9I+YIBHhsxZjmheQ3UomeEKL8C2l1AXOalNuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.169.139]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1ib4TB1DGG-007pDG; Sat, 21
 Dec 2019 23:24:05 +0100
Date: Sat, 21 Dec 2019 23:24:02 +0100
From: Helge Deller <deller@gmx.de>
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] hppa: Do not enable artist graphics with -nographic option
Message-ID: <20191221222402.GA27803@ls3530.fritz.box>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191221222205.GA27749@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221222205.GA27749@ls3530.fritz.box>
X-Provags-ID: V03:K1:fvAmCIWmTT3TC+wc0olXQC6fS14cUKFfVdHq9gW6SZcoiZoO6y/
 B5M9S5qC5Sc+8vspnLY8nE+ewjtvZeyFjVPtXxAZ+EIpp5MOfCka+wY67RZSC82Xpv7hyOh
 sYpSyQc1QLpwG3detBBKYPzjc7NhiZETs4zwkPCVTg1AWCzuRKoCpuEK9OYbSfhJS6cC5EY
 uDVaGOrb18nXO/ECGh5EQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xQ3FScf3lnU=:FQFZStq39r9B/ANbOoiR8+
 bo6W0oecO+F/3XhKCxrY7PAWqSrt/PrbWunrFC+blfAkvvS4Hm7kyit1Dn1YEqRP6FkWm7tll
 zit2sHPuQmHNv4U7xSDZRrN8jkx3z/Xfqaz4+ItmGDJjjMaCgqpu5R5yDm+2YT0St5d+5gIcJ
 Rqbxm/xmfcv2rcX6n3Ttt+fUQimADRqgFKuAwEoWQlFvEChPj8ElVZVCKkUMeDifLSlF8HXhw
 CqZKKaeAwb0E8VKjiT79d2URProEmuCV2i9NXUaippfjlRpbMIrCKSJDWo50mKH/SQEljUdVc
 ofgcuwNAe7t9g9TE+PdoPHikeDN3LXpn6d5OqZyvZdxbqy0Ru3vbMza4272HVSW5NumqaNxTD
 qLuA50dvZ1XEGwC1VMp1cRZ8TvUJGO84z1NFe6WqlRsSVY+QEG+xavR6BCruV8/fi1SrvJm20
 oBOk/opAmpmY6POrI7uvDhB2StILDuCsmyysqIvEXxzuotpmFKvPOUim3oJAmH3FBwD07zNHz
 BD1yqj1/naIiljjXq09UhXE/DQxzDt0gFpMghcdKdtK7018eM/zTzeK7ditQ3jRR7rJzfXjGI
 9YxIuRBLDyTa5w6p7UQwCMcPJWG1nvCFjl3CJOIF/HkdhYBT5JD4qJE58hmvoLNi6Fs9slphK
 vppBqKHBtO4hciK/ZT5C8iNCcwrdEut1BeR5Ssp8GWxrT+ATsWRxPPYzJXAFvtsHCUyXk6/jk
 DY1+NE13AL+/Q1GaBk/tzJ4g6WLy3QgRpIsjddG/yUyassXsh/63IcuZh+CnjH/uIQm4QqfAH
 lEEdgmDoxX3jzAvV10NYZIHRu43q6c5sdk6nNGos78VpUyWrEfcR6p1QeNOHlMaTp90LQ5NBP
 bEaVQtz0zPxf89NO5ddObYBJr+mvm780LQVPAujZkM8+KJhGcx6Pan8NWXq3jiy6RCEbg0RU4
 J6Ph2QWDz/3v2LR2CNo33BRs6oCJcnVH+MNK5TE8KyceylH2JZLvWvyq6MtjXQ1bosYEcSYzZ
 Nt0p7rM8tj09tgLfcclraHBhEwL1/DUNHSHwTNgdFRbzs2XyFq3BxJE3TgO9Rc9qe1JucRp4H
 q4YAHpZEBhip/ueUMOy89WUtOF4mHwYmfBX/1NfvtjNizyg87r+0j7AWllzshuP3hKjB9AOOw
 JvwQEYLLTcVL4zAQkRDcxaMeyp+2apV1DhwXmgNVnuCKoVBca8EIihKUy8LDH5Wd+3NYqQq/q
 KUWuibykVas8bcybU4Gq/Owc5tk9+9ov5reO/Iw==
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
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

When qemu was started with the -nographic option, do not enable the
artist graphic card emulation.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9d0192c4fa..aea365bf46 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -127,7 +127,7 @@ static void machine_hppa_init(MachineState *machine)
     dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);

-    if (vga_interface_type !=3D VGA_NONE) {
+    if (machine->enable_graphics && vga_interface_type !=3D VGA_NONE) {
         dev =3D qdev_create(NULL, "artist");
         qdev_init_nofail(dev);
         s =3D SYS_BUS_DEVICE(dev);

