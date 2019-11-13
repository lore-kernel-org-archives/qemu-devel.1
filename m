Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA9EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7354222CA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+8ZWXC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7354222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtGl-0002Z7-Ai
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iUtFP-0001fx-Jo
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iUtFO-0003sz-3z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:03:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iUtFM-0003s0-Iv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573653827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sdq2NZtGz8OIVDyjSo5YwQH4vZMY9IqGaMsD5AHtvZQ=;
 b=E+8ZWXC5yyrk9v8Sb62ceSPEuZDbAHqhbYWS6I4gW/FgNTcIqQGKsBc4Bv6GfaOK7991We
 QUIetUxzhzHuo5xWM1+7A+/WtBCV25x6x/+lRQ0twfH5+EOJLnCuBhkndrEtdJeE7OdDAt
 NM9lJnS/C+1fwmjO9cwgzfcfZt01iqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-6cL0Fn_TNpStH2S2_vyOjw-1; Wed, 13 Nov 2019 09:03:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2F1018B645B
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 14:03:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C84ED601B8;
 Wed, 13 Nov 2019 14:03:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7D2E411AAA; Wed, 13 Nov 2019 15:03:41 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Seabios 20191113 patches
Date: Wed, 13 Nov 2019 15:03:40 +0100
Message-Id: <20191113140341.27977-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6cL0Fn_TNpStH2S2_vyOjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

  git://git.kraxel.org/qemu tags/seabios-20191113-pull-request

for you to fetch changes up to 0221d73ce6a8e075adaa0a35a6ef853d2652b855:

  seabios: update to pre-1.13 snapshot (2019-11-13 15:02:21 +0100)

----------------------------------------------------------------
seabios: update to pre-1.13 snapshot (with ahci fix included).

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


