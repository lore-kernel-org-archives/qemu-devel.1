Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2106CC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FE42098B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4N2voeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FE42098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHOuG-0001xU-LE
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 06:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOtC-0000cR-Gz
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:42 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:44084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOtB-0002EF-0h
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id b12so14683135edz.11
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DtaDJQIlwIYvq2X082N0v4uFIfZ0Kcg079ABQmsDHiE=;
 b=A4N2voeYBC2qsKyH8x6m1146Un++nAZ7mCqQOPq7Z+aKyudXH8E0+vRilGsQb98lSc
 KM3ESx9hn/xxjPCyUCZy+9TkUqaQhQ6UyUUl9WaoePvPm+n9XIx/BQ+B1FOY6nByMaN2
 DyVDKmhMt2ATRljJxKWtDic+4FR+2nV+AfNbsry9LwQbWo5FQuFy/jTOEHR/VG8LuL15
 2rCaHDjMF7Uy5VBtJhGkWjkfXo+zTuUsJ/R4xrCJzHZXAe9Rij0sKNPzEOjuPDRAw80d
 9sKMfMF0itkYvtgAxUIqWuypyazZq874poDxN4ItBewQ7pSR390YUlqYO8+AE7TNkD0K
 krSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DtaDJQIlwIYvq2X082N0v4uFIfZ0Kcg079ABQmsDHiE=;
 b=Sj5ikP070jd9xaeZ5Hp9uzxqV2iEKpif3u47jZVE9Kzwcg7/XMXYLQ4kO9wolyLer8
 0zhW0v7laBmw/0E2kjJqptJmv/cR4bzcJMGKj1kHPTKrauNaO9M5wNzsctLbEFwQMJL+
 tre/PwHdVLNlSwhaB+1Lrj8HURZ2cMkU8KiU5ejWfYgvAcxLNwBa+D+KqNUWt6pmKI1F
 fAPY0ke2oQpifRQL8jkkyxEHPjai/pJUeTyF6winWYatPkpt8KOf5Cv6mnxUo1ay5aiz
 5EeiW7B9wEp+5yFam6sLMbNzFmttLbS/HVouFnIAP55smHU5v3/evEERBVflNK/ZNmU3
 Sx1g==
X-Gm-Message-State: AOAM532wKbA8ywj7C4klnWt1RGFvv5Y0CZswTfXnUU/+gkNS8Lr9ele9
 mG40eq08IMjkk4r8qv2/1YPZPSome8s=
X-Google-Smtp-Source: ABdhPJyBb+BZ4B0OhPVVmPjn5giuL9o6HUt+PvhujlkT+7UH4fIPvleAxLIx77LWy555RwFhIIwXvw==
X-Received: by 2002:aa7:d785:: with SMTP id s5mr11738576edq.154.1599991539070; 
 Sun, 13 Sep 2020 03:05:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:9c8:f845:9041:a5ee])
 by smtp.gmail.com with ESMTPSA id
 g11sm6690286edj.85.2020.09.13.03.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 03:05:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] configure: early test for Python
Date: Sun, 13 Sep 2020 12:05:33 +0200
Message-Id: <20200913100534.22084-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913100534.22084-1-pbonzini@redhat.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 configure | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index beae010e39..b4f5d2e272 100755
--- a/configure
+++ b/configure
@@ -1631,6 +1631,23 @@ for opt do
   esac
 done
 
+if test -n "$python"
+then
+    # Preserve python version since some functionality is dependent on it
+    python_version=$($python -c 'import sys; print("%d.%d.%d" % (sys.version_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)
+
+    # Suppress writing compiled files
+    python="$python -B"
+
+    # Note that if the Python conditional here evaluates True we will exit
+    # with status 1 which is a shell 'false' value.
+    if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
+        print_error "Cannot use '$python', Python >= 3.5 is required." \
+            "Use --python=/path/to/python to specify a supported Python."
+        python=
+    fi
+fi
+
 firmwarepath="${firmwarepath:-$prefix/share/qemu-firmware}"
 libdir="${libdir:-$prefix/lib}"
 libexecdir="${libexecdir:-$prefix/libexec}"
@@ -1962,19 +1979,6 @@ then
     error_exit "Python not found. Use --python=/path/to/python"
 fi
 
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
-  error_exit "Cannot use '$python', Python >= 3.5 is required." \
-      "Use --python=/path/to/python to specify a supported Python."
-fi
-
-# Preserve python version since some functionality is dependent on it
-python_version=$($python -c 'import sys; print("%d.%d.%d" % (sys.version_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)
-
-# Suppress writing compiled files
-python="$python -B"
-
 if test -z "$meson"; then
     if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.1; then
         meson=meson
-- 
2.26.2



