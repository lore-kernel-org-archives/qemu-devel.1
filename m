Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52492C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44B52225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhxI9alG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B52225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxVL-00034t-Eb
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQh-000677-A9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUxQe-0000yQ-6K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603222572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N00sznQw1fc3FzISv2Kqoi2O4X0SNyxs5vwWVLwNv90=;
 b=bhxI9alGC4UHRe/W9/hPjjPvRWokXy6mG9izCymwQh0klXkloOj5ChO5nR4QXAOsUL5/5A
 WCjmPuwesTwpqHsWDfZNkkMr2VlLOg9sGVkCsRZbE8BK4A4aA/24AX4fuGFjFRaPHLmVoV
 CqmINp/AoPEkRLxsou9NB6o4vay71HY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-IWrSV4rqOnq-CBtoSzGrqg-1; Tue, 20 Oct 2020 15:36:10 -0400
X-MC-Unique: IWrSV4rqOnq-CBtoSzGrqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B73D1006C8E;
 Tue, 20 Oct 2020 19:36:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85A465C1C2;
 Tue, 20 Oct 2020 19:36:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/15] python: add VERSION file
Date: Tue, 20 Oct 2020 15:35:43 -0400
Message-Id: <20201020193555.1493936-4-jsnow@redhat.com>
In-Reply-To: <20201020193555.1493936-1-jsnow@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python infrastructure as it exists today is not capable reliably of
single-sourcing a package version from a parent directory. The authors
of pip are working to correct this, but as of today this is not possible
to my knowledge.

The problem is that when using pip to build and install a python
package, it copies files over to a temporary directory and performs its
build there. This loses access to any information in the parent
directory, including git itself.

Further, Python versions have a standard (PEP 440) that may or may not
follow QEMU's versioning. In general, it does; but naturally QEMU does
not follow PEP 440. To avoid any automatically-generated conflict, a
manual version file is preferred.


I am proposing:

- Python tooling follows the QEMU version, indirectly, but with a major
  version of 0 to indicate that the API is not expected to be
  stable. This would mean version 0.5.2.0, 0.5.1.1, 0.5.3.0, etc.

- In the event that a Python package needs to be updated independently
  of the QEMU version, a pre-release alpha version should be preferred,
  but *only* after inclusion to the qemu development or stable branches.

  e.g. 0.5.2.0a1, 0.5.2.0a2, and so on should be preferred prior to
  5.2.0's release.

- The Python core tooling makes absolutely no version compatibility
  checks or constraints. It *may* work with releases of QEMU from the
  past or future, but it is not required to.

  i.e., "qemu.machine" will always remain in lock-step with QEMU.

- We reserve the right to split the qemu package into independently
  versioned subpackages at a later date. This might allow for us to
  begin versioning QMP independently from QEMU at a later date, if
  we so choose.


Implement this versioning scheme by adding a VERSION file and setting it
to 0.5.2.0a1.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/VERSION   | 1 +
 python/setup.cfg | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 python/VERSION

diff --git a/python/VERSION b/python/VERSION
new file mode 100644
index 0000000000..ceef7e1ad0
--- /dev/null
+++ b/python/VERSION
@@ -0,0 +1 @@
+0.5.2.0a1
diff --git a/python/setup.cfg b/python/setup.cfg
index 12b99a796e..260f7f4e94 100755
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -1,5 +1,6 @@
 [metadata]
 name = qemu
+version = file:VERSION
 maintainer = QEMU Developer Team
 maintainer_email = qemu-devel@nongnu.org
 url = https://www.qemu.org/
-- 
2.26.2


