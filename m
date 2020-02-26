Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0CC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B5F24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA9H0Evr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B5F24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v1Z-00038m-Hr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utx-0000zM-VG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utw-0006pc-0d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utv-0006l3-Nn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id j7so2493419wrp.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQCthPnR6y1TZUUgQIYVSn60kzDk9kwVXC4q84W9SeE=;
 b=MA9H0Evrqm8eXA6q2MF1l0SI8lKcIQ+XmsMFqU4mdcW3eqqMEjufRX+SjgA3rlNmrP
 FdJeR2J9ZutmG0nsXuAyTJJJ6pbK24hV2oYpSk0zToM7OSURNsjRP4EHQ8qgHFHnV9Mf
 pLT77cngrGAhR5ewcNP65H2YcLRFnkbbci+5L5fJxFmeqc06c1GyOspk1myvoMN/3g0q
 /+veChHgJAx4JY4yYTErJ3mIkh/AQaZp0rr1WLcVOq+elxirh6VUiLdSXUL0bP5rX1zI
 ZFXU0dGCtAVpiAmTKLiNvUildpzJZZyuI3rY2ezgcTvxTL9kHdA4kdPR0zMrwMc/zz6v
 OkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jQCthPnR6y1TZUUgQIYVSn60kzDk9kwVXC4q84W9SeE=;
 b=Ahp/0Davv6m7tceiRks/P4vyVtwiwPvx/QmmPS6Zv7iy3r0FZgAtStl30QDhd/jMRd
 ZZyHr9LTzE56hUXPnkbkQ0rYQqF0IDdhPaflN3hhKPzcWeOTtWOfLA+LICKdmH0anwO2
 vI8KUiA3/UWGRvaI9MBZSPlGdIu2a/rZzaLhs8iNYlvNDVUzWZwBRhrZL7hgUTlYTqxM
 uECkQnM+llWQm3laAIaUeBP7co6CDoHj5U4e62WIx5fhedouJH3QsxWnNfRvk7rV+l7V
 S4fURNBB8hgJb/K/C7j+z3+iHDEq0XuiLOukLeZetV2gRFP1iBgscN8IuQy2FZmGVETb
 Jqhg==
X-Gm-Message-State: APjAAAVVMMODHpiA2jjQxc122L6dLKuWgcJ3KSuKei0IOIphx19ur+G4
 fGo+VAEPyG73KloRULfFTrLg10Lo
X-Google-Smtp-Source: APXvYqzUjZN4OKkAcCDT3P8FR4U1ZC9UsDGaZHCbNZRHyU/xVWmNsCwmQs5XSADfXoDXFBgsqkYInQ==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr4916113wrw.194.1582716650217; 
 Wed, 26 Feb 2020 03:30:50 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] docs/system: Convert security.texi to rST format
Date: Wed, 26 Feb 2020 12:30:31 +0100
Message-Id: <20200226113034.6741-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

security.texi is included from qemu-doc.texi but is not used
in the qemu.1 manpage. So we can do a straightforward conversion
of the contents, which go into the system manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/index.rst    |   1 +
 docs/system/security.rst | 173 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 docs/system/security.rst

diff --git a/docs/system/index.rst b/docs/system/index.rst
index 21b5a18b67..d38addb2a0 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -13,3 +13,4 @@ Contents:
 
 .. toctree::
    :maxdepth: 2
+   security
diff --git a/docs/system/security.rst b/docs/system/security.rst
new file mode 100644
index 0000000000..f2092c8768
--- /dev/null
+++ b/docs/system/security.rst
@@ -0,0 +1,173 @@
+Security
+========
+
+Overview
+--------
+
+This chapter explains the security requirements that QEMU is designed to meet
+and principles for securely deploying QEMU.
+
+Security Requirements
+---------------------
+
+QEMU supports many different use cases, some of which have stricter security
+requirements than others.  The community has agreed on the overall security
+requirements that users may depend on.  These requirements define what is
+considered supported from a security perspective.
+
+Virtualization Use Case
+'''''''''''''''''''''''
+
+The virtualization use case covers cloud and virtual private server (VPS)
+hosting, as well as traditional data center and desktop virtualization.  These
+use cases rely on hardware virtualization extensions to execute guest code
+safely on the physical CPU at close-to-native speed.
+
+The following entities are untrusted, meaning that they may be buggy or
+malicious:
+
+- Guest
+- User-facing interfaces (e.g. VNC, SPICE, WebSocket)
+- Network protocols (e.g. NBD, live migration)
+- User-supplied files (e.g. disk images, kernels, device trees)
+- Passthrough devices (e.g. PCI, USB)
+
+Bugs affecting these entities are evaluated on whether they can cause damage in
+real-world use cases and treated as security bugs if this is the case.
+
+Non-virtualization Use Case
+'''''''''''''''''''''''''''
+
+The non-virtualization use case covers emulation using the Tiny Code Generator
+(TCG).  In principle the TCG and device emulation code used in conjunction with
+the non-virtualization use case should meet the same security requirements as
+the virtualization use case.  However, for historical reasons much of the
+non-virtualization use case code was not written with these security
+requirements in mind.
+
+Bugs affecting the non-virtualization use case are not considered security
+bugs at this time.  Users with non-virtualization use cases must not rely on
+QEMU to provide guest isolation or any security guarantees.
+
+Architecture
+------------
+
+This section describes the design principles that ensure the security
+requirements are met.
+
+Guest Isolation
+'''''''''''''''
+
+Guest isolation is the confinement of guest code to the virtual machine.  When
+guest code gains control of execution on the host this is called escaping the
+virtual machine.  Isolation also includes resource limits such as throttling of
+CPU, memory, disk, or network.  Guests must be unable to exceed their resource
+limits.
+
+QEMU presents an attack surface to the guest in the form of emulated devices.
+The guest must not be able to gain control of QEMU.  Bugs in emulated devices
+could allow malicious guests to gain code execution in QEMU.  At this point the
+guest has escaped the virtual machine and is able to act in the context of the
+QEMU process on the host.
+
+Guests often interact with other guests and share resources with them.  A
+malicious guest must not gain control of other guests or access their data.
+Disk image files and network traffic must be protected from other guests unless
+explicitly shared between them by the user.
+
+Principle of Least Privilege
+''''''''''''''''''''''''''''
+
+The principle of least privilege states that each component only has access to
+the privileges necessary for its function.  In the case of QEMU this means that
+each process only has access to resources belonging to the guest.
+
+The QEMU process should not have access to any resources that are inaccessible
+to the guest.  This way the guest does not gain anything by escaping into the
+QEMU process since it already has access to those same resources from within
+the guest.
+
+Following the principle of least privilege immediately fulfills guest isolation
+requirements.  For example, guest A only has access to its own disk image file
+``a.img`` and not guest B's disk image file ``b.img``.
+
+In reality certain resources are inaccessible to the guest but must be
+available to QEMU to perform its function.  For example, host system calls are
+necessary for QEMU but are not exposed to guests.  A guest that escapes into
+the QEMU process can then begin invoking host system calls.
+
+New features must be designed to follow the principle of least privilege.
+Should this not be possible for technical reasons, the security risk must be
+clearly documented so users are aware of the trade-off of enabling the feature.
+
+Isolation mechanisms
+''''''''''''''''''''
+
+Several isolation mechanisms are available to realize this architecture of
+guest isolation and the principle of least privilege.  With the exception of
+Linux seccomp, these mechanisms are all deployed by management tools that
+launch QEMU, such as libvirt.  They are also platform-specific so they are only
+described briefly for Linux here.
+
+The fundamental isolation mechanism is that QEMU processes must run as
+unprivileged users.  Sometimes it seems more convenient to launch QEMU as
+root to give it access to host devices (e.g. ``/dev/net/tun``) but this poses a
+huge security risk.  File descriptor passing can be used to give an otherwise
+unprivileged QEMU process access to host devices without running QEMU as root.
+It is also possible to launch QEMU as a non-root user and configure UNIX groups
+for access to ``/dev/kvm``, ``/dev/net/tun``, and other device nodes.
+Some Linux distros already ship with UNIX groups for these devices by default.
+
+- SELinux and AppArmor make it possible to confine processes beyond the
+  traditional UNIX process and file permissions model.  They restrict the QEMU
+  process from accessing processes and files on the host system that are not
+  needed by QEMU.
+
+- Resource limits and cgroup controllers provide throughput and utilization
+  limits on key resources such as CPU time, memory, and I/O bandwidth.
+
+- Linux namespaces can be used to make process, file system, and other system
+  resources unavailable to QEMU.  A namespaced QEMU process is restricted to only
+  those resources that were granted to it.
+
+- Linux seccomp is available via the QEMU ``--sandbox`` option.  It disables
+  system calls that are not needed by QEMU, thereby reducing the host kernel
+  attack surface.
+
+Sensitive configurations
+------------------------
+
+There are aspects of QEMU that can have security implications which users &
+management applications must be aware of.
+
+Monitor console (QMP and HMP)
+'''''''''''''''''''''''''''''
+
+The monitor console (whether used with QMP or HMP) provides an interface
+to dynamically control many aspects of QEMU's runtime operation. Many of the
+commands exposed will instruct QEMU to access content on the host file system
+and/or trigger spawning of external processes.
+
+For example, the ``migrate`` command allows for the spawning of arbitrary
+processes for the purpose of tunnelling the migration data stream. The
+``blockdev-add`` command instructs QEMU to open arbitrary files, exposing
+their content to the guest as a virtual disk.
+
+Unless QEMU is otherwise confined using technologies such as SELinux, AppArmor,
+or Linux namespaces, the monitor console should be considered to have privileges
+equivalent to those of the user account QEMU is running under.
+
+It is further important to consider the security of the character device backend
+over which the monitor console is exposed. It needs to have protection against
+malicious third parties which might try to make unauthorized connections, or
+perform man-in-the-middle attacks. Many of the character device backends do not
+satisfy this requirement and so must not be used for the monitor console.
+
+The general recommendation is that the monitor console should be exposed over
+a UNIX domain socket backend to the local host only. Use of the TCP based
+character device backend is inappropriate unless configured to use both TLS
+encryption and authorization control policy on client connections.
+
+In summary, the monitor console is considered a privileged control interface to
+QEMU and as such should only be made accessible to a trusted management
+application or user.
-- 
2.21.1



