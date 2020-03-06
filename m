Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD70C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95242051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ia7oHFmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95242051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGtR-0005mj-Un
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbl-0000YH-Hl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbk-0007tQ-Aq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbk-0007qg-3h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id a141so3186934wme.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dELmma94fIMJnBaoti3wb6dHPUqTaIQs2QH0CFvzC6Q=;
 b=Ia7oHFmxq/KVNlHoiYLmJqILSun6LVFikeMRB4EnsbPZRegEZ2Ym/uOE6QygabsW1l
 T8tuGsxqYX2zVswSQob3vY3ii/uaXJAQnmdr6s1psJhbyOS8ffwc1cGyYvJ1Dlspk+l5
 qcwyMkGw8vQ8UVzmbNwrS4aEAfXAQwn1MbJLqrapSoXb0GVj8D4SbHoePmjXLU8RHFXd
 yUBQt0TS+3Duq8o9XNFJD5GGZqwINRsscE7l8QR+3b1BdMnLLrg3HsJUKbWJgYM5SgWW
 en+orkEIaMBmCoyv5GL7p2n9hzAeNCbI/JoQBs+HASyd9oNej6sZXBakc9AdOLcznRJV
 PDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dELmma94fIMJnBaoti3wb6dHPUqTaIQs2QH0CFvzC6Q=;
 b=CwrNvPqcJ053JTI8Y8JCGNj8xvZ82zn4xN2gKsO69Znmmw5H5UqtTLqfofUb7KGxz4
 K9riV0NIBOcAyWOw8WxIPeJFvpATIDQnS+wEGiCwgKYHirxN0knKfrVnKZiTtvkBRrEI
 +jHNN96RCq3QSU8BK/COLyvs1gNvIKM5pYrz0GhIhf2Fu0K1VxqiLPsAe+bLTD8oQEaP
 06QDghoYuJdmDJTu3zbQxfj/kunXi6tgrBC0+AI6TK8rAEDePA7mI5r0OGJXzmFv5O27
 mnnMlUr/sPMs0L55jlob0N6PYmDiURbtlgEayS0GI09tSkmyG+f9a5BW1vnQPj2KYQGy
 P9tg==
X-Gm-Message-State: ANhLgQ27uIJVDgZti4vkTRbPbteiCQ2ZyDWV6RSq8yUisqiwFYBMH590
 PtB2BEvht1bQaVU+BACxy8JTp219ZHBBdg==
X-Google-Smtp-Source: ADFU+vtbK1YMze99OmKgoB0yGavushKHedDKo/OrIrvbwifEVvMmqqfIAwssYab1N26+OspRzXQAXQ==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr4885331wmk.19.1583515074709;
 Fri, 06 Mar 2020 09:17:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hxtool: Remove Texinfo generation support
Date: Fri,  6 Mar 2020 17:17:45 +0000
Message-Id: <20200306171749.10756-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the STEXI/ETEXI blocks and the Makfile rules that use them have now
been removed from the codebase. We can remove the code from the hxtool
script which handles the STEXI/ETEXI directives and the '-t' option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/hxtool | 78 +-------------------------------------------------
 1 file changed, 1 insertion(+), 77 deletions(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 0003e7b673d..7b1452f3cf1 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -7,7 +7,7 @@ hxtoh()
         case $str in
             HXCOMM*)
             ;;
-            STEXI*|ETEXI*|SRST*|ERST*) flag=$(($flag^1))
+            SRST*|ERST*) flag=$(($flag^1))
             ;;
             *)
             test $flag -eq 1 && printf "%s\n" "$str"
@@ -16,84 +16,8 @@ hxtoh()
     done
 }
 
-print_texi_heading()
-{
-    if test "$*" != ""; then
-        title="$*"
-        printf "@subsection %s\n" "${title%:}"
-    fi
-}
-
-hxtotexi()
-{
-    flag=0
-    rstflag=0
-    line=1
-    while read -r str; do
-        case "$str" in
-            HXCOMM*)
-            ;;
-            STEXI*)
-            if test $rstflag -eq 1 ; then
-                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            flag=1
-            ;;
-            ETEXI*)
-            if test $rstflag -eq 1 ; then
-                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            if test $flag -ne 1 ; then
-                printf "line %d: syntax error: expected STEXI, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            flag=0
-            ;;
-            SRST*)
-            if test $rstflag -eq 1 ; then
-                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            rstflag=1
-            ;;
-            ERST*)
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            if test $rstflag -ne 1 ; then
-                printf "line %d: syntax error: expected SRST, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            rstflag=0
-            ;;
-            DEFHEADING*)
-            print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
-            ;;
-            ARCHHEADING*)
-            print_texi_heading "$(expr "$str" : "ARCHHEADING(\(.*\),.*)")"
-            ;;
-            *)
-            test $flag -eq 1 && printf '%s\n' "$str"
-            ;;
-        esac
-        line=$((line+1))
-    done
-}
-
 case "$1" in
 "-h") hxtoh ;;
-"-t") hxtotexi ;;
 *) exit 1 ;;
 esac
 
-- 
2.20.1


