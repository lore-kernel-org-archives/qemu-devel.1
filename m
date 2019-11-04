Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5351CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A5F2080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/SARmWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A5F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhTO-00036H-Kh
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iRhSa-0002Jw-PT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iRhSZ-0001v1-9g
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:52:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iRhSZ-0001up-6w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572893535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u9yoCUoQ5IjQ9AYWfHlboVDzOuGLVXErAwJSGIPE5P4=;
 b=J/SARmWTBkTeKh6ArSae8lQVQyG1bBT3zjD22HfnOBZUPmCMQ4u8o7Vw6Vo6yzy2QQtHY8
 1XJ2Dixw6G2DSdJd2nkW3LQiizXW7gqUX6KBiue2dUd0tho4LfexfkOfuoQRfFYnon5AP1
 V4gUpQ7oNhISzn/k9bRgErnUT/I0BFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-WmY6-rjoOBSsD-AA_T6f_A-1; Mon, 04 Nov 2019 13:52:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625808017DD;
 Mon,  4 Nov 2019 18:52:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-99.ams2.redhat.com
 [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A6145D9CD;
 Mon,  4 Nov 2019 18:52:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 laurent@vivier.eu
Subject: [PATCH] global: Squash 'the the'
Date: Mon,  4 Nov 2019 18:52:02 +0000
Message-Id: <20191104185202.102504-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: WmY6-rjoOBSsD-AA_T6f_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

'the' has a tendency to double up; squash them back down.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 disas/libvixl/vixl/invalset.h       | 2 +-
 docs/interop/pr-helper.rst          | 2 +-
 docs/specs/ppc-spapr-hotplug.txt    | 2 +-
 docs/specs/ppc-xive.rst             | 2 +-
 docs/specs/tpm.txt                  | 2 +-
 include/hw/xen/interface/io/blkif.h | 2 +-
 scripts/dump-guest-memory.py        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disas/libvixl/vixl/invalset.h b/disas/libvixl/vixl/invalset.h
index ffdc0237b4..ef5e49d6fe 100644
--- a/disas/libvixl/vixl/invalset.h
+++ b/disas/libvixl/vixl/invalset.h
@@ -102,7 +102,7 @@ template<TEMPLATE_INVALSET_P_DECL> class InvalSet {
   size_t size() const;
=20
   // Returns true if no elements are stored in the set.
-  // Note that this does not mean the the backing storage is empty: it can=
 still
+  // Note that this does not mean the backing storage is empty: it can sti=
ll
   // contain invalid elements.
   bool empty() const;
=20
diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
index 9f76d5bcf9..e926f0a6c9 100644
--- a/docs/interop/pr-helper.rst
+++ b/docs/interop/pr-helper.rst
@@ -10,7 +10,7 @@ can delegate implementation of persistent reservations to=
 an external
 restricting access to block devices to specific initiators in a shared
 storage setup.
=20
-For a more detailed reference please refer the the SCSI Primary
+For a more detailed reference please refer to the SCSI Primary
 Commands standard, specifically the section on Reservations and the
 "PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
=20
diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplu=
g.txt
index cc7833108e..859d52cce6 100644
--- a/docs/specs/ppc-spapr-hotplug.txt
+++ b/docs/specs/ppc-spapr-hotplug.txt
@@ -385,7 +385,7 @@ Each LMB list entry consists of the following elements:
   is used to retrieve the right associativity list to be used for this
   LMB.
 - A 32bit flags word. The bit at bit position 0x00000008 defines whether
-  the LMB is assigned to the the partition as of boot time.
+  the LMB is assigned to the partition as of boot time.
=20
 ibm,dynamic-memory-v2
=20
diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
index 148d57eb6a..83d43f658b 100644
--- a/docs/specs/ppc-xive.rst
+++ b/docs/specs/ppc-xive.rst
@@ -163,7 +163,7 @@ Interrupt Priority Register (PIPR) is also updated usin=
g the IPB. This
 register represent the priority of the most favored pending
 notification.
=20
-The PIPR is then compared to the the Current Processor Priority
+The PIPR is then compared to the Current Processor Priority
 Register (CPPR). If it is more favored (numerically less than), the
 CPU interrupt line is raised and the EO bit of the Notification Source
 Register (NSR) is updated to notify the presence of an exception for
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 5d8c26b1ad..9c8cca042d 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -89,7 +89,7 @@ TPM upon reboot. The PPI specification defines the operat=
ion requests and the
 actions the firmware has to take. The system administrator passes the oper=
ation
 request number to the firmware through an ACPI interface which writes this
 number to a memory location that the firmware knows. Upon reboot, the firm=
ware
-finds the number and sends commands to the the TPM. The firmware writes th=
e TPM
+finds the number and sends commands to the TPM. The firmware writes the TP=
M
 result code and the operation request number to a memory location that ACP=
I can
 read from and pass the result on to the administrator.
=20
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface=
/io/blkif.h
index 8b1be50ce8..d07fa1e078 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -341,7 +341,7 @@
  *      access (even when it should be read-only). If the frontend hits th=
e
  *      maximum number of allowed persistently mapped grants, it can fallb=
ack
  *      to non persistent mode. This will cause a performance degradation,
- *      since the the backend driver will still try to map those grants
+ *      since the backend driver will still try to map those grants
  *      persistently. Since the persistent grants protocol is compatible w=
ith
  *      the previous protocol, a frontend driver can choose to work in
  *      persistent mode even when the backend doesn't support it.
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 2c587cbefc..9371e45813 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -170,7 +170,7 @@ class ELF(object):
         self.ehdr.e_phnum +=3D 1
=20
     def to_file(self, elf_file):
-        """Writes all ELF structures to the the passed file.
+        """Writes all ELF structures to the passed file.
=20
         Structure:
         Ehdr
--=20
2.23.0


