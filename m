Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08150C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12712070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12712070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43101 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5KC-00045W-31
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:12:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BQ-0004iy-Cy
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5BO-0004nf-L4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5BK-0004ig-Oj; Fri, 10 May 2019 09:03:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F62308FC5F;
	Fri, 10 May 2019 13:03:22 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 900201001E82;
	Fri, 10 May 2019 13:03:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:43 +0100
Message-Id: <20190510130243.8887-9-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 10 May 2019 13:03:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/8] docs: add Security chapter to the
 documentation
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

This new chapter in the QEMU documentation covers the security
requirements that QEMU is designed to meet and principles for securely
deploying QEMU.

It is just a starting point that can be extended in the future with more
information.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20190509121820.16294-3-stefanha@redhat.com
Message-Id: <20190509121820.16294-3-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile           |   2 +-
 docs/security.texi | 131 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi      |   3 ++
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 docs/security.texi

diff --git a/Makefile b/Makefile
index a971247cac..4a8ae0ef95 100644
--- a/Makefile
+++ b/Makefile
@@ -976,7 +976,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt=
: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi =
\
 	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
-	docs/qemu-cpu-models.texi
+	docs/qemu-cpu-models.texi docs/security.texi
=20
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/docs/security.texi b/docs/security.texi
new file mode 100644
index 0000000000..927764f1e6
--- /dev/null
+++ b/docs/security.texi
@@ -0,0 +1,131 @@
+@node Security
+@chapter Security
+
+@section Overview
+
+This chapter explains the security requirements that QEMU is designed to=
 meet
+and principles for securely deploying QEMU.
+
+@section Security Requirements
+
+QEMU supports many different use cases, some of which have stricter secu=
rity
+requirements than others.  The community has agreed on the overall secur=
ity
+requirements that users may depend on.  These requirements define what i=
s
+considered supported from a security perspective.
+
+@subsection Virtualization Use Case
+
+The virtualization use case covers cloud and virtual private server (VPS=
)
+hosting, as well as traditional data center and desktop virtualization. =
 These
+use cases rely on hardware virtualization extensions to execute guest co=
de
+safely on the physical CPU at close-to-native speed.
+
+The following entities are untrusted, meaning that they may be buggy or
+malicious:
+
+@itemize
+@item Guest
+@item User-facing interfaces (e.g. VNC, SPICE, WebSocket)
+@item Network protocols (e.g. NBD, live migration)
+@item User-supplied files (e.g. disk images, kernels, device trees)
+@item Passthrough devices (e.g. PCI, USB)
+@end itemize
+
+Bugs affecting these entities are evaluated on whether they can cause da=
mage in
+real-world use cases and treated as security bugs if this is the case.
+
+@subsection Non-virtualization Use Case
+
+The non-virtualization use case covers emulation using the Tiny Code Gen=
erator
+(TCG).  In principle the TCG and device emulation code used in conjuncti=
on with
+the non-virtualization use case should meet the same security requiremen=
ts as
+the virtualization use case.  However, for historical reasons much of th=
e
+non-virtualization use case code was not written with these security
+requirements in mind.
+
+Bugs affecting the non-virtualization use case are not considered securi=
ty
+bugs at this time.  Users with non-virtualization use cases must not rel=
y on
+QEMU to provide guest isolation or any security guarantees.
+
+@section Architecture
+
+This section describes the design principles that ensure the security
+requirements are met.
+
+@subsection Guest Isolation
+
+Guest isolation is the confinement of guest code to the virtual machine.=
  When
+guest code gains control of execution on the host this is called escapin=
g the
+virtual machine.  Isolation also includes resource limits such as thrott=
ling of
+CPU, memory, disk, or network.  Guests must be unable to exceed their re=
source
+limits.
+
+QEMU presents an attack surface to the guest in the form of emulated dev=
ices.
+The guest must not be able to gain control of QEMU.  Bugs in emulated de=
vices
+could allow malicious guests to gain code execution in QEMU.  At this po=
int the
+guest has escaped the virtual machine and is able to act in the context =
of the
+QEMU process on the host.
+
+Guests often interact with other guests and share resources with them.  =
A
+malicious guest must not gain control of other guests or access their da=
ta.
+Disk image files and network traffic must be protected from other guests=
 unless
+explicitly shared between them by the user.
+
+@subsection Principle of Least Privilege
+
+The principle of least privilege states that each component only has acc=
ess to
+the privileges necessary for its function.  In the case of QEMU this mea=
ns that
+each process only has access to resources belonging to the guest.
+
+The QEMU process should not have access to any resources that are inacce=
ssible
+to the guest.  This way the guest does not gain anything by escaping int=
o the
+QEMU process since it already has access to those same resources from wi=
thin
+the guest.
+
+Following the principle of least privilege immediately fulfills guest is=
olation
+requirements.  For example, guest A only has access to its own disk imag=
e file
+@code{a.img} and not guest B's disk image file @code{b.img}.
+
+In reality certain resources are inaccessible to the guest but must be
+available to QEMU to perform its function.  For example, host system cal=
ls are
+necessary for QEMU but are not exposed to guests.  A guest that escapes =
into
+the QEMU process can then begin invoking host system calls.
+
+New features must be designed to follow the principle of least privilege=
.
+Should this not be possible for technical reasons, the security risk mus=
t be
+clearly documented so users are aware of the trade-off of enabling the f=
eature.
+
+@subsection Isolation mechanisms
+
+Several isolation mechanisms are available to realize this architecture =
of
+guest isolation and the principle of least privilege.  With the exceptio=
n of
+Linux seccomp, these mechanisms are all deployed by management tools tha=
t
+launch QEMU, such as libvirt.  They are also platform-specific so they a=
re only
+described briefly for Linux here.
+
+The fundamental isolation mechanism is that QEMU processes must run as
+unprivileged users.  Sometimes it seems more convenient to launch QEMU a=
s
+root to give it access to host devices (e.g. @code{/dev/net/tun}) but th=
is poses a
+huge security risk.  File descriptor passing can be used to give an othe=
rwise
+unprivileged QEMU process access to host devices without running QEMU as=
 root.
+It is also possible to launch QEMU as a non-root user and configure UNIX=
 groups
+for access to @code{/dev/kvm}, @code{/dev/net/tun}, and other device nod=
es.
+Some Linux distros already ship with UNIX groups for these devices by de=
fault.
+
+@itemize
+@item SELinux and AppArmor make it possible to confine processes beyond =
the
+traditional UNIX process and file permissions model.  They restrict the =
QEMU
+process from accessing processes and files on the host system that are n=
ot
+needed by QEMU.
+
+@item Resource limits and cgroup controllers provide throughput and util=
ization
+limits on key resources such as CPU time, memory, and I/O bandwidth.
+
+@item Linux namespaces can be used to make process, file system, and oth=
er system
+resources unavailable to QEMU.  A namespaced QEMU process is restricted =
to only
+those resources that were granted to it.
+
+@item Linux seccomp is available via the QEMU @option{--sandbox} option.=
  It disables
+system calls that are not needed by QEMU, thereby reducing the host kern=
el
+attack surface.
+@end itemize
diff --git a/qemu-doc.texi b/qemu-doc.texi
index ae3c3f9632..577d1e8376 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -38,6 +38,7 @@
 * QEMU Guest Agent::
 * QEMU User space emulator::
 * System requirements::
+* Security::
 * Implementation notes::
 * Deprecated features::
 * Supported build platforms::
@@ -2878,6 +2879,8 @@ added with Linux 4.5 which is supported by the majo=
r distros. And even
 if RHEL7 has kernel 3.10, KVM there has the required functionality there
 to make it close to a 4.5 or newer kernel.
=20
+@include docs/security.texi
+
 @include qemu-tech.texi
=20
 @include qemu-deprecated.texi
--=20
2.21.0


