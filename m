Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8619C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848B4207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah+HTafQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848B4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKKu-0002qZ-My
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJy-0001DR-OJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJx-0006ck-S7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gFXS4QFRZD7SFMAo+WF7oLEzBzcN4uQOxE/aKRByhiE=;
 b=ah+HTafQhv+xgxFZRs2hzc5MhIInBp4W9f79IgROfn+V2lLAN7ZTK5UrDscookHlzxFk6L
 wKrWIZC7nH1yz1CLsPdahrDq+lsOW7nTPm/AWHix4HLvGLH3za9mq3sRpNMEqvhufjqzgy
 g8mHIlzWKtMKUckl5BxnsznrUwUfXUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Taa7oLzEP4ufyezokPSG9w-1; Wed, 20 May 2020 04:43:21 -0400
X-MC-Unique: Taa7oLzEP4ufyezokPSG9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAF9A800053;
 Wed, 20 May 2020 08:43:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2E119C4F;
 Wed, 20 May 2020 08:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 71CF117444; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Ui 20200520 patches
Date: Wed, 20 May 2020 10:43:05 +0200
Message-Id: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
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
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9=
:

  Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into st=
aging (2020-05-15 19:51:16 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20200520-pull-request

for you to fetch changes up to 7b23d121f913709306e678a3289edc813f3a7463:

  ui: increase min required GTK version to 3.22.0 (2020-05-19 09:06:44 +020=
0)

----------------------------------------------------------------
ui: windows keyboard fixes for gtk & sdl.
ui: require GTK 3.22 or newer.

----------------------------------------------------------------

Volker R=C3=BCmelin (11):
  ui/win32-kbd-hook: handle AltGr in a hook procedure
  ui/gtk: fix handling of AltGr key on Windows
  ui/gkt: release all keys on grab-broken-event
  ui/gtk: remove unused code
  ui/gtk: remove unused variable ignore_keys
  ui/sdl2: fix handling of AltGr key on Windows
  ui/sdl2: start in full screen with grab enabled
  ui/sdl2-input: use trace-events to debug key events
  ui/gtk: don't pass on win keys without keyboard grab
  ui/gtk: use native keyboard scancodes on Windows
  ui: increase min required GTK version to 3.22.0

 configure                   |   2 +-
 include/ui/win32-kbd-hook.h |  14 +++
 stubs/win32-kbd-hook.c      |  18 ++++
 ui/gtk.c                    | 194 +++++++++++++++++-------------------
 ui/sdl2-input.c             |   3 +
 ui/sdl2.c                   |  33 +++++-
 ui/win32-kbd-hook.c         | 102 +++++++++++++++++++
 stubs/Makefile.objs         |   1 +
 ui/Makefile.objs            |   3 +
 ui/trace-events             |   3 +
 10 files changed, 264 insertions(+), 109 deletions(-)
 create mode 100644 include/ui/win32-kbd-hook.h
 create mode 100644 stubs/win32-kbd-hook.c
 create mode 100644 ui/win32-kbd-hook.c

--=20
2.18.4


