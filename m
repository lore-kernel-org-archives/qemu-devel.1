Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1CAC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869A520656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeVAkK0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869A520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8IS-0003rp-OS
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fo-0007YD-Lm
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fm-0006wN-RO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id z15so694871wrl.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVMfracDJydLXMCggpl4mxu1W+C4dGbG4uOzhxzcx8s=;
 b=NeVAkK0uW4Q2i3+1m53uFSfZLXpe56PAklR7eMtlbnLxeKjp8X9Y443eZQBaPlHGLD
 bF0WNOh6z6WBgqcDBX9M0qG3eMN3gMnjyShsgtML7zvRk4qWklIXjKEnFlL2cNnr6DeA
 KUtwzx3bWQHOMUsZtHvh0/THlpV3gdZualf6qD/h+HXHTYlTsKXb8ezuKAM+SnLz2MaL
 527dtgBbaOSsk9bwmQiR4bviDzl8M0sgrvO4+nWfxOJ3fSTYPoZTh4bWPfhQH00l6+J7
 U6N8MoPqeUwgt174UbmKrOqlAm4cT3vt59vPoOEt1/5IGMWo+mRp1ErJ907vlGHSJRcW
 n19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVMfracDJydLXMCggpl4mxu1W+C4dGbG4uOzhxzcx8s=;
 b=qGTc1aYFmYys4pVS09//h0bw3LA6ASHxKx1uiABYK9osqoY4Tdl2BExzrnB8Syh1pl
 09mdo5r72S5mWlQmGP0jrvmllIAVJ0pzBDD3jRvSbggrlRy+171SfDSpdJLfaL4TI+r6
 hOEm40qamIxwnJ89f6f07V2P8l7RXhxwUZONX0fYH8zFQFIszrFYbcseuB9497orotDY
 Qkb2oA3w5AZg4gBgH87hoLiybFN1AmSfLS4uBUqO7K0mv6N1OCclEDBvqnwkn9EZe86B
 PUuvN4dXoYggbsJh3czNrZj6AN7Y1iJ5DgpuSGiS9mwcHkLya6K0KVeILqz6kLdASz8n
 DDkw==
X-Gm-Message-State: AOAM531s3+1qkHxjXXelVURyF6J+DWe3rgeuOIH6qr+kKOXyIDyaDlpV
 hSekTP8A/B5uxjGtKLj9NVCtew==
X-Google-Smtp-Source: ABdhPJxPnE3Dc/e8QCV+fbYiy0EzqgdqQKslupyyLdsbGl+9k6vHM7YPrOU95wjnMvLZ+aGxiOPPvQ==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr30208239wrq.263.1595399361583; 
 Tue, 21 Jul 2020 23:29:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm43358632wrw.83.2020.07.21.23.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A84F1FF9A;
 Wed, 22 Jul 2020 07:29:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 11/12] tests/docker: add support for DEB_KEYRING
Date: Wed, 22 Jul 2020 07:29:01 +0100
Message-Id: <20200722062902.24509-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For installing stuff from sid or ports you may need to manually
specify the location of the keyring. You can even import keys into
your personal keyring and point it there, e.g.:

  gpg --keyserver keyring.debian.org --recv-keys 84C573CD4E1AFD6C
  make docker-binfmt-image-debian-sid-hppa DEB_TYPE=sid DEB_ARCH=hppa \
      DEB_URL=http://ftp.ports.debian.org/debian-ports/ \
      EXECUTABLE=./hppa-linux-user/qemu-hppa V=1 \
      DEB_KEYRING=${HOME}/.gnupg/pubring.kbx

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index c164778c302..35c85f7db8a 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -79,6 +79,13 @@ else
     fi
 fi
 
+#
+# Add optional args
+#
+if [ -n "${DEB_KEYRING}" ]; then
+    DEBOOTSTRAP="${DEBOOTSTRAP} --keyring=${DEB_KEYRING}"
+fi
+
 #
 # Finally check to see if any qemu's are installed
 #
-- 
2.20.1


