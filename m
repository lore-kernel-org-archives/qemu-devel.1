Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC1C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2B4206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2B4206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeou-0005ob-KV
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:53:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJeX2-0006MQ-DJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJeWu-0002Px-M4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJeWu-0002OF-5K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:35:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D67112455F;
	Thu, 25 Apr 2019 13:35:11 +0000 (UTC)
Received: from localhost (ovpn-117-82.ams2.redhat.com [10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39308194A5;
	Thu, 25 Apr 2019 13:35:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 14:35:03 +0100
Message-Id: <20190425133503.30847-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 25 Apr 2019 13:35:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
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
Cc: Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425133503.aCu4MO5NdpKNNkR__yJK0HhLk53hz7GPe_whak5wGnI@z>

At KVM Forum 2018 I gave a presentation on security in QEMU:
https://www.youtube.com/watch?v=3DYAdRf_hwxU8 (video)
https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)

This patch adds a security guide to the developer docs.  This document
covers things that developers should know about security in QEMU.  It is
just a starting point that we can expand on later.  I hope it will be
useful as a resource for new contributors and will save code reviewers
from explaining the same concepts many times.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Added mention of passthrough USB and PCI devices [philmd]
 * Reworded resource limits [philmd]
 * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]
---
 docs/devel/index.rst    |   1 +
 docs/devel/security.rst | 225 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 docs/devel/security.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index ebbab636ce..fd0b5fa387 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -20,3 +20,4 @@ Contents:
    stable-process
    testing
    decodetree
+   security
diff --git a/docs/devel/security.rst b/docs/devel/security.rst
new file mode 100644
index 0000000000..83c6fb2231
--- /dev/null
+++ b/docs/devel/security.rst
@@ -0,0 +1,225 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Security Guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Overview
+--------
+This guide covers security topics relevant to developers working on QEMU=
.  It
+includes an explanation of the security requirements that QEMU gives its=
 users,
+the architecture of the code, and secure coding practices.
+
+Security Requirements
+---------------------
+QEMU supports many different use cases, some of which have stricter secu=
rity
+requirements than others.  The community has agreed on the overall secur=
ity
+requirements that users may depend on.  These requirements define what i=
s
+considered supported from a security perspective.
+
+Virtualization Use Case
+~~~~~~~~~~~~~~~~~~~~~~~
+The virtualization use case covers cloud and virtual private server (VPS=
)
+hosting, as well as traditional data center and desktop virtualization. =
 These
+use cases rely on hardware virtualization extensions to execute guest co=
de
+safely on the physical CPU at close-to-native speed.
+
+The following entities are **untrusted**, meaning that they may be buggy=
 or
+malicious:
+
+* Guest
+* User-facing interfaces (e.g. VNC, SPICE, WebSocket)
+* Network protocols (e.g. NBD, live migration)
+* User-supplied files (e.g. disk images, kernels, device trees)
+* Passthrough devices (e.g. PCI, USB)
+
+Bugs affecting these entities are evaluated on whether they can cause da=
mage in
+real-world use cases and treated as security bugs if this is the case.
+
+Non-virtualization Use Case
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Architecture
+------------
+This section describes the design principles that ensure the security
+requirements are met.
+
+Guest Isolation
+~~~~~~~~~~~~~~~
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
+Principle of Least Privilege
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+``a.img`` and not guest B's disk image file ``b.img``.
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
+Isolation mechanisms
+~~~~~~~~~~~~~~~~~~~~
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
+**unprivileged users**.  Sometimes it seems more convenient to launch QE=
MU as
+root to give it access to host devices (e.g. ``/dev/net/tun``) but this =
poses a
+huge security risk.  File descriptor passing can be used to give an othe=
rwise
+unprivileged QEMU process access to host devices without running QEMU as=
 root.
+
+**SELinux** and **AppArmor** make it possible to confine processes beyon=
d the
+traditional UNIX process and file permissions model.  They restrict the =
QEMU
+process from accessing processes and files on the host system that are n=
ot
+needed by QEMU.
+
+**Resource limits** and **cgroup controllers** provide throughput and ut=
ilization
+limits on key resources such as CPU time, memory, and I/O bandwidth.
+
+**Linux namespaces** can be used to make process, file system, and other=
 system
+resources unavailable to QEMU.  A namespaced QEMU process is restricted =
to only
+those resources that were granted to it.
+
+**Linux seccomp** is available via the QEMU ``--sandbox`` option.  It di=
sables
+system calls that are not needed by QEMU, thereby reducing the host kern=
el
+attack surface.
+
+Secure coding practices
+-----------------------
+At the source code level there are several points to keep in mind.  Both
+developers and security researchers must be aware of them so that they c=
an
+develop safe code and audit existing code properly.
+
+General Secure C Coding Practices
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Live migration
+~~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~~~~~~~~~~~~
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
2.20.1


