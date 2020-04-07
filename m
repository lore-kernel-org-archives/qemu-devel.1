Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6924220644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiS+glXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6924220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlgL-00037H-KZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLldz-0006oN-Jp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLldw-0003mH-3i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLldw-0003m5-0c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586255983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvbaRt6FjvsveUuC+vOjrJEApSprL7Ma0wM7xUkHHic=;
 b=hiS+glXZcwtBaVyT+HU0EwgGNLE3Z/cBgQZ7M0CVd/Nq77PbRrIUStGknCsuz3zr1fS4Px
 j/gU1wX56bLV3VGBF7Zo8PZQZJl/3dQ8ybAH/EJ3pEkImHMoxKLu31svcrPpdhGcunqkpj
 X+W0fQ2BzIV/eVG3Rkeo8TXkCUeAv8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ppd0tFcPNQeF2FA6W9hOtQ-1; Tue, 07 Apr 2020 06:39:36 -0400
X-MC-Unique: ppd0tFcPNQeF2FA6W9hOtQ-1
Received: by mail-wr1-f70.google.com with SMTP id c8so1520296wru.20
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 03:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8eDnRTWyU3nAHcaQhD153aO8yrsrCY+01wCb/6HMgdw=;
 b=uiMiagbxeaM9imXiPK7oPf3XyOJzbQWYQ2EX48+dKWx4iVwCDwH4V9O59OLj2AFWzy
 2YwT1wg7vrOPywt2WCjyP+s31vTuxbseN+ByAi9S71vkL8mcro2ZBhQP4Xhl9mRreVCf
 hMq476epDqxZfJFuCDG4O5V1kQOFhbHu8v+aHslgfytNtrKxNnVN7hcq4HRjecytHjOL
 VrGVMfoXuyT809O2kzonO/tEgJg2axCNKjEku1PBlRrf7K+8T6Z6QXzMIiFsQHW8WVVu
 VxEcXU5LdqbODY7cQREtV6/VXj0Ppkh71guPOUeKRzQDFLYTjPPm+4U+EYrejCqERe4A
 HJ6w==
X-Gm-Message-State: AGi0PuYGaSNFVzxT5COx5BoDTPCVmXyhx/myP4ERz0p96g09kwA7/Rr6
 flfmw8L94cDO3rO6+HBWXUDlncMrbiWMwS5BTDsJzpBZgTxHSgfoL7MZnL3tmY/LOGCnzojx3uB
 fFpsOwsd7xaDFJMM=
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2042017wrm.65.1586255974666; 
 Tue, 07 Apr 2020 03:39:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOPaS1hq3jTix9n7KFmemITVyjpxh5KMR1OJd3FxWdwwJY8h2bGS/FmyA0KGs0qxnf8y6KFQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2041993wrm.65.1586255974412; 
 Tue, 07 Apr 2020 03:39:34 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k185sm1847211wmb.7.2020.04.07.03.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 03:39:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Date: Tue,  7 Apr 2020 12:39:17 +0200
Message-Id: <20200407103920.32558-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200407103920.32558-1-philmd@redhat.com>
References: <20200407103920.32558-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use NetBSD content delivery network to get faster downloads.

Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200211134504.9156-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index b27572f212..138064285a 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
                     '7020-40p/P12H0456.IMG')
         bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
         bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive/'
                      'NetBSD-4.0/prep/installation/floppy/generic_com0.fs'=
)
         drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
@@ -66,7 +66,7 @@ def test_openbios_and_netbsd(self):
         :avocado: tags=3Darch:ppc
         :avocado: tags=3Dmachine:40p
         """
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
                      'NetBSD-7.1.2-prep.iso')
         drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
,
--=20
2.21.1


