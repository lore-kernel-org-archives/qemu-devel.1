Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D6C28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1682070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1682070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsbP-0003Mi-TQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:38:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUu-0006ro-Fb
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUm-0002Zl-Sv
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYsUk-0001ED-S9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D98D307D98D
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 13:31:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
	[10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 394DA68426;
	Thu,  6 Jun 2019 13:31:37 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Date: Thu,  6 Jun 2019 15:31:09 +0200
Message-Id: <20190606133110.13754-6-lersek@redhat.com>
In-Reply-To: <20190606133110.13754-1-lersek@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 06 Jun 2019 13:31:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/6] pc-bios: refresh edk2 build artifacts for
 edk2-stable201905
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rebuild the pc-bios/edk2-*.fd.bz2 binaries, and regenerate
pc-bios/edk2-licenses.txt, based on the edk2-stable201905 release.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 pc-bios/edk2-licenses.txt              | 752 ++++++++++++++++++--
 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1177603 -> 1178070 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1173662 -> 1172752 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1688659 -> 1736199 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1881979 -> 1943949 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1669280 -> 1717094 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1901210 -> 1958037 bytes
 7 files changed, 693 insertions(+), 59 deletions(-)

diff --git a/pc-bios/edk2-licenses.txt b/pc-bios/edk2-licenses.txt
index 8bdb1abc993e..0a4136eebc68 100644
--- a/pc-bios/edk2-licenses.txt
+++ b/pc-bios/edk2-licenses.txt
@@ -1,67 +1,661 @@
 =3D=3D> edk2/License.txt <=3D=3D
-Copyright (c) 2004 - 2016, Intel Corporation. All rights reserved.
-Copyright (c) 2008 - 2010, Apple Inc. All rights reserved.
-Copyright (c) 2011 - 2015, ARM Limited. All rights reserved.
-Copyright (c) 2014 - 2015, Linaro Limited. All rights reserved.
-Copyright (c) 2013 - 2015, Red Hat, Inc.
+Copyright (c) 2019, TianoCore and contributors.  All rights reserved.
+
+SPDX-License-Identifier: BSD-2-Clause-Patent
=20
 Redistribution and use in source and binary forms, with or without
-modification, are permitted provided that the following conditions
-are met:
-
-* Redistributions of source code must retain the above copyright
-  notice, this list of conditions and the following disclaimer.
-* Redistributions in binary form must reproduce the above copyright
-  notice, this list of conditions and the following disclaimer in
-  the documentation and/or other materials provided with the
-  distribution.
-
-THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
-FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
-COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
-INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
-BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
-LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
-ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+modification, are permitted provided that the following conditions are m=
et:
+
+1. Redistributions of source code must retain the above copyright notice=
,
+   this list of conditions and the following disclaimer.
+
+2. Redistributions in binary form must reproduce the above copyright not=
ice,
+   this list of conditions and the following disclaimer in the documenta=
tion
+   and/or other materials provided with the distribution.
+
+Subject to the terms and conditions of this license, each copyright hold=
er
+and contributor hereby grants to those receiving rights under this licen=
se
+a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevoca=
ble
+(except for failure to satisfy the conditions of this license) patent
+license to make, have made, use, offer to sell, sell, import, and otherw=
ise
+transfer this software, where such license applies only to those patent
+claims, already acquired or hereafter acquired, licensable by such copyr=
ight
+holder or contributor that are necessarily infringed by:
+
+(a) their Contribution(s) (the licensed copyrights of copyright holders =
and
+    non-copyrightable additions of contributors, in source or binary for=
m)
+    alone; or
+
+(b) combination of their Contribution(s) with the work of authorship to
+    which such Contribution(s) was added by such copyright holder or
+    contributor, if, at the time the Contribution is added, such additio=
n
+    causes such combination to be necessarily infringed. The patent lice=
nse
+    shall not apply to any other combinations which include the
+    Contribution.
+
+Except as expressly stated above, no rights or licenses from any copyrig=
ht
+holder or contributor is granted under this license, whether expressly, =
by
+implication, estoppel or otherwise.
+
+DISCLAIMER
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS =
IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, TH=
E
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO=
SE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS =
BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF T=
HE
 POSSIBILITY OF SUCH DAMAGE.
=20
+=3D=3D> edk2/License-History.txt <=3D=3D
+                              License-History.txt
+                              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+This file contains the history of license change and contributor's agree=
ment
+changes.
+
+Unless otherwise noted in a specific file, the EDK2 project is now licen=
sed
+under the terms listed in the License.txt file.  Terms under which Contr=
ibutions
+made prior to the move to the License.txt formulation are shown below.  =
Those
+terms require notice of the terms themselves be preserved and presented =
with the
+contributions.  This file serves that preservation purpose as a matter o=
f
+documenting the history of the project.
+
+Key Dates
+----------
+* August 3, 2017
+
+  Update the TianoCore Contribution Agreement from Version 1.0
+  to Version 1.1 to cover open source documentation associated
+  with the TianoCore project.
+
+  Version 1.0 covers source code files.  Version 1.1 is a
+  backwards compatible extension that adds support for document
+  files in both source form and compiled form.
+
+  References:
+      https://opensource.org/licenses/BSD-2-Clause
+      Complete text of TianoCore Contribution Agreement 1.0 included bel=
ow
+      Complete text of TianoCore Contribution Agreement 1.1 included bel=
ow
+
+  Proposals (RFCs):
+      https://lists.01.org/pipermail/edk2-devel/2017-March/008654.html
+
+  TianoCore Bugzilla:
+      https://bugzilla.tianocore.org/show_bug.cgi?id=3D629
+
+* April 9, 2019
+
+  Replace BSD 2-Clause License with BSD + Patent License removing the ne=
ed for
+  the TianoCore Contribution Agreement.
+
+  References:
+      https://opensource.org/licenses/BSD-2-Clause
+      Complete text of TianoCore Contribution Agreement 1.0 included bel=
ow
+      Complete text of TianoCore Contribution Agreement 1.1 included bel=
ow
+      https://opensource.org/licenses/BSDplusPatent
+
+  Proposals (RFCs):
+      https://lists.01.org/pipermail/edk2-devel/2019-February/036260.htm=
l
+      https://lists.01.org/pipermail/edk2-devel/2019-March/037500.html
+
+  TianoCore Bugzilla:
+      https://bugzilla.tianocore.org/show_bug.cgi?id=3D1373
+
+------------------------------------------------------------------------=
--------
+License.txt: BSD 2-Clause License
+------------------------------------------------------------------------=
--------
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+
+    * Redistributions of source code must retain the above copyright
+      notice, this list of conditions and the following disclaimer.
+    * Redistributions in binary form must reproduce the above copyright
+      notice, this list of conditions and the following disclaimer in
+      the documentation and/or other materials provided with the
+      distribution.
+
+    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
+    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+    POSSIBILITY OF SUCH DAMAGE.
+------------------------------------------------------------------------=
--------
+
+------------------------------------------------------------------------=
--------
+Contributions.txt: TianoCore Contribution Agreement 1.1
+------------------------------------------------------------------------=
--------
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D Code Contributions =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    To make a contribution to a TianoCore project, follow these steps.
+    1. Create a change description in the format specified below to
+       use in the source control commit log.
+    2. Your commit message must include your "Signed-off-by" signature,
+       and "Contributed-under" message.
+    3. Your "Contributed-under" message explicitly states that the
+       contribution is made under the terms of the specified
+       contribution agreement.  Your "Contributed-under" message
+       must include the name of contribution agreement and version.
+       For example: Contributed-under: TianoCore Contribution Agreement =
1.1
+       The "TianoCore Contribution Agreement" is included below in
+       this document.
+    4. Submit your code to the TianoCore project using the process
+       that the project documents on its web page.  If the process is
+       not documented, then submit the code on development email list
+       for the project.
+    5. It is preferred that contributions are submitted using the same
+       copyright license as the base project. When that is not possible,
+       then contributions using the following licenses can be accepted:
+       * BSD (2-clause): http://opensource.org/licenses/BSD-2-Clause
+       * BSD (3-clause): http://opensource.org/licenses/BSD-3-Clause
+       * MIT: http://opensource.org/licenses/MIT
+       * Python-2.0: http://opensource.org/licenses/Python-2.0
+       * Zlib: http://opensource.org/licenses/Zlib
+
+       For documentation:
+       * FreeBSD Documentation License
+         https://www.freebsd.org/copyright/freebsd-doc-license.html
+
+       Contributions of code put into the public domain can also be
+       accepted.
+
+       Contributions using other licenses might be accepted, but further
+       review will be required.
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+    =3D Change Description / Commit Message / Patch Email =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+    Your change description should use the standard format for a
+    commit message, and must include your "Signed-off-by" signature
+    and the "Contributed-under" message.
+
+    =3D=3D Sample Change Description / Commit Message =3D
+
+    =3D=3D=3D Start of sample patch email message =3D=3D=3D
+
+    From: Contributor Name <contributor@example.com>
+    Subject: [Repository/Branch PATCH] Module: Brief-single-line-summary
+
+    Full-commit-message
+
+    Contributed-under: TianoCore Contribution Agreement 1.1
+    Signed-off-by: Contributor Name <contributor@example.com>
+    ---
+
+    An extra message for the patch email which will not be considered pa=
rt
+    of the commit message can be added here.
+
+    Patch content inline or attached
+
+    =3D=3D=3D End of sample patch email message =3D=3D=3D
+
+    =3D=3D=3D Notes for sample patch email =3D=3D=3D
+
+    * The first line of commit message is taken from the email's subject
+      line following [Repository/Branch PATCH]. The remaining portion of=
 the
+      commit message is the email's content until the '---' line.
+    * git format-patch is one way to create this format
+
+    =3D=3D=3D Definitions for sample patch email =3D=3D=3D
+
+    * "Repository" is the identifier of the repository the patch applies=
.
+      This identifier should only be provided for repositories other tha=
n
+      'edk2'. For example 'edk2-BuildSpecification' or 'staging'.
+    * "Branch" is the identifier of the branch the patch applies. This
+      identifier should only be provided for branches other than 'edk2/m=
aster'.
+      For example 'edk2/UDK2015', 'edk2-BuildSpecification/release/1.27'=
, or
+      'staging/edk2-test'.
+    * "Module" is a short identifier for the affected code or documentat=
ion. For
+      example 'MdePkg', 'MdeModulePkg/UsbBusDxe', 'Introduction', or
+      'EDK II INF File Format'.
+    * "Brief-single-line-summary" is a short summary of the change.
+    * The entire first line should be less than ~70 characters.
+    * "Full-commit-message" a verbose multiple line comment describing
+      the change.  Each line should be less than ~70 characters.
+    * "Contributed-under" explicitly states that the contribution is
+      made under the terms of the contribution agreement. This
+      agreement is included below in this document.
+    * "Signed-off-by" is the contributor's signature identifying them
+      by their real/legal name and their email address.
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D TianoCore Contribution Agreement 1.1 =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    INTEL CORPORATION ("INTEL") MAKES AVAILABLE SOFTWARE, DOCUMENTATION
+    ("DOCUMENTATION"), INFORMATION AND/OR OTHER MATERIALS FOR USE IN THE
+    TIANOCORE OPEN SOURCE PROJECT (COLLECTIVELY "CONTENT"). USE OF THE C=
ONTENT
+    IS GOVERNED BY THE TERMS AND CONDITIONS OF THIS AGREEMENT BETWEEN YO=
U AND
+    INTEL AND/OR THE TERMS AND CONDITIONS OF LICENSE AGREEMENTS OR NOTIC=
ES
+    INDICATED OR REFERENCED BELOW. BY USING THE CONTENT, YOU AGREE THAT =
YOUR
+    USE OF THE CONTENT IS GOVERNED BY THIS AGREEMENT AND/OR THE TERMS AN=
D
+    CONDITIONS OF ANY APPLICABLE LICENSE AGREEMENTS OR NOTICES INDICATED=
 OR
+    REFERENCED BELOW. IF YOU DO NOT AGREE TO THE TERMS AND CONDITIONS OF=
 THIS
+    AGREEMENT AND THE TERMS AND CONDITIONS OF ANY APPLICABLE LICENSE
+    AGREEMENTS OR NOTICES INDICATED OR REFERENCED BELOW, THEN YOU MAY NO=
T
+    USE THE CONTENT.
+
+    Unless otherwise indicated, all Content (except Documentation) made =
available
+    on the TianoCore site is provided to you under the terms and conditi=
ons of the
+    BSD License ("BSD"). A copy of the BSD License is available at
+    http://opensource.org/licenses/bsd-license.php
+    or when applicable, in the associated License.txt file.
+
+    Unless otherwise indicated, all Documentation made available on the
+    TianoCore site is provided to you under the terms and conditions of =
the
+    FreeBSD Documentation License ("FreeBSD"). A copy of the license is
+    available at https://www.freebsd.org/copyright/freebsd-doc-license.h=
tml or,
+    when applicable, in the associated License.txt file.
+
+    Certain other content may be made available under other licenses as
+    indicated in or with such Content (for example, in a License.txt fil=
e).
+
+    You accept and agree to the following terms and conditions for Your
+    present and future Contributions submitted to TianoCore site. Except
+    for the license granted to Intel hereunder, You reserve all right,
+    title, and interest in and to Your Contributions.
+
+    =3D=3D SECTION 1: Definitions =3D=3D
+    * "You" or "Contributor" shall mean the copyright owner or legal
+      entity authorized by the copyright owner that is making a
+      Contribution hereunder. All other entities that control, are
+      controlled by, or are under common control with that entity are
+      considered to be a single Contributor. For the purposes of this
+      definition, "control" means (i) the power, direct or indirect, to
+      cause the direction or management of such entity, whether by
+      contract or otherwise, or (ii) ownership of fifty percent (50%)
+      or more of the outstanding shares, or (iii) beneficial ownership
+      of such entity.
+    * "Contribution" shall mean any original work of authorship,
+      including any modifications or additions to an existing work,
+      that is intentionally submitted by You to the TianoCore site for
+      inclusion in, or documentation of, any of the Content. For the
+      purposes of this definition, "submitted" means any form of
+      electronic, verbal, or written communication sent to the
+      TianoCore site or its representatives, including but not limited
+      to communication on electronic mailing lists, source code
+      control systems, and issue tracking systems that are managed by,
+      or on behalf of, the TianoCore site for the purpose of
+      discussing and improving the Content, but excluding
+      communication that is conspicuously marked or otherwise
+      designated in writing by You as "Not a Contribution."
+
+    =3D=3D SECTION 2: License for Contributions =3D=3D
+    * Contributor hereby agrees that redistribution and use of the
+      Contribution in source and binary forms, with or without
+      modification, are permitted provided that the following
+      conditions are met:
+    ** Redistributions of source code must retain the Contributor's
+       copyright notice, this list of conditions and the following
+       disclaimer.
+    ** Redistributions in binary form must reproduce the Contributor's
+       copyright notice, this list of conditions and the following
+       disclaimer in the documentation and/or other materials provided
+       with the distribution.
+    * Disclaimer. None of the names of Contributor, Intel, or the names
+      of their respective contributors may be used to endorse or
+      promote products derived from this software without specific
+      prior written permission.
+    * Contributor grants a license (with the right to sublicense) under
+      claims of Contributor's patents that Contributor can license that
+      are infringed by the Contribution (as delivered by Contributor) to
+      make, use, distribute, sell, offer for sale, and import the
+      Contribution and derivative works thereof solely to the minimum
+      extent necessary for licensee to exercise the granted copyright
+      license; this patent license applies solely to those portions of
+      the Contribution that are unmodified. No hardware per se is
+      licensed.
+    * EXCEPT AS EXPRESSLY SET FORTH IN SECTION 3 BELOW, THE
+      CONTRIBUTION IS PROVIDED BY THE CONTRIBUTOR "AS IS" AND ANY
+      EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+      THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+      PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+      CONTRIBUTOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+      NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+      LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+      HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+      CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+      OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THE
+      CONTRIBUTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+      DAMAGE.
+
+    =3D=3D SECTION 3: Representations =3D=3D
+    * You represent that You are legally entitled to grant the above
+      license. If your employer(s) has rights to intellectual property
+      that You create that includes Your Contributions, You represent
+      that You have received permission to make Contributions on behalf
+      of that employer, that Your employer has waived such rights for
+      Your Contributions.
+    * You represent that each of Your Contributions is Your original
+      creation (see Section 4 for submissions on behalf of others).
+      You represent that Your Contribution submissions include complete
+      details of any third-party license or other restriction
+      (including, but not limited to, related patents and trademarks)
+      of which You are personally aware and which are associated with
+      any part of Your Contributions.
+
+    =3D=3D SECTION 4: Third Party Contributions =3D=3D
+    * Should You wish to submit work that is not Your original creation,
+      You may submit it to TianoCore site separately from any
+      Contribution, identifying the complete details of its source
+      and of any license or other restriction (including, but not
+      limited to, related patents, trademarks, and license agreements)
+      of which You are personally aware, and conspicuously marking the
+      work as "Submitted on behalf of a third-party: [named here]".
+
+    =3D=3D SECTION 5: Miscellaneous =3D=3D
+    * Applicable Laws. Any claims arising under or relating to this
+      Agreement shall be governed by the internal substantive laws of
+      the State of Delaware or federal courts located in Delaware,
+      without regard to principles of conflict of laws.
+    * Language. This Agreement is in the English language only, which
+      language shall be controlling in all respects, and all versions
+      of this Agreement in any other language shall be for accommodation
+      only and shall not be binding. All communications and notices made
+      or given pursuant to this Agreement, and all documentation and
+      support to be provided, unless otherwise noted, shall be in the
+      English language.
+------------------------------------------------------------------------=
--------
+
+------------------------------------------------------------------------=
--------
+Contributions.txt: TianoCore Contribution Agreement 1.0
+------------------------------------------------------------------------=
--------
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D Code Contributions =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    To make a contribution to a TianoCore project, follow these steps.
+    1. Create a change description in the format specified below to
+       use in the source control commit log.
+    2. Your commit message must include your "Signed-off-by" signature,
+       and "Contributed-under" message.
+    3. Your "Contributed-under" message explicitly states that the
+       contribution is made under the terms of the specified
+       contribution agreement.  Your "Contributed-under" message
+       must include the name of contribution agreement and version.
+       For example: Contributed-under: TianoCore Contribution Agreement =
1.0
+       The "TianoCore Contribution Agreement" is included below in
+       this document.
+    4. Submit your code to the TianoCore project using the process
+       that the project documents on its web page.  If the process is
+       not documented, then submit the code on development email list
+       for the project.
+    5. It is preferred that contributions are submitted using the same
+       copyright license as the base project. When that is not possible,
+       then contributions using the following licenses can be accepted:
+       * BSD (2-clause): http://opensource.org/licenses/BSD-2-Clause
+       * BSD (3-clause): http://opensource.org/licenses/BSD-3-Clause
+       * MIT: http://opensource.org/licenses/MIT
+       * Python-2.0: http://opensource.org/licenses/Python-2.0
+       * Zlib: http://opensource.org/licenses/Zlib
+
+       Contributions of code put into the public domain can also be
+       accepted.
+
+       Contributions using other licenses might be accepted, but further
+       review will be required.
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+    =3D Change Description / Commit Message / Patch Email =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+    Your change description should use the standard format for a
+    commit message, and must include your "Signed-off-by" signature
+    and the "Contributed-under" message.
+
+    =3D=3D Sample Change Description / Commit Message =3D
+
+    =3D=3D=3D Start of sample patch email message =3D=3D=3D
+
+    From: Contributor Name <contributor@example.com>
+    Subject: [PATCH] CodeModule: Brief-single-line-summary
+
+    Full-commit-message
+
+    Contributed-under: TianoCore Contribution Agreement 1.0
+    Signed-off-by: Contributor Name <contributor@example.com>
+    ---
+
+    An extra message for the patch email which will not be considered pa=
rt
+    of the commit message can be added here.
+
+    Patch content inline or attached
+
+    =3D=3D=3D End of sample patch email message =3D=3D=3D
+
+    =3D=3D=3D Notes for sample patch email =3D=3D=3D
+
+    * The first line of commit message is taken from the email's subject
+      line following [PATCH]. The remaining portion of the commit messag=
e
+      is the email's content until the '---' line.
+    * git format-patch is one way to create this format
+
+    =3D=3D=3D Definitions for sample patch email =3D=3D=3D
+
+    * "CodeModule" is a short idenfier for the affected code.  For
+      example MdePkg, or MdeModulePkg UsbBusDxe.
+    * "Brief-single-line-summary" is a short summary of the change.
+    * The entire first line should be less than ~70 characters.
+    * "Full-commit-message" a verbose multiple line comment describing
+      the change.  Each line should be less than ~70 characters.
+    * "Contributed-under" explicitely states that the contribution is
+      made under the terms of the contribtion agreement.  This
+      agreement is included below in this document.
+    * "Signed-off-by" is the contributor's signature identifying them
+      by their real/legal name and their email address.
+
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =3D TianoCore Contribution Agreement 1.0 =3D
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+    INTEL CORPORATION ("INTEL") MAKES AVAILABLE SOFTWARE, DOCUMENTATION,
+    INFORMATION AND/OR OTHER MATERIALS FOR USE IN THE TIANOCORE OPEN SOU=
RCE
+    PROJECT (COLLECTIVELY "CONTENT"). USE OF THE CONTENT IS GOVERNED BY =
THE
+    TERMS AND CONDITIONS OF THIS AGREEMENT BETWEEN YOU AND INTEL AND/OR =
THE
+    TERMS AND CONDITIONS OF LICENSE AGREEMENTS OR NOTICES INDICATED OR
+    REFERENCED BELOW. BY USING THE CONTENT, YOU AGREE THAT YOUR USE OF T=
HE
+    CONTENT IS GOVERNED BY THIS AGREEMENT AND/OR THE TERMS AND CONDITION=
S
+    OF ANY APPLICABLE LICENSE AGREEMENTS OR NOTICES INDICATED OR REFEREN=
CED
+    BELOW. IF YOU DO NOT AGREE TO THE TERMS AND CONDITIONS OF THIS
+    AGREEMENT AND THE TERMS AND CONDITIONS OF ANY APPLICABLE LICENSE
+    AGREEMENTS OR NOTICES INDICATED OR REFERENCED BELOW, THEN YOU MAY NO=
T
+    USE THE CONTENT.
+
+    Unless otherwise indicated, all Content made available on the TianoC=
ore
+    site is provided to you under the terms and conditions of the BSD
+    License ("BSD"). A copy of the BSD License is available at
+    http://opensource.org/licenses/bsd-license.php
+    or when applicable, in the associated License.txt file.
+
+    Certain other content may be made available under other licenses as
+    indicated in or with such Content. (For example, in a License.txt fi=
le.)
+
+    You accept and agree to the following terms and conditions for Your
+    present and future Contributions submitted to TianoCore site. Except
+    for the license granted to Intel hereunder, You reserve all right,
+    title, and interest in and to Your Contributions.
+
+    =3D=3D SECTION 1: Definitions =3D=3D
+    * "You" or "Contributor" shall mean the copyright owner or legal
+      entity authorized by the copyright owner that is making a
+      Contribution hereunder. All other entities that control, are
+      controlled by, or are under common control with that entity are
+      considered to be a single Contributor. For the purposes of this
+      definition, "control" means (i) the power, direct or indirect, to
+      cause the direction or management of such entity, whether by
+      contract or otherwise, or (ii) ownership of fifty percent (50%)
+      or more of the outstanding shares, or (iii) beneficial ownership
+      of such entity.
+    * "Contribution" shall mean any original work of authorship,
+      including any modifications or additions to an existing work,
+      that is intentionally submitted by You to the TinaoCore site for
+      inclusion in, or documentation of, any of the Content. For the
+      purposes of this definition, "submitted" means any form of
+      electronic, verbal, or written communication sent to the
+      TianoCore site or its representatives, including but not limited
+      to communication on electronic mailing lists, source code
+      control systems, and issue tracking systems that are managed by,
+      or on behalf of, the TianoCore site for the purpose of
+      discussing and improving the Content, but excluding
+      communication that is conspicuously marked or otherwise
+      designated in writing by You as "Not a Contribution."
+
+    =3D=3D SECTION 2: License for Contributions =3D=3D
+    * Contributor hereby agrees that redistribution and use of the
+      Contribution in source and binary forms, with or without
+      modification, are permitted provided that the following
+      conditions are met:
+    ** Redistributions of source code must retain the Contributor's
+       copyright notice, this list of conditions and the following
+       disclaimer.
+    ** Redistributions in binary form must reproduce the Contributor's
+       copyright notice, this list of conditions and the following
+       disclaimer in the documentation and/or other materials provided
+       with the distribution.
+    * Disclaimer. None of the names of Contributor, Intel, or the names
+      of their respective contributors may be used to endorse or
+      promote products derived from this software without specific
+      prior written permission.
+    * Contributor grants a license (with the right to sublicense) under
+      claims of Contributor's patents that Contributor can license that
+      are infringed by the Contribution (as delivered by Contributor) to
+      make, use, distribute, sell, offer for sale, and import the
+      Contribution and derivative works thereof solely to the minimum
+      extent necessary for licensee to exercise the granted copyright
+      license; this patent license applies solely to those portions of
+      the Contribution that are unmodified. No hardware per se is
+      licensed.
+    * EXCEPT AS EXPRESSLY SET FORTH IN SECTION 3 BELOW, THE
+      CONTRIBUTION IS PROVIDED BY THE CONTRIBUTOR "AS IS" AND ANY
+      EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+      THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+      PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+      CONTRIBUTOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+      NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+      LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+      HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+      CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+      OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THE
+      CONTRIBUTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+      DAMAGE.
+
+    =3D=3D SECTION 3: Representations =3D=3D
+    * You represent that You are legally entitled to grant the above
+      license. If your employer(s) has rights to intellectual property
+      that You create that includes Your Contributions, You represent
+      that You have received permission to make Contributions on behalf
+      of that employer, that Your employer has waived such rights for
+      Your Contributions.
+    * You represent that each of Your Contributions is Your original
+      creation (see Section 4 for submissions on behalf of others).
+      You represent that Your Contribution submissions include complete
+      details of any third-party license or other restriction
+      (including, but not limited to, related patents and trademarks)
+      of which You are personally aware and which are associated with
+      any part of Your Contributions.
+
+    =3D=3D SECTION 4: Third Party Contributions =3D=3D
+    * Should You wish to submit work that is not Your original creation,
+      You may submit it to TianoCore site separately from any
+      Contribution, identifying the complete details of its source
+      and of any license or other restriction (including, but not
+      limited to, related patents, trademarks, and license agreements)
+      of which You are personally aware, and conspicuously marking the
+      work as "Submitted on behalf of a third-party: [named here]".
+
+    =3D=3D SECTION 5: Miscellaneous =3D=3D
+    * Applicable Laws. Any claims arising under or relating to this
+      Agreement shall be governed by the internal substantive laws of
+      the State of Delaware or federal courts located in Delaware,
+      without regard to principles of conflict of laws.
+    * Language. This Agreement is in the English language only, which
+      language shall be controlling in all respects, and all versions
+      of this Agreement in any other language shall be for accommodation
+      only and shall not be binding. All communications and notices made
+      or given pursuant to this Agreement, and all documentation and
+      support to be provided, unless otherwise noted, shall be in the
+      English language.
+------------------------------------------------------------------------=
--------
+
+
 =3D=3D> edk2/OvmfPkg/License.txt <=3D=3D
-Copyright (c) 2012, Intel Corporation. All rights reserved.
+Copyright (c) 2012 - 2019, Intel Corporation. All rights reserved.
+
+SPDX-License-Identifier: BSD-2-Clause-Patent
=20
 Redistribution and use in source and binary forms, with or without
-modification, are permitted provided that the following conditions
-are met:
-
-* Redistributions of source code must retain the above copyright
-  notice, this list of conditions and the following disclaimer.
-* Redistributions in binary form must reproduce the above copyright
-  notice, this list of conditions and the following disclaimer in
-  the documentation and/or other materials provided with the
-  distribution.
-
-THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
-FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
-COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
-INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
-BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
-LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
-ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+modification, are permitted provided that the following conditions are m=
et:
+
+1. Redistributions of source code must retain the above copyright notice=
,
+   this list of conditions and the following disclaimer.
+
+2. Redistributions in binary form must reproduce the above copyright not=
ice,
+   this list of conditions and the following disclaimer in the documenta=
tion
+   and/or other materials provided with the distribution.
+
+Subject to the terms and conditions of this license, each copyright hold=
er
+and contributor hereby grants to those receiving rights under this licen=
se
+a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevoca=
ble
+(except for failure to satisfy the conditions of this license) patent
+license to make, have made, use, offer to sell, sell, import, and otherw=
ise
+transfer this software, where such license applies only to those patent
+claims, already acquired or hereafter acquired, licensable by such copyr=
ight
+holder or contributor that are necessarily infringed by:
+
+(a) their Contribution(s) (the licensed copyrights of copyright holders =
and
+    non-copyrightable additions of contributors, in source or binary for=
m)
+    alone; or
+
+(b) combination of their Contribution(s) with the work of authorship to
+    which such Contribution(s) was added by such copyright holder or
+    contributor, if, at the time the Contribution is added, such additio=
n
+    causes such combination to be necessarily infringed. The patent lice=
nse
+    shall not apply to any other combinations which include the
+    Contribution.
+
+Except as expressly stated above, no rights or licenses from any copyrig=
ht
+holder or contributor is granted under this license, whether expressly, =
by
+implication, estoppel or otherwise.
+
+DISCLAIMER
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS =
IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, TH=
E
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO=
SE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS =
BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF T=
HE
 POSSIBILITY OF SUCH DAMAGE.
=20
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
 Some files are subject to the following license, the MIT license. Those =
files
 are located in:
 - OvmfPkg/Include/IndustryStandard/Xen/
 - OvmfPkg/XenBusDxe/
-- OvmfPkg/XenPvBlkDxe/
+
+SPDX-License-Identifier: MIT
=20
 Permission is hereby granted, free of charge, to any person obtaining a =
copy
 of this software and associated documentation files (the "Software"), to=
 deal
@@ -70,8 +664,9 @@ to use, copy, modify, merge, publish, distribute, subl=
icense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
=20
-The above copyright notice and this permission notice shall be included =
in
-all copies or substantial portions of the Software.
+The above copyright notice and this permission notice (including the nex=
t
+paragraph) shall be included in all copies or substantial portions of th=
e
+Software.
=20
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
@@ -81,6 +676,45 @@ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N
 THE SOFTWARE.
=20
+=3D=3D> edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3/COPYING=
.txt <=3D=3D
+
+License for Berkeley SoftFloat Release 3e
+
+John R. Hauser
+2018 January 20
+
+The following applies to the whole of SoftFloat Release 3e as well as to
+each source file individually.
+
+Copyright 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018 The Regents of =
the
+University of California.  All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are m=
et:
+
+ 1. Redistributions of source code must retain the above copyright notic=
e,
+    this list of conditions, and the following disclaimer.
+
+ 2. Redistributions in binary form must reproduce the above copyright
+    notice, this list of conditions, and the following disclaimer in the
+    documentation and/or other materials provided with the distribution.
+
+ 3. Neither the name of the University nor the names of its contributors
+    may be used to endorse or promote products derived from this softwar=
e
+    without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS", AND A=
NY
+EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIE=
D
+WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE
+DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR=
 ANY
+DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAG=
ES
+(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVI=
CES;
+LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND
+ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+
 =3D=3D> edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE <=3D=3D
=20
   LICENSE ISSUES
@@ -94,14 +728,14 @@ THE SOFTWARE.
   ---------------
=20
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- * Copyright (c) 1998-2018 The OpenSSL Project.  All rights reserved.
+ * Copyright (c) 1998-2019 The OpenSSL Project.  All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
  * are met:
  *
  * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.=20
+ *    notice, this list of conditions and the following disclaimer.
  *
  * 2. Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in
@@ -156,21 +790,21 @@ THE SOFTWARE.
  * This package is an SSL implementation written
  * by Eric Young (eay@cryptsoft.com).
  * The implementation was written so as to conform with Netscapes SSL.
- *=20
+ *
  * This library is free for commercial and non-commercial use as long as
  * the following conditions are aheared to.  The following conditions
  * apply to all code found in this distribution, be it the RC4, RSA,
  * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
  * included with this distribution is covered by the same copyright term=
s
  * except that the holder is Tim Hudson (tjh@cryptsoft.com).
- *=20
+ *
  * Copyright remains Eric Young's, and as such any Copyright notices in
  * the code are not to be removed.
  * If this package is used in a product, Eric Young should be given attr=
ibution
  * as the author of the parts of the library used.
  * This can be in the form of a textual message at program startup or
  * in documentation (online or textual) provided with the package.
- *=20
+ *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
  * are met:
@@ -185,10 +819,10 @@ THE SOFTWARE.
  *     Eric Young (eay@cryptsoft.com)"
  *    The word 'cryptographic' can be left out if the rouines from the l=
ibrary
  *    being used are not cryptographic related :-).
- * 4. If you include any Windows specific code (or a derivative thereof)=
 from=20
+ * 4. If you include any Windows specific code (or a derivative thereof)=
 from
  *    the apps directory (application code) you must include an acknowle=
dgement:
  *    "This product includes software written by Tim Hudson (tjh@cryptso=
ft.com)"
- *=20
+ *
  * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
@@ -200,7 +834,7 @@ THE SOFTWARE.
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
  * SUCH DAMAGE.
- *=20
+ *
  * The licence and distribution terms for any publically available versi=
on or
  * derivative of this code cannot be changed.  i.e. this code cannot sim=
ply be
  * copied and put under another distribution licence
diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code=
.fd.bz2
index b213334d9553..a074085b224f 100644
Binary files a/pc-bios/edk2-aarch64-code.fd.bz2 and b/pc-bios/edk2-aarch6=
4-code.fd.bz2 differ
diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
index a494a8391eed..42453cd1f273 100644
Binary files a/pc-bios/edk2-arm-code.fd.bz2 and b/pc-bios/edk2-arm-code.f=
d.bz2 differ
diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz=
2
index 5440ca856db6..633759688e32 100644
Binary files a/pc-bios/edk2-i386-code.fd.bz2 and b/pc-bios/edk2-i386-code=
.fd.bz2 differ
diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-sec=
ure-code.fd.bz2
index 24ae88ac3e40..df27bdd2ddbd 100644
Binary files a/pc-bios/edk2-i386-secure-code.fd.bz2 and b/pc-bios/edk2-i3=
86-secure-code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.f=
d.bz2
index 6a0b1f983199..0e108fc68a91 100644
Binary files a/pc-bios/edk2-x86_64-code.fd.bz2 and b/pc-bios/edk2-x86_64-=
code.fd.bz2 differ
diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64=
-secure-code.fd.bz2
index 3ef6452c0375..522f8376aabe 100644
Binary files a/pc-bios/edk2-x86_64-secure-code.fd.bz2 and b/pc-bios/edk2-=
x86_64-secure-code.fd.bz2 differ
--=20
2.19.1.3.g30247aa5d201



