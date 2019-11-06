Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E41EC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51192217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6DvA4Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51192217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKOR-00068b-Iz
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSKNT-0005fN-Hr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSKNR-00066m-9a
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:25:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSKNQ-00066X-TX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573043132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rB9nY9matD1IgGtwpJ0jTojOvo4bm5x33ZK8z+QWors=;
 b=Q6DvA4Nd16UALrKeWuYlm7hx/LZw6sYV038lVCn5l0loODqPKnLo4d50DNQEgI22Gtpa0r
 FwlaaxkpsAJfHOlkZ0NUX8gbKGHdCQiNofpYAs0eDH2me0UjlcXypRgp/74jkEMc5tq/wf
 XfQhNBRPUpN2aOs2qz/lLQ0D0317s+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-whnwNZjyPku5PZoiZlgvmA-1; Wed, 06 Nov 2019 07:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE179477
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:25:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E32111001B34;
 Wed,  6 Nov 2019 12:25:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0DEAE11AAA; Wed,  6 Nov 2019 13:25:24 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Seabios 20191106 patches
Date: Wed,  6 Nov 2019 13:25:23 +0100
Message-Id: <20191106122524.5537-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: whnwNZjyPku5PZoiZlgvmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/seabios-20191106-pull-request

for you to fetch changes up to 58b16e57ded751e2e8be626124aad1d46a408a33:

  seabios: update to pre-1.13 snapshot (2019-11-06 13:23:02 +0100)

----------------------------------------------------------------
seabios: update to pre-1.13 snapshot

----------------------------------------------------------------

Gerd Hoffmann (1):
  seabios: update to pre-1.13 snapshot

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 38912 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 27648 -> 28160 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 39424 bytes
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


