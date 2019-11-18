Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2850C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E23920692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd2q6cR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhxq-0005On-KW
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iWhwv-0004RJ-1Y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iWhws-0004wX-42
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:24:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iWhws-0004wB-0I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574087052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dDVF2+3VQEGidJ4932+PtRwX7l+QgKtfra4XXyX0IA=;
 b=Sd2q6cR4PrGLkjq9UmM3CZ1m/bm75ABSk/3J6KTPumwOayMq3zlg9/jDOyQO4WmVKWtNZg
 XehtcfoI5PBn4rRUbVp/OsYv1lWglM032iUlqMDXxV7R5Osz5LELuFRlucXFqxDxcjogw8
 jhRO1jPeFRRCCM7FDKOJHC3cPZL9T4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-QkDFrY_mNIu1pLtUacOaBg-1; Mon, 18 Nov 2019 09:24:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021E1801FD2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 14:24:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1866E60856;
 Mon, 18 Nov 2019 14:24:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0B7EA16E08; Mon, 18 Nov 2019 15:24:07 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Seabios 20191118 patches
Date: Mon, 18 Nov 2019 15:24:05 +0100
Message-Id: <20191118142407.6040-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QkDFrY_mNIu1pLtUacOaBg-1
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

The following changes since commit 9f2ce35dfa4ea4a31dbb765dd02bed2500891887=
:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191111' into st=
aging (2019-11-11 16:54:16 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/seabios-20191118-pull-request

for you to fetch changes up to 0285747737417a7d154ddc3e5adcf1fd665566fd:

  seabios: update to pre-1.13 snapshot again (2019-11-18 15:04:19 +0100)

----------------------------------------------------------------
seabios: update to pre-1.13 snapshot again (lchs fixed)

----------------------------------------------------------------

Gerd Hoffmann (2):
  seabios: update to pre-1.13 snapshot
  seabios: update to pre-1.13 snapshot again

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


