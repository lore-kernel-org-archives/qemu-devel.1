Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC607C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6EA2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QenY6Z27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6EA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zzV-0005v0-Oi
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zyX-0004c6-QA
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zyW-0001NU-K2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zyW-0001My-G0
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581782843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KddiZkYmDRfPOIEgujnl3Lx1NAvx6ywpvK43Vz9IJc=;
 b=QenY6Z277i6iMEffQ5ikB+MTKir7v8Dxl7MeucNNv4W1qehRsdJmQuKaqDFJXWy/wdbNwn
 8T+GUXAPFJIk9BBjmNg+hi/c5NVMobci/Dwp+hnxUaxYInsLRTLss7fsZmwxDRwOZbLV87
 00sgaKdEeapggTEDTiiLIOv4Yb0FFsk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-DdwnNLO5NZCFGjuntjLWFA-1; Sat, 15 Feb 2020 11:07:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so5952137wrw.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JAdJtb0hXIPeTgI5pZzta7S4+kyeKW1TY66bu8o8P5k=;
 b=EodIuD30IJ+RGGl0vGPq09i7G3yAUdr4Ns/Kjzg87WXyM9ndVcyTrX6/2hsy3DBdFL
 pZRI+Ri04Ts0YQwd+ugu69O/p5WZoqI64LaFh3ZzuKYsCGGQPhmJ+EqoEtS4ZSIIXbzb
 K0XZTLBsyt0G3jAbTcNuKheyagkeJS8CoFzzIRkE9/6FxqRZ0ET5VAhWc/P6lYz6rOmw
 yu5IT9Jp15ZLvDeEx2ti0Pi+wNebv+wX4l6AqhYoJgeJOdJiYspebCgYAjmlrLdWiDDD
 Qi48hrcZ4lNRBl79/8qrVQniGaTdNPvYoW4BjMHzkRTRcMTlqzSiFebBpC+BNG2+kDno
 UN2w==
X-Gm-Message-State: APjAAAUudR7DQQ9wdGC8xHK6IGiOa1ozY2Z/kdvfkc4UF10aFmwL0frE
 N2tbwxxb9VqE/Qw3LoaZyqI/EWhufv26CQd3+1zGJuI3iEkiwK9mf3jBWnURz5uFWXmCkrxJGWH
 EOCXUM2EVkiuZuLU=
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr11078710wmk.138.1581782840543; 
 Sat, 15 Feb 2020 08:07:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLuSL4ZupK1jkSGrKX19clyLz+q/nRGNfjCy1ZH29WzRBKy3vWKFzgtHeJFxk93hvLBibHSw==
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr11078699wmk.138.1581782840332; 
 Sat, 15 Feb 2020 08:07:20 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b18sm12103829wru.50.2020.02.15.08.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:07:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tools/virtiofsd/passthrough_ll: Remove unneeded variable
 assignment
Date: Sat, 15 Feb 2020 17:07:14 +0100
Message-Id: <20200215160716.1262-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215160716.1262-1-philmd@redhat.com>
References: <20200215160716.1262-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: DdwnNLO5NZCFGjuntjLWFA-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      tools/virtiofsd/passthrough_ll.o
  tools/virtiofsd/passthrough_ll.c:1083:5: warning: Value stored to 'saverr=
' is never read
      saverr =3D ENOMEM;
      ^        ~~~~~~

Fixes: 7c6b66027
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index c635fc8820..e9e71d5fc2 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1080,8 +1080,6 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
         return;
     }
=20
-    saverr =3D ENOMEM;
-
     saverr =3D lo_change_cred(req, &old);
     if (saverr) {
         goto out;
--=20
2.21.1


