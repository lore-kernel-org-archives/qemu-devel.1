Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E0C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3E020863
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCyY5jZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3E020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imz5M-0002KY-RP
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1imz4V-0001op-PO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1imz4T-0006EG-3E
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:55:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1imz4S-00066S-Et
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577966115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zXgQau0OHLXrbMTjTnAjOHTrAjILGGxG0SSv2EqN2i4=;
 b=UCyY5jZ6w5/P0AaTe46yYwM8PjLzxfUfvKj08OvO1Z9T9BKVMqAARcYbqX6LMQW6piYccE
 S0XuhmjWV59aNz6VTm0TXaKWl8gwjfY/IW4ZzPttjXUmuvFzzyr8WGziGsJCVcKCuskbOk
 AqWgxzH5RCrApUDopD6Wwvn6tvETTw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-0xewhmOzMWKgsS23R4FYZQ-1; Thu, 02 Jan 2020 06:55:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ABFB18B5FD2
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2020 11:55:13 +0000 (UTC)
Received: from localhost (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5207277C80;
 Thu,  2 Jan 2020 11:55:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Screendump patches
Date: Thu,  2 Jan 2020 15:54:52 +0400
Message-Id: <20200102115459.854103-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0xewhmOzMWKgsS23R4FYZQ-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit dd5b0f95490883cd8bc7d070db8de70d5c979cbc=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191219' into st=
aging (2019-12-20 16:37:07 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/screendump-pull-request

for you to fetch changes up to 6b8d2a5132378ac19cf93597dad694ea764cca4f:

  screendump: use qemu_unlink() (2020-01-02 13:54:57 +0400)

----------------------------------------------------------------
console: screendump improvements

Hi,

The following patches have been extracted from the "[PATCH v6 00/25]
monitor: add asynchronous command type", as they are
reviewable/mergeable independantly.

They introduce some internal API changes, and fix
qemu_open()/qemu_close()/unlink() misusages which should be quite
harmless.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (7):
  console: add graphic_hw_update_done()
  ppm-save: pass opened fd
  ui: add pixman image g_autoptr support
  object: add g_autoptr support
  screendump: replace FILE with QIOChannel and fix close()/qemu_close()
  osdep: add qemu_unlink()
  screendump: use qemu_unlink()

 hw/display/qxl-render.c  |  9 +++--
 hw/display/qxl.c         |  1 +
 include/qemu/osdep.h     |  1 +
 include/qom/object.h     |  3 ++
 include/ui/console.h     |  2 ++
 include/ui/qemu-pixman.h |  2 ++
 ui/console.c             | 74 +++++++++++++++++++++-------------------
 ui/trace-events          |  2 +-
 util/osdep.c             | 15 ++++++++
 9 files changed, 71 insertions(+), 38 deletions(-)

--=20
2.24.0.308.g228f53135a


