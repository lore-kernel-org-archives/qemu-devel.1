Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4AAC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB01420658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF/GqBQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB01420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izojh-0003oj-N4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaO-00009M-JO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaM-0004pk-R0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaL-0004ew-JH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvwnBf2n+YwQGmIuQTmd3deuxXo5e1sNUVXeiOxvALA=;
 b=OF/GqBQmG34jrYYZ9wFgtdMTix8eVt7n6t+vLi481eI4fEaQ/985zjzBzS7XdmQA0pBKvs
 sZsB/kiG01Vp+b9zLLVHZs7uZlRG8whU9oEdBsXmOa05e5FySqU3IsEYgDVLzkGp3zLE/U
 S8hVtyxDmJ0AnzlUN5xK9ojHjLHFShU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-4Vm-YrTzN-C9KYRBouZKOA-1; Thu, 06 Feb 2020 16:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5408DDB91;
 Thu,  6 Feb 2020 21:21:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA6760BEC;
 Thu,  6 Feb 2020 21:21:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/46] tests/acceptance/virtio_check_params: Disable the test
Date: Thu,  6 Feb 2020 22:19:12 +0100
Message-Id: <20200206211936.17098-23-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4Vm-YrTzN-C9KYRBouZKOA-1
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
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test fails on various CI:

- Using QEMU 4.0:
  tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_none_a=
lias:  ERROR: 'alias-of' (0.45 s)

- On OSX
  Unexpected error in object_property_find() at qom/object.c:1201:
  qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: can=
't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found

- When removing unavailable machine:
  VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x no=
t in list (0.12 s)

- Using Xen:
  xencall: error: Could not obtain handle on privileged command interface: =
No such file or directory
  xen be core: xen be core: can't open xen interface

- On PPC:
  TestFail: machine type pseries-2.8: No Transactional Memory support in TC=
G, try appending -machine cap-htm=3Doff

- On S390X configured with --without-default-devices:
  ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio-scs=
i-pci' is not a valid device model name

Disable it for now.

Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200206171715.25041-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 22792d4ec6..c3af8dbf9f 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -26,6 +26,7 @@ import logging
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu.machine import QEMUMachine
 from avocado_qemu import Test
+from avocado import skip
=20
 #list of machine types and virtqueue properties to test
 VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
@@ -117,6 +118,7 @@ class VirtioMaxSegSettingsCheck(Test):
             return True
         return False
=20
+    @skip("break multi-arch CI")
     def test_machine_types(self):
         # collect all machine types except 'none', 'isapc', 'microvm'
         with QEMUMachine(self.qemu_bin) as vm:
--=20
2.21.1


