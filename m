Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF3C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8535E20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpnApqta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8535E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vrt-0001DL-Kp
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpQ-0004Tc-28
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpO-0006rW-D3
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpO-0006qk-8a
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgBlEz7KfgSh67yVXb3ObLvSqXftzm1xPVcU1GCUJFY=;
 b=RpnApqtaxwWh70vsM4Vqa4oSb/me4qT72GeoGkBIoD1FlEgVQEDzIv9BCQCbbd2Wh+DDtL
 szgKnch4HVATu5hyTbFvfgkhqAmt3Q+5hbYRi3T52rddClIr8GTAgG4y2zga4iObM0l6Hx
 sF6MbgZtKxFA1hdkN9mV7paTKtn9abk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-fky0SArzMJadMCazjmsBNw-1; Sat, 15 Feb 2020 06:41:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1A6DB22;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 371FD60BE1;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34D3D11366D2; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] qga/qapi-schema.json: minor format fixups for rST
Date: Sat, 15 Feb 2020 12:41:23 +0100
Message-Id: <20200215114133.15097-9-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fky0SArzMJadMCazjmsBNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

We would like to switch the doc comments to rST format, and rST
requires a blank line before the start of a bulleted or enumerated
list. Two places in qapi-schema.json were missing this blank line.

Some places were using an indented line as a sort of single-item
bulleted list, which in the Texinfo output comes out all run
onto a single line; use a real bulleted list instead.

Some places unnecessarily indented lists, which confuses rST.

guest-fstrim:minimum's documentation was indented the
right amount to share a line with @minimum, but wasn't
actually doing so.

The indent on the bulleted list in the guest-set-vcpus
Returns section meant rST misindented it.

Changes to the generated Texinfo are very minor (the new
bulleted lists, and a few extra blank lines).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200213175647.17628-7-peter.maydell@linaro.org>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 94 ++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7661b2b3b4..f6fcb59f34 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -510,8 +510,7 @@
 #
 # Discard (or "trim") blocks which are not in use by the filesystem.
 #
-# @minimum:
-#           Minimum contiguous free range to discard, in bytes. Free range=
s
+# @minimum: Minimum contiguous free range to discard, in bytes. Free range=
s
 #           smaller than this may be ignored (this is a hint and the guest
 #           may not respect it).  By increasing this value, the fstrim
 #           operation will complete more quickly for filesystems with badl=
y
@@ -546,7 +545,8 @@
 # (or set its status to "shutdown") due to other reasons.
 #
 # The following errors may be returned:
-#          If suspend to disk is not supported, Unsupported
+#
+# - If suspend to disk is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -575,12 +575,14 @@
 #
 # This command does NOT return a response on success. There are two option=
s
 # to check for success:
-#   1. Wait for the SUSPEND QMP event from QEMU
-#   2. Issue the query-status QMP command to confirm the VM status is
-#      "suspended"
+#
+# 1. Wait for the SUSPEND QMP event from QEMU
+# 2. Issue the query-status QMP command to confirm the VM status is
+#    "suspended"
 #
 # The following errors may be returned:
-#          If suspend to ram is not supported, Unsupported
+#
+# - If suspend to ram is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -607,12 +609,14 @@
 #
 # This command does NOT return a response on success. There are two option=
s
 # to check for success:
-#   1. Wait for the SUSPEND QMP event from QEMU
-#   2. Issue the query-status QMP command to confirm the VM status is
-#      "suspended"
+#
+# 1. Wait for the SUSPEND QMP event from QEMU
+# 2. Issue the query-status QMP command to confirm the VM status is
+#    "suspended"
 #
 # The following errors may be returned:
-#          If hybrid suspend is not supported, Unsupported
+#
+# - If hybrid suspend is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -767,18 +771,22 @@
 # Returns: The length of the initial sublist that has been successfully
 #          processed. The guest agent maximizes this value. Possible cases=
:
 #
-#          - 0:              if the @vcpus list was empty on input. Guest =
state
-#                            has not been changed. Otherwise,
-#          - Error:          processing the first node of @vcpus failed fo=
r the
-#                            reason returned. Guest state has not been cha=
nged.
-#                            Otherwise,
-#          - < length(@vcpus): more than zero initial nodes have been proc=
essed,
-#                            but not the entire @vcpus list. Guest state h=
as
-#                            changed accordingly. To retrieve the error
-#                            (assuming it persists), repeat the call with =
the
-#                            successfully processed initial sublist remove=
d.
-#                            Otherwise,
-#          - length(@vcpus): call successful.
+#          - 0:
+#            if the @vcpus list was empty on input. Guest state
+#            has not been changed. Otherwise,
+#          - Error:
+#            processing the first node of @vcpus failed for the
+#            reason returned. Guest state has not been changed.
+#            Otherwise,
+#          - < length(@vcpus):
+#            more than zero initial nodes have been processed,
+#            but not the entire @vcpus list. Guest state has
+#            changed accordingly. To retrieve the error
+#            (assuming it persists), repeat the call with the
+#            successfully processed initial sublist removed.
+#            Otherwise,
+#          - length(@vcpus):
+#            call successful.
 #
 # Since: 1.5
 ##
@@ -1182,35 +1190,35 @@
 # @GuestOSInfo:
 #
 # @kernel-release:
-#     * POSIX: release field returned by uname(2)
-#     * Windows: build number of the OS
+# * POSIX: release field returned by uname(2)
+# * Windows: build number of the OS
 # @kernel-version:
-#     * POSIX: version field returned by uname(2)
-#     * Windows: version number of the OS
+# * POSIX: version field returned by uname(2)
+# * Windows: version number of the OS
 # @machine:
-#     * POSIX: machine field returned by uname(2)
-#     * Windows: one of x86, x86_64, arm, ia64
+# * POSIX: machine field returned by uname(2)
+# * Windows: one of x86, x86_64, arm, ia64
 # @id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "mswindows"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "mswindows"
 # @name:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "Microsoft Windows"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "Microsoft Windows"
 # @pretty-name:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
+# * POSIX: as defined by os-release(5)
+# * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
 # @version:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: long version string, e.g. "Microsoft Windows Server 2008"
+# * POSIX: as defined by os-release(5)
+# * Windows: long version string, e.g. "Microsoft Windows Server 2008"
 # @version-id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: short version identifier, e.g. "7" or "20012r2"
+# * POSIX: as defined by os-release(5)
+# * Windows: short version identifier, e.g. "7" or "20012r2"
 # @variant:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "server" or "client"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "server" or "client"
 # @variant-id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "server" or "client"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "server" or "client"
 #
 # Notes:
 #
--=20
2.21.1


