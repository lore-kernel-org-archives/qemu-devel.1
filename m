Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0BC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0E820720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3tbvbeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0E820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Am1-0005YN-4H
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j0Akp-0004Ni-IH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j0Akn-0004ch-4v
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:01:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j0Akm-0004Zy-RM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581109292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hlc+KmO+1zzUZodX6J88V1JV1ytPTiyq1CQSY00L/1c=;
 b=T3tbvbeCo2YTt72bqmx6kAZwQxfgd9zI7OvTDIoZdxM3GRar1xH6KiRACtbdw3BoWKjsoR
 J+eRfYnudFvQ93PvzIrKldpdNDdXf57p6uYiMJOsX79mo6x0HLEYtXv7xDP4j3opBQ2Xk7
 JQd8UYpSuems6ufUIi4YeJmDZ5LK934=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201--pJbZ3cTP2KgTnTp-S-nxw-1; Fri, 07 Feb 2020 16:01:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E2CDB63;
 Fri,  7 Feb 2020 21:01:29 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9955060C05;
 Fri,  7 Feb 2020 21:01:28 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] travis.yml: Fix Travis YAML configuration warnings
Date: Fri,  7 Feb 2020 16:01:24 -0500
Message-Id: <20200207210124.141119-2-wainersm@redhat.com>
In-Reply-To: <20200207210124.141119-1-wainersm@redhat.com>
References: <20200207210124.141119-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -pJbZ3cTP2KgTnTp-S-nxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes the following warnings Travis has detected on the
YAML configuration:

- 'on root: missing os, using the default "linux"'
- 'on root: the key matrix is an alias for jobs, using jobs'
- 'on jobs.include.python: unexpected sequence, using the first value (3.5)=
'
- 'on jobs.include.python: unexpected sequence, using the first value (3.6)=
'

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6c0ec6cf69..b1228e9175 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,7 @@
 # The current Travis default is a VM based 16.04 Xenial on GCE
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
+os: linux
 dist: xenial
 language: c
 compiler:
@@ -113,7 +114,7 @@ after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
=20
=20
-matrix:
+jobs:
   include:
     - name: "GCC static (user)"
       env:
@@ -297,8 +298,7 @@ matrix:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
-      python:
-        - "3.5"
+      python: 3.5
=20
=20
     - name: "GCC Python 3.6 (x86_64-softmmu)"
@@ -306,8 +306,7 @@ matrix:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
-      python:
-        - "3.6"
+      python: 3.6
=20
=20
     # Acceptance (Functional) tests
--=20
2.24.1


