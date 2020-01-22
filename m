Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE24C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABB420663
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5DbkeSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABB420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu4sW-0005Ok-P1
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iu4or-0001ZY-Tz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iu4oq-0004V4-QS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iu4oq-0004Um-C3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579656512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16m8CWi1RicKeiu7hQtFCqvb3TfpjKb/WXBT4ZKDVKQ=;
 b=T5DbkeSZ4KaOKJxu6rjWYnVm1w+IG1+6SElj7CnwDOezdoVfgXXP+iuPqyOo0dLvM8+zUw
 ydFgIytyFbpYFrRMe+9i2Q2G5GGdryEc8bNubj+GdBrsp9NdauPKFLM5erTMWpPeMhhY5i
 TC68HtmEL5s1kPQstlxKfzgjfhsN5bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-TYJtqCdTMCmY8qItF7N2Ug-1; Tue, 21 Jan 2020 20:28:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 576461854336;
 Wed, 22 Jan 2020 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-78.gru2.redhat.com
 [10.97.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6504985736;
 Wed, 22 Jan 2020 01:28:21 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
Date: Tue, 21 Jan 2020 22:27:53 -0300
Message-Id: <20200122012753.9846-5-wainersm@redhat.com>
In-Reply-To: <20200122012753.9846-1-wainersm@redhat.com>
References: <20200122012753.9846-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TYJtqCdTMCmY8qItF7N2Ug-1
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
Cc: philmd@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some acceptance tests require KVM or they are skipped. Travis
enables nested virtualization by default with Ubuntu
18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
changed the acceptance builder to run in a Bionic VM. Also
it was needed to ensure the current user has rw permission
to /dev/kvm.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..c3edd0a907 100644
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
+  - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; then
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
2.23.0


