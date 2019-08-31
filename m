Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1AC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB6523697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 01:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="RKt+Tic0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB6523697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3sHc-00036p-5t
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 21:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1i3sFT-0002c5-9t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1i3sFO-0004OU-9s
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:32:11 -0400
Received: from m12-11.163.com ([220.181.12.11]:50957)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1i3sFL-0003u7-6C
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 21:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=MIME-Version:From:Subject:Date:Message-Id; bh=/Uez7
 oN1v98ixmVQZsamfJKxv47FEqzhl0wlWoG8sYU=; b=RKt+Tic0sB9NJBLOJxH9w
 VaolxOnRALoPtyWx7ANXD4JxYAmxUc4PbTZmljaESVfxS/dsFLPM5UspwMNz49fh
 206J7B2GrqBcuxbtRScNA902XiG+i310uonGttfsEXP+NeZHivPQZP/XWDz+LyO8
 hxs/w70X6jT9leOPCF4n04=
Received: from [IPv6:::ffff:192.168.0.5] (unknown [183.158.152.47])
 by smtp7 (Coremail) with SMTP id C8CowABXl+cNzmldC2SWLA--.41612S3;
 Sat, 31 Aug 2019 09:31:58 +0800 (CST)
MIME-Version: 1.0
To: Alex Williamson <alex.l.williamson@gmail.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Li Qiang <liq3ea@163.com>
Date: Sat, 31 Aug 2019 09:31:59 +0800
Importance: normal
X-Priority: 3
X-CM-TRANSID: C8CowABXl+cNzmldC2SWLA--.41612S3
Message-Id: <5D69CE0F.011DCE.26140@m12-11.163.com>
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW5AFy5Ar43tFykGry5CFg_yoWkXrbE9a
 yfA3WUXr13ArWDuas8WF4vqr43A3ZrXrZ3ZF15ZFWkXrykWF1fWwn5Zryjy3WjqFW29rn8
 W395Za109asrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8-yCJUUUUU==
X-Originating-IP: [183.158.152.47]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQsibVQHGu6YwgAAsY
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.11
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Questions about 'emulated_config_bits' in vfio pci
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

Hi Alex and all,

My understanding for =E2=80=98emulated_config_bits=E2=80=99 in =E2=80=98VFI=
OPCIDevice=E2=80=99 is that this is the mask for PCI config space. If the b=
its is set in =E2=80=98 emulated_config_bits=E2=80=99 then we can just use =
the qemu=E2=80=99s =E2=80=98vdev->pdev.config=E2=80=99, it the bits is not =
set, we need to ask the physical device.=20

But there are two places I got confused in =E2=80=98vfio_realize=E2=80=99.

Here in =E2=80=98vfio_realize=E2=80=99
    /* QEMU can change multi-function devices to single function, or revers=
e */
    vdev->emulated_config_bits[PCI_HEADER_TYPE] =3D
                                              PCI_HEADER_TYPE_MULTI_FUNCTIO=
N;

In =E2=80=98vfio_add_std_cap=E2=80=99

        /* Begin the rebuild, use QEMU emulated list bits */
        pdev->config[PCI_CAPABILITY_LIST] =3D 0;
        vdev->emulated_config_bits[PCI_CAPABILITY_LIST] =3D 0xff;
        vdev->emulated_config_bits[PCI_STATUS] |=3D PCI_STATUS_CAP_LIST;


Per my understanding, I think =E2=80=98emulated_config_bits=E2=80=99 should=
 be set to 0xff just as other places. But here use =E2=80=98PCI_HEADER_TYPE=
_MULTI_FUNCTION=E2=80=99 and =E2=80=98PCI_STATUS_CAP_LIST=E2=80=99. In fact=
, this doesn=E2=80=99t affect the results, but it=E2=80=99s confusion.
Just a typo? Or other reasons.


Thanks,
Li Qiang
