Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C33C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4E521479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4E521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5Fu-0000MX-J1
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:08:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BS-0004kV-1O
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BQ-0004pO-Bq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5BI-0004gS-OJ; Fri, 10 May 2019 09:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 038CE70D64;
	Fri, 10 May 2019 13:03:20 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 469711001E82;
	Fri, 10 May 2019 13:03:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:42 +0100
Message-Id: <20190510130243.8887-8-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 13:03:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] docs: add Secure Coding Practices to
 developer docs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li Qiang <liq3ea@gmail.com>, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At KVM Forum 2018 I gave a presentation on security in QEMU:
https://www.youtube.com/watch?v=3DYAdRf_hwxU8 (video)
https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)

This patch adds a guide to secure coding practices.  This document
covers things that developers should know about security in QEMU.  It is
just a starting point that we can expand on later.  I hope it will be
useful as a resource for new contributors and will save code reviewers
from explaining the same concepts many times.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20190509121820.16294-2-stefanha@redhat.com
Message-Id: <20190509121820.16294-2-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/index.rst                   |   1 +
 docs/devel/secure-coding-practices.rst | 106 +++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 docs/devel/secure-coding-practices.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index ebbab636ce..2a4ddf40ad 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -20,3 +20,4 @@ Contents:
    stable-process
    testing
    decodetree
+   secure-coding-practices
diff --git a/docs/devel/secure-coding-practices.rst b/docs/devel/secure-c=
oding-practices.rst
new file mode 100644
index 0000000000..cbfc8af67e
--- /dev/null
+++ b/docs/devel/secure-coding-practices.rst
@@ -0,0 +1,106 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Secure Coding Practices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This document covers topics that both developers and security researcher=
s must
+be aware of so that they can develop safe code and audit existing code
+properly.
+
+Reporting Security Bugs
+-----------------------
+For details on how to report security bugs or ask questions about potent=
ial
+security bugs, see the `Security Process wiki page
+<https://wiki.qemu.org/SecurityProcess>`_.
+
+General Secure C Coding Practices
+---------------------------------
+Most CVEs (security bugs) reported against QEMU are not specific to
+virtualization or emulation.  They are simply C programming bugs.  There=
fore
+it's critical to be aware of common classes of security bugs.
+
+There is a wide selection of resources available covering secure C codin=
g.  For
+example, the `CERT C Coding Standard
+<https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standar=
d>`_
+covers the most important classes of security bugs.
+
+Instead of describing them in detail here, only the names of the most im=
portant
+classes of security bugs are mentioned:
+
+* Buffer overflows
+* Use-after-free and double-free
+* Integer overflows
+* Format string vulnerabilities
+
+Some of these classes of bugs can be detected by analyzers.  Static anal=
ysis is
+performed regularly by Coverity and the most obvious of these bugs are e=
ven
+reported by compilers.  Dynamic analysis is possible with valgrind, tsan=
, and
+asan.
+
+Input Validation
+----------------
+Inputs from the guest or external sources (e.g. network, files) cannot b=
e
+trusted and may be invalid.  Inputs must be checked before using them in=
 a way
+that could crash the program, expose host memory to the guest, or otherw=
ise be
+exploitable by an attacker.
+
+The most sensitive attack surface is device emulation.  All hardware reg=
ister
+accesses and data read from guest memory must be validated.  A typical e=
xample
+is a device that contains multiple units that are selectable by the gues=
t via
+an index register::
+
+  typedef struct {
+      ProcessingUnit unit[2];
+      ...
+  } MyDeviceState;
+
+  static void mydev_writel(void *opaque, uint32_t addr, uint32_t val)
+  {
+      MyDeviceState *mydev =3D opaque;
+      ProcessingUnit *unit;
+
+      switch (addr) {
+      case MYDEV_SELECT_UNIT:
+          unit =3D &mydev->unit[val];   <-- this input wasn't validated!
+          ...
+      }
+  }
+
+If ``val`` is not in range [0, 1] then an out-of-bounds memory access wi=
ll take
+place when ``unit`` is dereferenced.  The code must check that ``val`` i=
s 0 or
+1 and handle the case where it is invalid.
+
+Unexpected Device Accesses
+--------------------------
+The guest may access device registers in unusual orders or at unexpected
+moments.  Device emulation code must not assume that the guest follows t=
he
+typical "theory of operation" presented in driver writer manuals.  The g=
uest
+may make nonsense accesses to device registers such as starting operatio=
ns
+before the device has been fully initialized.
+
+A related issue is that device emulation code must be prepared for unexp=
ected
+device register accesses while asynchronous operations are in progress. =
 A
+well-behaved guest might wait for a completion interrupt before accessin=
g
+certain device registers.  Device emulation code must handle the case wh=
ere the
+guest overwrites registers or submits further requests before an ongoing
+request completes.  Unexpected accesses must not cause memory corruption=
 or
+leaks in QEMU.
+
+Invalid device register accesses can be reported with
+``qemu_log_mask(LOG_GUEST_ERROR, ...)``.  The ``-d guest_errors`` comman=
d-line
+option enables these log messages.
+
+Live Migration
+--------------
+Device state can be saved to disk image files and shared with other user=
s.
+Live migration code must validate inputs when loading device state so an
+attacker cannot gain control by crafting invalid device states.  Device =
state
+is therefore considered untrusted even though it is typically generated =
by QEMU
+itself.
+
+Guest Memory Access Races
+-------------------------
+Guests with multiple vCPUs may modify guest RAM while device emulation c=
ode is
+running.  Device emulation code must copy in descriptors and other guest=
 RAM
+structures and only process the local copy.  This prevents
+time-of-check-to-time-of-use (TOCTOU) race conditions that could cause Q=
EMU to
+crash when a vCPU thread modifies guest RAM while device emulation is
+processing it.
--=20
2.21.0


