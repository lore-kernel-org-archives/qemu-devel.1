Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A080CC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAB720776
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQBZg7QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAB720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiN3-0006sP-CT
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLf-000491-7n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLe-00036m-59
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiLd-000354-Fi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9OiKYEiXObyyvdBrn5ZU7rEjNuUJXTXkgfrEwy77Qf8=;
 b=hQBZg7QWDoFJO+tJ3XxQEtfpKLvGFc9omLcK4RiDVIs52uy1nMOpNnEoaIijFSA+N8/nza
 w/6EWMTGB8O1XLJUo1175MpB/wIsqmKfMkQhxb/ry3io+fdKYVEWWto3DkVzXgE0zrQoRX
 /t/aK9KrTS+xlOHd4FLwcaKYCWVEpoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-NYl-vv8ENfWcWES064Hzmg-1; Thu, 23 Apr 2020 16:21:20 -0400
X-MC-Unique: NYl-vv8ENfWcWES064Hzmg-1
Received: by mail-wr1-f72.google.com with SMTP id e5so3364748wrs.23
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g16r6Dl+yK2+wuLRwMGXGvj619Nq/tXVscJSs4aI4dk=;
 b=ZS88kna4ubtJqQXxFgKVuOmT/kunbcvyZhfHDYrO6WMd7rJJoE38deKHN/WVRSvbbu
 HwCSLd6whjzLmAix8b03JjCkML44KreCgxk/wRwD2zQrjZ4ypiya6SEE52Ow0A89pKDL
 y9KKG0v3p45uSWMnspLZENFMKz9Qj48HRSVO+C1Om4W7mWwjtpz7hj/5sQBQg3bU+zuG
 wlZVr09ZiI3fMWJiOIj7fodyVqquJkXbEUoGOdoLl7GE4R73rVwTvrjvnMWTkaWTYeKR
 7ginMmOR6HsEb3sSgn+vAsnnMgdc3AUfNb/w6MdhYIx7kAp53oVNiS9hXm5eEJdW/XiK
 IAtw==
X-Gm-Message-State: AGi0PuaoS3I7av7gnPg4FP0Y6N56ylK8B3+0bqtwqLpHSGLsdkjl3tqB
 7poenrYuBjyJ78QDWUEG15KhMks809jET0UsYjgE0fu7Zg8BU+12nVa7eaAYkkpkNlvH9Di0CQF
 Vb9NgyaVbwhX8RfE=
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr6218886wmb.4.1587673276548; 
 Thu, 23 Apr 2020 13:21:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXIL3Yh44jjBNt18MBCNIr/1uygsc5WV3Zp1pTm/oCwcAbLjo3a0k9eTwrGK5QjeypSFckLg==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr6218865wmb.4.1587673276328; 
 Thu, 23 Apr 2020 13:21:16 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g6sm5175029wrw.34.2020.04.23.13.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] chardev: Reduce system emulation specific code
Date: Thu, 23 Apr 2020 22:21:05 +0200
Message-Id: <20200423202112.644-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chardev cleanup while reviewing 'Refactor machine_init and exit
notifiers' from the multi-process series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697510.html

Elena Ufimtseva (1):
  multi-process: Refactor machine_init and exit notifiers

Philippe Mathieu-Daud=C3=A9 (6):
  monitor/misc: Remove unused "chardev/char-mux.h" include
  tests/test-char: Remove unused "chardev/char-mux.h" include
  chardev: Restrict msmouse / wctablet / testdev to system emulation
  chardev: Reduce "char-mux.h" scope, rename it "chardev-internal.h"
  chardev: Extract system emulation specific code
  stubs: Split machine-init-done as machine-init and machine-notify

 Makefile.objs                                 |  1 +
 .../char-mux.h =3D> chardev/chardev-internal.h  | 10 ++-
 include/sysemu/sysemu.h                       |  2 +
 chardev/char-fe.c                             |  2 +-
 chardev/char-mux.c                            |  2 +-
 chardev/char.c                                | 37 +---------
 chardev/chardev-sysemu.c                      | 69 +++++++++++++++++++
 monitor/misc.c                                |  1 -
 softmmu/vl.c                                  | 42 -----------
 stubs/machine-init.c                          |  4 ++
 .../{machine-init-done.c =3D> machine-notify.c} |  6 +-
 tests/test-char.c                             |  1 -
 util/machine-notify.c                         | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 chardev/Makefile.objs                         |  3 +-
 stubs/Makefile.objs                           |  3 +-
 16 files changed, 165 insertions(+), 88 deletions(-)
 rename include/chardev/char-mux.h =3D> chardev/chardev-internal.h (93%)
 create mode 100644 chardev/chardev-sysemu.c
 create mode 100644 stubs/machine-init.c
 rename stubs/{machine-init-done.c =3D> machine-notify.c} (63%)
 create mode 100644 util/machine-notify.c

--=20
2.21.1


