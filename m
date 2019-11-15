Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D565C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E6E20672
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PR0sXXMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E6E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeG0-0008WO-6o
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iVeEI-0006UI-Uc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iVeEH-0002kr-Na
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:13:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iVeEH-0002j9-Jx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573834427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJ8AgVP7ItkR5Ul/UyuU0SvDmcwXtFrRgDShktO4bLk=;
 b=PR0sXXMeMesGfP+mdde8TvtBdpIbx7cHGlnrFUMt8u3cAQYpgZHA8/b848VS1bImYzVA81
 Ru8YwHejIuxoPWRwT6coPy1u6bd1Hll9D+z1r9/6SecnjnU549gYCoLXQrumuxJmiAqFqv
 rmEHI2qPkO1vbF2yLbM2AwIr6DTs6PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-aT8f6FSvPE6hhFDDbNdb1w-1; Fri, 15 Nov 2019 11:13:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A4C10832A5
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 16:13:45 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADEF15ED29;
 Fri, 15 Nov 2019 16:13:44 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] docs/microvm.rst: add instructions for shutting down the
 guest
Date: Fri, 15 Nov 2019 17:13:38 +0100
Message-Id: <20191115161338.42864-3-slp@redhat.com>
In-Reply-To: <20191115161338.42864-1-slp@redhat.com>
References: <20191115161338.42864-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: aT8f6FSvPE6hhFDDbNdb1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new section explaining the particularities of the microvm
machine type for triggering a guest-initiated shut down.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 docs/microvm.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/microvm.rst b/docs/microvm.rst
index 4cf84746b9..fcf41fc1f6 100644
--- a/docs/microvm.rst
+++ b/docs/microvm.rst
@@ -106,3 +106,24 @@ disabled::
      -device virtio-blk-device,drive=3Dtest \
      -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
      -device virtio-net-device,netdev=3Dtap0
+
+
+Triggering a guest-initiated shut down
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As the microvm machine type includes just a small set of system
+devices, some x86 mechanisms for rebooting or shutting down the
+system, like sending a key sequence to the keyboard or writing to an
+ACPI register, doesn't have any effect in the VM.
+
+The recommended way to trigger a guest-initiated shut down is by
+generating a ``triple-fault``, which will cause the VM to initiate a
+reboot. Additionally, if the ``-no-reboot`` argument is present in the
+command line, QEMU will detect this event and terminate its own
+execution gracefully.
+
+Linux does support this mechanism, but by default will only be used
+after other options have been tried and failed, causing the reboot to
+be delayed by a small number of seconds. It's possible to instruct it
+to try the triple-fault mechanism first, by adding ``reboot=3Dt`` to the
+kernel's command line.
--=20
2.23.0


