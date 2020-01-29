Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E45EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B522071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDWdewJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B522071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwZA-0006WP-Gl
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwwXr-0004nP-Bq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwwXq-0001Yu-9K
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42049
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwwXq-0001YW-6K
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580339689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sF3HvUqYhkgPxB/c4GmYV3a6wRAMkeotO1GuvvQBLGQ=;
 b=LDWdewJldOKPz5DC/XYs6XV8jjczAnoznNSqEkv2f29gUDbcYGjmeGl8WEHrWeFYQ4+zDb
 bweyHDw4zMhoQYllDf09OV0l5RPteRo1JmPdQFK+rpFLKMHQ6cPMJ83PPKccpob9LlRtZZ
 1+2BH6mcQzPFrxwMCSi81SGayzQoUHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-mK2oiHTMPHmnWiYtj7YAzQ-1; Wed, 29 Jan 2020 18:14:47 -0500
X-MC-Unique: mK2oiHTMPHmnWiYtj7YAzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB5C8017CC;
 Wed, 29 Jan 2020 23:14:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD885DA7E;
 Wed, 29 Jan 2020 23:14:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] tests/acceptance: Remove shebang header
Date: Thu, 30 Jan 2020 00:13:57 +0100
Message-Id: <20200129231402.23384-6-philmd@redhat.com>
In-Reply-To: <20200129231402.23384-1-philmd@redhat.com>
References: <20200129231402.23384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ chmod 644 $(git grep -lF '#!/usr/bin/env python' | xargs grep -L 'if =
__name__.*__main__')
  $ sed -i "/^#\!\/usr\/bin\/\(env\ \)\?python.\?$/d" $(git grep -lF '#!/=
usr/bin/env python' | xargs grep -L 'if __name__.*__main__')

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_seg_max_adjust.py  | 1 -
 tests/acceptance/x86_cpu_model_versions.py | 1 -
 2 files changed, 2 deletions(-)
 mode change 100755 =3D> 100644 tests/acceptance/virtio_seg_max_adjust.py

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
old mode 100755
new mode 100644
index 5458573138..8d4f24da49
--- a/tests/acceptance/virtio_seg_max_adjust.py
+++ b/tests/acceptance/virtio_seg_max_adjust.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Test virtio-scsi and virtio-blk queue settings for all machine types
 #
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 90558d9a71..01ff614ec2 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Basic validation of x86 versioned CPU models and CPU model aliases
 #
--=20
2.21.1


