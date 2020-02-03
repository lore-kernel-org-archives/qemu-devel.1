Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D3EC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3DE2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCrelmNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3DE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXt4-0006GJ-7B
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqd-0002BZ-CY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXqc-0002Gt-A6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXqc-0002GI-2l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:16:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so16968042wru.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fHPbJK8Qk8lmc+JAu3gqEWiN+g162MeuZQlHPFj6YGo=;
 b=zCrelmNLm84f6MEjTEOKZLHTHiEV1O7JWugwz82eSooAkn+oDsytI/49Icn1CmVVC9
 02Oz6Hw4yFjwWo6/sDmXNoB5uKljNeU64cvjgvBtuw3WSjyANpFqg4qKktcW6ddHBu8f
 cEGon4zQRDkbNP0CUO74xLnUkeMW4UF4rFKN9/piuYOEK19MdPezpetxDbOk4xJYj/1V
 6zyLdfq5TcAZmXi/69KBrW25g5o+clJBNqC1ZtZHlqS2nFkIqBBgz//RwGjBPZFnA13m
 ScxOcrFii5bSnMHc3eo3np4ltRFMaQFXhdZB+T8vrDDq8Z3QfGacUXq9aUmWMI6fMwk7
 uVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fHPbJK8Qk8lmc+JAu3gqEWiN+g162MeuZQlHPFj6YGo=;
 b=oCPREp1GEcRbCkdQeXkWSGSFAtZxkwaF/RnuS8TrqM11F0Mu3XyFfrxtFgUeeY0EWZ
 w5ryZn/eX7TeZayZ64O/LoDZPrpfDClz1sl/0vzQDmQ5VWIFfqdjXmw78OyNz5LZxh+S
 CkDGQjyG1bzktDdeD4uurRE4G5ORZQ24JejNBcWU4BwiEW2O8seB7+CQFG3KnDlRBlZa
 Dy1emZUrLWNmrmy9OvDDOlcZAREDhB4n5Mr2noj/r+alSZqAuNHlOKxI60Cro7OAeFlT
 ljMuKSpzjyu3mwpsJq8DAEn2Dblth78hZ5svn9UbnDAsSgaEsXjlDPIJHFHac8KiP4gT
 Y8YQ==
X-Gm-Message-State: APjAAAV6uPIS6y0D8lN4DCXa/8K7IrkSOxV8+BWA7yEbhnPa6ZvEclpf
 vYbPK4swJpjblBSCBkMhJJ2P0A==
X-Google-Smtp-Source: APXvYqzQ3f9UO1jzs0+RH6A0JoDPZjz2LfGBHV4LjQrXXgRexrEv4wuSKiw1ancLM2L8VB/IDTyZlg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr13606361wrv.86.1580721409200; 
 Mon, 03 Feb 2020 01:16:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm24200327wrr.35.2020.02.03.01.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:16:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D77AC1FFA6;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 17/17] .travis.yml: single thread build-tcg
Date: Mon,  3 Feb 2020 09:09:32 +0000
Message-Id: <20200203090932.19147-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've theorised that a parallel build-tcg is somehow getting confused
when two fedora-30 based cross compilers attempt to build at the same
time. From one data-point so far this may fix the problem although the
plugins job runs quite close to timeout.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c1c6df475a8..3b35b7cf04d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -380,7 +380,7 @@ matrix:
     - name: "GCC check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
@@ -391,7 +391,7 @@ matrix:
     - name: "GCC plugins check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-- 
2.20.1


