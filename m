Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778FAC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4419E217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmHvZyHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4419E217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6VK-0005cs-9l
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:28:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6UP-0005Ia-Rn
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6UO-0001gm-Sl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:27:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU6UO-0001fw-JE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:27:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id v22so1226071wml.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ax5Lq5sVicqsAzQYBOYT8ZLwPonXUFJFttZD6qBtBR8=;
	b=FmHvZyHj1stO3ub0RBeC8hP/ucGVs1dYtjX7bOeIH8OI1iIGEtwy2dy43gjJiB/yB5
	UsgsZcBMHqf0TZT3hl2L6U/X0rImslz8+buamn2L2+xzgAFz4jKOVZ/5keaVpPV0Jdib
	2667sGPXptXeeLJc02OLLo/CNlnPO7/km/ExBdyOdsQ1fU+Z5a0C2+/H7eoxj2m83VqH
	HN5m8J7hyCT5VFwFKlgNhMPgqsfrlKs9ETTQPUaFA8ZpVbzs8P7xVSiX/UGtwAr6zUj4
	PYqOWlvZLFTHup1cvQDs6jJqv6Zg/Jz4zvwGESkzQuD72r7SQI3eSnijr4L9CmEEt5mv
	4IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ax5Lq5sVicqsAzQYBOYT8ZLwPonXUFJFttZD6qBtBR8=;
	b=NMdaJJkev0KmTe1LzEqvVOn6NT4eWOLKK3hVIiW2VeNPsCiAJRsoZeHKjMOsBm50DB
	L/qpfDcCx7tXJ3kD1Pt7R6aFkTXWuSP30V94OVT3GzA/0fvrZvNOitXwWCdt6t829lMe
	/9hUy+lxztBHcoUcD4LGsLT5BrxeiHf6vIzT+20L1KVPLdZikJ8SiO701xDThwSj69YP
	XeIeroe6ufHwpak3Mm3bMLIs2I8stz0nEhTuVwtjA/tfVUjYj6rkWxycffz/53yl22cJ
	iour9ak5gMNmhuw0FLC2oq97zVbQulRHQjTJYopZ0VdVqWBOG4NldDt/py5oV5KyucWp
	8xUA==
X-Gm-Message-State: APjAAAV4nfqmYHf9AvLcLhJMqs7SPrKezaLba3ZFrZay59r15+CZl2Fz
	EKIZGw4ado3XnjcUqnFSIudvdw==
X-Google-Smtp-Source: APXvYqwkXyj7X1QerqIPMnFeVUSlawg5o5tWHAeCTZA7zyB1khuXbpwZm/zqKo8EOzl5jBtJP6Ba+A==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr14866134wmd.30.1558690066759; 
	Fri, 24 May 2019 02:27:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b10sm3019121wrh.59.2019.05.24.02.27.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 02:27:46 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A8A581FF87;
	Fri, 24 May 2019 10:27:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: jan.bobek@gmail.com
Date: Fri, 24 May 2019 10:27:36 +0100
Message-Id: <20190524092736.21734-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [RISU PATCH] build-all-arches: include x86 triplets in
 the build
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a couple of minor warts:

  - 32 bit x86 can be either i386-linux-gnu or i686-linux-gnu
  - skip looking for x86_64-linux-gnu-gcc in docker cross envs

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 build-all-archs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/build-all-archs b/build-all-archs
index a7cd7c2..e5dcfc8 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -39,7 +39,7 @@ while [[ "$1" = -* ]]; do
             ;;
         --use-docker)
             if [ -z "$arg" ]; then
-                default_tags=$(docker images qemu --format "{{.Repository}}:{{.Tag}}" | grep "\(arm\|ppc64el\|m68k\).*cross$")
+                default_tags=$(docker images qemu --format "{{.Repository}}:{{.Tag}}" | grep "\(arm\|ppc64el\|m68k\|i386\).*cross$")
                 docker_tags=$(echo $default_tags | sed 's/\n/\s/g' )
             else
                 docker_tags="$arg"
@@ -74,7 +74,7 @@ fi
 DOCKER_RUN="docker run --rm -u $(id -u) -v $(pwd):$(pwd) -w $(pwd)"
 
 program_exists() {
-    if [ ! -z "$docker_tags" ]; then
+    if [[ ! -z "$docker_tags" && ! "$1" == "x86_64-linux-gnu-gcc" ]]; then
         use_docker_tag=""
         for tag in $docker_tags; do
             if ${DOCKER_RUN} ${tag} /bin/bash -c "command -v $1 >/dev/null"; then
@@ -88,8 +88,10 @@ program_exists() {
 }
 
 # powerpc64-linux-gnu doesn't work at the moment, so not yet listed.
-for triplet in aarch64-linux-gnu arm-linux-gnueabihf m68k-linux-gnu \
-    powerpc64le-linux-gnu powerpc64-linux-gnu ; do
+for triplet in i386-linux-gnu i686-linux-gnu x86_64-linux-gnu \
+                   aarch64-linux-gnu arm-linux-gnueabihf \
+                   m68k-linux-gnu \
+                   powerpc64le-linux-gnu powerpc64-linux-gnu ; do
 
     if ! program_exists "${triplet}-gcc"; then
         echo "Skipping ${triplet}: no compiler found"
-- 
2.20.1


