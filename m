Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3535C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF5A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpG2F2eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF5A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutm7-0002eO-RG
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlP-0001m0-My
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutlO-0006br-05
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HJrWKi2I0nLSz+oAHfsk++jS2hmz5RcDmF3E/+ZKXOU=;
 b=GpG2F2eSeoIP7ZNuyUzWD+PKR6hSRgl1mwyq6g8V7bjJsVJuIoQ8fARbWReZVjrCiVQkaa
 Rz6fsN4m4Ym6WibwSOx5XP37kZwQDalZ417FVTHAjdjt7iCaTuQs21+5lDjHmHU3obhtkd
 IgWWVC/S7LgjHY3o7HhPAYny+ivX2Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-oqWkpdtgMWKhRalwQJPwEQ-1; Mon, 13 Jul 2020 04:24:33 -0400
X-MC-Unique: oqWkpdtgMWKhRalwQJPwEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EBB81E9E6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:24:32 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03AD51CA;
 Mon, 13 Jul 2020 08:24:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Chardev patches
Date: Mon, 13 Jul 2020 12:24:16 +0400
Message-Id: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d34498309cff7560ac90c422c56e3137e6a64b19:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/avr-port-20200711' into staging (2020-07-11 19:27:59 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chardev-pull-request

for you to fetch changes up to 30827bad3852fd85d86995e7ccab429679442889:

  chardev: Extract system emulation specific code (2020-07-13 11:59:47 +0400)

----------------------------------------------------------------

----------------------------------------------------------------

Li Feng (1):
  char-socket: initialize reconnect timer only when the timer doesn't
    start

Marc-André Lureau (2):
  chardev: don't abort on attempt to add duplicated chardev
  char: fix use-after-free with dup chardev & reconnect

Philippe Mathieu-Daudé (5):
  monitor/misc: Remove unused "chardev/char-mux.h" include
  tests/test-char: Remove unused "chardev/char-mux.h" include
  chardev: Restrict msmouse / wctablet / testdev to system emulation
  chardev: Reduce "char-mux.h" scope, rename it "chardev-internal.h"
  chardev: Extract system emulation specific code

 .../char-mux.h => chardev/chardev-internal.h  |  10 +-
 chardev/char-fe.c                             |   2 +-
 chardev/char-mux.c                            |   2 +-
 chardev/char-socket.c                         |   5 +-
 chardev/char.c                                |  43 +-----
 chardev/chardev-sysemu.c                      |  69 ++++++++++
 monitor/misc.c                                |   1 -
 tests/test-char.c                             | 122 +++++++++++++++---
 chardev/Makefile.objs                         |   3 +-
 9 files changed, 195 insertions(+), 62 deletions(-)
 rename include/chardev/char-mux.h => chardev/chardev-internal.h (93%)
 create mode 100644 chardev/chardev-sysemu.c

-- 
2.27.0.221.ga08a83db2b


