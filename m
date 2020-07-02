Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061B720836
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDit0LVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061B720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyEW-0001OT-8I
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqyDH-00005k-3j
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:21:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqyDF-0000Xp-G3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593692468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uykhaC7Q51LZ9zora9s0hSYThyXIRGNMMT3K6MVuWNY=;
 b=XDit0LVdo8bpuewGwzBLU9eXnpZ/udz6YNx/yFHHDY7GDsBTB4az368imeJSV47UKRHB4k
 31nL4MgCmLsx/P3ksXYYiju4cXXuLwztqvmFn0QcrZfJbyCDVockDcBrywVHPvoAqLwiZw
 THXrg2vj/uU0g5pmy7yWecoJvTO3Fw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-uFrcVye2Ox-LSA5oJK4zdw-1; Thu, 02 Jul 2020 08:21:06 -0400
X-MC-Unique: uFrcVye2Ox-LSA5oJK4zdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF601019964
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 12:20:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D56952B6FF;
 Thu,  2 Jul 2020 12:20:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 201B031E58; Thu,  2 Jul 2020 14:20:48 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Modules 20200702 patches
Date: Thu,  2 Jul 2020 14:20:38 +0200
Message-Id: <20200702122048.27798-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/modules-20200702-pull-request

for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:

  chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)

----------------------------------------------------------------
qom: add support for qom objects in modules.
build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
build braille chardev as module.

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
 Makefile.target          |  7 +++++
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
 15 files changed, 148 insertions(+), 24 deletions(-)

-- 
2.18.4


