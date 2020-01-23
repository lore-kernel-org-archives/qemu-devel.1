Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A088A20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCsISz8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A088A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucxT-0005Zy-Er
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9U-0002yf-N1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9T-0005U2-1D
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9S-0005Th-TZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODpXSOVEGUeaXxqz+wQapDmiFYODWxVoMKjFwNMltkg=;
 b=HCsISz8/A3+KQfi8ExaXczVdze1XvGsJnbmO6yjswCiHxVhs42x+bxmANmTsv+FjUtyZHs
 7Ovjlw55BGf5+q0L8P1tZ6MBHgG/g3hJo8JHkyfGW4WqaT5dm2o968Mw+jdUXs2YQeyE/a
 epqt8gsB+RgtuXBt8vYtqWNaaO7S98o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-wVLQMjmUN2io9IlLUVXiBw-1; Thu, 23 Jan 2020 06:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F77107ACC9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3F11CB;
 Thu, 23 Jan 2020 11:59:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 059/111] virtiofsd: add security guide document
Date: Thu, 23 Jan 2020 11:57:49 +0000
Message-Id: <20200123115841.138849-60-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wVLQMjmUN2io9IlLUVXiBw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Many people want to know: what's up with virtiofsd and security?  This
document provides the answers!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/index.rst              |   2 +
 docs/tools/virtiofsd-security.rst | 118 ++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 docs/tools/virtiofsd-security.rst

diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index adbcd3bc72..b9f8b70995 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -10,3 +10,5 @@ Contents:
=20
 .. toctree::
    :maxdepth: 2
+
+   virtiofsd-security
diff --git a/docs/tools/virtiofsd-security.rst b/docs/tools/virtiofsd-secur=
ity.rst
new file mode 100644
index 0000000000..61ce551344
--- /dev/null
+++ b/docs/tools/virtiofsd-security.rst
@@ -0,0 +1,118 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Virtiofsd Security Guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This document covers security topics for users of virtiofsd, the daemon th=
at
+implements host<->guest file system sharing.  Sharing files between one or=
 more
+guests and the host raises questions about the trust relationships between
+these entities.  By understanding these topics users can safely deploy
+virtiofsd and control access to their data.
+
+Architecture
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The virtiofsd daemon process acts as a vhost-user device backend, implemen=
ting
+the virtio-fs device that the corresponding device driver inside the guest
+interacts with.
+
+There is one virtiofsd process per virtio-fs device instance.  For example=
,
+when two guests have access to the same shared directory there are still t=
wo
+virtiofsd processes since there are two virtio-fs device instances.  Simil=
arly,
+if one guest has access to two shared directories, there are two virtiofsd
+processes since there are two virtio-fs device instances.
+
+Files are created on the host with uid/gid values provided by the guest.
+Furthermore, virtiofsd is unable to enforce file permissions since guests =
have
+the ability to access any file within the shared directory.  File permissi=
ons
+are implemented in the guest, just like with traditional local file system=
s.
+
+Security Requirements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Guests have root access to the shared directory.  This is necessary for ro=
ot
+file systems on virtio-fs and similar use cases.
+
+When multiple guests have access to the same shared directory, the guests =
have
+a trust relationship.  A broken or malicious guest could delete or corrupt
+files.  It could exploit symlink or time-of-check-to-time-of-use (TOCTOU) =
race
+conditions against applications in other guests.  It could plant device no=
des
+or setuid executables to gain privileges in other guests.  It could perfor=
m
+denial-of-service (DoS) attacks by consuming available space or making the=
 file
+system unavailable to other guests.
+
+Guests are restricted to the shared directory and cannot access other file=
s on
+the host.
+
+Guests should not be able to gain arbitrary code execution inside the virt=
iofsd
+process.  If they do, the process is sandboxed to prevent escaping into ot=
her
+parts of the host.
+
+Daemon Sandboxing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The virtiofsd process handles virtio-fs FUSE requests from the untrusted g=
uest.
+This attack surface could give the guest access to host resources and must
+therefore be protected.  Sandboxing mechanisms are integrated into virtiof=
sd to
+reduce the impact in the event that an attacker gains control of the proce=
ss.
+
+As a general rule, virtiofsd does not trust inputs from the guest, aside f=
rom
+uid/gid values.  Input validation is performed so that the guest cannot co=
rrupt
+memory or otherwise gain arbitrary code execution in the virtiofsd process=
.
+
+Sandboxing adds restrictions on the virtiofsd so that even if an attacker =
is
+able to exploit a bug, they will be constrained to the virtiofsd process a=
nd
+unable to cause damage on the host.
+
+Seccomp Whitelist
+-----------------
+Many system calls are not required by virtiofsd to perform its function.  =
For
+example, ptrace(2) and execve(2) are not necessary and attackers are likel=
y to
+use them to further compromise the system.  This is prevented using a secc=
omp
+whitelist in virtiofsd.
+
+During startup virtiofsd installs a whitelist of allowed system calls.  Al=
l
+other system calls are forbidden for the remaining lifetime of the process=
.
+This list has been built through experience of running virtiofsd on severa=
l
+flavors of Linux and observing which system calls were encountered.
+
+It is possible that previously unexplored code paths or newer library vers=
ions
+will invoke system calls that have not been whitelisted yet.  In this case=
 the
+process terminates and a seccomp error is captured in the audit log.  The =
log
+can typically be viewed using ``journalctl -xe`` and searching for ``SECCO=
MP``.
+
+Should it be necessary to extend the whitelist, system call numbers from t=
he
+audit log can be translated to names through a CPU architecture-specific
+``.tbl`` file in the Linux source tree.  They can then be added to the
+whitelist in ``seccomp.c`` in the virtiofsd source tree.
+
+Mount Namespace
+---------------
+During startup virtiofsd enters a new mount namespace and releases all mou=
nts
+except for the shared directory.  This makes the file system root `/` the
+shared directory.  It is impossible to access files outside the shared
+directory since they cannot be looked up by path resolution.
+
+Several attacks, including `..` traversal and symlink escapes, are prevent=
ed by
+the mount namespace.
+
+The current virtiofsd implementation keeps a directory file descriptor to
+/proc/self/fd open in order to implement several FUSE requests.  This file
+descriptor could be used by attackers to access files outside the shared
+directory.  This limitation will be addressed in a future release of virti=
ofsd.
+
+Other Namespaces
+----------------
+Virtiofsd enters new pid and network namespaces during startup.  The pid
+namespace prevents the process from seeing other processes running on the =
host.
+The network namespace removes network connectivity from the process.
+
+Deployment Best Practices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+The shared directory should be a separate file system so that untrusted gu=
ests
+cannot cause a denial-of-service by using up all available inodes or exhau=
sting
+free space.
+
+If the shared directory is also accessible from a host mount namespace, it=
 is
+recommended to keep a parent directory with rwx------ permissions so that =
other
+users on the host are unable to access any setuid executables or device no=
des
+in the shared directory.  The `nosuid` and `nodev` mount options can also =
be
+used to prevent this issue.
--=20
2.24.1


