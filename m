Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633BC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2092E2187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4YgZUzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2092E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdtA-0005ks-99
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSdpZ-0004XD-Q1
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSdpX-0000go-8u
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:11:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSdpW-0000XS-4a
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573117909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsFzovN8bI9jF8FoLsqMnE4/z2gxo0zuYOLROPK9jRk=;
 b=J4YgZUzrKLV6zHEmsKZjN+OjFUDM1sg/fw6aotqogJJH9Lq8akauKHGMVn5mX0kK1/wSNP
 8e1k0DXNmf9XLVPNMgBQ+/TgJX+IjcBPy2KVZGNATlklojs1o233ztgrCDutXJ9uPxEwtO
 0J00HKfpzOWCx0IPhr6QO+LG3WBvBCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-GevHbLAMOq2CLX2nqX2G0g-1; Thu, 07 Nov 2019 04:11:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80641477;
 Thu,  7 Nov 2019 09:11:44 +0000 (UTC)
Received: from localhost (ovpn-117-109.ams2.redhat.com [10.36.117.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06B9B600F0;
 Thu,  7 Nov 2019 09:11:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] Add device fuzzing blog post
Date: Thu,  7 Nov 2019 10:11:36 +0100
Message-Id: <20191107091136.359965-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GevHbLAMOq2CLX2nqX2G0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Thomas Huth <thuth@redhat.com>, megele@bu.edu,
 Alexander Oleinik <alxndr@bu.edu>, bsd@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This blog post covers the device fuzzing GSoC project that Alexander
Olenik did in 2019.

Cc: Alexander Oleinik <alxndr@bu.edu>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 _posts/2019-11-07-device-fuzzing.md |  73 ++++++++++++++++++++++++++++
 screenshots/fuzzing-intro.png       | Bin 0 -> 66276 bytes
 screenshots/fuzzing.png             | Bin 0 -> 100281 bytes
 3 files changed, 73 insertions(+)
 create mode 100644 _posts/2019-11-07-device-fuzzing.md
 create mode 100644 screenshots/fuzzing-intro.png
 create mode 100644 screenshots/fuzzing.png

diff --git a/_posts/2019-11-07-device-fuzzing.md b/_posts/2019-11-07-device=
-fuzzing.md
new file mode 100644
index 0000000..2881068
--- /dev/null
+++ b/_posts/2019-11-07-device-fuzzing.md
@@ -0,0 +1,73 @@
+---
+layout: post
+title:  "Fuzzing QEMU Device Emulation"
+date:   2019-11-07 07:50:00 +0200
+categories: [fuzzing, gsoc, internships]
+---
+QEMU (https://www.qemu.org/) emulates a large number of network cards, dis=
k
+controllers, and other devices needed to simulate a virtual computer syste=
m,
+called the "guest".
+
+The guest is untrusted and QEMU may even be used to run malicious
+software, so it is important that bugs in emulated devices do not
+allow the guest to compromise QEMU and escape the confines of the
+guest. For this reason a Google Summer of Code project was undertaken
+to develop fuzz tests for emulated devices.
+
+![QEMU device emulation attack surface](/screenshots/fuzzing-intro.png)
+
+Fuzzing is a testing technique that feeds random inputs to a program
+in order to trigger bugs. Random inputs can be generated quickly
+without relying on human guidance and this makes fuzzing an automated
+testing approach.
+
+## Device Fuzzing
+Emulated devices are exposed to the guest through a set of registers
+and also through data structures located in guest RAM that are
+accessed by the device in a process known as Direct Memory Access
+(DMA). Fuzzing emulated devices involves mapping random inputs to the
+device registers and DMA memory structures in order to explore code
+paths in QEMU's device emulation code.
+
+![Device fuzzing overview](/screenshots/fuzzing.png)
+
+Fuzz testing discovered an assertion failure in the virtio-net network
+card emulation code in QEMU that can be triggered by a guest. Fixing
+such bugs is usually easy once fuzz testing has generated a reproducer.
+
+Modern fuzz testing intelligently selects random inputs such that new
+code paths are explored and previously-tested code paths are not
+tested repeatedly. This is called coverage-guided fuzzing and
+involves an instrumented program executable so the fuzzer can detect
+the code paths that are taken for a given input. This was
+surprisingly effective at automatically exploring the input space of
+emulated devices in QEMU without requiring the fuzz test author to
+provide detailed knowledge of device internals.
+
+## How Fuzzing was Integrated into QEMU
+Device fuzzing in QEMU is driven by the open source libfuzzer library
+(https://llvm.org/docs/LibFuzzer.html). A special build of QEMU
+includes device emulation fuzz tests and launches without running a
+normal guest. Instead the fuzz test directly programs device
+registers and stores random data into DMA memory structures.
+
+The next step for the QEMU project will be to integrate fuzzing into
+Google's OSS-Fuzz (https://google.github.io/oss-fuzz/) continuous
+fuzzing service. This will ensure that fuzz tests are automatically
+run after new code is merged into QEMU and bugs are reported to the
+community.
+
+## Conclusion
+Fuzzing emulated devices has already revealed bugs in QEMU that would
+have been time-consuming to find through manual testing approaches.
+So far only a limited number of devices have been fuzz-tested and we
+hope to increase this number now that the foundations have been laid.
+The goal is to integrate these fuzz tests into OSS-Fuzz so that fuzz
+testing happens continuously.
+
+This project would not have been possible without Google's generous
+funding of Google Summer of Code. Alexander Oleinik developed the
+fuzzing code and was mentored by Bandan Das, Paolo Bonzini, and Stefan
+Hajnoczi.
+
+This article was contributed by Stefan Hajnoczi and Alexander Oleinik.
diff --git a/screenshots/fuzzing-intro.png b/screenshots/fuzzing-intro.png
new file mode 100644
index 0000000..e130027
Binary files /dev/null and b/screenshots/fuzzing-intro.png differ
diff --git a/screenshots/fuzzing.png b/screenshots/fuzzing.png
new file mode 100644
index 0000000..2f15ecb
Binary files /dev/null and b/screenshots/fuzzing.png differ
--=20
2.23.0


