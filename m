Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B080C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F592184C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F592184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQMK-0000wo-KY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hjQLe-0000G4-4F
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hjQLc-0001OU-QH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hjQLc-0001An-IG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD3BE301E111;
 Fri,  5 Jul 2019 15:42:01 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-48.ams2.redhat.com
 [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9073E772A7;
 Fri,  5 Jul 2019 15:41:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 16:41:54 +0100
Message-Id: <20190705154154.9305-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 05 Jul 2019 15:42:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] doc: document that the monitor console is a
 privileged control interface
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 P J P <ppandit@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A supposed exploit of QEMU was recently announced as CVE-2019-12928
claiming that the monitor console was insecure because the "migrate"
command enabled arbitrary command execution for a remote attacker.

To be a security risk the user launching QEMU must have configured
the monitor in a way that allows for other users to access it. The
exploit report quoted use of the "tcp" character device backend for
QMP.

This would indeed allow any network user to connect to QEMU and
execute arbitrary commands, however, this is not a flaw in QEMU.
It is the normal expected behaviour of the monitor console and the
commands it supports. Given a monitor connection, there are many
ways to access host file system content besides the migrate command.

The reality is that the monitor console (whether QMP or HMP) is
considered a privileged interface to QEMU and as such must only
be made available to trusted users. IOW, making it available with
no authentication over TCP is simply a, very serious, user
configuration error not a security flaw in QEMU itself.

The one thing this bogus security report highlights though is that
we have not clearly documented the security implications around the
use of the monitor. Add a few paragraphs of text to the security
docs explaining why the monitor is a privileged interface and making
a recommendation to only use the UNIX socket character device backend.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Changed in v3:

 - More copy editing from review feedback (Markus, PJP, Alex)

Changed in v2:

 - Addressed misc typos (Eric / Philippe)

 docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/docs/security.texi b/docs/security.texi
index 927764f1e6..0d6b30edfc 100644
--- a/docs/security.texi
+++ b/docs/security.texi
@@ -129,3 +129,39 @@ those resources that were granted to it.
 system calls that are not needed by QEMU, thereby reducing the host kern=
el
 attack surface.
 @end itemize
+
+@section Sensitive configurations
+
+There are aspects of QEMU that can have security implications which user=
s &
+management applications must be aware of.
+
+@subsection Monitor console (QMP and HMP)
+
+The monitor console (whether used with QMP or HMP) provides an interface
+to dynamically control many aspects of QEMU's runtime operation. Many of=
 the
+commands exposed will instruct QEMU to access content on the host file s=
ystem
+and/or trigger spawning of external processes.
+
+For example, the @code{migrate} command allows for the spawning of arbit=
rary
+processes for the purpose of tunnelling the migration data stream. The
+@code{blockdev-add} command instructs QEMU to open arbitrary files, expo=
sing
+their content to the guest as a virtual disk.
+
+Unless QEMU is otherwise confined using technologies such as SELinux, Ap=
pArmor,
+or Linux namespaces, the monitor console should be considered to have pr=
ivileges
+equivalent to those of the user account QEMU is running under.
+
+It is further important to consider the security of the character device=
 backend
+over which the monitor console is exposed. It needs to have protection a=
gainst
+malicious third parties which might try to make unauthorized connections=
, or
+perform man-in-the-middle attacks. Many of the character device backends=
 do not
+satisfy this requirement and so must not be used for the monitor console=
.
+
+The general recommendation is that the monitor console should be exposed=
 over
+a UNIX domain socket backend to the local host only. Use of the TCP base=
d
+character device backend is inappropriate unless configured to use both =
TLS
+encryption and authorization control policy on client connections.
+
+In summary, the monitor console is considered a privileged control inter=
face to
+QEMU and as such should only be made accessible to a trusted management
+application or user.
--=20
2.21.0


