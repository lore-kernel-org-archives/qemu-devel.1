Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6365EC47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9372206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMdrrBc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9372206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMJm-0003M8-1d
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMHz-00016w-23
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMHw-0004Ux-De
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L//1CGUj0rBYcxSReEPLJ4l43MPjZ/l65bBuwUSb4fk=;
 b=CMdrrBc25O8hYlQNCqGP4J3QtMJoFOl7NGzj1GfzYtLZfGy1jZy8FHrX/pboFh2yktLVgR
 6RzmJ4dubEaK65jjmerP8+ZK9Xi67xGutZ5hBz/V2CH08fcDBLpZsw7LivoUypR0kz0bJZ
 vce9tWYdIJMxjy3cd2t06+vIWL7mbrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-uqOErNMsPFWiFrOwDtC0fw-1; Fri, 02 Oct 2020 10:43:56 -0400
X-MC-Unique: uqOErNMsPFWiFrOwDtC0fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07FC1084C93;
 Fri,  2 Oct 2020 14:43:54 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06F445D9D5;
 Fri,  2 Oct 2020 14:43:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/37] docs: Document the throttle block filter
Date: Fri,  2 Oct 2020 16:43:11 +0200
Message-Id: <20201002144345.253865-4-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This filter was added back in 2017 for QEMU 2.11 but it was never
properly documented, so let's explain how it works and add a couple of
examples.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200921173016.27935-1-berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/throttle.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/docs/throttle.txt b/docs/throttle.txt
index cd4e109d39..b5b78b7326 100644
--- a/docs/throttle.txt
+++ b/docs/throttle.txt
@@ -1,6 +1,6 @@
 The QEMU throttling infrastructure
 ==================================
-Copyright (C) 2016 Igalia, S.L.
+Copyright (C) 2016,2020 Igalia, S.L.
 Author: Alberto Garcia <berto@igalia.com>
 
 This work is licensed under the terms of the GNU GPL, version 2 or
@@ -253,3 +253,109 @@ up. After those 60 seconds the bucket will have leaked 60 x 100 =
 
 Also, due to the way the algorithm works, longer burst can be done at
 a lower I/O rate, e.g. 1000 IOPS during 120 seconds.
+
+
+The 'throttle' block filter
+---------------------------
+Since QEMU 2.11 it is possible to configure the I/O limits using a
+'throttle' block filter. This filter uses the exact same throttling
+infrastructure described above but can be used anywhere in the node
+graph, allowing for more flexibility.
+
+The user can create an arbitrary number of filters and each one of
+them must be assigned to a group that contains the actual I/O limits.
+Different filters can use the same group so the limits are shared as
+described earlier in "Applying I/O limits to groups of disks".
+
+A group can be created using the object-add QMP function:
+
+   { "execute": "object-add",
+     "arguments": {
+       "qom-type": "throttle-group",
+       "id": "group0",
+       "props": {
+         "limits" : {
+           "iops-total": 1000
+           "bps-write": 2097152
+         }
+       }
+     }
+   }
+
+throttle-group has a 'limits' property (of type ThrottleLimits as
+defined in qapi/block-core.json) which can be set on creation or later
+with 'qom-set'.
+
+A throttle-group can also be created with the -object command line
+option but at the moment there is no way to pass a 'limits' parameter
+that contains a ThrottleLimits structure. The solution is to set the
+individual values directly, like in this example:
+
+   -object throttle-group,id=group0,x-iops-total=1000,x-bps-write=2097152
+
+Note however that this is not a stable API (hence the 'x-' prefixes) and
+will disappear when -object gains support for structured options and
+enables use of 'limits'.
+
+Once we have a throttle-group we can use the throttle block filter,
+where the 'file' property must be set to the block device that we want
+to filter:
+
+   { "execute": "blockdev-add",
+     "arguments": {
+        "options":  {
+           "driver": "qcow2",
+           "node-name": "disk0",
+           "file": {
+              "driver": "file",
+              "filename": "/path/to/disk.qcow2"
+           }
+        }
+     }
+   }
+
+   { "execute": "blockdev-add",
+     "arguments": {
+        "driver": "throttle",
+        "node-name": "throttle0",
+        "throttle-group": "group0",
+        "file": "disk0"
+     }
+   }
+
+A similar setup can also be done with the command line, for example:
+
+   -drive driver=throttle,throttle-group=group0,
+          file.driver=qcow2,file.file.filename=/path/to/disk.qcow2
+
+The scenario described so far is very simple but the throttle block
+filter allows for more complex configurations. For example, let's say
+that we have three different drives and we want to set I/O limits for
+each one of them and an additional set of limits for the combined I/O
+of all three drives.
+
+First we would define all throttle groups, one for each one of the
+drives and one that would apply to all of them:
+
+   -object throttle-group,id=limits0,x-iops-total=2000
+   -object throttle-group,id=limits1,x-iops-total=2500
+   -object throttle-group,id=limits2,x-iops-total=3000
+   -object throttle-group,id=limits012,x-iops-total=4000
+
+Now we can define the drives, and for each one of them we use two
+chained throttle filters: the drive's own filter and the combined
+filter.
+
+   -drive driver=throttle,throttle-group=limits012,
+          file.driver=throttle,file.throttle-group=limits0
+          file.file.driver=qcow2,file.file.file.filename=/path/to/disk0.qcow2
+   -drive driver=throttle,throttle-group=limits012,
+          file.driver=throttle,file.throttle-group=limits1
+          file.file.driver=qcow2,file.file.file.filename=/path/to/disk1.qcow2
+   -drive driver=throttle,throttle-group=limits012,
+          file.driver=throttle,file.throttle-group=limits2
+          file.file.driver=qcow2,file.file.file.filename=/path/to/disk2.qcow2
+
+In this example the individual drives have IOPS limits of 2000, 2500
+and 3000 respectively but the total combined I/O can never exceed 4000
+IOPS.
-- 
2.25.4


