Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FDEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD4B206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbRdmOjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD4B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IpX-0000RB-6F
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjZ-0000KA-1m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjX-0002WJ-4G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjW-0002Qb-Sb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id b17so7802588wmb.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fLHmDYlQWfVhICZYevuL8zWZyC/V25dFeDELII/rZe0=;
 b=nbRdmOjVYe+iQDa1VUiH9cMvYBXgtoW5pQWEPpqGeiVioM1n33HMFS/UmSzWDzM5Ju
 qjjWvT11C6fIgGtWotWjMy/WjpwJdLApmGTZLT52g9UIO1jNKk92VeCPk2Dn2jkbxW0t
 HIDY3anAa0jcHaSUncmh0pJTLR75UHEQp2KkaPPETu6lfmG2QChU7NPkFkdWsx2IFaE9
 B76D514cfJzk3IVGs694et2/oLLHFE01agoIzBJVq3JmMUpQLtcp5xkDAnhi6L/MTHi6
 vJmPTeu9qI3f17b24PJ13omw5X2YDEvIcKsAftH8fqerlTzp+Sa3XnIHQvT1F5+YvfVp
 r83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fLHmDYlQWfVhICZYevuL8zWZyC/V25dFeDELII/rZe0=;
 b=hglR01z3AwIttx1gUkCX9wlTDC2Rgta3Y3sfHXBwM2CwuDUz1zckt5e1ZlknrhNhv2
 b3nWLM32PMXnOlE5rjyIktAIwmd9e5TU+t6hOSYqlBlzF4Q1qZI4aK9UbpRjF6IdRCv2
 Brz5oS7T+qMXIphBvNudq6/COJz9gkwn/j7ldo7t8KE+hicWgmyWKK0iU5a4V23HzQI4
 iqTmLCzE1phVGiBg1lumB+zfcFMT2kpQQx1VxPg4s6tNm45deDT6Le2Ogw6QdcRc6Afp
 fqCnT4sx722PXKlSc+/4crR/X4i0O7UTnc4yvBvUIxgl1RR9Onpyi9GZOdO4K/zb9XXa
 ox+w==
X-Gm-Message-State: APjAAAXStY6ZkjwAJZJufkv1SZkF6gMsjr0q7Tyh2PbtyDGQDvQZ1nwV
 aQq/qcQVYj3FQtkDzkHi7UT0CVj/wZs=
X-Google-Smtp-Source: APXvYqxzY+gNirlHFe6Hw3LMktCz1UNWii9+LvHgOX44Jfd3R1gJ9Dcex+yCTesEwg7YGdKp4sidUw==
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr6976901wmg.39.1581616617124; 
 Thu, 13 Feb 2020 09:56:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/30] qga/qapi-schema.json: Fix indent level on doc
 comments
Date: Thu, 13 Feb 2020 17:56:22 +0000
Message-Id: <20200213175647.17628-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The texinfo doc generation doesn't care much about indentation
levels, but we would like to add a rST backend, and rST does care
about indentation.

Make the doc comments more strongly consistent about indentation
for multiline constructs like:

@arg: description line 1
      description line 2

Returns: line one
         line 2

so that there is always exactly one space after the colon, and
subsequent lines align with the first.

This commit is a purely whitespace change, and it does not alter the
generated .texi files (because the texi generation code strips away
all the extra whitespace).  This does mean that we end up with some
over-length lines.

Note that when the documentation for an argument fits on a single
line like this:

@arg: one line only

then stray extra spaces after the ':' don't affect the rST output, so
I have not attempted to methodically fix them, though the preference
is a single space here too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 23ce6af597d..7661b2b3b45 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -416,7 +416,7 @@
 # Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined below)
 #
 # Note: This may fail to properly report the current state as a result of
-# some other guest processes having issued an fs freeze/thaw.
+#       some other guest processes having issued an fs freeze/thaw.
 #
 # Since: 0.15.0
 ##
@@ -431,13 +431,13 @@
 # unfreeze.
 #
 # Note: On Windows, the command is implemented with the help of a
-# Volume Shadow-copy Service DLL helper. The frozen state is limited
-# for up to 10 seconds by VSS.
+#       Volume Shadow-copy Service DLL helper. The frozen state is limited
+#       for up to 10 seconds by VSS.
 #
 # Returns: Number of file systems currently frozen. On error, all filesystems
-# will be thawed. If no filesystems are frozen as a result of this call,
-# then @guest-fsfreeze-status will remain "thawed" and calling
-# @guest-fsfreeze-thaw is not necessary.
+#          will be thawed. If no filesystems are frozen as a result of this call,
+#          then @guest-fsfreeze-status will remain "thawed" and calling
+#          @guest-fsfreeze-thaw is not necessary.
 #
 # Since: 0.15.0
 ##
@@ -455,7 +455,7 @@
 #               Invalid mount points are ignored.
 #
 # Returns: Number of file systems currently frozen. On error, all filesystems
-# will be thawed.
+#          will be thawed.
 #
 # Since: 2.2
 ##
@@ -511,12 +511,12 @@
 # Discard (or "trim") blocks which are not in use by the filesystem.
 #
 # @minimum:
-#       Minimum contiguous free range to discard, in bytes. Free ranges
-#       smaller than this may be ignored (this is a hint and the guest
-#       may not respect it).  By increasing this value, the fstrim
-#       operation will complete more quickly for filesystems with badly
-#       fragmented free space, although not all blocks will be discarded.
-#       The default value is zero, meaning "discard every free block".
+#           Minimum contiguous free range to discard, in bytes. Free ranges
+#           smaller than this may be ignored (this is a hint and the guest
+#           may not respect it).  By increasing this value, the fstrim
+#           operation will complete more quickly for filesystems with badly
+#           fragmented free space, although not all blocks will be discarded.
+#           The default value is zero, meaning "discard every free block".
 #
 # Returns: A @GuestFilesystemTrimResponse which contains the
 #          status of all trimmed paths. (since 2.4)
@@ -693,7 +693,7 @@
 # @ip-addresses: List of addresses assigned to @name
 #
 # @statistics: various statistic counters related to @name
-# (since 2.11)
+#              (since 2.11)
 #
 # Since: 1.1
 ##
@@ -743,7 +743,7 @@
 # This is a read-only operation.
 #
 # Returns: The list of all VCPUs the guest knows about. Each VCPU is put on the
-# list exactly once, but their order is unspecified.
+#          list exactly once, but their order is unspecified.
 #
 # Since: 1.5
 ##
@@ -937,8 +937,8 @@
 # This is a read-only operation.
 #
 # Returns: The list of all memory blocks the guest knows about.
-# Each memory block is put on the list exactly once, but their order
-# is unspecified.
+#          Each memory block is put on the list exactly once, but their order
+#          is unspecified.
 #
 # Since: 2.3
 ##
@@ -971,9 +971,9 @@
 # @response: the result of memory block operation.
 #
 # @error-code: the error number.
-#               When memory block operation fails, we assign the value of
-#               'errno' to this member, it indicates what goes wrong.
-#               When the operation succeeds, it will be omitted.
+#              When memory block operation fails, we assign the value of
+#              'errno' to this member, it indicates what goes wrong.
+#              When the operation succeeds, it will be omitted.
 #
 # Since: 2.3
 ##
@@ -1040,15 +1040,15 @@
 # @exited: true if process has already terminated.
 # @exitcode: process exit code if it was normally terminated.
 # @signal: signal number (linux) or unhandled exception code
-#       (windows) if the process was abnormally terminated.
+#          (windows) if the process was abnormally terminated.
 # @out-data: base64-encoded stdout of the process
 # @err-data: base64-encoded stderr of the process
-#       Note: @out-data and @err-data are present only
-#       if 'capture-output' was specified for 'guest-exec'
+#            Note: @out-data and @err-data are present only
+#            if 'capture-output' was specified for 'guest-exec'
 # @out-truncated: true if stdout was not fully captured
-#       due to size limitation.
+#                 due to size limitation.
 # @err-truncated: true if stderr was not fully captured
-#       due to size limitation.
+#                 due to size limitation.
 #
 # Since: 2.5
 ##
@@ -1131,8 +1131,8 @@
 
 ##
 # @GuestUser:
-# @user:       Username
-# @domain:     Logon domain (windows only)
+# @user: Username
+# @domain: Logon domain (windows only)
 # @login-time: Time of login of this user on the computer. If multiple
 #              instances of the user are logged in, the earliest login time is
 #              reported. The value is in fractional seconds since epoch time.
@@ -1156,10 +1156,10 @@
 ##
 # @GuestTimezone:
 #
-# @zone:    Timezone name. These values may differ depending on guest/OS and
-#           should only be used for informational purposes.
-# @offset:  Offset to UTC in seconds, negative numbers for time zones west of
-#           GMT, positive numbers for east
+# @zone: Timezone name. These values may differ depending on guest/OS and
+#        should only be used for informational purposes.
+# @offset: Offset to UTC in seconds, negative numbers for time zones west of
+#          GMT, positive numbers for east
 #
 # Since: 2.10
 ##
-- 
2.20.1


