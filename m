Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399EEC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056B020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwcli3P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056B020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ulZ-0006lT-57
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1uiw-0001ek-4Q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1uiv-0004YE-6A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1uiv-0004Xf-2k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581524328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qSMJAQomtpzP/Dr733919naIw3tYANguYQgEPpG7jGI=;
 b=Bwcli3P7x2IIddcYbXuF2OPKr0g77NbNfF4Xa9BZsScZx1cSzu7hRbOqBxiPqE2IY9C6BT
 xyMQf/3bp3UipmmOn21T2dKT/Jviynb2xYBftzw2MqkumTMgthM04mnUXPcOh4y14e08Ks
 gYeTLSkNQ7djuqcp94HJupA2buC8U/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-tQ27u0JMMw2-kYa-oLyDBA-1; Wed, 12 Feb 2020 11:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2221133657D;
 Wed, 12 Feb 2020 16:18:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 905321001B07;
 Wed, 12 Feb 2020 16:18:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C99109D6B; Wed, 12 Feb 2020 17:18:35 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Ui 20200212 patches
Date: Wed, 12 Feb 2020 17:18:25 +0100
Message-Id: <20200212161835.28576-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tQ27u0JMMw2-kYa-oLyDBA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730=
:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-=
20200210' into staging (2020-02-10 18:09:14 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20200212-pull-request

for you to fetch changes up to 483644c25b932360018d15818d8bcd8c85ba70b8:

  ui/cocoa: Drop workarounds for pre-10.12 OSX (2020-02-12 13:27:08 +0100)

----------------------------------------------------------------
gtk: refresh rate fix.
cocoa: drop pre-10.12 support.
ui: rework show-cursor option.

----------------------------------------------------------------

Gerd Hoffmann (7):
  ui: add show-cursor option
  ui: wire up legacy -show-cursor option
  ui/sdl: switch to new show-cursor option
  ui/cocoa: switch to new show-cursor option
  ui/gtk: implement show-cursor option
  ui: drop curor_hide global variable.
  ui: deprecate legacy -show-cursor option

Peter Maydell (1):
  ui/cocoa: Drop workarounds for pre-10.12 OSX

Philippe Mathieu-Daud=C3=A9 (2):
  ui/gtk: Update gd_refresh_rate_millihz() to handle VirtualConsole
  ui/gtk: Fix gd_refresh_rate_millihz() when widget window is not
    realized

 include/sysemu/sysemu.h |  1 -
 ui/gtk.c                | 27 +++++++++++-------
 ui/sdl2.c               | 16 +++++------
 vl.c                    | 16 +++++++++--
 qapi/ui.json            |  3 ++
 qemu-deprecated.texi    |  5 ++++
 ui/cocoa.m              | 63 +++--------------------------------------
 7 files changed, 51 insertions(+), 80 deletions(-)

--=20
2.18.2


