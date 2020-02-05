Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655DC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22325217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEA6oKY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22325217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRNF-000075-7l
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRM9-0006iX-K2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRM8-0004KG-I9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRM8-0004IC-E4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGSpo52D3fZW4+N8anSSrynW9tfxc5ispo3LN8n7cwk=;
 b=dEA6oKY/IFVTys2pOP+lgTs37lOLBxVOJLOyuBylBX1K8M1qBN8MSe3FuaQrikzyUvyThg
 UM/s49PiPUj24RkF8AUVS6j+wsUbpKA+10j1C0DdlKq+L55DLdlQYUyeblHdk88+1BYIsN
 JA1ax8MlaSG+kf2qIZi4m6bhR9KI+bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-N1omvasKNKejBFW67Drqiw-1; Wed, 05 Feb 2020 15:33:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 314CE8010F9;
 Wed,  5 Feb 2020 20:33:01 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67C47100164D;
 Wed,  5 Feb 2020 20:33:00 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 8/8] travis.yml: Enable acceptance KVM tests
Date: Wed,  5 Feb 2020 15:32:50 -0500
Message-Id: <20200205203250.30526-9-wainersm@redhat.com>
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
References: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: N1omvasKNKejBFW67Drqiw-1
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some acceptance tests require KVM or they are skipped. Travis
enables nested virtualization by default with Ubuntu
18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
changed the acceptance builder to run in a Bionic VM. Also
it was needed to ensure the current user has rw permission
to /dev/kvm.

python3.5-venv is not packaged on Bionic. So it was replaced
with python3.6-venv.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 1ae645e9fc..76fc828887 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,6 +2,7 @@
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
 dist: xenial
+sudo: true
 language: c
 compiler:
   - gcc
@@ -83,6 +84,9 @@ git:
=20
 before_script:
   - if command -v ccache ; then ccache --zero-stats ; fi
+  - if [[ -c /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; then
+        sudo chmod o+rw /dev/kvm ;
+    fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && e=
xit 1; }
 script:
@@ -272,12 +276,13 @@ matrix:
         - TEST_CMD=3D"make check-acceptance"
       after_script:
         - python3 -c 'import json; r =3D json.load(open("tests/results/lat=
est/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"=
] not in ("PASS", "SKIP")]' | xargs cat
+      dist: bionic
       addons:
         apt:
           packages:
             - python3-pil
             - python3-pip
-            - python3.5-venv
+            - python3.6-venv
             - tesseract-ocr
             - tesseract-ocr-eng
=20
--=20
2.24.1


