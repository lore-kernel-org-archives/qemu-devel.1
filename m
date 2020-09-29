Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E1CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906432076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDVb3eJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906432076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMAZ-000704-Hy
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6B-0001oR-Eu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003Sv-Dv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lGTelQT9KRDYB0pvFHIOCxQ4Sh/H0ePPpMQppP0IWM=;
 b=RDVb3eJpdyvsrI4R9E86q+K7ME8n/jEXimV9dDpS6NnOJFavSNjj1YLRh9Cn9gOKHVJpjJ
 D17oBBg0t9bSmZ/9+kR0SZCVxHId2Tuul/uGBvhyiqrxDNMSLx5mZYyv5vRSiatM1B2C4o
 xZsENIXMa7XRGeKXI14v1yIzrv4qsWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-apRKzlRNNxe4fhw8aNlhag-1; Tue, 29 Sep 2020 16:19:31 -0400
X-MC-Unique: apRKzlRNNxe4fhw8aNlhag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A538030B4;
 Tue, 29 Sep 2020 20:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3CDA5C1CF;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF01511358BF; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] qapi: Fix doc comment indentation again
Date: Tue, 29 Sep 2020 22:19:06 +0200
Message-Id: <20200929201926.2155622-10-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
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

but because the script updates that enforce this are not yet in the
tree we have had a steady trickle of subsequent changes which didn't
follow the new rules.

Fix the latest round of mis-indented doc comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-2-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Updated for commit 4c437254b807 and a83e24ba1a5]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json |   4 +-
 qapi/machine.json    |   4 +-
 qapi/migration.json  | 108 +++++++++++++++++++++----------------------
 3 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3c16f1e11d..dd77a91174 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4316,8 +4316,8 @@
 # @data-file-raw: True if the external data file must stay valid as a
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (default: false; since: 4.0)
-# @extended-l2      True to make the image have extended L2 entries
-#                   (default: false; since 5.2)
+# @extended-l2: True to make the image have extended L2 entries
+#               (default: false; since 5.2)
 # @size: Size of the virtual disk in bytes
 # @version: Compatibility level (default: v3)
 # @backing-file: File name of the backing file if a backing file
diff --git a/qapi/machine.json b/qapi/machine.json
index c061cce0e4..2c237563ea 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1001,9 +1001,11 @@
 #
 # Request the balloon driver to change its balloon size.
 #
-# @value: the target logical size of the VM in bytes
+# @value: the target logical size of the VM in bytes.
 #         We can deduce the size of the balloon using this formula:
+#
 #            logical_vm_size = vm_ram_size - balloon_size
+#
 #         From it we have: balloon_size = vm_ram_size - @value
 #
 # Returns: - Nothing on success
diff --git a/qapi/migration.json b/qapi/migration.json
index ce2216cfea..7f5e6fd681 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -681,23 +681,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
@@ -841,23 +841,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
@@ -1037,23 +1037,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
@@ -1744,9 +1744,9 @@
 # Information about current dirty page rate of vm.
 #
 # @dirty-rate: @dirtyrate describing the dirty page rate of vm
-#          in units of MB/s.
-#          If this field returns '-1', it means querying has not
-#          yet started or completed.
+#              in units of MB/s.
+#              If this field returns '-1', it means querying has not
+#              yet started or completed.
 #
 # @status: status containing dirtyrate query status includes
 #          'unstarted' or 'measuring' or 'measured'
-- 
2.26.2


