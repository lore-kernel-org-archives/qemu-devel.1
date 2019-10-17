Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C03ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEC021A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrniwuoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEC021A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6xF-0000tx-UZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FW-0004eP-3k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FV-0004Eu-4d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL6FU-0004Dy-TN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id r19so2681803wmh.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzZsouR7Din5HPLemL+hHL1mAITvyQ7Z5IcL4PnrG6E=;
 b=vrniwuoS5TL4OPYX1T0kwBjzLcJO2AKiy6Jm+2WlRhODld79Y4uQJ5I+LAU//tIOw1
 /R1TmXSp6Nw8qOEyXu1va6mFN8MT61sJrQ37Bn/IyRN5x4Y6xudlEtPD6MDA/eIcFzEi
 3XSagviyLN94Nr5TV2+X7wCu5ZRaWHhSTy9WmQqCWNhGb/IcKWc34VQfIA0cwW4859j0
 I+z05wJS4xdBy+wTGQISKTdLpGv59h4Uj3mb9sTm/3cRk09T494+cY5tXKekHrcIHZGD
 XXK818EAskRQqL6og+Z125aXp5ur++Hi9+cgJ9Qknmy22fqwl9cebYiSvMgN1Z1K/BVB
 1OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzZsouR7Din5HPLemL+hHL1mAITvyQ7Z5IcL4PnrG6E=;
 b=VHunjzdrged3vuFGJR429jVJXqMhBYL5vn0eRtLtwNmDXAgooy1nhaslP4z3l1D2iD
 Jo4oGerEdUNNo8cYIA8v/0GVxHMcCOqN85kLu2LLU2j2ji9+lYlGkz+r/3uZ0inrnFAE
 oHhnY2acxLTG6x3vP6LRgwiEvQGiQPLvhJuvgUujsuG/P1AKR7H6pdOO8e/CY5Wn70xX
 4FV4nyxKkEOcj4WdEFoY1/SuYj5zZtc4DODtqS+gzMDaMDyTRH7chKXPP2k+DU/P4oqS
 HV++vu7KjI9gNblHe+k6zS9r8VXhmPkhPXfNyJL7wbEkRwhW45CUBEnMofsd6kskOG3V
 9Pwg==
X-Gm-Message-State: APjAAAUqz9SGSpSl9P8N0tmJ0aYlIv2Xl9VGD9xCrtHrm7naP9ced9AY
 cXs8rUrQ5KV0NtNQuj3iGeXHWQ==
X-Google-Smtp-Source: APXvYqx1ARJJccZnz8duKOvKdxuhk4T+NA/tQwu+QMvR/HBIF4SQ+abaU6nR0FE6PiKTj8Shxek/og==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr2823247wmj.110.1571320525600; 
 Thu, 17 Oct 2019 06:55:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u2sm1998056wml.44.2019.10.17.06.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:55:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 27DF11FF91;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 35/54] configure: add --enable-plugins
Date: Thu, 17 Oct 2019 14:15:56 +0100
Message-Id: <20191017131615.19660-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the basic boilerplate feature enable option for the build.
We shall expand it later.

[AJB: split from larger patch]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 412b1e13af..65cfd6c403 100755
--- a/configure
+++ b/configure
@@ -497,6 +497,7 @@ libxml2=""
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+plugins="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1524,6 +1525,10 @@ for opt do
   ;;
   --disable-xkbcommon) xkbcommon=no
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1705,6 +1710,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6432,6 +6439,7 @@ echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "plugin support    $plugins"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7259,6 +7267,11 @@ if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.20.1


