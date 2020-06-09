Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A6C207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phEzfPyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A6C207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiblt-0001XN-BF
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeB-0007dd-0y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe8-0004OG-Ph
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id r7so20744667wro.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dy5kY10AJguH6nm5zuGcJziOR+JWiuUYiLstcUD0qZk=;
 b=phEzfPyxvmh7q9LBG/r3zi1qYqM4mVN+iddKNuIMqPgsX+w+ttuwmme/jiE/F3o61T
 a1SQxG3SSN7/2gVrCK2Jb/bEnDAlx4fJxDkTkqTB74uu9kVyHMMZWvTJ/nBtU1uYcwIK
 RN3b51jFtDsRBFzSy9Hc1zcgK21vDlLQZFLzlN3P+DX3inUXcjMJ3xFx5KJlnsS30uG4
 x02odV7AGwl9++oD4GjF082qiXmUgei6z7nSYfMYh13gqHtL3OGPHph0v7s/pVwN+INv
 ED9GNtNDGJVjuHHqys5JvHlxiFscq+IqLSEfPayyRvfzGzvq04A+qn+bthgOL5pasnRs
 MdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dy5kY10AJguH6nm5zuGcJziOR+JWiuUYiLstcUD0qZk=;
 b=BS3OuzREALlHcARLxAMzDBmEXcbKmxJX12bTxG//7aKRHp26Jpio+d9Owc2pXgsU6H
 /YHjMDjg03PmdUZQ22OPHZKo2Kd/vhRGlgjWx5sxm3VmoSx17JV/wyrlTbiFQrfJVsgV
 qdDWN9BP0G+EfTyVZmO4Fu/VOTK4TfukQmP7vx0DY/d0jnYJQsUYC+v0se+zBsLMdVZY
 kHn3Hv+JUyWtKrEe4twdfGFS/DHq6ROZSX+AUSpVYP0lozpfgbOICGBLDdU5Ck7DZtPo
 0c0u10n4ovck4vRMXmtyiK6aNdrgA3aRjz2Jyk5G7GM8mcdrCduV2k3S6lkVYis0H75E
 0M7Q==
X-Gm-Message-State: AOAM532Jxi9vYMugKfj9ZyDMYZ4whnqUD7knHjacRL78zzF5HZyDp+KY
 iU5at4PFmRcQzQQV7dMIEXoIMMTvNuI=
X-Google-Smtp-Source: ABdhPJz3iHK5lkzaenpWXyBjTRzpO64yfh61d8MdJg5fMgpcKHoS5EBvIXmLytB88bJYERy39UQURg==
X-Received: by 2002:a05:6000:341:: with SMTP id e1mr3712359wre.1.1591699098978; 
 Tue, 09 Jun 2020 03:38:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z206sm2515600wmg.30.2020.06.09.03.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3C5A1FF91;
 Tue,  9 Jun 2020 11:38:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/17] .travis.yml: allow failure for unreliable hosts
Date: Tue,  9 Jun 2020 11:37:57 +0100
Message-Id: <20200609103809.23443-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They will still run but they won't get in the way of the result.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200605154929.26910-6-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 564be50a3c1..ec6367af1f0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -429,6 +429,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - UNRELIABLE=true
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
@@ -493,6 +494,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+        - UNRELIABLE=true
       script:
         - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
@@ -535,6 +537,7 @@ jobs:
         - TEST_CMD="make check-unit"
         - CONFIG="--disable-containers --disable-tcg --enable-kvm
                   --disable-tools --host-cc=clang --cxx=clang++"
+        - UNRELIABLE=true
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
@@ -556,3 +559,5 @@ jobs:
         - mkdir -p release-build && cd release-build
         - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
         - make install
+  allow_failures:
+    - env: UNRELIABLE=true
-- 
2.20.1


