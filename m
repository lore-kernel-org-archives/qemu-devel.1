Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9926BC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A5B20737
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 11:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJnPgQGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A5B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMIr-0000Mm-JF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 07:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG9-0003SU-1y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMG8-00021Y-0i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMG7-00020n-Q0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 07:44:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id a5so5753183wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=S3FP1kpG0+CD0HY1IFdcDdgzt4hFOb8Y8vdpTW5pwMc=;
 b=XJnPgQGY04SzJe3OclZjoaTdZop/gDTkE2udHAhXaBBkgEHTsrZ6SDUsx2HfVh/O57
 kjpCkJMK6FX/hhCdBhWetPwYLf1fRDIjYDdmWWbPj4Cr2u5pd44lXWfviLW2Vo0P5FU4
 HZdXiP2w1GX1FiwQwjgyMvNwn/oTrcmRZ0/cCyPjzZmPHiAa22QLvGoG2Nd4TCrXH96w
 BGJTGVcPEB/ErmK8mlW0XXwk7jRgn9Nin0sz/UtqMu53K27XELQZh+MIVGVTLYeSnk3T
 XiAyXEDE6oRR1XYOKbgC2JSCDFPG9VmpR7TrST85Y6tZPh7hfMlPV2+tberWNetkdvKS
 u2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S3FP1kpG0+CD0HY1IFdcDdgzt4hFOb8Y8vdpTW5pwMc=;
 b=mNmY8ZD0FpTOIkZ7+9K+YDlHHs/XzneYlYjd6zBy2diNOoaTTj4WGYQaquVxLOPtVj
 IWeNTzmjpqIBmMSyqK9/JlrL6bnoHWrqrqIayOLtIIBsbzhMq+mjKA4N5zJ9VfRWQ/NB
 nWxsQT3pC+oKi3fh0u9RIgU13f329z7EVcMJJwijEpaLkbnuG5xuxUkdjyzVfw2OK1kn
 OR9f42OvgCUUtFcFHWvrpE3Fys0UHE6fmz278/FldytgH4AbgspVTA8fFlh5c0siX0Ag
 LVgWSpmJb8GELeVtvsCCuFAVFcgQnaLfhaFGcABLxYCcNGEM988w/oKJ4gjycL8ZwbUN
 b8jQ==
X-Gm-Message-State: ANhLgQ3nqSgwxDT5geo/EjLiJHdyN/eNvPpxofAow7mjErqh5BVCCuFk
 MUXw5avcHVRJiyQpRBrbRUZryPUQZ8NZWg==
X-Google-Smtp-Source: ADFU+vtPlMOeJMi6VA2y0icJWvyj6HqY0KkXjC0W4oDzpW5CYObZ5Xc5cbVohuy+uUSIbXn3mXJGoQ==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr4746086wmc.52.1584013454353; 
 Thu, 12 Mar 2020 04:44:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p16sm2688564wmg.22.2020.03.12.04.44.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:44:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hxtool: Remove Texinfo generation support
Date: Thu, 12 Mar 2020 11:43:59 +0000
Message-Id: <20200312114408.16891-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
References: <20200312114408.16891-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200306171749.10756-4-peter.maydell@linaro.org
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


