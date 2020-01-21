Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A7C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69541217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbaqs1rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69541217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itywt-0004Ez-V1
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 14:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ityvA-0002Jf-Md
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ityv9-0004PF-E9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ityv9-0004Or-80
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:10:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id j42so4518258wrj.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZwxrhVFppo0vboz/j9HZKWFBkmFicMobpa/s3rMNnE=;
 b=hbaqs1rTQiRnvoCB0CHT1LLY8R99sDptJ20S8i0ScWCYKPmsnB/11qTquzol0wpeLL
 q6jSSbJF3fJKdyl7YQ8DZyK6v5h+I3vVEQZUx4FaDZtMINryCvu+eZwHJLKMfcyPX7Uq
 UogZ/NGW3lek8ccU2xsa/nhxQyysPgLSVFeHGO6PwjXuHhvzqo3x6E7CPag4qYGjYMCn
 H4XZRxmglJQdFEEOuhozHiI6dBrjT0U/mVAPRhP44lZNcgInzp/5fzSRV8KNvdkZSxhD
 /suXZS4mu6B2aMQXwgk54QCwHCA2moXiFHyWmygFK/wgd19g3CG+UvqWWEgyP7ikx/GV
 UOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZwxrhVFppo0vboz/j9HZKWFBkmFicMobpa/s3rMNnE=;
 b=Lv2ZP08HY/Dwp4EWEvA7wmyLhkJ2DI+qGcenp+WM2K6qvE+5oTUVJKumzq54xgHYKb
 vVIXX/rBXyWPNQnfzGpCM36qwKqD0fAjWbiGbH2uRmso5sHrDYVy1gRJIRmUKhWe3XKs
 0W0K4G4NrAD2UKB8RySThTF/kGI2Vcshv0DgdGEG5mXj8KXST90x4iQON2D1p9N45H4l
 lc0lKbn5DRGY9VmZbYmHj69MjXo1wbPok4bhnZu/yBGpM6o7IEcUMC8Xj7VPaBpp3H/X
 1D5+zThCzPHZojUq07f6hspALw630qBJfYaE1mslW5IEy/eyXkcXl5j7vfWBiz4a5UvA
 d+GQ==
X-Gm-Message-State: APjAAAU+1Mt/B9UUtmBIfFDtW0qhhdew91WF5PGJEHwim2W/sXaxqSF1
 j9xyNnBffoMgwer+JW4WiAco+i2M4U8J2w==
X-Google-Smtp-Source: APXvYqzXr/GKzHqavdcRoAi+uCoNU4Wq3/c/OXE2ZBLliFdu+S6Hb8UiPfOoh6C+LNZQhzLN9PyEhw==
X-Received: by 2002:adf:f605:: with SMTP id t5mr6491666wrp.282.1579633838063; 
 Tue, 21 Jan 2020 11:10:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l3sm49533271wrt.29.2020.01.21.11.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 11:10:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hxtool: Support SRST/ERST directives
Date: Tue, 21 Jan 2020 19:10:29 +0000
Message-Id: <20200121191033.28195-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200121191033.28195-1-peter.maydell@linaro.org>
References: <20200121191033.28195-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to add support for including rST document fragments
in our .hx files, in the same way we currently have texinfo
fragments. These will be delimited by SRST and ERST directives,
in the same way the texinfo is delimited by STEXI/ETEXI.
The rST fragments will not be extracted by the hxtool
script, but by a different mechanism, so all we need to
do in hxtool is have it ignore all the text inside a
SRST/ERST section, with suitable error-checking for
mismatched rST-vs-texi fragment delimiters.

The resulting effective state machine has only three states:
 * flag = 0, rstflag = 0 : reading section for C output
 * flag = 1, rstflag = 0 : reading texi fragment
 * flag = 0, rstflag = 1 : reading rST fragment
and flag = 1, rstflag = 1 is not possible. Using two
variables makes the parallel between the rST handling and
the texi handling clearer; in any case all this code will
be deleted once we've converted entirely to rST.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/hxtool | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 7d7c4289e32..0003e7b673d 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -7,7 +7,7 @@ hxtoh()
         case $str in
             HXCOMM*)
             ;;
-            STEXI*|ETEXI*) flag=$(($flag^1))
+            STEXI*|ETEXI*|SRST*|ERST*) flag=$(($flag^1))
             ;;
             *)
             test $flag -eq 1 && printf "%s\n" "$str"
@@ -27,12 +27,17 @@ print_texi_heading()
 hxtotexi()
 {
     flag=0
+    rstflag=0
     line=1
     while read -r str; do
         case "$str" in
             HXCOMM*)
             ;;
             STEXI*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
             if test $flag -eq 1 ; then
                 printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
                 exit 1
@@ -40,12 +45,38 @@ hxtotexi()
             flag=1
             ;;
             ETEXI*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
             if test $flag -ne 1 ; then
                 printf "line %d: syntax error: expected STEXI, found '%s'\n" "$line" "$str" >&2
                 exit 1
             fi
             flag=0
             ;;
+            SRST*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            if test $flag -eq 1 ; then
+                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            rstflag=1
+            ;;
+            ERST*)
+            if test $flag -eq 1 ; then
+                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            if test $rstflag -ne 1 ; then
+                printf "line %d: syntax error: expected SRST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            rstflag=0
+            ;;
             DEFHEADING*)
             print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
             ;;
-- 
2.20.1


