Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4803C2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoBucZW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnx1-0006r6-JY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsns5-0006uE-2K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsns3-0004bP-Bn
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594129370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g8rzLsqIBr6kengzgWK0jKpoF83iSQGaFa7lknLGQ8E=;
 b=PoBucZW+Xun7oT0BKf2IpO292rsd67qlfJahvqrmWT5xmHlbb9J75tbQB2RieUZ6oHqwm8
 /4/RLhC4lg9RlWvr64UkT1Ol7lbLUadkLLYLldntad9/DbIp8qI96bc2bDtmA5wT5i8sWQ
 WancxbPyPBqILdk9q3Ksct6pYWrfP8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-GKeg2HqBMmOFrLx--MTnLg-1; Tue, 07 Jul 2020 09:42:37 -0400
X-MC-Unique: GKeg2HqBMmOFrLx--MTnLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61E6818829CB
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 13:42:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1165DD63;
 Tue,  7 Jul 2020 13:42:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A46F531E60; Tue,  7 Jul 2020 15:42:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Modules 20200707 patches
Date: Tue,  7 Jul 2020 15:42:19 +0200
Message-Id: <20200707134229.9773-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/modules-20200707-pull-request

for you to fetch changes up to ef138c77249771081d8c2d09b8e729f7e92cdf28:

  chardev: enable modules, use for braille (2020-07-07 15:33:59 +0200)

----------------------------------------------------------------
qom: add support for qom objects in modules.
build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
build braille chardev as module.

v2: more verbose comment for "build: fix device module builds" patch.

note: qemu doesn't rebuild objects on cflags changes (specifically
      -fPIC being added when code is switched from builtin to module).
      Workaround for resulting build errors: "make clean", rebuild.

----------------------------------------------------------------

Gerd Hoffmann (10):
  module: qom module support
  object: qom module support
  qdev: device module support
  build: fix device module builds
  ccid: build smartcard as module
  usb: build usb-redir as module
  vga: build qxl as module
  vga: build virtio-gpu only once
  vga: build virtio-gpu as module
  chardev: enable modules, use for braille

 Makefile.objs            |  2 ++
 Makefile.target          | 14 +++++++++
 include/qemu/module.h    |  2 ++
 include/qom/object.h     | 12 +++++++
 chardev/char.c           |  2 +-
 hw/core/qdev.c           |  6 ++--
 qdev-monitor.c           |  5 +--
 qom/object.c             | 14 +++++++++
 qom/qom-qmp-cmds.c       |  3 +-
 softmmu/vl.c             |  4 +--
 util/module.c            | 67 ++++++++++++++++++++++++++++++++++++++++
 chardev/Makefile.objs    |  5 ++-
 hw/Makefile.objs         |  2 ++
 hw/display/Makefile.objs | 28 ++++++++++-------
 hw/usb/Makefile.objs     | 13 +++++---
 15 files changed, 155 insertions(+), 24 deletions(-)

-- 
2.18.4


