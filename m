Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC134C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33A20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSO+6to6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vqN-0006EX-Sq
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpO-0004Ri-2U
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpM-0006pb-GI
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpM-0006pI-CP
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlrLFwmr5Efn4/6uQft88TeIT1BpfwscrbQaYL0i6ys=;
 b=VSO+6to6b676BIx09iU4YqG33Dukjgg5+WZeZ9eIkCEkMc16l2vmi6wkAktUJKj6yTFMSd
 chgrdPXAuj/21cBfeBflVBMyRFf2BNmawAWurTBVClOTO09plzLiOdh01rAf98CkIpV3dX
 Y9UXV/DgdEoW/nPbr6eUhEObyZbdGhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-sX-PbDNLN0OoWsejSuTRXQ-1; Sat, 15 Feb 2020 06:41:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878558017CC;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 319E45D9CD;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 315C911366D0; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] qga/qapi-schema.json: Fix indent level on doc comments
Date: Sat, 15 Feb 2020 12:41:22 +0100
Message-Id: <20200215114133.15097-8-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sX-PbDNLN0OoWsejSuTRXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The current doc generation doesn't care much about indentation levels,
but we would like to switch to an rST format, and rST does care about
indentation.

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
Message-Id: <20200213175647.17628-6-peter.maydell@linaro.org>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 23ce6af597..7661b2b3b4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -416,7 +416,7 @@
 # Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined below=
)
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
 # Returns: Number of file systems currently frozen. On error, all filesyst=
ems
-# will be thawed. If no filesystems are frozen as a result of this call,
-# then @guest-fsfreeze-status will remain "thawed" and calling
-# @guest-fsfreeze-thaw is not necessary.
+#          will be thawed. If no filesystems are frozen as a result of thi=
s call,
+#          then @guest-fsfreeze-status will remain "thawed" and calling
+#          @guest-fsfreeze-thaw is not necessary.
 #
 # Since: 0.15.0
 ##
@@ -455,7 +455,7 @@
 #               Invalid mount points are ignored.
 #
 # Returns: Number of file systems currently frozen. On error, all filesyst=
ems
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
+#           Minimum contiguous free range to discard, in bytes. Free range=
s
+#           smaller than this may be ignored (this is a hint and the guest
+#           may not respect it).  By increasing this value, the fstrim
+#           operation will complete more quickly for filesystems with badl=
y
+#           fragmented free space, although not all blocks will be discard=
ed.
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
 # Returns: The list of all VCPUs the guest knows about. Each VCPU is put o=
n the
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
+#          Each memory block is put on the list exactly once, but their or=
der
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
=20
 ##
 # @GuestUser:
-# @user:       Username
-# @domain:     Logon domain (windows only)
+# @user: Username
+# @domain: Logon domain (windows only)
 # @login-time: Time of login of this user on the computer. If multiple
 #              instances of the user are logged in, the earliest login tim=
e is
 #              reported. The value is in fractional seconds since epoch ti=
me.
@@ -1156,10 +1156,10 @@
 ##
 # @GuestTimezone:
 #
-# @zone:    Timezone name. These values may differ depending on guest/OS a=
nd
-#           should only be used for informational purposes.
-# @offset:  Offset to UTC in seconds, negative numbers for time zones west=
 of
-#           GMT, positive numbers for east
+# @zone: Timezone name. These values may differ depending on guest/OS and
+#        should only be used for informational purposes.
+# @offset: Offset to UTC in seconds, negative numbers for time zones west =
of
+#          GMT, positive numbers for east
 #
 # Since: 2.10
 ##
--=20
2.21.1


