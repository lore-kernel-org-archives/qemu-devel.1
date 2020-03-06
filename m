Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61203C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE222051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvJ06ed7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE222051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGtI-0005Ys-88
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbk-0000W4-Ln
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbj-0007qY-E4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbj-0007mk-2K
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:55 -0500
Received: by mail-wr1-x443.google.com with SMTP id x7so3284715wrr.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/AwZc7g9eMUorN93TpjXyaUPzRm4sHdMxZ1jOCWcens=;
 b=yvJ06ed7UwfWL46WM7Z9OpMc4c0c592rAVH6EI8Qc50Xp6Tdds9VZN/pVX5xMErKCW
 KGt7lq3Zeg0d0h3k3dIgkb2bLzYfx1BTkpAazYMiSkAHBjChFvLVd4SCV5pWbPEX3lOP
 9yw5+Y2Ut1U4vD5OT76WMfRQcNfKT2gAolnqdiUI0P7ahne+0VUjkywWIcDEdS+ITE5W
 jzlZSPeMpEJ0kjo7RS0mNHFrz7ul4HKX7wGAHS4DtP8mqu/NxkV+cC8EgQ7yRv+eCLN0
 +wuze6bTBX83Wi77cu4vdUhSvXjLF51xhq/kIBCpmWR1fgiPLO7kbxMNV1om0LWYoeXV
 6SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/AwZc7g9eMUorN93TpjXyaUPzRm4sHdMxZ1jOCWcens=;
 b=CsMHSPwNaa1Gfsi1BJhJoMuCs9qPo3CJwRJ19m/ubwPXrMAqN8eps3Y0MguCGBcvp9
 RDq0jCOevffUY8KtVuAA9s56wlUcufZB0+aFHgZRU+/HCLo2s5Z5odIbvLX9BhC2fdyO
 bpUyaz5JUhHZu4xh6yMxxFd8igAC3ChRXJOy2aBpArZd+Mor1/VY1mNW3Mj6VqibYqd0
 osCZDszSA1jDMU9HS/zeHuBseqBNKev6uDVlN/WfPcCK70EvtAwMrW4Krhr6OD16mo3b
 tFo6MT+vpjwV3de6O8iPK8NFmVPfZeC05OPhKAev0yi17xSv4gWB3qYcjQlbMOFjoOjY
 tfLw==
X-Gm-Message-State: ANhLgQ2pH+hJplFB6xUZvVRXjQ/EsfgNReFwLvaukzgKpHXFv9+RXRDG
 Nd77K2CbJ5N0iqqyZmCtpMy4m4iZD2gKvw==
X-Google-Smtp-Source: ADFU+vvU78fnkmg2hJXTYscDiAA1sC0o3Bj3JyAGgPG2I17vVykAl248P2gGwq0djkoqUN0+HpiP2A==
X-Received: by 2002:adf:e803:: with SMTP id o3mr4895907wrm.110.1583515073691; 
 Fri, 06 Mar 2020 09:17:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] Update comments in .hx files that mention Texinfo
Date: Fri,  6 Mar 2020 17:17:44 +0000
Message-Id: <20200306171749.10756-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Update the header comments in .hx files that mention STEXI/ETEXI
markup; this is now SRST/ERST as all these files have been
converted to rST.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hmp-commands-info.hx | 8 ++++----
 hmp-commands.hx      | 8 ++++----
 qemu-options.hx      | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 499d6d54b01..ca5198438de 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -1,9 +1,9 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
 HXCOMM monitor info commands
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 HXCOMM
 HXCOMM In this file, generally SRST fragments should have two extra
 HXCOMM spaces of indent, so that the documentation list item for "info foo"
diff --git a/hmp-commands.hx b/hmp-commands.hx
index eb3d1605fd6..d33ff367da3 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1,9 +1,9 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
 HXCOMM monitor commands
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 
 
     {
diff --git a/qemu-options.hx b/qemu-options.hx
index f9fefd43be9..1d8f852d896 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1,10 +1,10 @@
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
 HXCOMM DEF(option, HAS_ARG/0, opt_enum, opt_help, arch_mask) is used to
 HXCOMM construct option structures, enums and help message for specified
 HXCOMM architectures.
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
 
 DEFHEADING(Standard options:)
 
-- 
2.20.1


