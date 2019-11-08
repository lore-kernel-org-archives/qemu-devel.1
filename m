Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22460FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52122178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L90cCbZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52122178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1Rd-0006XW-OH
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iT1PJ-0003Op-2e
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iT1PH-00087a-WB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:22:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iT1PH-00087A-Si
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573208539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NFIFdqR/JbcUPJAQyR7Yd97xZj9N3PANWKle10gy0kI=;
 b=L90cCbZ+4Osd6Uv/D3X2YcNn0DX8eRM6SoO+n1RuG9C5CeJ1eRCZIS9CJ6rgpDMvFnYjGQ
 1FNbXCRsZLa10p/toji67FwaHqtESNlg5yrGm+sHLJyTPVLrk1NhWxFYYDAnhpA6kQwsZf
 hfT2yJNquAgxGuDdOs72osgzL5VmcyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-VcUyKlCfMhucuEAPLVrnfw-1; Fri, 08 Nov 2019 05:22:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 264C0800C72
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:22:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4759C600C9;
 Fri,  8 Nov 2019 10:22:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 80D4517535; Fri,  8 Nov 2019 11:22:12 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Seabios 20191108 patches
Date: Fri,  8 Nov 2019 11:22:11 +0100
Message-Id: <20191108102212.11101-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VcUyKlCfMhucuEAPLVrnfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 59015778f3ec7c01202d46c5dbeeac8ab4225c52=
:

  Update version for v4.2.0-rc0 release (2019-11-07 18:17:31 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/seabios-20191108-pull-request

for you to fetch changes up to f085bf95a6208b42f1ae01f60c76d936d9fed490:

  seabios: update to pre-1.13 snapshot (2019-11-08 11:18:26 +0100)

----------------------------------------------------------------
seabios: update to pre-1.13 snapshot (gcc 4.8.5 version).

----------------------------------------------------------------

Gerd Hoffmann (1):
  seabios: update to pre-1.13 snapshot

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 38912 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 27648 -> 28672 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38912 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 39424 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28160 -> 28672 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 39424 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 39424 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 39424 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38912 bytes
 roms/Makefile                     |   2 +-
 roms/seabios                      |   2 +-
 13 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.18.1


