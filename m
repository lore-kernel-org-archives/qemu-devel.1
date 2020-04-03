Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3960FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063E020737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7Odwos9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063E020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQFN-0007qW-6R
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8q-0008NG-5u
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8l-0006xj-DZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8l-0006xC-7z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNPn2H1M50FjhhDecltPYfWD8OWcf2g/i9c77dxqyhw=;
 b=f7Odwos90rVEN+uyuzqY8oNuVHwbi4411CJu+FmKyEgvGfo7sqiydQZoA84w3coaovvhuy
 LCc/2OuJ86WeR26sSxWpWDun/shWUdhcgep8lSlGD2znTQbM8/ceoNa6Wj/S7/qVlGS87e
 DR+a350MWjXfIjC+NIdHPAULPKwSMdc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-1zLYyqcuMz-wqnnCYpdR-A-1; Fri, 03 Apr 2020 13:29:56 -0400
X-MC-Unique: 1zLYyqcuMz-wqnnCYpdR-A-1
Received: by mail-wr1-f70.google.com with SMTP id 91so2581015wro.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TSlBrLwxhAdexcEXjJ1NeQ0BcWKn/T2U+OvtZXNY8Dg=;
 b=oIs06VliUOl16OnrxFjx+p6xn0qOvotT7cOqeA+r3XKV1v/72DbTPRdNnWwHfmHpXQ
 UrdRo3PGFeG8MtGpccoPRHnYynY6f4vqZxbADhq0yAjzPS5cY5dFKF7wQ1bd/AVpIUbs
 Tu8mkTJGCuvUMhMDvtLKwNkk1hhR0VvH0v+/Tkm2yZYo7TiIX95VhcBohj6MngTbhdFz
 SM5sYGKTSmFEyvw8iVZZX4CTi7HE4C/PKvLBVV29XW0oKgG0bAaGQZMMTUJLiuaLswFT
 MyXJO3NUgKmAgNDPUeT5lLo+5JogcxuQ3u73V21H+L2RIp8TBR6f2ip61gmSY8TCXZ7r
 3B0A==
X-Gm-Message-State: AGi0PuYuN9puB5yzMyuXzSLugdqUaXBAo5sVFErsmR+WElogdKdctZwW
 T+IIwtwJ/RyLzXB9SwNPEC7WDDCQCaM5bTizKuHk0EQlu3+tAgQ9lI0rTrFNeaRzOF/MNc0Oq4r
 bfQ+o858uaL7036I=
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr9869984wrm.216.1585934994978; 
 Fri, 03 Apr 2020 10:29:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyaTwJHCZLWKzOmMoJaerfxtpfUAWojGsHQ84eGpJgGnsOMWM0I/lNhw4DuJLL637YOzFXow==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr9869957wrm.216.1585934994716; 
 Fri, 03 Apr 2020 10:29:54 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f25sm12024235wml.11.2020.04.03.10.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 5/8] .travis.yml: Cache acceptance-test assets
Date: Fri,  3 Apr 2020 19:29:16 +0200
Message-Id: <20200403172919.24621-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep all acceptance-test assets in the same cache bucket.

As of v5.0.0-rc1, the cache is 2610.11MB:
https://travis-ci.org/github/philmd/qemu/jobs/670558103

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index e0c72210b7..2fd63eceaa 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -318,8 +318,10 @@ jobs:
       env:
         - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha-s=
oftmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-so=
ftmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sp=
arc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD=3D"make check-acceptance"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
       after_script:
         - python3 -c 'import json; r =3D json.load(open("tests/results/lat=
est/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"=
] not in ("PASS", "SKIP")]' | xargs cat
+        - du -chs $HOME/avocado/data/cache
       addons:
         apt:
           packages:
--=20
2.21.1


