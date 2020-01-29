Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B560C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC1920702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBg5Tpo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC1920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuzj-0007Qf-3o
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwups-00075W-8Z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupq-0002Eq-VI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupq-0002Bu-FA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT+uuh6avARiNQsN/PIYvN90hkJck+KhsDfZiEfl+bE=;
 b=VBg5Tpo4BBq47qPQofUWSSWCW+BObunFpSlWOb1kybqEAjf7toBslMuTkhX40tXCw4eLS2
 LprXnZ5ldTXX74fJzL6AXHPxTJtth4jpWDAzQLBxYc+CxWMPVqAezaYR3AKalppoT/ZU8Y
 YQ97IyeJHXxabIaiveaDEI5GnXSxVDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Xo6aUt6ONDCDKsK3VPt0yQ-1; Wed, 29 Jan 2020 16:25:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78411800D4E;
 Wed, 29 Jan 2020 21:25:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB7A60BF3;
 Wed, 29 Jan 2020 21:25:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 23/29] tests/acceptance/virtio_check_params: Support the
 ppc architecture
Date: Wed, 29 Jan 2020 22:23:39 +0100
Message-Id: <20200129212345.20547-24-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Xo6aUt6ONDCDKsK3VPt0yQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can run these tests on the pSeries machines too,
we were just missing to properly parse the machine names.

Note: we have to exclude the versioned machines from QEMU 2.8
to 2.11 which fail, such:

  TestFail: machine type pseries-2.8: No Transactional Memory support in TC=
G, try appending -machine cap-htm=3Doff

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index b14cfb5958..2c14af825d 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -113,6 +113,8 @@ class VirtioMaxSegSettingsCheck(Test):
             ver =3D ver.split(".");
         elif arch =3D=3D 's390x':
             ver =3D mt[len('s390-ccw-virtio-'):].split('.')
+        elif arch.startswith('ppc'):
+            ver =3D mt[len('pseries-'):].split('.')
         else:
             raise TestCancel('Unsupported architecture: %s' % arch)
=20
@@ -131,6 +133,9 @@ class VirtioMaxSegSettingsCheck(Test):
             EXCLUDED_MACHINES +=3D ['isapc', 'microvm']
             if os.geteuid() !=3D 0:
                 EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
+        elif arch.startswith('ppc'):
+            EXCLUDED_MACHINES +=3D ['pseries-2.8', 'pseries-2.9',
+                                  'pseries-2.10', 'pseries-2.11']
         # collect all machine types except the ones in EXCLUDED_MACHINES
         with QEMUMachine(self.qemu_bin) as vm:
             if arch.startswith('mips'):
@@ -142,6 +147,8 @@ class VirtioMaxSegSettingsCheck(Test):
         for m in EXCLUDED_MACHINES:
             if m in machines:
                 machines.remove(m)
+        if arch.startswith('ppc'):
+            machines =3D [m for m in machines if m.startswith('pseries')]
=20
         for dev_type in DEV_TYPES:
             # create the list of machine types and their parameters.
--=20
2.21.1


