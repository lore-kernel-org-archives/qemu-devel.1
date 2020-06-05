Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14342070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY6tZtJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14342070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAWN-0003sN-VP
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jhAVa-0002Ux-MH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42721
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jhAVZ-00030J-0e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591356451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ER/QBSjn+ErYomgR+6q07e43fYMJ+i9OA60iYCdKFZA=;
 b=bY6tZtJ8xOyWGZ2WA+GwpuBUvDS7x+D/OrMMwh5MToFoMpcgN9J0gyDfheW23cdqNDaB/5
 DmmTzt5NaMmqBXxjv3k9/L0o62qyjU3wlQJ7LPJ5po129qmHZHeHLko2zoj7Tb78HZiFAm
 443dtnq2ztDVBOgdTKikr7DD2sy/mZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-TRgCgUZCOIeOkMds9Q_DQA-1; Fri, 05 Jun 2020 07:27:30 -0400
X-MC-Unique: TRgCgUZCOIeOkMds9Q_DQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2631005510
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 11:27:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC9A7CCF7;
 Fri,  5 Jun 2020 11:27:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E54D91747D; Fri,  5 Jun 2020 13:27:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Vga 20200605 patches
Date: Fri,  5 Jun 2020 13:27:22 +0200
Message-Id: <20200605112724.18622-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 66234fee9c2d37bfbc523aa8d0ae5300a14cc10e=
:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-2=
0200603' into staging (2020-06-04 11:38:48 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20200605-pull-request

for you to fetch changes up to ae3887e6f08c0031b669d4613987ee51df8f1769:

  hw/display/cirrus_vga: Fix code mis-indentation (2020-06-05 09:17:23 +020=
0)

----------------------------------------------------------------
vga: ati security fix, cirrus cleanup.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  hw/display/cirrus_vga: Fix code mis-indentation

Prasad J Pandit (1):
  ati-vga: check mm_index before recursive call (CVE-2020-13800)

 hw/display/ati.c        | 10 ++++++++--
 hw/display/cirrus_vga.c |  6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

--=20
2.18.4


