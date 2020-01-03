Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB5C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E74C222C4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrAmvtiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E74C222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inIxz-0001tb-D4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inIxE-00018o-TT
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inIxB-000753-1D
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1inIxA-00070R-GV
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578042547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqT428/hQKdcp7Y53e6gV66kPBU6L3r5GbhwDXvNt9c=;
 b=IrAmvtiChaYoPsaxK3+6l6iEC7efiOzyFQE6udYbnYnMFp1qvqD5TscMYNlrbZQ0sa8bJ+
 GaFXzaYWxQ+vmhPtBvW1cP1Rvecq2X/RwnwUozL9xrM0Z3ZuUyDNZwvjMh2m8cBMDMAo2o
 eWEYNVfrB9owzasJfzf3gTiNKLt54Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Ch6dzGeKP0CakvO_cJYJag-1; Fri, 03 Jan 2020 04:09:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FC310054E3;
 Fri,  3 Jan 2020 09:09:04 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACFFA5D9C9;
 Fri,  3 Jan 2020 09:08:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/7] Screendump patches
Date: Fri,  3 Jan 2020 13:08:46 +0400
Message-Id: <20200103090853.1014627-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ch6dzGeKP0CakvO_cJYJag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit dd5b0f95490883cd8bc7d070db8de70d5c979cbc=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191219' into st=
aging (2019-12-20 16:37:07 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/screendump-pull-request

for you to fetch changes up to 53a61ecbb16b28c707f0b126193d226a25c28cb2:

  screendump: use qemu_unlink() (2020-01-02 16:29:32 +0400)

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
 ui/console.c             | 73 +++++++++++++++++++++-------------------
 ui/trace-events          |  2 +-
 util/osdep.c             | 15 +++++++++
 9 files changed, 70 insertions(+), 38 deletions(-)

--=20
2.24.0.308.g228f53135a


