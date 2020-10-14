Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFBC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFD520BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKnLbMyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFD520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSc6K-0005GS-Eu
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2v-0008VO-KD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2q-0007am-3u
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602663718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7zDlQlupIijMBWKanjbG7UkTzAIPZIP868ZwnM4gfvg=;
 b=BKnLbMytL5+XNTcQTUA13DlHmshG8KHeKTG16nPHxhbnRAXWlLluNZZofNANjmpZSxaIaI
 WTkijPuqw4qpbmBurWi10RHDPhDcxUT177LjnCqKPr8RmxHCmDRb3rM5xeXcFvhxY5ycvX
 9hfCR8/RK8zmdH01fTFBEe7JcxKGFjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-HPv2Fs3NMnSulmUjKq6MBQ-1; Wed, 14 Oct 2020 04:21:55 -0400
X-MC-Unique: HPv2Fs3NMnSulmUjKq6MBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27DB856BE6;
 Wed, 14 Oct 2020 08:21:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D276F5C1A3;
 Wed, 14 Oct 2020 08:21:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 00DBB9CBC; Wed, 14 Oct 2020 10:21:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Ui 20201014 patches
Date: Wed, 14 Oct 2020 10:21:40 +0200
Message-Id: <20201014082149.26853-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 96292515c07e3a99f5a29540ed2f257b1ff75111=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2=
-pull-request' into staging (2020-10-13 14:06:22 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/ui-20201014-pull-request=0D
=0D
for you to fetch changes up to 41d004d8af59885da2c21460a73898b1aa09690f:=0D
=0D
  ui: Fix default window_id value (2020-10-14 10:20:26 +0200)=0D
=0D
----------------------------------------------------------------=0D
ui: fixes for sdl, curses, vnc, input-linux.=0D
=0D
----------------------------------------------------------------=0D
=0D
Colin Xu (1):=0D
  input-linux: Reset il->fd handler before closing it=0D
=0D
Gerd Hoffmann (1):=0D
  qemu-edid: drop cast=0D
=0D
Jan Henrik Weinstock (1):=0D
  SDL: enable OpenGL context creation=0D
=0D
Jason Andryuk (1):=0D
  vnc-stubs: Allow -vnc none=0D
=0D
Samuel Thibault (1):=0D
  ui: Fix default window_id value=0D
=0D
Yonggang Luo (4):=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
  configure: Fixes ncursesw detection under msys2/mingw by convert them=0D
    to meson=0D
=0D
 configure                 | 155 ++------------------------------------=0D
 meson_options.txt         |   4 +=0D
 include/sysemu/os-win32.h |   4 +-=0D
 qemu-edid.c               |   2 +-=0D
 ui/console.c              |   1 +=0D
 ui/curses.c               |  14 ++--=0D
 ui/input-linux.c          |   1 +=0D
 ui/sdl2.c                 |   5 ++=0D
 ui/vnc-stubs.c            |   3 +=0D
 util/oslib-win32.c        |   4 +-=0D
 meson.build               |  83 +++++++++++++++++---=0D
 ui/meson.build            |   2 +-=0D
 12 files changed, 105 insertions(+), 173 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


