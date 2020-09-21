Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9DC4346F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C04220B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aLmMk7A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPgC-0005f9-Dq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKPeF-0004nk-P8; Mon, 21 Sep 2020 13:30:43 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKPe9-0007KW-VZ; Mon, 21 Sep 2020 13:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=JmcDG1B5/8OdVbH+Fhn5Lce2tHZEcej0OECmsnc39bE=; 
 b=aLmMk7A+k/UNGcZ29MYuhaoqJkcC+mjiSwxcrJNaK91+Qls/BCUMUnq29YX7MQdg4zegHPZ0gHkyhnz6HpTY81mQ96wIcCFlRzilQ3LHmLXbpeC7i+COAJamz/Ox5PZ9tj53RgNdlETLaCR0ucdkxLv55wBpvhkqP7OybXVk/uegWDWS/mKxumiHnEj4Ft7Z5/yEdRpTZQjvmWd31UK+TIxXY2HRAKY67DKZYcRuKA/yBUkFbSTs4SdI6R6ZiprLeWN4OS6x+giYa2gU6m8EZtdBPAGnCD0dtuqHYb7PobcHMrzQIS3GCaZeypmOBV917fLgjbWU9nKlAw2HbAZBFw==;
Received: from [81.0.34.134] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kKPe5-0006qU-Aw; Mon, 21 Sep 2020 19:30:33 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kKPdq-0007HJ-75; Mon, 21 Sep 2020 19:30:18 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: Document the throttle block filter
Date: Mon, 21 Sep 2020 19:30:16 +0200
Message-Id: <20200921173016.27935-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 13:30:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This filter was added back in 2017 for QEMU 2.11 but it was never
properly documented, so let's explain how it works and add a couple of
examples.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 docs/throttle.txt | 107 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/docs/throttle.txt b/docs/throttle.txt
index cd4e109d39..c06d1b9662 100644
--- a/docs/throttle.txt
+++ b/docs/throttle.txt
@@ -1,6 +1,6 @@
 The QEMU throttling infrastructure
 ==================================
-Copyright (C) 2016 Igalia, S.L.
+Copyright (C) 2016,2020 Igalia, S.L.
 Author: Alberto Garcia <berto@igalia.com>
 
 This work is licensed under the terms of the GNU GPL, version 2 or
@@ -253,3 +253,108 @@ up. After those 60 seconds the bucket will have leaked 60 x 100 =
 
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
+Note however that this not stable API (hence the 'x-' prefixes) and
+can change or disappear in the future.
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
2.20.1


