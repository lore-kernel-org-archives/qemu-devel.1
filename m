Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C56246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvOiKQi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C56246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cZd-0001G8-Sq
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cYa-00086K-Ed
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cYY-0002oO-6b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cYW-0002nN-IB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582884459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QusGXbB16+fD+JpyOdOgOzufoJqlutG1Rs5p7p93/+8=;
 b=WvOiKQi/sVwz4ptYNBRRV+TW3YOXWQjU6w1/4AO6IxnDIeWQTfN5+PemXDYhS66lqoXL9u
 f92ncHYmorg4xqWxE3sYgrkhc/M5WYvx3Ld6ENt7ZZXMT6FbGVaM0aqcv5lDRWmOspG2jf
 SnvTUE/3AoxwHvEvW1HUQp1XnPVAdMc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-DpmRCU8ONgOiMhYT8drXkQ-1; Fri, 28 Feb 2020 05:07:33 -0500
X-MC-Unique: DpmRCU8ONgOiMhYT8drXkQ-1
Received: by mail-wm1-f71.google.com with SMTP id w3so509795wmg.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wnDvjmsR0Fx1jpSLjo2oU9Nma1VeFY3J2/yuqXRPvG4=;
 b=RV229mGeu9PHLiYW1JCD7L0lySJE5mr9N0aBOyvUD5r4H7rgl+kct1dW6tCC08lX03
 0ySoZrjxhY2Bx6Y5w3517HnnLqqfdPrOEFTJvhNY23tCRwDV/dQ4A2+gBQFIN1KFrk33
 qFjNqJqPY5yYvVIyvOb+Go92udVqIP4AHY4nnhGUqftSOSXXQjU89i47y1hlXh9M0eHE
 hsdkg5kxDJkkEwRRksobKaxpGtSHFfVaoUn3wad0nbc1gQryTJ9A7lDWM+6Khe929706
 ilc52uqSacrO3RXDYWQ3WabGtkDrOolwkGajexOeroEdZWiCftD41s5pbwE8UZrJpyNJ
 7FDg==
X-Gm-Message-State: APjAAAVviaNmQBd9QZeAYNODpIZnzNayQ2DEotsPFwU4GmB7cPRGl1I/
 RXZM3SGqp76PMt8o3L+CMgsmlE340RyBFbOp13VGRxf+8L5rs0B1yr4n7yC1fv0Rf58XzOvR7W4
 I4jxA4ckRT0/nMzs=
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr4031016wrj.315.1582884452410; 
 Fri, 28 Feb 2020 02:07:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWweUuD+OM3VSMgCotBxyyOLyX0SHgMuXsc7GCxGPkxT/qiWZ7FPTaA/PPK4SpsJsLePLsOA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr4030995wrj.315.1582884452156; 
 Fri, 28 Feb 2020 02:07:32 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id q12sm12534994wrg.71.2020.02.28.02.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 02:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] misc: Improve error reporting on Windows
Date: Fri, 28 Feb 2020 11:07:22 +0100
Message-Id: <20200228100726.8414-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few patches to improve bug reports on Windows.
(i.e. https://bugs.launchpad.net/qemu/+bug/1657841)

Since v2:
- Remove changes in functions using fprintf()
  (util/oslib-win32.c is no more modified)
- Do not remove slog() call in qmp_guest_shutdown()

Since v1:
- Rebase an old patch from Alistair to use error_report()
  as suggested by Markus
- Fix other uses in util/osdep.c and QEMU guest-agent

Philippe Mathieu-Daud=C3=A9 (4):
  chardev: Improve error report by calling error_setg_win32()
  util/osdep: Improve error report by calling error_setg_win32()
  qga: Improve error report by calling error_setg_win32()
  qga: Fix a memory leak

 chardev/char-pipe.c  | 2 +-
 chardev/char-win.c   | 2 +-
 qga/channel-win32.c  | 7 ++++---
 qga/commands-win32.c | 8 +++++---
 util/osdep.c         | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)

--=20
2.21.1


