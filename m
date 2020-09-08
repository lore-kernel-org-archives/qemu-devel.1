Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F4C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD402068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fznSe3kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD402068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXZV-0005d6-DP
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWN-0001G4-8T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWK-0008Ce-1J
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRfAespCf/P+adg1eAVmIUv6jcwlKRu8WgP4/uGSIIs=;
 b=fznSe3kB3yFCW33raIXYtFTEBSaUv82uo0LxXhJ0tLWLQGbyBjTg6osPOxqGzmbNMN1Cpu
 imLKAJLKapiFiBpX4zUYj633/qP+jOpDOnBqxoo8xOb9W17CFwrNyzMx8K2m1Alll53sim
 Qq+1UqLPwPV2wFdTlNLAQ9pRA4hmAc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-sB0TbduIMcChe_mtxkRvGA-1; Tue, 08 Sep 2020 02:54:20 -0400
X-MC-Unique: sB0TbduIMcChe_mtxkRvGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2EB51084D73;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53F247049D;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91926112CDE6; Tue,  8 Sep 2020 08:54:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] qapi: Fix indentation, again
Date: Tue,  8 Sep 2020 08:54:16 +0200
Message-Id: <20200908065417.3158250-5-armbru@redhat.com>
In-Reply-To: <20200908065417.3158250-1-armbru@redhat.com>
References: <20200908065417.3158250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In commit 26ec4e53f2 and similar commits we fixed the indentation
for doc comments in our qapi json files to follow a new stricter
standard for indentation, which permits only:
    @arg: description line 1
          description line 2

or:
    @arg:
    line 1
    line 2

Unfortunately since we didn't manage to get the script changes that
enforced the new style in, a variety of commits (eg df4097aeaf71,
2e4457032105) introduced new doc text which doesn't follow the new
stricter rules for indentation on multi-line doc comments.  Bring
those into line with the new rules.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200810195019.25427-3-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/audio.json      | 12 ++++++------
 qapi/block-core.json |  8 ++++----
 qapi/control.json    |  4 ++--
 qapi/machine.json    |  6 +++---
 qapi/migration.json  |  8 ++++----
 qapi/misc.json       |  4 ++--
 qapi/net.json        |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index f62bd0d7f6..3b843878d2 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -159,20 +159,20 @@
 # recording.
 #
 # @server-name: select from among several possible concurrent server instances
-# (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
+#               (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
 #
 # @client-name: the client name to use. The server will modify this name to
-# create a unique variant, if needed unless @exact-name is true (default: the
-# guest's name)
+#               create a unique variant, if needed unless @exact-name is true (default: the
+#               guest's name)
 #
 # @connect-ports: if set, a regular expression of JACK client port name(s) to
-# monitor for and automatically connect to
+#                 monitor for and automatically connect to
 #
 # @start-server: start a jack server process if one is not already present
-# (default: false)
+#                (default: false)
 #
 # @exact-name: use the exact name requested otherwise JACK automatically
-# generates a unique one, if needed (default: false)
+#              generates a unique one, if needed (default: false)
 #
 # Since: 5.1
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 55b58ba892..091f826f53 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -373,7 +373,7 @@
 #
 # Features:
 # @deprecated: Member @encryption_key_missing is deprecated.  It is
-#     always false.
+#              always false.
 #
 # Since: 0.14.0
 #
@@ -508,7 +508,7 @@
 #
 # Features:
 # @deprecated: Member @status is deprecated.  Use @recording and
-#     @locked instead.
+#              @locked instead.
 #
 # Since: 1.3
 ##
@@ -618,7 +618,7 @@
 #
 # Features:
 # @deprecated: Member @dirty-bitmaps is deprecated.  Use @inserted
-#     member @dirty-bitmaps instead.
+#              member @dirty-bitmaps instead.
 #
 # Since:  0.14.0
 ##
@@ -1646,7 +1646,7 @@
 #
 # Features:
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
-#     and @top-node instead.
+#              and @top-node instead.
 #
 # Returns: - Nothing on success
 #          - If @device does not exist, DeviceNotFound
diff --git a/qapi/control.json b/qapi/control.json
index de51e9916c..134f842baf 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -177,8 +177,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated, because its output doesn't
-#     reflect compile-time configuration.  Use 'query-qmp-schema'
-#     instead.
+#              reflect compile-time configuration.  Use 'query-qmp-schema'
+#              instead.
 #
 # Returns: A list of @EventInfo.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index abc6fd0477..0ac1880e4a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -191,8 +191,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated, because it interferes with
-#     the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
-#     interruption.
+#              the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
+#              interruption.
 #
 # Returns: a list of @CpuInfo for each virtual CPU
 #
@@ -316,7 +316,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use `device_add` instead.
-#     See the `query-hotpluggable-cpus` command for details.
+#              See the `query-hotpluggable-cpus` command for details.
 #
 # Returns: Nothing on success
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 115181f4a5..675f70bb67 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1362,7 +1362,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # Returns: nothing on success
 #
@@ -1386,7 +1386,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # Returns: nothing on success
 #
@@ -1410,7 +1410,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # The size will be rounded down to the nearest power of 2.
 # The cache size can be modified before and during ongoing migration
@@ -1436,7 +1436,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'query-migrate-parameters' instead.
+#              'query-migrate-parameters' instead.
 #
 # Returns: XBZRLE cache size in bytes
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 9d32820dc1..8cf6ebe67c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -877,8 +877,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  For changing block
-#     devices, use 'blockdev-change-medium' instead; for changing VNC
-#     parameters, use 'change-vnc-password' instead.
+#              devices, use 'blockdev-change-medium' instead; for changing VNC
+#              parameters, use 'change-vnc-password' instead.
 #
 # Returns: - Nothing on success.
 #          - If @device is not a valid block device, DeviceNotFound
diff --git a/qapi/net.json b/qapi/net.json
index ddb113e5e5..a3a1336001 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -457,7 +457,7 @@
 #
 # Since: 2.7
 #
-# @vhost-vdpa since 5.1
+#        @vhost-vdpa since 5.1
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-- 
2.26.2


