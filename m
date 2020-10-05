Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE20C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093D72083B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KToeO1yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093D72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLv3-00006p-27
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmk-0007wj-TL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmh-0007Ir-PB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id z1so8470319wrt.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+QPGHfEsI1tVrYkYTPEuF90ZfkTKyzarzGuFssmOlYk=;
 b=KToeO1yYvIEvgD5xq79ehqS75O0Jb8yBUzlogXI6CJUip/tWayO69cpZdHGN5Ir7mL
 Ucv5mXlmtuRVYHDxY2unyZff356+P3bQLA1vSCmIk1hd1pMqw4rXpCoHYdVZ6N7oDLE0
 WhU98kisWn7VCu0cMx+uCkBOwY3fr3kbkmwJyoroQH7AWSUK+V93FoGtywtDcK3EjaTS
 4KFO+MSEEzsm+kcC5gf00NdmTrHHmZvQGBoxWvAXUfMwALQymgnnumU+H9ypYrHtrxYM
 I0uuiX3Ch4jHXHS8yWizH+uJyMJMh3wABLxMM2/nhPuHIq8VyB9ceJGH3AfYHfg40qyd
 4fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+QPGHfEsI1tVrYkYTPEuF90ZfkTKyzarzGuFssmOlYk=;
 b=TItjDQEf2es4vKrTsJl8ffreA17g31QQAGfSPFwk0LevyxCeHIlI3JWGIF73zF2M1R
 04YRuawpxGM4Lx7jZ8ZRB+sNhpsEVw0vBnBCpmSRc1225WxFprBULK0oJzfUT3pD78Wn
 jLsnWJosq21qMZp+QcFnDAsS+/EaR3ISTbqYOsjY9xU9h5Kz4JFakRTjF6DN2rhuLmGP
 o/o4NKShIocg4UEL623kzQcbxwypBZoiNXPcDqeBIrUX7qC27IYh1H0in9dh875BcyAM
 nAWT2RG0OKje8rrYK50RCl+ieUxPhWPvkNmJp1LzV5t767tWlc3NfZDdXzTCtYqLbXyV
 zrSg==
X-Gm-Message-State: AOAM533oNs5/SdeKh9kgyxw+ZMFvJRlg3uax0MOgRPSEuPIBkvy8n0Tz
 3NfDEKfuR9yeOVrD0oGkvJ6WZZiovJw=
X-Google-Smtp-Source: ABdhPJxJuA6yBrvcYqDsaeE3+o9/TtK7IUgvpYMNCb4vio+P97U4i7rE99ysIKGpEWRW23Qjrmt4PA==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr16057325wro.407.1601886229322; 
 Mon, 05 Oct 2020 01:23:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] travis: remove TCI test
Date: Mon,  5 Oct 2020 10:23:31 +0200
Message-Id: <20201005082349.354095-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCI is already covered on gitlab CI, so we can remove it.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 519e62432d..1054ec5d29 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -226,14 +226,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # Check the TCG interpreter (TCI)
-    - name: "GCC TCI"
-      env:
-        - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
-            --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
-        - TEST_CMD="make check-qtest check-tcg V=1"
-
-
     # We don't need to exercise every backend with every front-end
     - name: "GCC trace log,simple,syslog (user)"
       env:
-- 
2.26.2



