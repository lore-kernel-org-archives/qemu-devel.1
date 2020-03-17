Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15C7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F5B2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHcU40rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F5B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIVz-0002af-Oq
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEITO-0008Aw-58
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEITM-0003hn-9K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEITM-0003dH-53
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2Uio4O39LGTCl54niMoeAIzdHQX9K6PS1/yY4c+PZU=;
 b=UHcU40rCCB7hSwa+BzP+2fU/V8cinppyW4W2U1d5GY88AKSuoXfUL+XGfJsZwAPlRVmrJ4
 TnJz1pWiEwnUE4bjwnt6QPWNOulEIRUAkySNWXj4bZwtA8US2pLuzZYNkD1Kbh9ymgrlbF
 YdLaT34tY644FeTlOBMqlZm8CdK4ttY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-vJHLUJk0N7SCuS0AYGTGcA-1; Tue, 17 Mar 2020 16:05:50 -0400
X-MC-Unique: vJHLUJk0N7SCuS0AYGTGcA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so3378172wro.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lT/ObMlAQ2H/bRv1VQKQQXSN8/cTHTnb20apclf4pHs=;
 b=YJTvtDi1Pxkzb97EcgOCuRrssAqxKcykHpWn1TtY9yiqXhjqWSdvXT9QG4k52MDleQ
 /aGM3QV6fihomch2AI1p7b+L6uRRZM8Vx62TNWl0+dpeKqaZrqdvG9l1FPd0+WGwS/Se
 QGjmZkkVfMORdGScDvnoCHRxsLYBJLESbqly9+oQJ5Zyda45DIBbrx3nQ83fWpoUTMgn
 r54j5unAzJ7LZOcdR8QsWrY1kvCQqYqb/ExSz5E4+8kaansl9rHVpwypCkcCUwwzLSQ9
 nGn4xWF2G8yQseBcvyIV1o32YEy/LKrCwGIi2i1SuDVTOk9Qs2DCkv1epigKZwrDbnUl
 aRJg==
X-Gm-Message-State: ANhLgQ1hbBkueuuQ+XroeTNRRXzk4b2jEmb6JjQPv43SMzUYfWI7bsRE
 0Uxa9EWRNX8mpurVYir7YUQnUOnoy4q/1/RoiXVoo4X6CTz6QL4mFBzqC6zMdSUIy6hiTx1ddqZ
 6ZO5TVIB+Oezeg9A=
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr798889wrx.166.1584475548789; 
 Tue, 17 Mar 2020 13:05:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu5vgWxnlSjm8ZhdjL4SXpPoUyYaBt0jrnhjrVAHZ8L2fxE8nUGXrN3S/uaRngmC9lMrQtjAg==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr798868wrx.166.1584475548616; 
 Tue, 17 Mar 2020 13:05:48 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id v2sm6213931wrt.58.2020.03.17.13.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:05:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] tests/test-util-filemonitor: Fix Travis-CI $ARCH env
 variable name
Date: Tue, 17 Mar 2020 21:05:38 +0100
Message-Id: <20200317200541.6246-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317200541.6246-1-philmd@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we can find reference of a 'TRAVIS_ARCH' variable in
the environment and source [1], per the Travis-CI multi-arch
documentation [2] the variable is named TRAVIS_CPU_ARCH.

[1] https://github.com/travis-ci/travis-build/blob/v10.0.0/lib/travis/build=
/bash/travis_setup_env.bash#L39
[2] https://docs.travis-ci.com/user/multi-cpu-architectures/#identifying-cp=
u-architecture-of-build-jobs

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-util-filemonitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 45009c69f4..e703a7f8fc 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -415,7 +415,7 @@ test_file_monitor_events(void)
      * This test does not work on Travis LXD containers since some
      * syscalls are blocked in that environment.
      */
-    travis_arch =3D getenv("TRAVIS_ARCH");
+    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
     if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
         g_test_skip("Test does not work on non-x86 Travis containers.");
         return;
--=20
2.21.1


