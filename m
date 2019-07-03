Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2FC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E61421882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E61421882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiblq-00038s-SQ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hib2S-0004Cl-JF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hib2R-0003xe-KE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hib2P-00030Z-0c; Wed, 03 Jul 2019 04:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C59BD30C0DDA;
 Wed,  3 Jul 2019 08:54:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7973E5945E;
 Wed,  3 Jul 2019 08:54:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5E9AC16E18; Wed,  3 Jul 2019 10:54:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 10:54:12 +0200
Message-Id: <20190703085416.21837-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 03 Jul 2019 08:54:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Vga 20190703 patches
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd=
43:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702=
' into staging (2019-07-02 18:56:44 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190703-pull-request

for you to fetch changes up to 0a87fd693d4e955a6877a2166b65bb7b7192aaaa:

  Add ati vgabios to INSTALL_BLOBS. (2019-07-03 10:52:15 +0200)

----------------------------------------------------------------
vga: virtio fixes, bitbang i2c asan fix, install ati vgabios.

----------------------------------------------------------------

Gerd Hoffmann (2):
  virtio-gpu: fix unmap in error path
  Add ati vgabios to INSTALL_BLOBS.

Li Qiang (1):
  virtio-gpu: check if the resource already exists in virtio_gpu_load()

Peter Maydell (1):
  hw/i2c/bitbang_i2c: Use in-place rather than malloc'd
    bitbang_i2c_interface struct

 Makefile                     |  2 +-
 hw/display/ati_int.h         |  2 +-
 include/hw/i2c/bitbang_i2c.h | 38 ++++++++++++++++++++++++++++-
 include/hw/i2c/ppc4xx_i2c.h  |  2 +-
 hw/display/ati.c             |  7 +++---
 hw/display/virtio-gpu.c      |  9 +++++--
 hw/i2c/bitbang_i2c.c         | 47 +++---------------------------------
 hw/i2c/ppc4xx_i2c.c          |  6 ++---
 hw/i2c/versatile_i2c.c       |  8 +++---
 9 files changed, 61 insertions(+), 60 deletions(-)

--=20
2.18.1


