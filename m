Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90636C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E20E214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZEttwVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E20E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izknc-00017f-FX
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izkme-0000Le-Nk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izkmb-0004rs-Uo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:17:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izkmb-0004dE-QK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581009460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0SvBnboEVQmPTHDbxe9lHiUfszK3mstEgzAp1VInKfE=;
 b=WZEttwVFILX1Fr4ZaTwVMnsld3b86Utzuy9oMx8uyPN+CxubxnBE4WK5qO4PUo7vZMofRH
 VaCdCIY93lqsi1IGFehgLzmlbMWKQyFNhXfMRpCMrQkVZLGO9seIl3DM27mtcLiQPO5L+T
 vwm7FTZN/q1gpUb1tO5a8UDzgM9VMTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-L5bD7F-gMJqqAppTiL1HEg-1; Thu, 06 Feb 2020 12:17:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE521005513;
 Thu,  6 Feb 2020 17:17:23 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49E4381213;
 Thu,  6 Feb 2020 17:17:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance/virtio_check_params: Disable test
Date: Thu,  6 Feb 2020 18:17:15 +0100
Message-Id: <20200206171715.25041-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: L5bD7F-gMJqqAppTiL1HEg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test fails on various CI:

- Using QEMU 4.0:

  tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_none_a=
lias:  ERROR: 'alias-of' (0.45 s)

- On OSX

   Unexpected error in object_property_find() at qom/object.c:1201:
   qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: ca=
n't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found

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

- On S390X:

  ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio-scs=
i-pci' is not a valid device model name

Disable it for now.

Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Series fixing the errors:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
---
 tests/acceptance/virtio_check_params.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index d5f345f75e..87e6c839d1 100644
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -25,6 +25,7 @@ import logging
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu.machine import QEMUMachine
 from avocado_qemu import Test
+from avocado import skip
=20
 #list of machine types and virtqueue properties to test
 VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
@@ -116,6 +117,7 @@ class VirtioMaxSegSettingsCheck(Test):
             return True
         return False
=20
+    @skip("break multi-arch CI")
     def test_machine_types(self):
         # collect all machine types except 'none', 'isapc', 'microvm'
         with QEMUMachine(self.qemu_bin) as vm:
--=20
2.21.1


